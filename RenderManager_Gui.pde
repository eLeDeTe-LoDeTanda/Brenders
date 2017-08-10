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

int offsetmanager;
int framemanager;
int startframemanager;
int endframemanager;

void renderManager_Gui()
{
  pushStyle();

  surface.setTitle("Render Manager -"+proyectname+"- "+version);
  background(backgroundcolor);
  tint(250, 240, 240);
  image(bg2, 0, 0);
  menuBar();

  for (int i = 0; i < 10; i++) {
    for (int x = 0; x < 15; x++) {
      fill(acolor, 20);
      rect(20 + x * 40, 32 + i * 30, 40, 20);

      if (multiblend_active) {
        if (multiblend_files > 0) {
          framemanager = ((i * 15 + x) + offsetmanager) + int(valoption[frame_start_id]);

          if (framemanager <= int(valoption[frame_end_id])) {
            fill(bcolor);
            textSize(10);
            text("Empty", 22 + x * 40, 50 + i * 30);

            File img = new File(proyectpath+"Manager"+File.separator+"Previews"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+"_"+nf(framemanager, 4)+".png");
            if (!img.exists()) renderpre = loadImage("Img"+File.separator+"Manager-none.png");
            else  renderpre = loadImage(proyectpath+"Manager"+File.separator+"Previews"+File.separator+settingsname.substring(0, settingsname.lastIndexOf("."))+"_"+nf(framemanager, 4)+".png");

            image(renderpre, 20 + x * 40, 32 + i * 30);

            fill(acolor);
            textSize(8);
            text(nf(framemanager, 5), 26 + x * 40, 60 + i * 30);
          }
        }
      }
    }
  }
  textAlign(CENTER, CENTER);
  textSize(14);
  pathname = settingsname;
  if (settingsname.length() > 20) pathname = settingsname.substring(0, 10)+"..."+settingsname.substring(settingsname.length() - 10);
  text(pathname, width / 2, 5);

  fill(bcolor);
  textSize(12);
  text("<<", 8, height / 2);
  text(">>", width - 10, height / 2);

  text("Selected Range:"+">"+nf(startframemanager, 5)+"<"+" to "+">"+nf(endframemanager, 5)+"<"+" | >ALL< |", 180, 345);
  fill(ccolor);
  text(">GOOD<", 385, 345);
  fill(ecolor);
  text(">BAD<", 445, 345);
  fill(bcolor);
  if (multiblend_active) {
    if (multiblend_files <= 0) {
      text("-EMPTY proyect-", 550, 345);
    } else {
      text("WAITING...", 550, 345);
    }
  } else {
    textSize(16);
    rect(240, 167, 160, 20);
    fill(ecolor);
    text("NO PROYECT OPEN", 320, 175);
    textSize(12);
    fill(bcolor);
  }
  popStyle();
}

boolean manager_L() 
{
  return  (mouseX > 0 && mouseX < 20 && mouseY > 170 && mouseY < 190);
}
boolean manager_R() 
{
  return  (mouseX > 620 && mouseX < 640 && mouseY > 170 && mouseY < 190);
}

boolean manager_all() 
{
  return  (mouseX > 275 && mouseX < 315 && mouseY > 340 && mouseY < 355);
}
boolean manager_good() 
{
  return  (mouseX > 355 && mouseX < 410 && mouseY > 340 && mouseY < 355);
}
boolean manager_bad() 
{
  return  (mouseX > 425 && mouseX < 470 && mouseY > 340 && mouseY < 355);
}