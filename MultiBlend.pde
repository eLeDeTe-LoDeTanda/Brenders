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
    File f = new File(dataPath("Preferences"+File.separator+"recent_Windows.txt"));
    if (!f.exists()) {
      write = createWriter(dataPath("Preferences"+File.separator+"recent_Windows.txt"));
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
    String lines[] = loadStrings(dataPath("Preferences"+File.separator+"recent_Windows.txt"));
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
    File f = new File(dataPath("Preferences"+File.separator+"recent_Linux.txt"));
    if (!f.exists()) {
      write = createWriter(dataPath("Preferences"+File.separator+"recent_Linux.txt"));
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
    String lines[] = loadStrings(dataPath("Preferences"+File.separator+"recent_Linux.txt"));
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


void keyEventsMultiblend(String keypress)
{
  if (keypress == "number") {
    if (frameprev.length() < 5) frameprev += key;
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

        fromblend(false);
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

        fromblend(false);
        loadfromblend();
      }
    }
    if (reload_Multiblend_()) {
      loadMultiblend(false);
      fromblend(true);
      loadfromblend();
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
        if (multiblend_renders[0]) {
          loadMultiblend(false);
          multiblend_autorun(proyectpath+"Autorun"+File.separator+proyectname);

          if (os == "WINDOWS") {
            String cmd[]= {terminalpath, "/c", "start", "/w", proyectpath+"Autorun"+File.separator+proyectname+".bat"};
            exec(cmd);
          } else {
            String cmd[] = {terminalpath, "-e", proyectpath+"Autorun"+File.separator+proyectname+".sh"};
            exec(cmd);
          }
          multiblend_renders[0] = false;
          multiblend_renders[1] = false;
          multiblend_renders[2] = false;
          info = "Rendering... You can close Brenders";
        } else if (multiblend_renders[1]) {
          loadMultiblend(false);
          commandLineOptions();
          py_Save_bads(proyectpath+"Options"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+"_bads.multiblend");
          multiblend_autorun(proyectpath+"Autorun"+File.separator+proyectname);

          if (os == "WINDOWS") {
            String cmd[]= {terminalpath, "/c", "start", "/w", proyectpath+"Autorun"+File.separator+proyectname+"_bads.bat"};
            exec(cmd);
          } else {
            String cmd[] = {terminalpath, "-e", proyectpath+"Autorun"+File.separator+proyectname+"_bads.sh"};
            exec(cmd);
          }
          multiblend_renders[0] = false;
          multiblend_renders[1] = false;
          multiblend_renders[2] = false;
        } else if (multiblend_renders[2]) {
          loadMultiblend(false);
          multiblend_autorun(proyectpath+"Autorun"+File.separator+proyectname);

          if (os == "WINDOWS") {
            String cmd[]= {terminalpath, "/c", "start", "/w", proyectpath+"Autorun"+File.separator+proyectname+"_continue.bat"};
            exec(cmd);
          } else {
            String cmd[] = {terminalpath, "-e", proyectpath+"Autorun"+File.separator+proyectname+"_continue.sh"};
            exec(cmd);
          }
          multiblend_renders[0] = false;
          multiblend_renders[1] = false;
          multiblend_renders[2] = false;
        } else {
          error = true;
          info = "Select 'All' 'Bad' or 'Continue'";
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
      if (all_Multiblend_()) {
        multiblend_renders[0] = true;
        multiblend_renders[1] = false;
        multiblend_renders[2] = false;
      }
      if (bad_Multiblend_()) {
        multiblend_renders[0] = false;
        multiblend_renders[1] = true;
        multiblend_renders[2] = false;
      }
      if (continue_Multiblend_()) {
        multiblend_renders[0] = false;
        multiblend_renders[1] = false;
        multiblend_renders[2] = true;
      }
      if (openblend_Multiblend_()) {
        info = "*Opening "+blendname+" ...";
        String cmd[] = {blenderpath, blendpath+blendname};
        exec(cmd);
      }
      if (blendpre_Multiblend_()) {
        if (int(frameprev) <= 0) frameprev = "1";
        loadPy(proyectpath+"Options"+File.separator+multiblend_names[order]+".multiblend");
        multiblend_pre();
      }
      if (framepre_Multiblend_()) {
        frameprev = "";
      } 
      if (framepreL_Multiblend_()) {
        frameprev = str(constrain(int(frameprev) - 1, 1, 500000));
      }  
      if (framepreR_Multiblend_()) {
        frameprev = str(constrain(int(frameprev) + 1, 1, 500000));
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

      String multiblendpath;
      for (int i = 0; i < multiblend_files; i++) {
        multiblendpath = proyectpath+"Options"+File.separator+multiblend_names[i]+".multiblend";

        loadPy(multiblendpath);
        settingspath = multiblendpath;
        settingsfolder = new File(multiblendpath);
        settingsname = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);
        fromblend(true);
        loadfromblend();
      }
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

      String multiblendpath;
      for (int i = 0; i < multiblend_files; i++) {
        multiblendpath = proyectpath+"Options"+File.separator+multiblend_names[i]+".multiblend";

        loadPy(multiblendpath);
        settingspath = multiblendpath;
        settingsfolder = new File(multiblendpath);
        settingsname = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);
        fromblend(true);
        loadfromblend();
      }
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

  fromblend(false);
  loadfromblend();

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
    if (multiblend_renders[0]) write = createWriter(path+".bat");
    else if (multiblend_renders[1]) write = createWriter(path+"_bads.bat");
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
      if (multiblend_renders[0]) write.print('"'+proyectpath+"Options"+File.separator+order_name[a]+'"');
      else if (multiblend_renders[1]) write.print('"'+proyectpath+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_bads.multiblend"+'"');
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
    if (multiblend_renders[0]) write = createWriter(path+".sh");
    else if (multiblend_renders[1]) write = createWriter(path+"_bads.sh");
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
      if (multiblend_renders[0]) write.print('"'+proyectpath+"Options"+File.separator+order_name[a]+'"');
      else if (multiblend_renders[1]) write.print('"'+proyectpath+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_bads.multiblend"+'"');
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

    if (multiblend_renders[0]) {
      File fexec = new File(path+".sh");
      fexec.setExecutable(true, false);
    } else if (multiblend_renders[1]) {
      File fexec = new File(path+"_bads.sh");
      fexec.setExecutable(true, false);
    }
  }
}


void py_Save_bads(String pypath)
{
  write = createWriter(pypath);

  write.println("# Auto-generated by "+version);
  write.println("# https://github.com/eLeDeTe-LoDeTanda/Brenders");
  write.println();
  write.println("'''");
  changeforblend();
  write.println();
  command_Line();
  write.println("'''");
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
  if (fromblend[pxX_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.resolution_x = ");
  write.println(valoption[pxX_id]);
  if (fromblend[pxY_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.resolution_y = ");
  write.println(valoption[pxY_id]);
  if (fromblend[percentage_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.resolution_percentage = ");
  write.println(valoption[percentage_id]);
  if (fromblend[anti_aliasing_id] || valoption[engine_id] == "CYCLES") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_antialiasing = ");
  write.println(valoption[anti_aliasing_id]);
  if (fromblend[anti_aliasing_id] || valoption[anti_aliasing_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.antialiasing_samples = ");
  write.println('"'+valoption[anti_aliasing_samples_id]+'"');
  if (fromblend[anti_aliasing_id] || valoption[anti_aliasing_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_full_sample = ");
  write.println(valoption[anti_aliasing_fullsamples_id]);
  if (fromblend[tile_x_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.tile_x = ");
  write.println(valoption[tile_x_id]);
  if (fromblend[tile_y_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.tile_y = ");
  write.println(valoption[tile_y_id]);
  if (fromblend[threads_mode_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.threads_mode = ");
  write.println('"'+valoption[threads_mode_id]+'"');
  if (fromblend[threads_mode_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.threads = ");
  write.println(valoption[threads_id]);
  if (fromblend[engine_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.engine = ");
  write.println('"'+valoption[engine_id]+'"');
  if (fromblend[engine_id] || valoption[engine_cyclessamples_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].cycles.samples = ");
  write.println(valoption[engine_cyclessamples_val_id]);
  write.println();
  if (fromblend[dither_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.dither_intensity = ");
  write.println(valoption[dither_id]);

  if (fromblend[compositing_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_compositing = ");
  write.println(valoption[compositing_id]);
  if (fromblend[sequencer_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_sequencer = ");
  write.println(valoption[sequencer_id]);

  write.println();

  write.println("# Output");
  if (fromblend[output_path_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.filepath = ");
  write.println('"'+outputpath+rendersname+'"');
  if (fromblend[placeholder_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_placeholder = ");
  write.println(valoption[placeholder_id]);
  if (fromblend[overwrite_renders_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_overwrite = ");
  write.println(valoption[overwrite_renders_id]);
  if (fromblend[file_format_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.image_settings.file_format = ");
  write.println('"'+valoption[file_format_id]+'"');
  if (!fromblend[file_format_id]) {
    if (valoption[file_format_id] == "PNG") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.compression = ");
      write.println(compresion);
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
    } else if (valoption[file_format_id] == "JPEG") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.quality = ");
      write.println(quality);
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else if (valoption[file_format_id] == "TARGA") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else if (valoption[file_format_id] == "TARGA_RAW") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else if (valoption[file_format_id] == "TIFF") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.tiff_codec = ");
      write.println('"'+tiffcompresion+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
    } else if (valoption[file_format_id] == "IRIS") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else if (valoption[file_format_id] == "BMP") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else if (valoption[file_format_id] == "JPEG2000") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.quality = ");
      write.println(quality);
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.jpeg2k_codec = ");
      write.println('"'+jpg2codec+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_jpeg2k_cinema_preset = ");
      write.println('"'+jpg2cinema+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_jpeg2k_cinema_48 = ");
      write.println('"'+jpg2cinema48+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_jpeg2k_ycc = ");
      write.println('"'+jpg2ycc+'"');
    } else if (valoption[file_format_id] == "OPEN_EXR") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.exr_codec = ");
      write.println('"'+openexcompresion+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_zbuffer = ");
      write.println(openexrzbuffer);
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_preview = ");
      write.println(openexrpreview);
    } else if (valoption[file_format_id] == "OPEN_EXR_MULTILAYER") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.exr_codec = ");
      write.println('"'+openexcompresion+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
    } else if (valoption[file_format_id] == "CINEON") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else if (valoption[file_format_id] == "DPX") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_cineon_log = ");
      write.println(dpxlog);
    } else if (valoption[file_format_id] == "HDR") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    }
  }
  if (fromblend[add_extension_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_file_extension = ");
  write.println(valoption[add_extension_id]);
  if (fromblend[render_cache_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_render_cache = ");
  write.println(valoption[render_cache_id]);
  write.println();

  write.println("# stamp");
  if (fromblend[stamp_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp = ");
  write.println(valoption[stamp_id]);
  if (fromblend[use_stamp_textsize_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.stamp_font_size = ");
  write.println(valoption[use_stamp_textsize_id]);
  if (fromblend[stamp_background_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.stamp_background = ");
  write.println(valoption[stamp_background_id]);
  if (fromblend[stamp_foreground_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.stamp_foreground = ");
  write.println(valoption[stamp_foreground_id]);
  if (fromblend[use_stamp_dlabels_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_labels = ");
  write.println(valoption[use_stamp_dlabels_id]);
  if (fromblend[use_stamp_time_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_time = ");
  write.println(valoption[use_stamp_time_id]);
  if (fromblend[use_stamp_camera_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_camera = ");
  write.println(valoption[use_stamp_camera_id]);
  if (fromblend[use_stamp_date_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_date = ");
  write.println(valoption[use_stamp_date_id]);
  if (fromblend[use_stamp_lens_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_lens = ");
  write.println(valoption[use_stamp_lens_id]);
  if (fromblend[use_stamp_render_time_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_render_time = ");
  write.println(valoption[use_stamp_render_time_id]);
  if (fromblend[use_stamp_filename_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_filename = ");
  write.println(valoption[use_stamp_filename_id]);
  if (fromblend[use_stamp_frame_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_frame = ");
  write.println(valoption[use_stamp_frame_id]);
  if (fromblend[use_stamp_marker_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_marker = ");
  write.println(valoption[use_stamp_marker_id]);
  if (fromblend[use_stamp_scene_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_scene = ");
  write.println(valoption[use_stamp_scene_id]);
  if (fromblend[use_stamp_sequencer_strip_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_sequencer_strip = ");
  write.println(valoption[use_stamp_sequencer_strip_id]);
  if (fromblend[stamp_note_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_note = ");
  write.println(valoption[stamp_note_id]);
  if (fromblend[stamp_note_text_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.stamp_note_text = ");
  write.println('"'+valoption[stamp_note_text_id]+'"');
  if (fromblend[use_stamp_memory_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_memory = ");
  write.println(valoption[use_stamp_memory_id]);
  if (fromblend[use_stamp_strip_meta_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_strip_meta = ");
  write.println(valoption[use_stamp_strip_meta_id]);
  write.println();

  write.println();
  write.println("# Render frames");

  for (int i = 0; i <= int(valoption[frame_end_id]) - int(valoption[frame_start_id]); i++) {
    if (loadJson(i).equals("bad")) {
      write.println();
      write.print("bpy.data.scenes[Scenename].frame_start = ");
      write.println(i + int(valoption[frame_start_id]));
      write.print("bpy.data.scenes[Scenename].frame_end = ");
      write.println(i + int(valoption[frame_start_id]));
      write.print("bpy.data.scenes[Scenename].frame_step = ");
      write.println(valoption[frame_step_id]);

      if (oglrenders) write.print("#");
      write.println("bpy.ops.render.render(animation=True,scene=Scenename)");
      write.println();
      write.println("# Render OpenGL");
      if (!oglrenders) write.print("#");
      write.println("bpy.ops.render.opengl(animation=True,view_context = False)");
    }
  }
  if (!oglrenders) write.print("#");
  write.println("bpy.ops.wm.quit_blender()");
  write.println();

  write.println();
  write.print("####################################");

  write.flush();
  write.close();
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
    write.print(" - ");
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
    write.print(" - ");
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
  }
  blendpre = loadImage(proyectpath+"Options"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".png");

  File f_bat = new File (dataPath("tmp")+File.separator+"blend_prev.bat");
  f_bat.delete();

  File f_sh = new File(dataPath("tmp")+File.separator+"blend_prev.sh");
  f_sh.delete();

  File f_py = new File (dataPath("tmp")+File.separator+"blend_prev.py");
  f_py.delete();
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
    write = createWriter(dataPath("Preferences"+File.separator+"recent_Windows.txt"));
    write.println("[Recent]");
    write.println(proyectpath+proyectname+".brenders");
    write.println(recentproyect[0]);
    write.println(recentproyect[1]);
    write.println(recentproyect[2]);
    write.println(recentproyect[3]);
    write.println(recentproyect[4]);

    write.flush();
    write.close();

    String lines[] = loadStrings(dataPath("Preferences"+File.separator+"recent_Windows.txt"));
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
    write = createWriter(dataPath("Preferences"+File.separator+"recent_Linux.txt"));

    write.println("[Recent]");
    write.println(proyectpath+proyectname+".brenders");
    write.println(recentproyect[0]);
    write.println(recentproyect[1]);
    write.println(recentproyect[2]);
    write.println(recentproyect[3]);
    write.println(recentproyect[4]);

    write.flush();
    write.close();

    String lines[] = loadStrings(dataPath("Preferences"+File.separator+"recent_Linux.txt"));
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