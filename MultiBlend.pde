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

void initvarMultiblend()
{
  if (os == "WINDOWS") {
    File f = new File(dataPath(dataPath("Proyects")+File.separator+"recent_Windows.txt"));
    if (!f.exists()) {
      write = createWriter(dataPath("Proyects")+File.separator+"recent_Windows.txt");
      write.println("[Recent]");
      write.println("None");
      write.println("None");
      write.println("None");
      write.println("None");
      write.println("None");
      write.println("None");

      write.flush();
      write.close();
    } 
    String lines[] = loadStrings(dataPath("Proyects")+File.separator+"recent_Windows.txt");
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains("[Recent]")) {
        recentproyect[0] = lines[i+1];
        recentproyect[1] = lines[i+2];
        recentproyect[2] = lines[i+3];
        recentproyect[3] = lines[i+4];
        recentproyect[4] = lines[i+5];
        recentproyect[5] = lines[i+6];  
        break;
      }
    }
  } else {
    File f = new File(dataPath(dataPath("Proyects")+File.separator+"recent_Linux.txt"));
    if (!f.exists()) {
      write = createWriter(dataPath("Proyects")+File.separator+"recent_Linux.txt");
      write.println("[Recent]");
      write.println("None");
      write.println("None");
      write.println("None");
      write.println("None");
      write.println("None");
      write.println("None");

      write.flush();
      write.close();
    } 
    String lines[] = loadStrings(dataPath("Proyects")+File.separator+"recent_Linux.txt");
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains("[Recent]")) {
        recentproyect[0] = lines[i+1];
        recentproyect[1] = lines[i+2];
        recentproyect[2] = lines[i+3];
        recentproyect[3] = lines[i+4];
        recentproyect[4] = lines[i+5];
        recentproyect[5] = lines[i+6];  
        break;
      }
    }
  }
}


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

        precheck();

        fromblend();
        loadfromblend();
      }
      if (orderR_Multiblend_() ) {
        order = constrain(order + 1, 0, multiblend_files - 1);
        String path = proyectpath+"Options"+File.separator+multiblend_names[order]+".multiblend";

        loadPy(path);

        settingspath = path;
        settingsfolder = new File(path);
        settingsname = settingspath.substring(settingspath.lastIndexOf(File.separator));

        precheck();

        fromblend();
        loadfromblend();
      }
    }
    if (reload_Multiblend_()) {
      loadMultiblend(false);

      precheck();
    }
    if (import_Multiblend_()) {
      selectInput("Select your .py or commandline file", "settingsOpen", settingsfolder);
    }
    if (open_folder_Multiblend_()) {
      info = "*Opening...";
      String cmd[] = {managerpath, proyectpath};
      exec(cmd);
    }
    if (rendermanager_Multiblend_()) {
      gui = 2;
    }
    if (go_Multiblend_()) {
      if (multiblend_files > 0) {
        if (multiblend_restart) {
          loadMultiblend(false);
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
          info = "Rendering... 'Restart' for overwrite";
        }
      } else {
        error = true;
        info = "Proyect empty";
      }
    }
    if (multiblend_files > 0) {
      if (order_Multiblend_()) {
        multiblend_selectinorder();
        if (os == "WINDOWS") {
          try {
            String cmd[] = {texteditorpath, proyectpath+proyectname+".brenders"};
            Process proc = Runtime.getRuntime().exec(cmd);
            proc.waitFor();
          } 
          catch(Exception e) {
            e.printStackTrace();
          }
        } else {
          try {
            String cmd[] = {terminalpath, "-e", texteditorpath, proyectpath+proyectname+".brenders"};
            Process proc = Runtime.getRuntime().exec(cmd);
            proc.waitFor();
          } 
          catch(Exception e) {
            e.printStackTrace();
          }
        }
        loadMultiblend(false);
        precheck();
        info = "'RELOADED' new order";
      }
      if (rename_Multiblend_()) {
        settingsfolder = new File(settingspath.substring(0, settingspath.lastIndexOf(File.separator)+1)+settingsname);
        selectOutput("New name: "+settingsname, "settingsRename", settingsfolder);
      }
      if (delete_Multiblend_()) {
        multiblend_delete();
        loadMultiblend(false);
      }
      if (overwrite_Multiblend_()) {
        multiblend_restart = true;
      }
      if (continue_Multiblend_()) {
        multiblend_restart = false;
      }
      if (openblend_Multiblend_()) {
        info = "*Opening "+blendname+" ...";
        String cmd[] = {blenderpath, blendpath+blendname};
        exec(cmd);
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
      if (edit_Multiblend_()) {
        gui = 1;
      }
    }
  } else if (recent_Multiblend_()) {
    int Y = floor(map(mouseY, 215, 320, 0, 5));

    String path = recentproyect[Y]; 
    if (path.endsWith(".brenders")) {
      proyectpath = path; 
      proyectname = path.substring(path.lastIndexOf(File.separator) + 1, path.lastIndexOf("."));
      proyectpath = proyectpath.substring(0, proyectpath.lastIndexOf(File.separator) + 1);
      loadMultiblend(false);
      loadMultiblend(false);
      String multiblendpath = proyectpath+"Options"+File.separator+multiblend_names[order]+".multiblend";
      loadPy(multiblendpath);
      settingspath = multiblendpath;
      settingsfolder = new File(multiblendpath);
      settingsname = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);

      precheck();
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

    write = createWriter(proyectpath+proyectname+".brenders");
    write.println("[Proyect Name]");
    write.println(proyectname);
    write.println();
    write.println("[Order]");

    write.flush();
    write.close();

    multiblend_files = 0;
    multiblend_active = true;

    info = "New proyect created!";

    addrecentproyect();
  }
  redraw();
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

      loadMultiblend(false);
      String multiblendpath = proyectpath+"Options"+File.separator+multiblend_names[order]+".multiblend";
      loadPy(multiblendpath);
      settingspath = multiblendpath;
      settingsfolder = new File(multiblendpath);
      settingsname = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);

      precheck();
      addrecentproyect();
    } else {
      error = true;
      info = "*Warning No '.brenders' selected";
    }
  }
  redraw();
}


