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
 * The Original Code is Copyright (C) 2017 Marcelo "Tanda" Cerviño. http://lodetanda.blogspot.com/ 
 * All rights reserved.
 *
 * Contributor(s):
 *
 * ***** END GPL LICENSE BLOCK *****
 */

void mouseEventsMultiblend() 
{
  if (new_Proyect_Multiblend_()) {
    selectOutput("Select path and proyect name:", "newProyect", proyectfolder);
  }
  if (open_Proyect_Multiblend_()) {
    selectInput("Select proyect:", "openProyect", proyectfolder);
  }

  if (multiblend_active) {
    if (multiblend_files > 0) {
      if (orderL_Multiblend_() ) {
        order = constrain(order - 1, 0, multiblend_files - 1);
        String path = proyectpath+"Options"+File.separator+multiblend_names[order]+".multiblend";
        loadPy(path);
        settingspath = path;
        settingsfolder = new File(path);
        settingsname = settingspath.substring(settingspath.lastIndexOf(File.separator));
        blendpre = requestImage(proyectpath+"Options"+File.separator+"Previews"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".png");
      }
      if (orderR_Multiblend_() ) {
        order = constrain(order + 1, 0, multiblend_files - 1);
        String path = proyectpath+"Options"+File.separator+multiblend_names[order]+".multiblend";
        loadPy(path);
        settingspath = path;
        settingsfolder = new File(path);
        settingsname = settingspath.substring(settingspath.lastIndexOf(File.separator));
        blendpre = requestImage(proyectpath+"Options"+File.separator+"Previews"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".png");
      }
    }
    if (reload_Multiblend_()) {
      loadMultiblend();
    }

    if (import_Multiblend_()) {
      selectInput("Select your .py or commandline file", "settingsOpen", settingsfolder);
    }
    if (edit_order_Multiblend_()) {
      if (os == "WINDOWS") exec(texteditorpath, proyectpath+proyectname+".brenders");
      else {
        String cmd[] = {terminalpath, "-e", texteditorpath, proyectpath+proyectname+".brenders"};
        exec(cmd);
      }
    }
    if (open_folder_Multiblend_()) {
      info = "*Opening...";
      String cmd[] = {managerpath, proyectpath};
      exec(cmd);
    }
    if (go_Multiblend_()) {
      if (multiblend_files > 0) {
        if (multiblend_restart) {
          multiblend_autorun(proyectpath+"Autorun"+File.separator+proyectname);

          if (os == "WINDOWS") {
            String cmd[]= {terminalpath, "/c", "start", "/w", proyectpath+"Autorun"+File.separator+proyectname+".bat"};
            exec(cmd);
          } else {
            String cmd[] = {terminalpath, "-e", proyectpath+"Autorun"+File.separator+proyectname+".sh"};
            exec(cmd);
          }
          multiblend_restart = false;
          info = "Rendering... You can close Brenders";
        } else {
          error = true;
          info = "Rendering... 'Restart' for overwite";

          /* if (os == "WINDOWS") {
           String cmd[]= {terminalpath, "/c", "start", "/w", proyectpath+proyectname+"-continue.bat"};
           exec(cmd);
           } else {
           String cmd[] = {terminalpath, "-e", proyectpath+proyectname+"-continue.sh"};
           exec(cmd);
           }*/
        }
      } else {
        error = true;
        info = "Proyect empty";
      }
    }
    if (multiblend_files > 0) {
      if (overwrite_Multiblend_()) {
        multiblend_restart = true;
      }
      if (continue_Multiblend_()) {
        multiblend_restart = false;
      }
      if (blendpre_Multiblend_()) {
        loadPy(proyectpath+"Options"+File.separator+multiblend_names[order]+".multiblend");
        multiblend_pre();
      }
      if (framepreL_Multiblend_()) {
        frameprev = constrain(frameprev - 1, 0, 500000);
      }  
      if (framepreR_Multiblend_()) {
        frameprev = constrain(frameprev + 1, 0, 500000);
      }
      if (renderoptions_Multiblend_()) {
        gui = 1;
      }
    }
  }
}

