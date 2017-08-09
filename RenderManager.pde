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
        rendersManager("good");
      }
      if (manager_bad()) {
        rendersManager("bad");
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
            String prepath = proyectpath+"Manager"+File.separator+"Previews"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+"_"+nf(framemanager, 4)+".png";
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

void rendersManager(String option) 
{
  write = createWriter(proyectpath+"Manager"+File.separator+"RendersControl-FINAL.Manager");
  write.println("[Proyect Name]");
  write.println(proyectname);
  write.println();
  write.println("[Renders]");
  write.println();
  write.println(settingsname);
  for (int i = 0; i <= int(valoption[frame_end_id]); i++) {
    if (option == "good") write.print("Good  ");
    else if (option == "bad")  write.print("Bad   ");
    else if (option == "empty")  write.print("Empty ");
    write.print(" Frame:");
    write.println(nf(int(valoption[frame_start_id]) + i, 5));
  }
  write.flush();
  write.close();
}

void getrenderoutputManager() 
{
  
}