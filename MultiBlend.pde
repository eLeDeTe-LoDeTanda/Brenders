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
        recent_project[0] = lines[i+1];
        recent_project[1] = lines[i+2];
        recent_project[2] = lines[i+3];
        recent_project[3] = lines[i+4];
        recent_project[4] = lines[i+5];
        recent_project[5] = lines[i+6];  
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
        recent_project[0] = lines[i+1];
        recent_project[1] = lines[i+2];
        recent_project[2] = lines[i+3];
        recent_project[3] = lines[i+4];
        recent_project[4] = lines[i+5];
        recent_project[5] = lines[i+6];  
        break;
      }
    }
  }
}


void keyEventsMultiblend(String keypress)
{
  if (keypress == "number") {
    if (frame_prev.length() < 5) frame_prev += key;
  }
}


void mouseEventsMultiblend() 
{
  if (new_Project_Multiblend_()) {
    selectOutput("Select path and project name:", "newProject", project_folder);
  }
  if (open_Project_Multiblend_()) {
    selectInput("Select project:", "openProject", project_folder);
  }
  if (multiblend_active) {
    if (multiblend_files > 0) {
      if (orderL_Multiblend_() ) {
        order = constrain(order - 1, 0, multiblend_files - 1);
        String path;
        if (final_renders) path = project_path+"Options"+File.separator+multiblend_names[order]+".multiblend";
        else path = project_path+"Options"+File.separator+multiblend_names[order]+"_preview.multiblend";

        loadPy(path);

        settings_path = path;
        settings_folder = new File(path);
        settings_name = settings_path.substring(settings_path.lastIndexOf(File.separator));

        precheck();
        if (final_renders) {
          savefromblend(false);
          loadfromblend();
        }
        String name = settings_name;
        if (project_name.length() > 20) name = project_name.substring(0, 10)+"..."+project_name.substring(project_name.length() - 10);
        info = name;
      }
      if (orderR_Multiblend_() ) {
        order = constrain(order + 1, 0, multiblend_files - 1);
        String path = "";
        if (final_renders) path = project_path+"Options"+File.separator+multiblend_names[order]+".multiblend";
        else path = project_path+"Options"+File.separator+multiblend_names[order]+"_preview.multiblend";

        loadPy(path);

        settings_path = path;
        settings_folder = new File(path);
        settings_name = settings_path.substring(settings_path.lastIndexOf(File.separator));

        precheck();

        if (final_renders) {
          savefromblend(false);
          loadfromblend();
        }
        String name = settings_name;
        if (project_name.length() > 20) name = project_name.substring(0, 10)+"..."+project_name.substring(project_name.length() - 10);
        info = name;
      }
      if (reload_Multiblend_()) {
        loadNames_Multiblend(false);
        savefromblend(true);
        loadfromblend();
        precheck();
      }
    }
    if (import_Multiblend_()) {
      selectInput("Select your .py or commandline file", "settingsOpen", settings_folder);
    }
    if (open_folder_Multiblend_()) {
      info = "*Opening...";
      String cmd[] = {manager_path, project_path};
      exec(cmd);
    }
    if (open_recent_Multiblend_()) {
      multiblend_active = false;
    }
    if (rendermanager_Multiblend_()) {
      gui = 2;
    }
    if (go_Multiblend_()) {
      if (multiblend_files > 0) {
        if (multiblend_renders[0]) {
          loadNames_Multiblend(false);
          if (os == "WINDOWS") {
            multiblend_autorun(project_path+"Autorun"+File.separator+project_name);
            if (final_renders) {
              String cmd[]= {terminal_path, "/c", "start", "/w", project_path+"Autorun"+File.separator+project_name+".bat"};
              exec(cmd);
            } else {
              edit_options = false;
              multiblend_autorun(project_path+"Autorun"+File.separator+project_name);

              String cmd[]= {terminal_path, "/c", "start", "/w", project_path+"Autorun"+File.separator+project_name+"_preview.bat"};
              exec(cmd);
            }
          } else {
            multiblend_autorun(project_path+"Autorun"+File.separator+project_name);
            if (final_renders) {
              String cmd[] = {terminal_path, "-e", project_path+"Autorun"+File.separator+project_name+".sh"};
              exec(cmd);
            } else {
              edit_options = false;

              String cmd[] = {terminal_path, "-e", project_path+"Autorun"+File.separator+project_name+"_preview.sh"};
              exec(cmd);
            }
          }
          multiblend_renders[0] = false;
          multiblend_renders[1] = false;
          multiblend_renders[2] = false;
          info = "Rendering... You can close Brenders";
        } else if (multiblend_renders[1]) {
          loadNames_Multiblend(false);
          String order_name[] = new String[multiblend_files];
          for (int x = 0; x < order_name.length; x++) {
            String path = "";
            if (final_renders) path = project_path+"Options"+File.separator+multiblend_names[x]+".multiblend";
            else  path = project_path+"Options"+File.separator+multiblend_names[x]+"_preview.multiblend";
            loadPy(path);
            settings_name = path.substring(path.lastIndexOf(File.separator) + 1);
          }
          multiblend_autorun(project_path+"Autorun"+File.separator+project_name);

          if (os == "WINDOWS") {
            if (final_renders) {
              String cmd[]= {terminal_path, "/c", "start", "/w", project_path+"Autorun"+File.separator+project_name+"_bads.bat"};
              exec(cmd);
            } else {
              edit_options = false;
              String cmd[]= {terminal_path, "/c", "start", "/w", project_path+"Autorun"+File.separator+project_name+"_bads-preview.bat"};
              exec(cmd);
            }
          } else {
            if (final_renders) {
              String cmd[] = {terminal_path, "-e", project_path+"Autorun"+File.separator+project_name+"_bads.sh"};
              exec(cmd);
            } else {
              edit_options = false;
              String cmd[]= {terminal_path, "-e", project_path+"Autorun"+File.separator+project_name+"_bads-preview.sh"};
              exec(cmd);
            }
          }
          multiblend_renders[0] = false;
          multiblend_renders[1] = false;
          multiblend_renders[2] = false;
        } else if (multiblend_renders[2]) {
          loadNames_Multiblend(false);
          String order_name[] = new String[multiblend_files];
          for (int x = 0; x < order_name.length; x++) {
            render_order = x;
            String path = "";
            if (final_renders) path = project_path+"Options"+File.separator+multiblend_names[x]+".multiblend";
            else  path = project_path+"Options"+File.separator+multiblend_names[x]+"_preview.multiblend";
            loadPy(path);
            settings_name = path.substring(path.lastIndexOf(File.separator) + 1);
          }
          multiblend_autorun(project_path+"Autorun"+File.separator+project_name);

          if (os == "WINDOWS") {
            if (final_renders) {
              String cmd[]= {terminal_path, "/c", "start", "/w", project_path+"Autorun"+File.separator+project_name+"_continue.bat"};
              exec(cmd);
            } else {
              edit_options = false;
              String cmd[]= {terminal_path, "/c", "start", "/w", project_path+"Autorun"+File.separator+project_name+"_continue-preview.bat"};
              exec(cmd);
            }
          } else {
            if (final_renders) {
              String cmd[] = {terminal_path, "-e", project_path+"Autorun"+File.separator+project_name+"_continue.sh"};
              exec(cmd);
            } else {
              edit_options = false;
              String cmd[] = {terminal_path, "-e", project_path+"Autorun"+File.separator+project_name+"_continue-preview.sh"};
              exec(cmd);
            }
          }
          multiblend_renders[0] = false;
          multiblend_renders[1] = false;
          multiblend_renders[2] = false;
        } else {
          error = true;
          info = "Select 'All', 'Bad' or 'Continue'";
        }
      } else {
        error = true;
        info = "Project empty";
      }
    }
    if (multiblend_files > 0) {
      if (order_Multiblend_()) {
        multiblend_selectinorder();
        if (os == "WINDOWS") {
          try {
            String cmd[] = {text_editor_path, project_path+project_name+".brenders"};
            Process proc = Runtime.getRuntime().exec(cmd);
            proc.waitFor();
          } 
          catch(Exception e) {
            e.printStackTrace();
          }
        } else {
          try {
            String cmd[] = {terminal_path, "-e", text_editor_path, project_path+project_name+".brenders"};
            Process proc = Runtime.getRuntime().exec(cmd);
            proc.waitFor();
          } 
          catch(Exception e) {
            e.printStackTrace();
          }
        }
        loadNames_Multiblend(false);
        precheck();
        info = "'RELOADED' new order";
      }
      if (rename_Multiblend_()) {
        String multiblendpath = project_path+"Options"+File.separator+multiblend_names[order]+".multiblend";
        loadPy(multiblendpath);
        settings_path = multiblendpath;
        settings_folder = new File(multiblendpath);
        settings_name = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);
        edit_options = false;

        settings_folder = new File(settings_path.substring(0, settings_path.lastIndexOf(File.separator)+1)+settings_name);
        selectOutput("New name: "+settings_name, "settingsRename", settings_folder);
      }
      if (delete_Multiblend_()) {
        String multiblendpath = project_path+"Options"+File.separator+multiblend_names[order]+".multiblend";
        loadPy(multiblendpath);
        settings_path = multiblendpath;
        settings_folder = new File(multiblendpath);
        settings_name = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);
        final_renders = true;
        edit_options = false;

        multiblend_delete();
        info = "Multiblend deleted!";
      }
      if (all_Multiblend_()) {
        multiblend_renders[0] = true;
        multiblend_renders[1] = false;
        multiblend_renders[2] = false;
        info = "Rendering All frames";
      }
      if (bad_Multiblend_()) {
        multiblend_renders[0] = false;
        multiblend_renders[1] = true;
        multiblend_renders[2] = false;
        py_Save_multiblend();
        info = "Rendering only bads frames";
      }
      if (continue_Multiblend_()) {
        multiblend_renders[0] = false;
        multiblend_renders[1] = false;
        multiblend_renders[2] = true;
        py_Save_multiblend();
        info = "Continue rendering from last frame";
      }
      if (openblend_Multiblend_()) {
        info = "*Opening "+blend_name+" ...";
        String cmd[] = {blender_path, blend_path+blend_name};
        exec(cmd);
      }
      if (blend_pre_Multiblend_()) {
        if (int(frame_prev) <= 0) frame_prev = "1";
        loadPy(project_path+"Options"+File.separator+multiblend_names[order]+".multiblend");
        multiblend_pre();
      }
      if (framepre_Multiblend_()) {
        frame_prev = "";
      } 
      if (framepreL_Multiblend_()) {
        frame_prev = str(constrain(int(frame_prev) - 1, 1, 500000));
      }  
      if (framepreR_Multiblend_()) {
        frame_prev = str(constrain(int(frame_prev) + 1, 1, 500000));
      }
      if (edit_Multiblend_()) {
        info = "Edit render options and 'SAVE'";
        gui = 1;
      }
      if (final_Multiblend_()) {
        String multiblendpath = project_path+"Options"+File.separator+multiblend_names[order]+".multiblend";
        loadPy(multiblendpath);
        settings_path = multiblendpath;
        settings_folder = new File(multiblendpath);
        settings_name = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);
        final_renders = true;
        edit_options = false;
        info = "Final renders";
        savefromblend(false);
        loadfromblend();
        precheck();
      }
      if (preview_Multiblend_()) {
        final_renders = false;
        loadNames_Multiblend(false);
        String order_name[] = new String[multiblend_files];
        for (int x = 0; x < order_name.length; x++) {
          String path = project_path+"Options"+File.separator+multiblend_names[x]+".multiblend";
          loadPy(path);
          settings_name = path.substring(path.lastIndexOf(File.separator) + 1);
        }

        String multiblendpath = project_path+"Options"+File.separator+multiblend_names[order]+"_preview.multiblend";
        File f = new File(multiblendpath);
        if (!f.exists()) py_Save_multiblend();
        
        loadPy(multiblendpath);
        settings_path = multiblendpath;
        settings_folder = new File(multiblendpath);
        settings_name = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);
        edit_options = true;
        multiblend_autorun(project_path+"Autorun"+File.separator+project_name);
        info = "Preview mode";
        precheck();
        if (renders_name.contains("#")) renders_name = renders_name.substring(0, renders_name.indexOf("#"));
      }
      if (editpreview_Multiblend_()) {
        if (!final_renders) {
          edit_options = true;
          info = "Edit preview render options and 'SAVE'";
          gui = 1;
        }
      }
    }
  } else if (recent_Multiblend_()) {
    int Y = floor(map(mouseY, 215, 320, 0, 5));

    String path = recent_project[Y]; 
    File f = new File(path);
    if (f.exists()) {
      if (path.endsWith(".brenders")) {
        project_path = path; 
        project_name = path.substring(path.lastIndexOf(File.separator) + 1, path.lastIndexOf("."));
        project_path = project_path.substring(0, project_path.lastIndexOf(File.separator) + 1);
        loadNames_Multiblend(false);

        String multiblendpath;
        for (int i = 0; i < multiblend_files; i++) {
          multiblendpath = project_path+"Options"+File.separator+multiblend_names[i]+".multiblend";

          loadPy(multiblendpath);
          settings_path = multiblendpath;
          settings_folder = new File(multiblendpath);
          settings_name = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);
          savefromblend(true);
          loadfromblend();
        }
        precheck();
      }
    } else {
      error = true;
      info = "Project not available!";
    }
  }
}


