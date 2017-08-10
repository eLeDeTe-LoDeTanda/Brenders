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
            String prepath = outputpath+rendersname.substring(0, rendersname.lastIndexOf("_"))+"_"+nf(framemanager, 4)+".png";
            //print(prepath);
            if (os == "WINDOWS") {
              String cmd[] = {"rundll32.exe", "C:"+File.separator+"WINDOWS"+File.separator+"System32"+File.separator+"shimgvw.dll,ImageView_Fullscreen", prepath};
              exec(cmd);
            } else {
              String cmd[] = {imageviewerpath, prepath};
              exec(cmd);
            }
          }
        }
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