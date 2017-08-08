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

boolean multiblend_active = false;
boolean add_tomulti= false;

int multiblend_files = 0;
int order = 0;

int frameprev = 1;

boolean multiblend_restart= true;

String proyectname = "NO proyect open";
String[] multiblend_names = new String[24];
String[] names = new String[12];

String proyectpath;

File proyectfolder;

void multiBlend_Gui()
{
  pushStyle();
  pathname = proyectname;
  if (proyectname.length() > 20) pathname = proyectname.substring(0, 10)+"..."+proyectname.substring(proyectname.length() - 10);
  surface.setTitle("MultiBlend -"+pathname+"- "+version);
  background(backgroundcolor);
  tint(230, 250, 230);
  image(bg2, 0, 0);

  menuBar();

  textAlign(LEFT);
  textSize(15);
  fill(acolor);
  rect(65, 34, 190, 25);
  rect(270, 34, 105, 20);
  rect(390, 34, 190, 25);
  fill(ccolor);
  textSize(16);
  text(">>NEW PROYECT<<", 80, 53);
  text(">>OPEN PROYECT<<", 400, 53);

  textSize(14);
  text(">>RELOAD<<", 274, 49);

  fill(bcolor);
  rect(174, 145, 295, 25);
  if (error) fill(ecolor);
  else fill(icolor);
  textAlign(CENTER);
  String inf = info;
  if (info.length() > 36) inf = info.substring(0, 18)+"..."+info.substring(info.length() - 18);
  text(inf, width / 2, 162);

  if (multiblend_active) {
    fill(bcolor);
    pathname = proyectname;
    if (proyectname.length() > 20) pathname = proyectname.substring(0, 10)+"..."+proyectname.substring(proyectname.length() - 10);
    text(pathname, width / 2, 13);
    text(">>OPEN Proyect Folder<<", width / 2, 95);
    text(">>RENDER MANAGER<<", width / 2, 115);

    fill(bcolor);
    rect(width / 2 - 25, 205, 50, 12);
    fill(icolor);
    textSize(10);
    text("IMPORT", width / 2, 215);

    textSize(14);
    if (multiblend_files > 0) {
      fill(acolor);
      String name = multiblend_names[order]+".multiblend";
      if (multiblend_names[order].length() > 18) name = multiblend_names[order].substring(0, 9)+"..."+multiblend_names[order].substring(multiblend_names[order].length() - 9);
      text("-"+name+"-", width / 2, 185);
      name = blendname;
      textSize(12);
      if (blendname.length() > 20) name = blendname.substring(0, 10)+"..."+blendname.substring(blendname.length() - 10);
      text("-"+name+"-", width / 2, 200);
      text("*"+multiblend_files+"*  .blend to render", 135, 310);
      fill(bcolor);
      text("<< Order: "+nf(order+1, 4)+" | "+nf(multiblend_files, 4)+">>", 135, 330);

      fill(bcolor);
      rect(width / 2 - 25, 205, 50, 12);
      rect(width / 2 - 25, 220, 50, 12);
      rect(width / 2 - 25, 235, 50, 12);
      rect(width / 2 - 25, 250, 50, 12);
      rect(width / 2 - 25, 265, 50, 12);
      fill(icolor);
      textSize(10);
      text("IMPORT", width / 2, 215);
      text("ORDER", width / 2, 230);
      text("EDIT", width / 2, 245);
      text("RENAME", width / 2, 260);
      text("DELETE", width / 2, 275);

      fill(ccolor);

      textAlign(LEFT);
      textSize(12);
      text("> Open Blend <", 505, 185);
      image(blendpre, 490, 190);
      fill(bcolor);
      text(">> New Preview <<", 495, 330);
      textSize(10);
      fill(ccolor);
      text("Frame: <<"+nf(frameprev, 4)+">>", 510, 345);
    }
    textAlign(CENTER);
    textSize(14);
    text("Start render", width / 2 + 2, 340);
    fill(bcolor);
    ellipse(width / 2, 305, 40, 40);
    fill(icolor);
    text("Go!", width / 2 + 1, 310);
    fill(acolor);
    textSize(11);
    textAlign(LEFT);
    text("o Restart", 400, 310);
    text("o Rendering", 400, 330);
    if (multiblend_restart) {
      fill(ccolor);
      ellipse(403, 307, 8, 8);
    } else {
      fill(ccolor);
      ellipse(403, 327, 8, 8);
    }
  } else {
    fill(ecolor);
    textSize(16);
    text("No Proyect Open", width / 2, 270);
  } 
  popStyle();
}


boolean new_Proyect_Multiblend_() 
{
  return  (mouseX > 65 && mouseX < 245 && mouseY > 35 && mouseY < 60);
}
boolean open_Proyect_Multiblend_() 
{
  return  (mouseX > 390 && mouseX < 570 && mouseY > 35 && mouseY < 60);
}
boolean reload_Multiblend_()
{
  return  (mouseX > 260 && mouseX < 380 && mouseY > 35 && mouseY < 60);
}

boolean open_folder_Multiblend_() 
{
  return  (mouseX > 270 && mouseX < 370 && mouseY > 80 && mouseY < 100);
}
boolean rendermanager_Multiblend_() 
{
  return  (mouseX > 270 && mouseX < 370 && mouseY > 100 && mouseY < 120);
}

boolean go_Multiblend_() 
{
  return  (mouseX > 290 && mouseX < 345 && mouseY > 280 && mouseY < 330);
}

boolean overwrite_Multiblend_() 
{
  return  (mouseX > 400 && mouseX < 470 && mouseY > 300 && mouseY < 310);
}
boolean continue_Multiblend_() 
{
  return  (mouseX > 400 && mouseX < 470 && mouseY > 320 && mouseY < 330);
}

boolean orderL_Multiblend_() 
{
  return  (mouseX > 0 && mouseX < 115 && mouseY > 315 && mouseY < 340);
}
boolean orderR_Multiblend_() 
{
  return  (mouseX > 160 && mouseX < 230 && mouseY > 315 && mouseY < 340);
}

boolean openblend_Multiblend_() 
{
  return  (mouseX > 495 && mouseX < 615 && mouseY > 175 && mouseY < 190);
}
boolean blendpre_Multiblend_() 
{
  return  (mouseX > 495 && mouseX < 615 && mouseY > 315 && mouseY < 335);
}
boolean framepreL_Multiblend_()
{
  return  (mouseX > 545 && mouseX < 570 && mouseY > 335 && mouseY < 350);
}
boolean framepreR_Multiblend_()
{
  return  (mouseX > 580 && mouseX < 605 && mouseY > 335 && mouseY < 350);
}

boolean import_Multiblend_()
{
  return  (mouseX > 290 && mouseX < 350 && mouseY > 205 && mouseY < 220);
}
boolean order_Multiblend_()
{
  return  (mouseX > 290 && mouseX < 350 && mouseY > 220 && mouseY < 235);
}
boolean edit_Multiblend_()
{
  return  (mouseX > 290 && mouseX < 350 && mouseY > 235 && mouseY < 250);
}
boolean rename_Multiblend_()
{
  return  (mouseX > 290 && mouseX < 350 && mouseY > 250 && mouseY < 265);
}
boolean delete_Multiblend_()
{
  return  (mouseX > 290 && mouseX < 350 && mouseY > 265 && mouseY < 280);
}