void loadMultiblend(boolean addmulti)
{
  multiblend_addinorder(addmulti);
  multiblend_active = true;
  multiblend_files = 0;

  String lines[] = loadStrings(proyectpath+proyectname+".brenders");
  int x = 0;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains(".multiblend")) {
      lines[i] = trim(lines[i]);
      multiblend_names[x] = lines[i].substring(0, lines[i].lastIndexOf("."));
      multiblend_files = x + 1;
      x = x + 1;
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

  order = multiblend_files;

  loadMultiblend(true);

  jsonManager();

  multiblend_autorun(proyectpath+"Autorun"+File.separator+proyectname);

  precheck();
}


void multiblend_rename()
{
  String path = proyectpath+proyectname+".brenders";
  String lines[] = loadStrings(path);
  write = createWriter(path);
  int x = 0;
  for (int i = 0; i < lines.length; i++) {
    x = x + 1;
    if (!lines[i].contains(".multiblend")) {
      write.println(trim(lines[i]));
      if (lines[i].contains("[Order]")) x = -1;
    } else {
      if (x == order) write.println(settingsname);
      else write.println(trim(lines[i]));
    }
  } 
  write.flush();
  write.close();

  loadMultiblend(false);
}


void multiblend_delete()
{
  File f = new File(settingspath);
  f.delete();
  File f_pre = new File(proyectpath+"Options"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".png");
  f_pre.delete();

  String path = proyectpath+proyectname+".brenders";
  String lines[] = loadStrings(path);
  write = createWriter(path);
  int x = 0;
  for (int i = 0; i < lines.length; i++) {
    x = x + 1;
    if (!lines[i].contains(".multiblend")) {
      write.println(trim(lines[i]));
      if (lines[i].contains("[Order]")) x = -1;
    } else {
      if (x != order) write.println(trim(lines[i]));
    }
  } 
  write.flush();
  write.close();

  order = 0;
  loadMultiblend(false);
}


void multiblend_addinorder(boolean add)
{
  String path = proyectpath+proyectname+".brenders";
  String[] lines = loadStrings(path);

  write = createWriter(path);

  for (int i = 0; i < lines.length; i++) {
    write.println(trim(lines[i]));
    if (lines[i].contains("[Order]")) break;
  } 
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains(".multiblend")) {
      String multipath = trim(lines[i].substring(0, lines[i].lastIndexOf(".multiblend") + 11));

      File f = new File(proyectpath+"Options"+File.separator+multipath);

      if (f.exists()) write.println(multipath);
    }
  }
  if (add) write.print(settingsname);

  write.flush();
  write.close();
}


void multiblend_selectinorder()
{
  loadMultiblend(false);

  String path = proyectpath+proyectname+".brenders";
  String lines[] = loadStrings(path);
  write = createWriter(path);
  int x = 0;
  for (int i = 0; i < lines.length; i++) {
    x = x + 1;
    if (!lines[i].contains(".multiblend")) {
      write.println(trim(lines[i]));
      if (lines[i].contains("[Order]")) x = -1;
    } else {
      if (x != order) write.println(trim(lines[i]));
      else  write.println(trim(lines[i])+"  <<<<-Selected->>>>");
    }
  } 
  write.flush();
  write.close();
}


