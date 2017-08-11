/*
 *            ***BRENDERS***
 * ***** BEGIN GPL LICENSE BLOCK *****
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 * The Original Code is Copyright (C) 2017 Marcelo "Tanda" Cerviño. 
 * http://lodetanda.blogspot.com/ 
 * All rights reserved.
 *
 * Contributor(s):
 *
 * ***** END GPL LICENSE BLOCK *****
 */

void keyEventsBatch (String keypress)
{
  if (keypress == "number") {
    if (select_sframe) {
      sframe += key;
    }
  }
  if (keypress == "BACKSPACE") {
    if (select_delete) {
      if (ext_delete.length() > 0) ext_delete = ext_delete.substring(0, ext_delete.length() - 1);
    }
    if (select_rename) {
      if (new_name.length() > 0) new_name = new_name.substring(0, new_name.length() - 1);
    }
    if (select_sframe) {
      if (sframe.length() > 0) sframe = sframe.substring(0, sframe.length() - 1);
    }
  } else if (keypress == "CODED") {
    if (select_delete) {
      ext_delete += key;
      batchCountDeleteFiles();
    }
    if (select_rename) {
      new_name += key;
      batchCountRenameFiles();
    }
  }
  if (keypress == "ENTER") {
    select_delete = false;
    select_rename = false;
    select_sframe = false;
  }
  if (keypress == "27") {
    if (select_rename) {
      new_name = esc;
    }
    if (select_sframe) {
      sframe = esc;
    }
    if (select_delete) {
      ext_delete = esc;
    }
  }
}


void  mouseEventsBatch()
{
  if (path_batch_()) {
    selectInput("Select path:", "pathBatch");
  }
  if (rename_batch_()) { 
    select_delete = false;
    select_rename = false;
    select_sframe = false;

    batchRename();
  }
  if (delete_batch_()) { 
    select_delete = false;
    select_rename = false;
    select_sframe = false;
    batchDelete();
  }
  if (newname_batch_()) { 
    esc = new_name;
    new_name = "";
    select_rename = true;
    select_delete = false;
    select_sframe = false;
  }
  if (extension_batch_()) {
    esc = ext_delete;
    ext_delete = "";
    select_delete = true;
    select_rename = false;
    select_sframe = false;
  }
  if (sframe_batch_()) {
    esc = sframe;
    sframe = "";
    select_sframe = true;
    select_delete = false;
    select_rename = false;
  }
  batchCountDeleteFiles();
  batchCountRenameFiles();
}


void pathBatch(File selection) 
{
  if (selection != null) {
    path_batch = selection.getAbsolutePath();

    ext_delete = selection.getName();
    ext_delete = ext_delete.substring(ext_delete.lastIndexOf(".")+1);
    ext_rename = ext_delete;
    path_batch = path_batch.substring(0, path_batch.lastIndexOf(File.separator)+1);

    batchCountDeleteFiles();
    batchCountRenameFiles();
  }
    redraw();
}


void batchCountRenameFiles()
{
  rename_files = 0;
  File dir = new File(path_batch);
  String[] fList = sort(dir.list());
  for (int x = 0; x < fList.length; x++) {
    File f = new File(path_batch+fList[x]);
    File newf = new File(path_batch+new_name+nf(x + int(sframe), sframe.length())+"."+ext_rename);
    if (f.isFile()) {
      if (!newf.exists() && f.getName().endsWith(ext_rename)) {
        rename_files = rename_files + 1;
      }
    }
  }
}


void batchCountDeleteFiles()
{
  File folder = new File(path_batch);
  File fList[] = folder.listFiles();
  delete_files = 0;
  for (File f : fList) {
    if (f.isFile()) {
      if (f.getName().endsWith("."+ext_delete)) {
        delete_files = delete_files + 1;
      }
    }
  }
}


void batchDelete()
{
  File folder = new File(path_batch);
  File fList[] = folder.listFiles();

  for (File f : fList) {
    if (f.isFile()) {
      if (f.getName().endsWith("."+ext_delete)) {
        f.delete();
      }
    }
  }
}

int y = -1;

void batchRename()
{
  for (int i = 0; i < rename_files; i++) {
    y = -1;
    File dir = new File(path_batch);
    String[] fList = sort(dir.list());
    for (int x = 0; x < fList.length; x++) {
      File f = new File(path_batch+fList[x]);
      if (f.isFile() && f.getName().endsWith(ext_rename)) {
        y = y + 1;
        File newf = new File(path_batch+new_name+nf(y + int(sframe), sframe.length())+"."+ext_rename);
        if (!newf.exists()) {
          f.renameTo(newf);
        }
      }
    }
  }
}