void newProyect(File selection) 
{
  if (selection != null) {
    proyectpath = selection.getAbsolutePath()+File.separator;
    proyectname = selection.getName();

    File folder = new File(proyectpath);
    folder.mkdir();
    folder = new File(proyectpath+"Options");
    folder.mkdir();
    folder = new File(proyectpath+"Autorun");
    folder.mkdir();
    folder = new File(proyectpath+"Manager");
    folder.mkdir();
    folder = new File(proyectpath+"Logs");
    folder.mkdir();
    folder = new File(proyectpath+"Options"+File.separator+"Previews");
    folder.mkdir();

    write = createWriter(proyectpath+proyectname+".brenders");
    write.println("[Proyect Name]");
    write.println(proyectname);
    write.println();
    write.println("[Order]");

    write.flush();
    write.close();
    //info = "*You can test it with '-Open<' bottom.";
    // multiblendRenameFiles();
    multiblend_active = true;

    redraw();
  }
}

void openProyect(File selection) 
{
  if (selection != null) {
    String path = selection.getAbsolutePath(); 
    if (path.endsWith(".brenders")) { 
      proyectpath = selection.getAbsolutePath(); 
      proyectname = selection.getName();
      proyectname = proyectname.substring(0, proyectname.lastIndexOf("."));
      proyectpath = proyectpath.substring(0, proyectpath.lastIndexOf(File.separator)+1);

      loadMultiblend();
    } else {
      error = true;
      info = "*Warning No '.brenders' selected";
    }
    redraw();
  }
}

void loadMultiblend()
{
  multiblend_active = true;

  String lines[] = loadStrings(proyectpath+proyectname+".brenders");
  File dir = new File(proyectpath+"Options"+File.separator);
  String[] fList = dir.list();
  int x = 0;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains("[Order]")) {
      for (int e = 0; e < fList.length; e++) {
        File f = new File(proyectpath+"Options"+File.separator+fList[x]);
        if (f.isFile()) {
          // println(multiblend_names.length);
          multiblend_names[x] = lines[i + 1 + x].substring(0, lines[i + 1 + x].lastIndexOf("."));
          multiblend_files = x + 1;
          x = x + 1;
        }
      }
    }
  }
  info = proyectname;
}

void multiblend_save(String path)
{
  String multiblendpath = proyectpath+"Options"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".multiblend";
  File f = new File(multiblendpath);

  if (path.endsWith(".txt")) {
    loadCommandline(path);
    String fconv = multiblendpath.substring(0, multiblendpath.lastIndexOf("."))+".convert";
    generatepy = true;
    commandLineOptions();
    py_Save(fconv);
    path = fconv;
    if (!f.exists()) {
      saveBytes(f, loadBytes(path));
    }
    File fconvert = new File(fconv);
    fconvert.delete();
  } else {
    saveBytes(f, loadBytes(path));
  }
  loadPy(multiblendpath);
  settingspath = multiblendpath;
  settingsfolder = new File(multiblendpath);
  settingsname = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);
  multiblend_order();
  multiblend_autorun(proyectpath+"Autorun"+File.separator+proyectname);

  precheck();
}

void multiblend_order()
{
  // if (os == "WINDOWS") {
  // } else {
  write = createWriter(proyectpath+proyectname+".brenders");
  write.println("[Proyect Name]");
  write.println(proyectname);
  write.println();
  write.println("[Order]");
  File dir = new File(proyectpath+"Options"+File.separator);
  String[] fList = sort(dir.list());
  int x = 0;
  for (int i = 0; i < fList.length; i++) {
    File f = new File(proyectpath+"Options"+File.separator+fList[x]);
    if (f.isFile()) {
      write.println(fList[x]);
      multiblend_names[x] = fList[x].substring(0, fList[x].lastIndexOf("."));
      multiblend_files = x + 1;
      x = x + 1;
    }
  }
  write.flush();
  write.close();
  // }
}

