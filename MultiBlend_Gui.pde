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
  surface.setTitle("MultiBlend -"+proyectname+"- "+version);
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
  text(info, width / 2, 162);

  fill(bcolor);
  if (multiblend_active) {
    text(">>'IMPORT' Render Options<<", width / 2, 80);
    text(">>Order 'EDIT'<<", width / 2, 100);
    text(">>Open Proyect Folder<<", width / 2, 120);
   
    String name = multiblend_names[order];
    if (multiblend_names[order].length() > 18) name = multiblend_names[order].substring(0, 9)+"..."+multiblend_names[order].substring(multiblend_names[order].length() - 9);
    text("<< Order:"+nf(order, 4)+" - "+name+">>", 170, 340);
    fill(acolor);
    text("'"+multiblend_files+"' .blend to render", 170, 320);
    fill(ccolor);
   
    textAlign(LEFT);
    textSize(12);
    image(blendpre, 490, 200);
    text("Preview", 500, 320);
    fill(bcolor);
    text(">> New preview <<", 495, 340);
    textSize(10);
    fill(ccolor);
    text("Frame: <<"+nf(frameprev, 4)+">>", 510, 355);

    textSize(14);
    text("Start render", 342, 348);
    fill(bcolor);
    ellipse(380, 315, 40, 40);
    fill(icolor);
    text("Go!", 370, 320);
    fill(acolor);
    textSize(11);
    text("o Restart", 410, 310);
    text("o Rendering", 410, 330);
    if (multiblend_restart) {
      fill(ccolor);
      ellipse(413, 307, 8, 8);
    } else {
      fill(ccolor);
      ellipse(413, 327, 8, 8);
    }
    fill(acolor);
  } else {
    textSize(16);
    text("No Proyect Open", width / 2, 280);
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

boolean import_Multiblend_() 
{
  return  (mouseX > 270 && mouseX < 370 && mouseY > 60 && mouseY < 85);
}
boolean edit_order_Multiblend_() 
{
  return  (mouseX > 270 && mouseX < 370 && mouseY > 86 && mouseY < 105);
}
boolean open_folder_Multiblend_() 
{
  return  (mouseX > 270 && mouseX < 370 && mouseY > 106 && mouseY < 125);
}

boolean go_Multiblend_() 
{
  return  (mouseX > 360 && mouseX < 400 && mouseY > 295 && mouseY < 335);
}

boolean overwrite_Multiblend_() 
{
  return  (mouseX > 410 && mouseX < 470 && mouseY > 300 && mouseY < 310);
}
boolean continue_Multiblend_() 
{
  return  (mouseX > 410 && mouseX < 470 && mouseY > 320 && mouseY < 330);
}

boolean orderL_Multiblend_() 
{
  return  (mouseX > 0 && mouseX < 150 && mouseY > 320 && mouseY < 350);
}
boolean orderR_Multiblend_() 
{
  return  (mouseX > 200 && mouseX < 320 && mouseY > 320 && mouseY < 350);
}

boolean blendpre_Multiblend_() 
{
  return  (mouseX > 495 && mouseX < 615 && mouseY > 325 && mouseY < 345);
}
boolean framepreL_Multiblend_()
{
  return  (mouseX > 545 && mouseX < 570 && mouseY > 345 && mouseY < 360);
}
boolean framepreR_Multiblend_()
{
  return  (mouseX > 580 && mouseX < 605 && mouseY > 345 && mouseY < 360);
}