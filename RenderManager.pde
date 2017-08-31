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

void mouseEventsManager() 
{
  if (multiblend_active) {
    if (multiblend_files > 0) {
      if (manager_L()) {
        offset_manager = constrain(offset_manager - 150, 0, int(valoption[frame_end_id]));
      }
      if (manager_R()) {
        if (int(valoption[frame_end_id]) > 150) offset_manager = constrain(offset_manager + 150, 0, int(valoption[frame_end_id]));
      }
      if (manager_all()) {
        startframe_manager = int(valoption[frame_start_id]);
        endframe_manager = int(valoption[frame_end_id]);
      }
      if (manager_good()) {
        for (int i = startframe_manager; i <= endframe_manager; i++) {
          addinJsonManager("good", i);
        }
      }
      if (manager_bad()) {
        for (int i = startframe_manager; i <= endframe_manager; i++) {
          addinJsonManager("bad", i);
        }
      }
      if (manager_openfolder()) {
        String cmd[] = {manager_path, output_path};
        exec(cmd);
      }

      if (mouseX >= 20 && mouseX <= 625 && mouseY >= 30 && mouseY <=  325) {
        int X = floor(map(mouseX, 20, 620, 0, 15));
        int Y = floor(map(mouseY, 30, 325, 0, 10));

        select_frame = ((Y * 15 + X) + offset_manager) + int(valoption[frame_start_id]);

        select_frame = constrain(select_frame, int(valoption[frame_start_id]), int(valoption[frame_end_id]));

        if (mouseButton == LEFT) {
          startframe_manager = select_frame;
          endframe_manager = select_frame;
        }
        if (mouseButton == RIGHT) {
          endframe_manager = select_frame;
        }
        if (mouseButton == CENTER) {
          if (select_frame <= int(valoption[frame_end_id])) {
            String prepath = output_path+renders_name+nf(select_frame, 4)+extensionName(valoption[file_format_id]);
            if (os == "WINDOWS") {
              String cmd[] = {"rundll32.exe", "C:"+File.separator+"WINDOWS"+File.separator+"System32"+File.separator+"shimgvw.dll,ImageView_Fullscreen", prepath};
              exec(cmd);
            } else {
              String cmd[] = {image_viewer_path, prepath};
              exec(cmd);
            }
          }
          frame_preview(output_path+renders_name+nf(select_frame, 4)+extensionName(valoption[file_format_id]));
        }
      }
      if (manager_reloadallpre()) {
        thread("allpreviews");
      }
      if (manager_reloadnewpre()) {
        thread("newspreviews");
      }
      if (manager_playrender()) {
        selectInput("Select START Render:", "startRendersToPlaySelect", play_renders_folder);
      }
      if (manager_orderL()) {
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
      if (manager_orderR()) {
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
    }
  }
}


void addinJsonManager(String option, int frame)
{
  JSONArray values;

  values = loadJSONArray(project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".manager");

  for (int i = 0; i <= int(valoption[frame_end_id]) - int(valoption[frame_start_id]); i++) {
    JSONObject rendermanager = values.getJSONObject(i); 
    rendermanager.getInt("Frame");
    rendermanager.getString("Multi");
    rendermanager.getString("Status");
    rendermanager.getString("Render");
    if (new_output) {
      rendermanager.setString("Render path", output_path);
      rendermanager.setString("Render name", renders_name);
    } else {
      rendermanager.getString("Render path");
      rendermanager.getString("Render name");
    }
    if (i + int(valoption[frame_start_id]) == int(frame)) rendermanager.setString("Status", option);
  }

  saveJSONArray(values, project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".manager");
}


String loadJsonManager(int frame, String path)
{
  JSONArray values;

  values = loadJSONArray(project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".manager");
  String status = "";
  if (frame < values.size()) {
    JSONObject rendermanager = values.getJSONObject(frame); 
    status = rendermanager.getString("Status");
  } else {
    JSONObject news = new JSONObject();

    news.setInt("Frame", frame);
    news.setString("Multi", settings_name);
    news.setString("Status", "Waiting");
    news.setString("Render", "None");
    if (new_output) {
      news.setString("Render path", output_path);
      news.setString("Render name", renders_name);
    } else {
      news.setString("Render path", "From .blend");
      news.setString("Render name", "From .blend");
    }
    values.append(news);
    saveJSONArray(values, path);
  }
  return status;
}


void newjsonManager(String path) 
{
  JSONArray rendercontrol;

  rendercontrol = new JSONArray();

  for (int i = 0; i <= int(valoption[frame_end_id]) - int(valoption[frame_start_id]); i++) {

    JSONObject rendermanager = new JSONObject();

    rendermanager.setInt("Frame", i + int(valoption[frame_start_id]));
    rendermanager.setString("Multi", settings_name);
    rendermanager.setString("Status", "Waiting");
    rendermanager.setString("Render", "None");
    if (new_output) {
      rendermanager.setString("Render path", output_path);
      rendermanager.setString("Render name", renders_name);
    } else {
      rendermanager.setString("Render path", "From .blend");
      rendermanager.setString("Render name", "From .blend");
    }

    rendercontrol.setJSONObject(i, rendermanager);
  }

  saveJSONArray(rendercontrol, path);
}


void allpreviews()
{
  PImage img;
  for (int i = int(valoption[frame_start_id]); i <= int(valoption[frame_end_id]); i++) {
    File f = new File(output_path+renders_name+nf(i, 4)+extensionName(valoption[file_format_id]));
    if (f.exists()) {
      img = loadImage(output_path+renders_name+nf(i, 4)+extensionName(valoption[file_format_id]));
      img.resize(40, 23);
      img.save(project_path+"Manager"+File.separator+"Previews"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+File.separator+renders_name+nf(i, 4)+".png");
      System.gc(); 
      redraw();
    }
  }
}


void newspreviews()
{
  PImage img;
  for (int i = int(valoption[frame_start_id]); i <= int(valoption[frame_end_id]); i++) {
    File fp = new File(project_path+"Manager"+File.separator+"Previews"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+File.separator+renders_name+nf(i, 4)+".png");
    if (!fp.exists()) {
      File f = new File(output_path+renders_name+nf(i, 4)+extensionName(valoption[file_format_id]));
      if (f.exists()) {
        img = loadImage(output_path+renders_name+nf(i, 4)+extensionName(valoption[file_format_id]));
        img.resize(40, 23);
        img.save(project_path+"Manager"+File.separator+"Previews"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+File.separator+renders_name+nf(i, 4)+".png");
        System.gc();
        redraw();
      }
    }
  }
}

void frame_preview(String frame)
{
  //  fromblend();
  PImage img;
  File f = new File(frame);
  if (f.exists()) {
    img = loadImage(frame);
    img.resize(40, 23);
    img.save(project_path+"Manager"+File.separator+"Previews"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+File.separator+renders_name+nf(select_frame, 4)+".png");
    System.gc();
  }
  updating = false;
}


void loadfromblend()
{
  String lines[] = loadStrings(project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf(".")) + ".txt");
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains("[RendersOutput]")) {
      if (fromblend[output_path_id]) {
        if (lines[i+1].startsWith("//")) output_path = blend_path+lines[i+1].substring(2);
        else output_path = lines[i+1];
      }
    } else if (lines[i].contains("[RenderName]")) {
      if (fromblend[output_path_id]) {
        if (!lines[i+1].contains("#")) renders_name = lines[i+1];
        else renders_name = lines[i+1].substring(0, lines[i+1].indexOf("#"));
      } else if (renders_name.contains("#")) renders_name = renders_name.substring(0, renders_name.indexOf("#"));
    } else if (lines[i].contains("[FileFormat]")) {
      if (fromblend[file_format_id]) valoption[file_format_id] = lines[i+1];
    } else if (lines[i].contains("[StartFrame]")) {
      if (fromblend[frame_start_id]) valoption[frame_start_id] = lines[i+1];
    } else if (lines[i].contains("[EndFrame]")) {
      if (fromblend[frame_end_id]) valoption[frame_end_id] = lines[i+1];
    }
  }
}