void multiblend_autorun(String path)
{   
  String lines[] = loadStrings(proyectpath+proyectname+".brenders");
  //  File dir = new File(proyectpath+"Options"+File.separator);
  //String[] fList = dir.list();
  String order[] = new String[multiblend_files];
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains("[Order]")) {
      for (int e = 0; e < multiblend_files; e++) {
        order[e] = lines[i + 1 + e];
      }
    }
  }

  if (os == "WINDOWS") {
    write = createWriter(path+".bat");
    write.println("@ECHO OFF");
    write.println("COLOR 8F");
    write.println();
    write.println("@ECHO -");
    write.println("@ECHO START renders...");
    write.println("@ECHO -");
    write.println("PAUSE");
    write.println("@ECHO -");
    write.println("@ECHO RENDERING...");
    write.println("@ECHO -");
    for (int a = 0; a < order.length; a++) {
      loadPy(proyectpath+"Options"+File.separator+order[a]);
      //write.print("xterm -e ");
      //write.print("echo $(date +'%H:%M:%S') Start: "+order[a]+" 2>&1 | tee -a ");
      // write.println('"'+proyectpath+"Manager"+File.separator+"RenderStatus.log"+'"');   
      // write.println();
      write.print("call ");
      write.print('"'+blenderpath+'"');
      write.print(" -b ");
      write.print('"'+blendpath+blendname+'"');
      write.print(" -P ");
      write.print('"'+proyectpath+"Options"+File.separator+order[a]+'"');
     // write.print(" 2>&1 | tee ");
     // write.println('"'+proyectpath+"Logs"+File.separator+"$(date +'%Y-%m-%d_%H:%M:%S_')"+order[a].substring(0, order[a].lastIndexOf("."))+".log"+'"');
      write.println();
      // write.print("echo $(date +'%H:%M:%S') Finish: "+order[a]+" 2>&1 | tee -a ");
      // write.println('"'+proyectpath+"Manager"+File.separator+"RenderStatus.log"+'"');   
      // write.println();
    }   
    write.println("@ECHO -");
    write.println("@ECHO FINISH!");
    write.println("@ECHO -");
    write.println("PAUSE");
    write.print("exit");

    write.flush();
    write.close();
  } else {
    write = createWriter(path+".sh");
    write.println("#!/bin/bash");
    write.println();
    write.println("# Auto-generated by " + version);
    write.println();
    write.println("# Command Line:");
    write.println();
    write.print("echo ---------- $(date +'%Y-%m-%d') ---------- 2>&1 | tee -a ");
    write.println('"'+proyectpath+"Manager"+File.separator+"RenderStatus.log"+'"');   

    for (int a = 0; a < order.length; a++) {
      loadPy(proyectpath+"Options"+File.separator+order[a]);
      //write.print("xterm -e ");
      write.print("echo $(date +'%H:%M:%S') Start: "+order[a]+" 2>&1 | tee -a ");
      write.println('"'+proyectpath+"Manager"+File.separator+"RenderStatus.log"+'"');   
      write.println();
      write.print('"'+blenderpath+'"');
      write.print(" -b ");
      write.print('"'+blendpath+blendname+'"');
      write.print(" -P ");
      write.print('"'+proyectpath+"Options"+File.separator+order[a]+'"');
      write.print(" 2>&1 | tee ");
      write.println('"'+proyectpath+"Logs"+File.separator+"$(date +'%Y-%m-%d_%H:%M:%S_')"+order[a].substring(0, order[a].lastIndexOf("."))+".log"+'"');
      write.println();
      write.print("echo $(date +'%H:%M:%S') Finish: "+order[a]+" 2>&1 | tee -a ");
      write.println('"'+proyectpath+"Manager"+File.separator+"RenderStatus.log"+'"');   
      write.println();
    }
    write.print("echo ------------------------------- 2>&1 | tee -a ");
    write.println('"'+proyectpath+"Manager"+File.separator+"RenderStatus.log"+'"');   

    write.flush();
    write.close();

    File fexec = new File(path+".sh");
    fexec.setExecutable(true, false);
  }
}

