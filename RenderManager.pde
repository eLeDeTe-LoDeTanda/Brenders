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
        offsetmanager = constrain(offsetmanager - 150, 0, int(valoption[frame_end_id]));
      }
      if (manager_R()) {
        if (int(valoption[frame_end_id]) > 150) offsetmanager = constrain(offsetmanager + 150, 0, int(valoption[frame_end_id]));
      }
      if (manager_all()) {
        startframemanager = int(valoption[frame_start_id]);
        endframemanager = int(valoption[frame_end_id]);
      }
      if (manager_good()) {
        rendersManager("good", framemanager);
      }
      if (manager_bad()) {
        rendersManager("bad", framemanager);
      }
      if (mouseX >= 20 && mouseX <= 625 && mouseY >= 30 && mouseY <=  325) {
        int X = floor(map(mouseX, 20, 620, 0, 15));
        int Y = floor(map(mouseY, 30, 325, 0, 10));

        framemanager = ((Y * 15 + X) + offsetmanager) + int(valoption[frame_start_id]);

        if (mouseButton == LEFT) {
          startframemanager = framemanager;
          endframemanager = framemanager;
        }
        if (mouseButton == RIGHT) {
          endframemanager = framemanager;
        }
        if (mouseButton == CENTER) {
          if (framemanager <= int(valoption[frame_end_id])) {
            String prepath = outputpath+rendersname+nf(framemanager, 4)+".png";
            //print(prepath);
            if (os == "WINDOWS") {
              String cmd[] = {"rundll32.exe", "C:"+File.separator+"WINDOWS"+File.separator+"System32"+File.separator+"shimgvw.dll,ImageView_Fullscreen", prepath};
              exec(cmd);
            } else {
              String cmd[] = {imageviewerpath, prepath};
              exec(cmd);
            }
          }
          framepreview(outputpath+rendersname+nf(framemanager, 4)+".png");
        }
      }
      if (manager_reloadallpre()) {
        thread("allpreviews");
      }
      if (manager_reloadnewpre()) {
        thread("newspreviews");
      }
    }
  }
}


void rendersManager(String option, int frame)
{
  JSONObject rendermanager;

  rendermanager = new JSONObject();

  rendermanager.setInt("Frame", frame);
  rendermanager.setString("Render", option);

  saveJSONObject(rendermanager, proyectpath+"Manager"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".Manager");
}


void jsonManager() 
{
  JSONArray rendercontrol;

  rendercontrol = new JSONArray();

  for (int i = int(valoption[frame_start_id]); i <= int(valoption[frame_end_id]); i++) {

    JSONObject rendermanager = new JSONObject();

    rendermanager.setInt("Frame", i);
    rendermanager.setString("Multi", settingsname);
    rendermanager.setString("Status", "Waiting");
    rendermanager.setString("Render", "None");
    if (newoutput) {
      rendermanager.setString("Render path", outputpath);
      rendermanager.setString("Render path", rendersname);
    } else {
      rendermanager.setString("Render path", "From .blend");
      rendermanager.setString("Render name", "From .blend");
    }

    rendercontrol.setJSONObject(i, rendermanager);
  }

  saveJSONArray(rendercontrol, proyectpath+"Manager"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+".Manager");
}


void allpreviews()
{
  PImage img;
  for (int i = int(valoption[frame_start_id]); i <= int(valoption[frame_end_id]); i++) {
    File f = new File(outputpath+rendersname+nf(i, 4)+".png");
    if (f.exists()) {
      img = loadImage(outputpath+rendersname+nf(i, 4)+".png");
      img.resize(40, 23);
      img.save(proyectpath+"Manager"+File.separator+"Previews"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+File.separator+rendersname+nf(i, 4)+".png");
      System.gc(); 
      redraw();
    }
  }
}


void newspreviews()
{
  PImage img;
  for (int i = int(valoption[frame_start_id]); i <= int(valoption[frame_end_id]); i++) {
    File fp = new File(proyectpath+"Manager"+File.separator+"Previews"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+File.separator+rendersname+nf(i, 4)+".png");
    if (!fp.exists()) {
      File f = new File(outputpath+rendersname+nf(i, 4)+".png");
      if (f.exists()) {
        img = loadImage(outputpath+rendersname+nf(i, 4)+".png");
        img.resize(40, 23);
        img.save(proyectpath+"Manager"+File.separator+"Previews"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+File.separator+rendersname+nf(i, 4)+".png");

        System.gc();
        redraw();
      }
    }
  }
}

void framepreview(String frame)
{
  fromblend();
  PImage img;
  File f = new File(frame);
  if (f.exists()) {
    img = loadImage(frame);
    img.resize(40, 23);
    img.save(proyectpath+"Manager"+File.separator+"Previews"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+File.separator+rendersname+nf(framemanager, 4)+".png");
    System.gc();
  }
  updating = false;
}