void savefromblend(boolean forcetowrite)
{
  if (fromblend[output_path_id] || fromblend[file_format_id] || fromblend[frame_start_id] || fromblend[frame_end_id]) {

    File f = new File(project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf(".")) + ".txt");
    if (forcetowrite) f = new File("");

    if (!f.exists()) {
      write = createWriter(dataPath("tmp")+File.separator+"fromblend.py");
      write.println("# Auto-generated by " + version);
      write.println();
      write.println("import bpy");
      write.println();
      write.print("Scenename = ");
      if (fromblend[scene_name_id]) write.println("bpy.context.scene.name");
      else write.println('"'+scene_name+'"');

      String path = project_path+"Manager"+File.separator+"fromblend.txt";
      if (os == "WINDOWS") path = path.replace("\\", "/");

      write.println("file = open("+'"'+path+'"'+", 'w', encoding='utf-8')");
      write.println("file.write("+'"'+"%s"+'"'+" % (bpy.data.scenes[Scenename].render.filepath) + "+'"'+"***"+'"'+" + "+'"'+"%s"+'"'+" % (bpy.data.scenes[Scenename].render.image_settings.file_format) + "+'"'+"***"+'"'+" + "+'"'+"%s"+'"'+" % (bpy.data.scenes[Scenename].frame_start) + "+'"'+"***"+'"'+" + "+'"'+"%s"+'"'+" % (bpy.data.scenes[Scenename].frame_end))");
      write.println("file.close()");

      write.flush();
      write.close();

      if (os == "WINDOWS") {
        write = createWriter(dataPath("tmp")+File.separator+"fromblend.bat");

        write.println("@ECHO OFF");
        write.println("COLOR 8F");
        write.println();
        write.print("call ");
        write.print('"'+blender_path+'"');
        write.print(" -b ");
        write.print('"'+blend_path+blend_name+'"');
        write.print(" -P ");
        write.print('"'+dataPath("tmp")+File.separator+"fromblend.py"+'"');
        write.println();
        write.print("exit");

        write.flush();
        write.close();
        try {
          String cmd[]= {terminal_path, "/c", "start", "/w", dataPath("tmp")+File.separator+"fromblend.bat"};
          Process proc = Runtime.getRuntime().exec(cmd);
          proc.waitFor();
        } 
        catch(Exception e) {
          e.printStackTrace();
        }
      } else {
        write = createWriter(dataPath("tmp")+File.separator+"fromblend.sh");
        write.println("#!/bin/bash");
        write.println();
        write.println("# Auto-generated by " + version);
        write.println();
        write.println("# Command Line:");
        write.println();
        write.print('"'+blender_path+'"');
        write.print(" -b ");
        write.print('"'+blend_path+blend_name+'"');
        write.print(" -P ");
        write.print('"'+dataPath("tmp")+File.separator+"fromblend.py"+'"');

        write.flush();
        write.close();

        File f_sh = new File(dataPath("tmp")+File.separator+"fromblend.sh");
        f_sh.setExecutable(true, false);

        try {
          String cmd[] = {terminal_path, "-e", dataPath("tmp")+File.separator+"fromblend.sh"};
          Process proc = Runtime.getRuntime().exec(cmd);
          proc.waitFor();
        } 
        catch(Exception e) {
          e.printStackTrace();
        }
      }

      String line[] = loadStrings(project_path+"Manager"+File.separator+"fromblend.txt");

      write = createWriter(project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf(".")) + ".txt");
      write.println("[RendersOutput]");
      write.println(line[0].substring(0, line[0].lastIndexOf(File.separator) + 1));
      write.println();
      write.println("[RenderName]");
      write.println(line[0].substring(line[0].lastIndexOf(File.separator) +1, line[0].indexOf("***")));
      write.println();
      write.println("[FileFormat]");
      write.println(line[0].substring(line[0].indexOf("***") + 3, line[0].indexOf("***", line[0].indexOf("***") + 1)));
      write.println();
      write.println("[StartFrame]");
      write.println(line[0].substring(line[0].indexOf("***", line[0].indexOf("***") + 2) + 3, line[0].lastIndexOf("***")));
      write.println();
      write.println("[EndFrame]");
      write.println(line[0].substring(line[0].lastIndexOf("***") + 3));
      write.flush();
      write.close();

      if (os == "WINDOWS") {
        File f_bat = new File (dataPath("tmp")+File.separator+"fromblend.bat");
        f_bat.delete();
      } else {
        File f_sh = new File(dataPath("tmp")+File.separator+"fromblend.sh");
        f_sh.delete();
      }
      File f_py = new File (dataPath("tmp")+File.separator+"fromblend.py");
      f_py.delete();
      File f_txt = new File (project_path+"Manager"+File.separator+"fromblend.txt");
      f_txt.delete();
    }
  }
}


String extensionName(String ext)
{
  if (ext.equals("PNG")) {
    ext = ".png";
  } else if (ext.equals("JPEG")) {
    ext = ".jpg";
  } else if (ext.equals("TARGA")) {
    ext = ".tga";
  } else if (ext.equals("TARGA_RAW")) {
    ext = ".tga";
  } else if (ext.equals("TIFF")) {
    ext = ".tif";
  } else if (ext.equals("IRIS")) {
    ext = ".rgb";
  } else if (ext.equals("BMP")) {
    ext = ".bmp";
  } else if (ext.equals("JPEG2000")) {
    ext = ".jp2";
  } else if (ext.equals("OPEN_EXR")) {
    ext = ".exr";
  } else if (ext.equals("OPEN_EXR_MULTILAYER")) {
    ext = ".exr";
  } else if (ext.equals("CINEON")) {
    ext = ".cin";
  } else if (ext.equals("DPX")) {
    ext = ".dpx";
  } else if (ext.equals("HDR")) {
    ext = ".hdr";
  }
  return ext;
}