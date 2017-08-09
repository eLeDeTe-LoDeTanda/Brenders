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
  if (terminal_default_()) selectInput("Select Terminal executable:", "terminalSelect", terminalfolder);
  if (terminal_default_open_()) {
    info = "*Opening...";
    if (os == "WINDOWS") {
      write = createWriter(dataPath("")+File.separator+"tmp"+File.separator+"cmd.bat");
      write.println("start ");
      write.print(terminalpath);
      write.flush();
      write.close();

      exec(dataPath("")+File.separator+"tmp"+File.separator+"cmd.bat");
    } else exec(terminalpath);
  }
  if (texteditor_default_()) selectInput("Select Text editor executable:", "texteditorSelect", texteditorfolder);
  if (texteditor_default_open_()) {
    info = "*Opening...";
    if (os == "WINDOWS") exec(texteditorpath);
    else {
      String cmd[] = {terminalpath, "-e", texteditorpath};
      exec(cmd);
    }
  }
  if (filemanager_default_()) selectInput("Select File Manager executable:", "managerSelect", explorerfolder);
  if (filemanager_default_open_()) {
    info = "*Opening...";
    exec(managerpath);
  }
  if (imageviewer_default_()) selectInput("Select Text editor executable:", "imageviewerSelect", imageviewerfolder);
  if (imageviewer_default_open_()) {
    info = "*Opening...";
    exec(imageviewerpath);
  }
  if (settings_path_open_()) {
    info = "*Opening...";
    String cmd[] = {managerpath, settingspath.substring(0, settingspath.lastIndexOf(File.separator)+1)};
    exec(cmd);
  }
  if (blender_default_()) selectInput("Select Blender executable:", "blenderSelect", blenderfolder);
  if (blender_default_open_()) {
    info = "*Opening Blender...";
    exec(blenderpath);
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
        if (lines[i].contains("[Terminal]")) terminalpath = lines[i+1];
        else if (lines[i].contains("[TextEditor]")) texteditorpath = lines[i+1];
        else if (lines[i].contains("[FileManager]")) managerpath = lines[i+1];
        else if (lines[i].contains("[Blender]")) blenderpath = lines[i+1];
        else if (lines[i].contains("[ImageViewer]")) imageviewerpath = lines[i+1];
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
        if (lines[i].contains("[Terminal]")) terminalpath = lines[i+1];
        else if (lines[i].contains("[TextEditor]")) texteditorpath = lines[i+1];
        else if (lines[i].contains("[FileManager]")) managerpath = lines[i+1];
        else if (lines[i].contains("[Blender]")) blenderpath = lines[i+1];
        else if (lines[i].contains("[ImageViewer]")) imageviewerpath = lines[i+1];
      }
    }
  }
}

void savePreferences()
{
  redraw();

  if (os == "WINDOWS") write = createWriter(dataPath("Preferences"+File.separator+"extern_Windows.txt"));
  else write = createWriter(dataPath("Preferences"+File.separator+"extern_Linux.txt"));

  write.println("[Blender]");
  write.println(blenderpath);
  write.println();
  write.println("[Terminal]");
  write.println(terminalpath);
  write.println();
  write.println("[TextEditor]");
  write.println(texteditorpath);
  write.println();
  write.println("[FileManager]");
  write.println(managerpath);
  write.println();
  write.println("[ImageViewer]");
  write.println(imageviewerpath);

  write.flush();
  write.close();
}