void multiblend_autorun(String path)
{   
  String lines[] = loadStrings(proyectpath+proyectname+".brenders");
  String order_name[] = new String[multiblend_files];
  int x = 0;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains(".multiblend")) {
      lines[i] = trim(lines[i]);
      order_name[x] = lines[i];
      x = x + 1;
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
    for (int a = 0; a < order_name.length; a++) {
      loadPy(proyectpath+"Options"+File.separator+order_name[a]);
      write.print("call ");
      write.print('"'+blenderpath+'"');
      if (!oglrenders) write.print(" -b ");
      else write.print(" - ");
      write.print('"'+blendpath+blendname+'"');
      write.print(" -P ");
      write.print('"'+proyectpath+"Options"+File.separator+order_name[a]+'"');
      write.println();
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

    for (int a = 0; a < order_name.length; a++) {
      loadPy(proyectpath+"Options"+File.separator+order_name[a]);
      write.print("echo $(date +'%H:%M:%S') Start: "+order_name[a]+" 2>&1 | tee -a ");
      write.println('"'+proyectpath+"Manager"+File.separator+"RenderStatus.log"+'"');   
      write.println();
      write.print('"'+blenderpath+'"');
      if (!oglrenders) write.print(" -b ");
      else write.print(" - ");
      write.print('"'+blendpath+blendname+'"');
      write.print(" -P ");
      write.print('"'+proyectpath+"Options"+File.separator+order_name[a]+'"');
      write.print(" 2>&1 | tee ");
      write.println('"'+proyectpath+"Logs"+File.separator+"$(date +'%Y-%m-%d_%H:%M:%S_')"+order_name[a].substring(0, order_name[a].lastIndexOf("."))+".log"+'"');
      write.println();
      write.print("echo $(date +'%H:%M:%S') Finish: "+order_name[a]+" 2>&1 | tee -a ");
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

  order = multiblend_files;

  loadMultiblend(true);

  jsonManager();

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

  write.println("bpy.data.images['Render Result'].save_render("+'"'+proyectpath+"Options"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".png"+'"'+")");
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
    try {
      String cmd[]= {terminalpath, "/c", "start", "/w", dataPath("tmp")+File.separator+"blend_prev.bat"};
      Process proc = Runtime.getRuntime().exec(cmd);
      proc.waitFor();
    } 
    catch(Exception e) {
      e.printStackTrace();
    }
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

    File f_sh = new File(dataPath("tmp")+File.separator+"blend_prev.sh");
    f_sh.setExecutable(true, false);

    try {
      String cmd[] = {terminalpath, "-e", dataPath("tmp")+File.separator+"blend_prev.sh"};
      Process proc = Runtime.getRuntime().exec(cmd);
      proc.waitFor();
    } 
    catch(Exception e) {
      e.printStackTrace();
    }
    blendpre = requestImage(proyectpath+"Options"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".png");
  }
  if (os == "WINDOWS") {
    File f_bat = new File (dataPath("tmp")+File.separator+"blend_prev.bat");
    f_bat.delete();
  } else {
    File f_sh = new File(dataPath("tmp")+File.separator+"blend_prev.sh");
    f_sh.delete();
    File f_py = new File (dataPath("tmp")+File.separator+"blend_prev.py");
    f_py.delete();
  }
}


void precheck()
{
  File img = new File(proyectpath+"Options"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".png");
  if (!img.exists()) blendpre = loadImage("Img"+File.separator+"None.png");
  else  blendpre = loadImage(proyectpath+"Options"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".png");
}

void addrecentproyect()
{
  if (os == "WINDOWS") {
    write = createWriter(dataPath("Proyects")+File.separator+"recent_Windows.txt");
    write.println("[Recent]");
    write.println(proyectpath+proyectname+".brenders");
    write.println(recentproyect[0]);
    write.println(recentproyect[1]);
    write.println(recentproyect[2]);
    write.println(recentproyect[3]);
    write.println(recentproyect[4]);

    write.flush();
    write.close();

    String lines[] = loadStrings(dataPath("Proyects")+File.separator+"recent_Windows.txt");
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains("[Recent]")) {
        recentproyect[0] = lines[i+1];
        recentproyect[1] = lines[i+2];
        recentproyect[2] = lines[i+3];
        recentproyect[3] = lines[i+4];
        recentproyect[4] = lines[i+5];
        recentproyect[5] = lines[i+6];  
        break;
      }
    }
  } else {
    write = createWriter(dataPath("Proyects")+File.separator+"recent_Linux.txt");

    write.println("[Recent]");
    write.println(proyectpath+proyectname+".brenders");
    write.println(recentproyect[0]);
    write.println(recentproyect[1]);
    write.println(recentproyect[2]);
    write.println(recentproyect[3]);
    write.println(recentproyect[4]);

    write.flush();
    write.close();

    String lines[] = loadStrings(dataPath("Proyects")+File.separator+"recent_Linux.txt");
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains("[Recent]")) {
        recentproyect[0] = lines[i+1];
        recentproyect[1] = lines[i+2];
        recentproyect[2] = lines[i+3];
        recentproyect[3] = lines[i+4];
        recentproyect[4] = lines[i+5];
        recentproyect[5] = lines[i+6];  
        break;
      }
    }
  }
}