void newProject(File selection) 
{
  if (selection != null) {
    project_path = selection.getAbsolutePath()+File.separator;
    project_name = selection.getName();

    File folder = new File(project_path);
    folder.mkdir();
    folder = new File(project_path+"Options");
    folder.mkdir();
    folder = new File(project_path+"Autorun");
    folder.mkdir();
    folder = new File(project_path+"Manager");
    folder.mkdir();
    folder = new File(project_path+"Logs");
    folder.mkdir();

    write = createWriter(project_path+project_name+".brenders");
    write.println("[Project Name]");
    write.println(project_name);
    write.println();
    write.println("[Order]");

    write.flush();
    write.close();

    multiblend_files = 0;
    multiblend_active = true;

    info = "New project created!";

    addrecent_project();
  }
  redraw();
}


void openProject(File selection) 
{
  if (selection != null) {
    String path = selection.getAbsolutePath(); 
    if (path.endsWith(".brenders")) { 
      project_path = selection.getAbsolutePath(); 
      project_name = selection.getName();
      project_name = project_name.substring(0, project_name.lastIndexOf("."));
      project_path = project_path.substring(0, project_path.lastIndexOf(File.separator)+1);

      loadNames_Multiblend(false);

      String multiblendpath;
      for (int i = 0; i < multiblend_files; i++) {
        multiblendpath = project_path+"Options"+File.separator+multiblend_names[i]+".multiblend";

        loadPy(multiblendpath);
        settings_path = multiblendpath;
        settings_folder = new File(multiblendpath);
        settings_name = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);
        savefromblend(true);
        loadfromblend();
      }
      precheck();
      addrecent_project();
    } else {
      error = true;
      info = "*Warning No '.brenders' selected";
    }
  }
  redraw();
}