void fromblend()
{
  File f = new File(proyectpath+"Manager"+File.separator+settingsname.substring(0, settingsname.lastIndexOf(".")) + ".txt");

  if (!f.exists()) {
    write = createWriter(dataPath("tmp")+File.separator+"fromblend.py");
    write.println("# Auto-generated by " + version);
    write.println();
    write.println("import bpy");
    write.println();
    write.print("Scenename = ");
    if (fromblend[scene_name_id]) write.println("bpy.context.scene.name");
    else write.println('"'+scenename+'"');
    write.println("file = open("+'"'+dataPath("tmp")+File.separator+"fromblend.txt"+'"'+", 'w', encoding='utf-8')");
    write.println("file.write("+'"'+"%s"+'"'+" % (bpy.data.scenes[Scenename].render.filepath) + "+'"'+"***"+'"'+" + "+'"'+"%s"+'"'+" % (bpy.data.scenes[Scenename].frame_start) + "+'"'+"***"+'"'+" + "+'"'+"%s"+'"'+" % (bpy.data.scenes[Scenename].frame_end))");
    write.println("file.close()");

    write.flush();
    write.close();

    if (os == "WINDOWS") {
      write = createWriter(dataPath("tmp")+File.separator+"fromblend.bat");

      write.println("@ECHO OFF");
      write.println("COLOR 8F");
      write.println();
      write.print("call ");
      write.print('"'+blenderpath+'"');
      write.print(" -b ");
      write.print('"'+blendpath+blendname+'"');
      write.print(" -P ");
      write.print('"'+dataPath("tmp")+File.separator+"fromblend.py"+'"');
      write.println();
      write.print("exit");

      write.flush();
      write.close();
      try {
        String cmd[]= {terminalpath, "/c", "start", "/w", dataPath("tmp")+File.separator+"fromblend.bat"};
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
      write.print('"'+blenderpath+'"');
      write.print(" -b ");
      write.print('"'+blendpath+blendname+'"');
      write.print(" -P ");
      write.print('"'+dataPath("tmp")+File.separator+"fromblend.py"+'"');

      write.flush();
      write.close();

      File f_sh = new File(dataPath("tmp")+File.separator+"fromblend.sh");
      f_sh.setExecutable(true, false);

      try {
        String cmd[] = {terminalpath, "-e", dataPath("tmp")+File.separator+"fromblend.sh"};
        Process proc = Runtime.getRuntime().exec(cmd);
        proc.waitFor();
      } 
      catch(Exception e) {
        e.printStackTrace();
      }
    }

    String line[] = loadStrings(dataPath("tmp")+File.separator+"fromblend.txt");

    write = createWriter(proyectpath+"Manager"+File.separator+settingsname.substring(0, settingsname.lastIndexOf(".")) + ".txt");
    write.println("[RendersOutput]");
    write.println(line[0].substring(0, line[0].lastIndexOf(File.separator) + 1));
    write.println();
    write.println("[RenderName]");
    write.println(line[0].substring(line[0].lastIndexOf(File.separator) +1, line[0].indexOf("***")));
    write.println();
    write.println("[StartFrame]");
    write.println(line[0].substring(line[0].indexOf("***") + 3, line[0].lastIndexOf("***")));
    write.println();
    write.println("[EndFrame]");
    write.println(line[0].substring(line[0].lastIndexOf("***") + 3));
    write.flush();
    write.close();

    String lines[] = loadStrings(proyectpath+"Manager"+File.separator+settingsname.substring(0, settingsname.lastIndexOf(".")) + ".txt");
    for (int i = 0; i < lines.length; i++) {
      write.println(trim(lines[i]));
      if (lines[i].contains("[RendersOutput]")) outputpath = lines[i+1];
      else if (lines[i].contains("[RenderName]")) rendersname = lines[i+1];
      else if (lines[i].contains("[StartFrame]")) valoption[frame_start_id] = lines[i+1];
      else if (lines[i].contains("[EndFrame]")) valoption[frame_end_id] = lines[i+1];
    } 

    if (os == "WINDOWS") {
      File f_bat = new File (dataPath("tmp")+File.separator+"fromblend.bat");
      f_bat.delete();
    } else {
      File f_sh = new File(dataPath("tmp")+File.separator+"fromblend.sh");
      f_sh.delete();
      File f_py = new File (dataPath("tmp")+File.separator+"fromblend.py");
      f_py.delete();
    }
    File f_txt = new File (dataPath("tmp")+File.separator+"fromblend.txt");
    f_txt.delete();
  }
}