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

String path_batch =  "";
String ext_delete = "blend1";
String ext_rename = "png";
String new_name = "NewName-";
boolean select_delete = false;
boolean select_rename = false;
boolean select_s_frame = false;
String s_frame = "0000";

int rename_files = 0;
int delete_files = 0;

void batch_Gui()
{
  pushStyle();

  surface.setTitle("Batch Processing");
  background(background_color);
  tint(230, 230, 250);
  image(bg2, 0, 0);

  menuBar();

  textAlign(CENTER, CENTER);

  fill(acolor);
  textSize(16);
  text("Select folder:", width / 2 + 10, 50);

  fill(bcolor);
  rect(width / 2, 72, 20, 20, 4);

  fill(icolor);
  textSize(12);
  text("...", width / 2 + 11, 77);

  fill(acolor);
  path_name = path_batch;
  if (path_batch.length() > 50) path_name = path_batch.substring(0, 25)+"..."+path_batch.substring(path_batch.length() - 25);
  textSize(14);
  text("RENAME or DELETE files in: ", width / 2, 110);
  fill(bcolor);
  text(path_name, width / 2, 130);
  text(">Open folder<", width / 2, 160);

  fill(acolor);
  text("-New Name: "+" >>"+new_name+s_frame+"."+ext_rename+"<<", width / 2, 190);
  text("-New name start:  >>"+s_frame+"<<", width / 2, 210);
  text("-Ends With: "+" >>"+"."+ext_delete+"<<", width / 2, 250);

  fill(bcolor);
  rect(70, 191, 80, 20);
  rect(70, 241, 80, 20);
  fill(ecolor);
  text(">RENAME<", 110, 200);
  text(">DELETE<", 110, 250);

  noFill();
  text(rename_files+"     files to Rename!", width / 2, 290);
  text(delete_files+"     files to deleted!", width / 2, 310);
  rect(30, 96, 580, 50);
  rect(10, 176, 620, 50);
  rect(10, 226, 620, 50);
  rect(150, 276, 330, 55);

  popStyle();
}

boolean rename_batch_() 
{
  return  (mouseX > 60 && mouseX < 150 && mouseY > 190 && mouseY < 215);
}
boolean newname_batch_() 
{
  return  (mouseX > 230 && mouseX < 500 && mouseY > 180 && mouseY < 205);
}

boolean s_frame_batch_() 
{
  return  (mouseX > 230 && mouseX < 500 && mouseY > 206 && mouseY < 220);
}


boolean delete_batch_() 
{
  return  (mouseX > 60 && mouseX < 150 && mouseY > 240 && mouseY < 260);
}
boolean extension_batch_() 
{
  return  (mouseX > 230 && mouseX < 500 && mouseY > 245 && mouseY < 265);
}

boolean path_batch_() 
{
  return  (mouseX > 315 && mouseX < 350 && mouseY > 70 && mouseY < 95);
}
boolean openpath_batch_() 
{
  return  (mouseX > 260 && mouseX < 380 && mouseY > 150 && mouseY < 170);
}