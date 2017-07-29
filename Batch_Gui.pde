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
String path_batch =  "No folder selected...";
String ext_del = "blend1";
String new_name = "xxxxxxxxxxxxxxxx";
boolean select_del = false;

void batch_Gui()
{
  pushStyle();
  
  surface.setTitle("Batch Processing");
  background(backgroundcolor);
  tint(230, 230, 250);
  image(bg2, 0, 0);

  menuBar();

  fill(acolor);
  textSize(16);
  text("Select folder:", 260, 70);

  fill(bcolor);
  rect(150, 102, 15, 15, 4);

  fill(icolor);
  textSize(11);
  text("...", 153, 110);

  fill(acolor);
  pathname = path_batch;
  if (path_batch.length() > 50) pathname = path_batch.substring(0, 25)+"..."+path_batch.substring(path_batch.length() - 25);
  text(pathname, 170, 115);

  textSize(14);
  //text(">RENAME<   -Rename all files to: "+" >>"+new_name+"<<", 110, 200);
  text("                   -Delete all files ends with: "+" >>"+"."+ext_del+"<<", 130, 250);
  fill(ecolor);
  text(">DELETE<", 130, 250);
 
  popStyle();
}

boolean rename_batch_() 
{
  return  (mouseX > 245 && mouseX < 265 && mouseY > 180 && mouseY < 200);
}
boolean newname_batch_() 
{
  return  (mouseX > 320 && mouseX < 530 && mouseY > 180 && mouseY < 200);
}

boolean delete_batch_() 
{
  return  (mouseX > 130 && mouseX < 210 && mouseY > 235 && mouseY < 255);
}
boolean extension_batch_() 
{
  return  (mouseX > 340 && mouseX < 530 && mouseY > 235 && mouseY < 255);
}

boolean path_batch_() 
{
  return  (mouseX > 145 && mouseX < 170 && mouseY > 100 && mouseY < 120);
}