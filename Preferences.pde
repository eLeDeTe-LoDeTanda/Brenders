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

void mouseEventsPreferences()
{
  if (terminal_default_()) selectInput("Select Terminal executable:", "terminalSelect", terminal_folder);
  if (terminal_default_open_()) {
    info = "*Opening...";
    if (os == "WINDOWS") {
      write = createWriter(dataPath("")+File.separator+"tmp"+File.separator+"cmd.bat");
      write.println("start ");
      write.print(terminal_path);
      write.flush();
      write.close();

      exec(dataPath("")+File.separator+"tmp"+File.separator+"cmd.bat");
    } else exec(terminal_path);
  }
  if (texteditor_default_()) selectInput("Select Text editor executable:", "texteditorSelect", text_editor_folder);
  if (texteditor_default_open_()) {
    info = "*Opening...";
    if (os == "WINDOWS") exec(text_editor_path);
    else {
      String cmd[] = {terminal_path, "-e", text_editor_path};
      exec(cmd);
    }
  }
  if (filemanager_default_()) selectInput("Select File Manager executable:", "managerSelect", explorer_folder);
  if (filemanager_default_open_()) {
    info = "*Opening...";
    exec(manager_path);
  }
  if (imageviewer_default_()) selectInput("Select Text editor executable:", "imageviewerSelect", image_viewer_folder);
  if (imageviewer_default_open_()) {
    info = "*Opening...";
    exec(image_viewer_path);
  }
  if (settings_path_open_()) {
    info = "*Opening...";
    String cmd[] = {manager_path, settings_path.substring(0, settings_path.lastIndexOf(File.separator)+1)};
    exec(cmd);
  }
  if (blender_default_()) selectInput("Select Blender executable:", "blenderSelect", blender_folder);
  if (blender_default_open_()) {
    info = "*Opening Blender...";
    exec(blender_path);
  }

  if (load_factory_()) {
    if (os == "WINDOWS") { 
      File f = new File(dataPath("Preferences"+File.separator+"extern_Windows.txt"));
      f.delete();

      write = createWriter(dataPath("Preferences"+File.separator+"extern_Windows.txt"));
      write.println("[Blender]");
      write.println("C:"+File.separator+"Program Files"+File.separator+"Blender Foundation"+File.separator+"blender"+File.separator+"Blender.exe");
      write.println();
      write.println("[Terminal]");
      write.println("cmd.exe");
      write.println();
      write.println("[TextEditor]");
      write.println("NOTEPAD.exe");
      write.println();
      write.println("[FileManager]");
      write.println("explorer.exe");
      write.println();
      write.println("[ImageViewer]");
      write.println("explorer.exe");

      write.flush();
      write.close();

      String lines[] = loadStrings(dataPath("Preferences"+File.separator+"extern_Windows.txt"));
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].contains("[Terminal]")) terminal_path = lines[i+1];
        else if (lines[i].contains("[TextEditor]")) text_editor_path = lines[i+1];
        else if (lines[i].contains("[FileManager]")) manager_path = lines[i+1];
        else if (lines[i].contains("[Blender]")) blender_path = lines[i+1];
        else if (lines[i].contains("[ImageViewer]")) image_viewer_path = lines[i+1];
      }
    } else {
      File f = new File(dataPath("Preferences"+File.separator+"extern_Linux.txt"));
      f.delete();

      write = createWriter(dataPath("Preferences"+File.separator+"extern_Linux.txt"));
      write.println("[Blender]");
      write.println("/usr/bin/blender");
      write.println();
      write.println("[Terminal]");
      write.println("/usr/bin/xterm");
      write.println();
      write.println("[TextEditor]");
      write.println("/usr/bin/vi");
      write.println();
      write.println("[FileManager]");
      write.println("/usr/bin/nautilus");
      write.println();
      write.println("[ImageViewer]");
      write.println("/usr/bin/eog");

      write.flush();
      write.close();

      String lines[] = loadStrings(dataPath("Preferences"+File.separator+"extern_Linux.txt"));
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].contains("[Terminal]")) terminal_path = lines[i+1];
        else if (lines[i].contains("[TextEditor]")) text_editor_path = lines[i+1];
        else if (lines[i].contains("[FileManager]")) manager_path = lines[i+1];
        else if (lines[i].contains("[Blender]")) blender_path = lines[i+1];
        else if (lines[i].contains("[ImageViewer]")) image_viewer_path = lines[i+1];
      }
    }
  }
}

void savePreferences()
{
  if (os == "WINDOWS") write = createWriter(dataPath("Preferences"+File.separator+"extern_Windows.txt"));
  else write = createWriter(dataPath("Preferences"+File.separator+"extern_Linux.txt"));

  write.println("[Blender]");
  write.println(blender_path);
  write.println();
  write.println("[Terminal]");
  write.println(terminal_path);
  write.println();
  write.println("[TextEditor]");
  write.println(text_editor_path);
  write.println();
  write.println("[FileManager]");
  write.println(manager_path);
  write.println();
  write.println("[ImageViewer]");
  write.println(image_viewer_path);

  write.flush();
  write.close();
}