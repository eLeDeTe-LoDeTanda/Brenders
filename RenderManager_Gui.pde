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

int offset_manager;
int frame_manager;
int select_frame;
int startframe_manager;
int endframe_manager;

boolean updating;

void renderManager_Gui()
{
  pushStyle();

  surface.setTitle("Render Manager -"+project_name+"- "+version);
  background(background_color);
  tint(250, 240, 240);
  image(bg2, 0, 0);
  menuBar();

  String prepath;

  for (int i = 0; i < 10; i++) {
    for (int x = 0; x < 15; x++) {
      fill(acolor, 20);
      rect(20 + x * 40, 32 + i * 30, 40, 22);
      if (multiblend_active) {
        if (multiblend_files > 0) {
          frame_manager = ((i * 15 + x) + offset_manager) + int(valoption[frame_start_id]);

          if (frame_manager <= int(valoption[frame_end_id])) {
            fill(bcolor);
            textSize(9);
            text("Empty", 26 + x * 40, 46 + i * 30);
            File render = new File(output_path+renders_name+nf(frame_manager, 4)+extensionName(valoption[file_format_id]));
            if (render.exists()) {
              prepath = project_path+"Manager"+File.separator+"Previews"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+File.separator+renders_name+nf(frame_manager, 4)+".png";
              File img = new File(prepath);
              if (!img.exists()) render_pre = loadImage("Img"+File.separator+"Manager-none.png");
              else  render_pre = loadImage(prepath);

              image(render_pre, 20 + x * 40, 32 + i * 30);

              fill(acolor);
              textSize(8);
              String jsonpath = "";
              if (final_renders) jsonpath = project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+".manager";
              else jsonpath = project_path+"Manager"+File.separator+settings_name.substring(0, settings_name.lastIndexOf("."))+"_preview.manager";

              if (loadJsonManager(frame_manager, jsonpath).equals("good")) {
                fill(ccolor);
                text("Good", 23 + x * 40, 52 + i * 30);
              } else if (loadJsonManager(frame_manager, jsonpath).equals("bad")) {
                fill(ecolor);
                text("Bad", 23 + x * 40, 52 + i * 30);
              }
            }
            fill(acolor);
            textSize(8);
            text(nf(frame_manager, 5), 26 + x * 40, 60 + i * 30);
          }
        }
      }
    }
  }
  
  textAlign(CENTER, CENTER);
  textSize(14);
  fill(acolor);
  String name = multiblend_names[order]+".multiblend";
  if (multiblend_names[order].length() > 20) path_name = multiblend_names[order].substring(0, 10)+"..."+multiblend_names[order].substring(multiblend_names[order].length() - 10);
  text("<< "+name+" >>", width / 2 + 15, 5);

  fill(bcolor);
  textSize(12);
  text("<<", 8, height / 2);
  text(">>", width - 10, height / 2);

  text("-Selected Range:"+">"+nf(startframe_manager, 5)+"<"+" to "+">"+nf(endframe_manager, 5)+"<"+" | >ALL< |", 177, 345);
  fill(ccolor);
  textSize(10);
  text("Mouse buttons: L: start frame, R: end frame, Center: open frame", 330, 333);
  textSize(12);
  text(">GOOD<", 385, 345);
  text(">OPEN folder<", 525, 345);
  fill(ecolor);
  text(">BAD<", 445, 345);
  fill(bcolor);
  if (multiblend_active) {
    if (multiblend_files <= 0) {
      text("-EMPTY project-", 550, 345);
    } else {
      text("Update previews: >ALL<  >NEWS<", width / 2 + 100, 22);
    }
  } else {
    textSize(16);
    rect(240, 167, 160, 20);
    fill(ecolor);
    text("NO PROJECT OPEN", 320, 175);
    textSize(12);
    fill(bcolor);
  }

  fill(bcolor);
  ellipse(595, 345, 20, 20);
  fill(icolor);
  text(">", 596, 343);
  fill(acolor);
  text("Play", 620, 345);

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
boolean manager_openfolder() 
{
  return  (mouseX > 480 && mouseX < 570 && mouseY > 340 && mouseY < 355);
}

boolean manager_reloadallpre() 
{
  return  (mouseX > 420 && mouseX < 460 && mouseY > 10 && mouseY < 25);
}
boolean manager_reloadnewpre() 
{
  return  (mouseX > 470 && mouseX < 520 && mouseY > 10 && mouseY < 30);
}

boolean manager_playrender() 
{
  return  (mouseX > 580 && mouseX < 630 && mouseY > 335 && mouseY < 360);
}

boolean manager_orderL() 
{
  return  (mouseX > 200 && mouseX < 320 && mouseY > 0 && mouseY < 15);
}
boolean manager_orderR() 
{
  return  (mouseX > 350 && mouseX < 500 && mouseY > 0 && mouseY < 15);
}