void multiblend_addtomulti()
{
  String multiblendpath = proyectpath+"Options"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".multiblend";
  commandLineOptions();
  py_Save(multiblendpath);
  add_tomulti = false;
  multiblend_order();
  loadMultiblend();
  multiblend_autorun(proyectpath+"Autorun"+File.separator+proyectname);
  info = "Saved: "+settingsname.substring(0, settingsname.lastIndexOf("."));
}

void multiblend_pre()
{

  write = createWriter(dataPath("tmp")+File.separator+"blend_prev.py");

  write.println("# Auto-generated by "+version);
  write.println("# https://github.com/eLeDeTe-LoDeTanda/Brenders");
  write.println();
  write.println("import bpy");
  write.println();
  write.println("# Render Options to change");
  write.println("############################");
  write.println();

  write.println("# Scene Name");
  write.print("Scenename = ");
  if (fromblend[scene_name_id]) write.println("bpy.context.scene.name");
  else write.println('"'+scenename+'"');
  write.println();
  write.println("# Render Quality");
  write.print("bpy.data.scenes[Scenename].render.resolution_x = ");
  write.println("128");
  write.print("bpy.data.scenes[Scenename].render.resolution_y = ");
  write.println("128");
  write.print("bpy.data.scenes[Scenename].render.resolution_percentage = ");
  write.println("100");
  write.println();

  write.println("# stamp");
  write.print("bpy.data.scenes[Scenename].render.use_stamp = ");
  write.println("False");
  write.println();

  write.println("# Render frame");

  write.print("bpy.data.scenes[Scenename].frame_current = ");
  write.println(frameprev);
  write.println();

  write.println("# Render OpenGL");
  write.println("bpy.ops.render.opengl(view_context = False)");
  write.println();

  write.println("bpy.data.images['Render Result'].save_render("+'"'+proyectpath+"Options"+File.separator+"Previews"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".png"+'"'+")");
  write.println();

  write.println("bpy.ops.wm.quit_blender()");
  write.println();
  write.print("####################################");

  write.flush();
  write.close();

  if (os == "WINDOWS") {
    write = createWriter(dataPath("tmp")+File.separator+"blend_prev.bat");

    write.println("@ECHO OFF");
    write.println("COLOR 8F");
    write.println();
    write.print("call ");
    write.print('"'+blenderpath+'"');
    write.print(" ");
    write.print('"'+blendpath+blendname+'"');
    write.print(" -P ");
    write.print('"'+dataPath("tmp")+File.separator+"blend_prev.py"+'"');
    write.println();
    write.print("exit");

    write.flush();
    write.close();

    String cmd[]= {terminalpath, "/c", "start", "/w", dataPath("tmp")+File.separator+"blend_prev.bat"};
    exec(cmd);
  } else {
    write = createWriter(dataPath("tmp")+File.separator+"blend_prev.sh");
    write.println("#!/bin/bash");
    write.println();
    write.println("# Auto-generated by " + version);
    write.println();
    write.println("# Command Line:");
    write.println();
    write.print('"'+blenderpath+'"');
    write.print(" ");
    write.print('"'+blendpath+blendname+'"');
    write.print(" -P ");
    write.print('"'+dataPath("tmp")+File.separator+"blend_prev.py"+'"');

    write.flush();
    write.close();

    File fexec = new File(dataPath("tmp")+File.separator+"blend_prev.sh");
    fexec.setExecutable(true, false);

    String cmd[] = {terminalpath, "-e", dataPath("tmp")+File.separator+"blend_prev.sh"};
    exec(cmd);
  }
}

void precheck()
{
  File img = new File(proyectpath+"Options"+File.separator+"Previews"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".png");
  if (!img.exists())  multiblend_pre();
}