void loadNames_Multiblend(boolean addmulti)
{
  multiblend_addinorder(addmulti);
  multiblend_active = true;
  multiblend_files = 0;

  String lines[] = loadStrings(project_path+project_name+".brenders");
  int x = 0;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains(".multiblend")) {
      lines[i] = trim(lines[i]);
      multiblend_names[x] = lines[i].substring(0, lines[i].lastIndexOf("."));
      multiblend_files = x + 1;
      x = x + 1;
    }
  }
  info = project_name;
}


void multiblend_import(String path)
{
  String multiblendpath = project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".multiblend";
  File f = new File(multiblendpath);

  if (path.endsWith(".txt")) {
    loadCommandline(path);
    String fconv = multiblendpath.substring(0, multiblendpath.lastIndexOf("."))+".convert";
    generate_py = true;
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
  settings_path = multiblendpath;
  settings_folder = new File(multiblendpath);
  settings_name = multiblendpath.substring(multiblendpath.lastIndexOf(File.separator) + 1);

  order = multiblend_files;

  loadNames_Multiblend(true);

  savefromblend(false);
  loadfromblend();

  newjsonManager(project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".manager");
  newjsonManager(project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_preview.manager");

  multiblend_autorun(project_path+"Autorun"+File.separator+project_name);

  precheck();
}


void multiblend_rename()
{
  String path = project_path+project_name+".brenders";
  String lines[] = loadStrings(path);
  write = createWriter(path);
  int x = 0;
  for (int i = 0; i < lines.length; i++) {
    x = x + 1;
    if (!lines[i].contains(".multiblend")) {
      write.println(trim(lines[i]));
      if (lines[i].contains("[Order]")) x = -1;
    } else {
      if (x == order) write.println(settings_name);
      else write.println(trim(lines[i]));
    }
  } 
  write.flush();
  write.close();

  loadNames_Multiblend(false);
}


void multiblend_delete()
{
  File f = new File(settings_path);
  f.delete();
  f = new File(project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".png");
  f.delete();
  f = new File(project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_preview.png");
  f.delete();
  f = new File(project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_preview.multiblend");
  f.delete();
  f = new File(project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_continue.multiblend");
  f.delete();
  f = new File(project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_bads.multiblend");
  f.delete();
  f = new File(project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".manager");
  f.delete();
  f = new File(project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_preview.manager");
  f.delete();
  f = new File(project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".txt");
  f.delete();

  File dir = new File(project_path+"Manager"+File.separator+"Previews"+File.separator+settings_name.substring(0, settings_name.lastIndexOf(".")));
  if (dir.exists()) {
    String[] files = dir.list();
    for (int x = 0; x < files.length; x++) {
      f = new File(project_path+"Manager"+File.separator+"Previews"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+File.separator+files[x]);
      if (f.exists()) f.delete();
    }
    f = new File(project_path+"Manager"+File.separator+"Previews"+File.separator+settings_name.substring(0, settings_name.lastIndexOf(".")));
    if (f.exists()) f.delete();
  }

  String path = project_path+project_name+".brenders";
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
  loadNames_Multiblend(false);
}


void multiblend_addinorder(boolean add)
{
  String path = project_path+project_name+".brenders";
  String[] lines = loadStrings(path);

  write = createWriter(path);

  for (int i = 0; i < lines.length; i++) {
    write.println(trim(lines[i]));
    if (lines[i].contains("[Order]")) break;
  } 
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains(".multiblend")) {
      String multipath = trim(lines[i].substring(0, lines[i].lastIndexOf(".multiblend") + 11));

      File f = new File(project_path+"Options"+File.separator+multipath);

      if (f.exists()) write.println(multipath);
    }
  }
  if (add) write.print(settings_name);

  write.flush();
  write.close();
}


void multiblend_selectinorder()
{
  loadNames_Multiblend(false);

  String path = project_path+project_name+".brenders";
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
  String lines[] = loadStrings(project_path+project_name+".brenders");
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
    if (multiblend_renders[0]) {
      if (final_renders)  write = createWriter(path+".bat");
      else write = createWriter(path+"_preview.bat");
    } else if (multiblend_renders[1]) {
      if (final_renders) write = createWriter(path+"_bads.bat");
      else  write = createWriter(path+"_bads-preview.bat");
    } else if (multiblend_renders[2]) { 
      if (final_renders) write = createWriter(path+"_continue.bat");
      else  write = createWriter(path+"_continue-preview.bat");
    }
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
    write.println("@ECHO ---------- %date:~10,4%-%date:~4,2%-%date:~7,2% ---------- >> "+'"'+project_path+"Manager"+File.separator+"RenderStatus.log"+'"'); 
    for (int a = 0; a < order_name.length; a++) {
      if (final_renders) loadPy(project_path+"Options"+File.separator+order_name[a]);
      else loadPy(project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_preview.multiblend");
      write.println("@ECHO %time:~0,2%:%time:~3,2%:%time:~6,2% Start: "+order_name[a]+">> "+'"'+project_path+"Manager"+File.separator+"RenderStatus.log"+'"');

      write.println("@ECHO Log: %date:~10,4%-%date:~4,2%-%date:~7,2%_%time:~0,2%:%time:~3,2%:%time:~6,2%_"+order_name[a].substring(0, order_name[a].lastIndexOf("."))+".log >> "+'"'+project_path+"Manager"+File.separator+"RenderStatus.log"+'"');  
      write.println();
      write.print("call ");
      write.print('"'+blender_path+'"');
      if (!ogl_renders) write.print(" -b ");
      else write.print(" - ");
      write.print('"'+blend_path+blend_name+'"');
      write.print(" -P ");
      if (multiblend_renders[0]) {
        if (final_renders) {
          write.print('"'+project_path+"Options"+File.separator+order_name[a]+'"');
        } else {
          write.print('"'+project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_preview.multiblend"+'"');
        }
      } else if (multiblend_renders[1]) {
        if (final_renders) write.print('"'+project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_bads.multiblend"+'"');
        else write.print('"'+project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_bads-preview.multiblend"+'"');
      } else if (multiblend_renders[2]) {
        if (final_renders)  write.print('"'+project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_continue.multiblend"+'"');
        else write.print('"'+project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_continue-preview.multiblend"+'"');
      }
      write.println(" > "+'"'+project_path+"Logs"+File.separator+"%date:~10,4%-%date:~4,2%-%date:~7,2%_%time:~0,2%:%time:~3,2%:%time:~6,2%_"+order_name[a].substring(0, order_name[a].lastIndexOf("."))+".log"+'"');
      write.println();
      write.println("@ECHO %time:~0,2%:%time:~3,2%:%time:~6,2% Finish: "+order_name[a]+" >> "+'"'+project_path+"Manager"+File.separator+"RenderStatus.log"+'"');  
      write.println();
    }   
    write.println("@ECHO ------------------------------- >> "+'"'+project_path+"Manager"+File.separator+"RenderStatus.log"+'"'); 
    write.println("@ECHO -");
    write.println("@ECHO FINISH!");
    write.println("@ECHO -");
    write.println("PAUSE");
    write.print("exit");

    write.flush();
    write.close();
  } else {
    if (multiblend_renders[0]) {
      if (final_renders) write = createWriter(path+".sh");
      else write = createWriter(path+"_preview.sh");
    } else if (multiblend_renders[1]) { 
      if (final_renders) write = createWriter(path+"_bads.sh");
      else write = createWriter(path+"_bads-preview.sh");
    } else if (multiblend_renders[2]) { 
      if (final_renders) write = createWriter(path+"_continue.sh");
      else  write = createWriter(path+"_continue-preview.sh");
    }
    write.println("#!/bin/bash");
    write.println();
    write.println("# Auto-generated by " + version);
    write.println();
    write.println("# Command Line:");
    write.println();
    write.print("echo ---------- $(date +'%Y-%m-%d') ---------- 2>&1 | tee -a ");
    write.println('"'+project_path+"Manager"+File.separator+"RenderStatus.log"+'"');   

    for (int a = 0; a < order_name.length; a++) {
      if (final_renders) loadPy(project_path+"Options"+File.separator+order_name[a]);
      else loadPy(project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_preview.multiblend");

      write.print("echo $(date +'%H:%M:%S') Start: "+order_name[a]+" 2>&1 | tee -a ");
      write.println('"'+project_path+"Manager"+File.separator+"RenderStatus.log"+'"');    
      write.print("echo Log: $(date +'%Y-%m-%d_%H:%M:%S_')"+order_name[a].substring(0, order_name[a].lastIndexOf("."))+".log"+" 2>&1 | tee -a ");
      write.println('"'+project_path+"Manager"+File.separator+"RenderStatus.log"+'"');  
      write.println();
      write.print('"'+blender_path+'"');
      if (!ogl_renders) write.print(" -b ");
      else write.print(" - ");
      write.print('"'+blend_path+blend_name+'"');
      write.print(" -P ");
      if (multiblend_renders[0]) {
        if (final_renders) {
          write.print('"'+project_path+"Options"+File.separator+order_name[a]+'"');
        } else {
          write.print('"'+project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_preview.multiblend"+'"');
        }
      } else if (multiblend_renders[1]) {
        if (final_renders) write.print('"'+project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_bads.multiblend"+'"');
        else write.print('"'+project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_bads-preview.multiblend"+'"');
      } else if (multiblend_renders[2]) {
        if (final_renders)  write.print('"'+project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_continue.multiblend"+'"');
        else write.print('"'+project_path+"Options"+File.separator+order_name[a].substring(0, order_name[a].lastIndexOf("."))+"_continue-preview.multiblend"+'"');
      }
      write.print(" 2>&1 | tee ");
      write.println('"'+project_path+"Logs"+File.separator+"$(date +'%Y-%m-%d_%H:%M:%S_')"+order_name[a].substring(0, order_name[a].lastIndexOf("."))+".log"+'"');
      write.println();
      write.print("echo $(date +'%H:%M:%S') Finish: "+order_name[a]+" 2>&1 | tee -a ");
      write.println('"'+project_path+"Manager"+File.separator+"RenderStatus.log"+'"');   
      write.println();
    }
    write.print("echo ------------------------------- 2>&1 | tee -a ");
    write.println('"'+project_path+"Manager"+File.separator+"RenderStatus.log"+'"');   

    write.flush();
    write.close();

    if (multiblend_renders[0]) { 
      if (final_renders) {
        File fexec = new File(path+".sh");
        fexec.setExecutable(true, false);
      } else {
        File fexec = new File(path+"_preview.sh");
        fexec.setExecutable(true, false);
      }
    } else if (multiblend_renders[1]) {
      if (final_renders) {
        File fexec = new File(path+"_bads.sh");
        fexec.setExecutable(true, false);
      } else {
        File fexec = new File(path+"_bads-preview.sh");
        fexec.setExecutable(true, false);
      }
    } else if (multiblend_renders[2]) {
      if (final_renders) {
        File fexec = new File(path+"_continue.sh");
        fexec.setExecutable(true, false);
      } else {
        File fexec = new File(path+"_continue-preview.sh");
        fexec.setExecutable(true, false);
      }
    }
  }
}


void py_Save_multiblend()
{
  String path = "";
  if (final_renders) path = project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".multiblend";
  else {
    if (settings_name.substring(0, settings_name.lastIndexOf(".")).contains("_preview")) path = project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("_"))+"_preview.multiblend";
    else path = project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_preview.multiblend";
  }
  if (multiblend_renders[1]) {
    if (final_renders) path = project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_bads.multiblend";
    else {
      if (settings_name.substring(0, settings_name.lastIndexOf(".")).contains("_preview")) path = project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("_"))+"_bads-preview.multiblend";
      else path = project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_bads-preview.multiblend";
    }
  } else if (multiblend_renders[2]) {
    if (final_renders) path = project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_continue.multiblend";
    else {
      if (settings_name.substring(0, settings_name.lastIndexOf(".")).contains("_preview")) path = project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("_"))+"_continue-preview.multiblend";
      else path = project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_continue-preview.multiblend";
    }
  }

  write = createWriter(path);
  write.println("# Auto-generated by "+version);
  write.println("# https://github.com/eLeDeTe-LoDeTanda/Brenders");
  write.println();
  if (!final_renders) write.println("# PREVIEW");
  if (multiblend_renders[1]) write.println("# For Bads renders");
  else if (multiblend_renders[2]) write.println("# For Continue renders");
  write.println("# Render options in: "+path);
  write.println();
  write.println("import bpy");
  write.println();
  write.println("# Render Options to change");
  write.println("############################");
  write.println();

  write.println("# Scene Name");
  write.print("Scenename = ");
  if (fromblend[scene_name_id]) write.println("bpy.context.scene.name");
  else write.println('"'+scene_name+'"');
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
  write.println('"'+output_path+renders_name+'"');
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

  if (multiblend_renders[1]) {
    for (int i = 0; i <= int(valoption[frame_end_id]) - int(valoption[frame_start_id]); i++) {
      String jsonpath = "";
      if (final_renders) jsonpath = project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".manager";
      else jsonpath = project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_preview.manager";

      if (loadJsonManager(i, jsonpath).equals("bad")) {
        write.println();
        write.print("bpy.data.scenes[Scenename].frame_start = ");
        write.println(i + int(valoption[frame_start_id]));
        write.print("bpy.data.scenes[Scenename].frame_end = ");
        write.println(i + int(valoption[frame_start_id]));
        write.print("bpy.data.scenes[Scenename].frame_step = ");
        write.println(valoption[frame_step_id]);

        if (ogl_renders) write.print("#");
        write.println("bpy.ops.render.render(animation=True,scene=Scenename)");
        write.println();
        write.println("# Render OpenGL");
        if (!ogl_renders) write.print("#");
        write.println("bpy.ops.render.opengl(animation=True,view_context = False)");
      }
    }
  } else if (multiblend_renders[2]) {
    String lastframe ="0";
    String logpath ="";

    String lineslog[] = loadStrings(project_path+"Manager"+File.separator+"RenderStatus.log");

    for (int e = 0; e < lineslog.length; e++) {
      int i = lineslog.length - 1 - e;
      if (lineslog[i].startsWith("Log:")) {
        logpath = project_path+"Logs"+File.separator+trim(lineslog[i].substring(lineslog[i].indexOf(":") + 1));
        break;
      }
    }

    String lines[] = loadStrings(logpath);

    for (int e = 0; e < lines.length; e++) {
      int i = lines.length - 1 - e;
      if (lines[i].startsWith("Saved:")) {
        lastframe = trim(lines[i - 1].substring(lines[i - 1].indexOf(":") + 1, lines[i - 1].indexOf("M")));
        break;
      }
    }
    String lastmultiblend = logpath.substring(logpath.lastIndexOf("_") + 1, logpath.lastIndexOf("."))+".multiblend";

    int lastrender_order = 0;
    for (int x = 0; x < multiblend_files; x++) {
      if (lastmultiblend.equals(multiblend_names[x]+".multiblend")) lastrender_order = x;
    }

    if (int(lastframe) < int(valoption[frame_end_id]) && render_order == lastrender_order) {
      write.println();
      write.print("bpy.data.scenes[Scenename].frame_start = ");
      write.println(int(lastframe) + 1);
      write.print("bpy.data.scenes[Scenename].frame_end = ");
      write.println(valoption[frame_end_id]);
      write.print("bpy.data.scenes[Scenename].frame_step = ");
      write.println(valoption[frame_step_id]);

      if (ogl_renders) write.print("#");
      write.println("bpy.ops.render.render(animation=True,scene=Scenename)");
    } else if (render_order > lastrender_order) {
      write.println();
      write.print("bpy.data.scenes[Scenename].frame_start = ");
      write.println(valoption[frame_start_id]);
      write.print("bpy.data.scenes[Scenename].frame_end = ");
      write.println(valoption[frame_end_id]);
      write.print("bpy.data.scenes[Scenename].frame_step = ");
      write.println(valoption[frame_step_id]);

      if (ogl_renders) write.print("#");
      write.println("bpy.ops.render.render(animation=True,scene=Scenename)");
    }

    write.println();

    write.println("# Render OpenGL");
    if (!ogl_renders) write.print("#");
    write.println("bpy.ops.render.opengl(animation=True,view_context = False)");
  } else {
    write.println();
    write.print("bpy.data.scenes[Scenename].frame_start = ");
    write.println(valoption[frame_start_id]);
    write.print("bpy.data.scenes[Scenename].frame_end = ");
    write.println(valoption[frame_end_id]);
    write.print("bpy.data.scenes[Scenename].frame_step = ");
    write.println(valoption[frame_step_id]);
    if (ogl_renders) write.print("#");
    write.println("bpy.ops.render.render(animation=True,scene=Scenename)");
    write.println();

    write.println("# Render OpenGL");
    if (!ogl_renders) write.print("#");
    write.println("bpy.ops.render.opengl(animation=True,view_context = False)");
  }


  if (!ogl_renders) write.print("#");
  write.println("bpy.ops.wm.quit_blender()");
  write.println();

  write.println();
  write.print("####################################");

  write.flush();
  write.close();
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
  else write.println('"'+scene_name+'"');
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
  write.println(frame_prev);
  write.println();

  write.println("# Render OpenGL");
  write.println("bpy.ops.render.opengl(view_context = False)");
  write.println();

  String path = project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".png";
  if (os == "WINDOWS") path = path.replace("\\", "/");

  write.println("bpy.data.images['Render Result'].save_render("+'"'+path+'"'+")");
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
    write.print('"'+blender_path+'"');
    write.print(" - ");
    write.print('"'+blend_path+blend_name+'"');
    write.print(" -P ");
    write.print('"'+dataPath("tmp")+File.separator+"blend_prev.py"+'"');
    write.println();
    write.print("exit");

    write.flush();
    write.close();
    try {
      String cmd[]= {terminal_path, "/c", "start", "/w", dataPath("tmp")+File.separator+"blend_prev.bat"};
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
    write.print('"'+blender_path+'"');
    write.print(" - ");
    write.print('"'+blend_path+blend_name+'"');
    write.print(" -P ");
    write.print('"'+dataPath("tmp")+File.separator+"blend_prev.py"+'"');

    write.flush();
    write.close();

    File f_sh = new File(dataPath("tmp")+File.separator+"blend_prev.sh");
    f_sh.setExecutable(true, false);

    try {
      String cmd[] = {terminal_path, "-e", dataPath("tmp")+File.separator+"blend_prev.sh"};
      Process proc = Runtime.getRuntime().exec(cmd);
      proc.waitFor();
    } 
    catch(Exception e) {
      e.printStackTrace();
    }
  }
  blend_pre = loadImage(project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".png");

  File f = new File (dataPath("tmp")+File.separator+"blend_prev.bat");
  f.delete();

  f = new File(dataPath("tmp")+File.separator+"blend_prev.sh");
  f.delete();

  f = new File (dataPath("tmp")+File.separator+"blend_prev.py");
  f.delete();
}


void precheck()
{
  File img = new File(project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".png");
  if (!img.exists()) blend_pre = loadImage("Img"+File.separator+"None.png");
  else  blend_pre = loadImage(project_path+"Options"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".png");
}


void addrecent_project()
{
  if (os == "WINDOWS") {
    write = createWriter(dataPath("Preferences"+File.separator+"recent_Windows.txt"));
    write.println("[Recent]");
    write.println(project_path+project_name+".brenders");
    write.println(recent_project[0]);
    write.println(recent_project[1]);
    write.println(recent_project[2]);
    write.println(recent_project[3]);
    write.println(recent_project[4]);

    write.flush();
    write.close();

    String lines[] = loadStrings(dataPath("Preferences"+File.separator+"recent_Windows.txt"));
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains("[Recent]")) {
        recent_project[0] = lines[i+1];
        recent_project[1] = lines[i+2];
        recent_project[2] = lines[i+3];
        recent_project[3] = lines[i+4];
        recent_project[4] = lines[i+5];
        recent_project[5] = lines[i+6];  
        break;
      }
    }
  } else {
    write = createWriter(dataPath("Preferences"+File.separator+"recent_Linux.txt"));

    write.println("[Recent]");
    write.println(project_path+project_name+".brenders");
    write.println(recent_project[0]);
    write.println(recent_project[1]);
    write.println(recent_project[2]);
    write.println(recent_project[3]);
    write.println(recent_project[4]);

    write.flush();
    write.close();

    String lines[] = loadStrings(dataPath("Preferences"+File.separator+"recent_Linux.txt"));
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains("[Recent]")) {
        recent_project[0] = lines[i+1];
        recent_project[1] = lines[i+2];
        recent_project[2] = lines[i+3];
        recent_project[3] = lines[i+4];
        recent_project[4] = lines[i+5];
        recent_project[5] = lines[i+6];  
        break;
      }
    }
  }
}