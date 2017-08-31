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
  text("Select folder:", width / 2, 55);

  fill(bcolor);
  rect(150, 102, 15, 15, 4);

  fill(icolor);
  textSize(11);
  text("...", 157, 105);

  fill(acolor);
  path_name = path_batch;
  if (path_batch.length() > 50) path_name = path_batch.substring(0, 25)+"..."+path_batch.substring(path_batch.length() - 25);
  text(path_name,  width / 2, 85);

  textSize(14);
  fill(bcolor);
  text("RENAME o DELETE all files in: "+path_name,  width / 2, 150);
  
  fill(acolor);
  text("                 -New Name: "+" >>"+new_name+s_frame+"."+ext_rename+"<<",  width / 2, 200);
  text("                 -Ends With: "+" >>"+"."+ext_delete+"<<",  width / 2, 250);
  text("-New name start:  >>"+s_frame+"<<",  width / 2, 220);
  fill(ecolor);
  text(">RENAME<", 110, 200);
  text(">DELETE<", 150, 250);
  
  noFill();
  rect(150, 275, 330, 55);
  text(rename_files+"             files to Rename!", width / 2, 290);
  text(delete_files+"             files to deleted!",  width / 2, 310);

  popStyle();
}

boolean rename_batch_() 
{
  return  (mouseX > 70 && mouseX < 150 && mouseY > 190 && mouseY < 215);
}
boolean newname_batch_() 
{
  return  (mouseX > 340 && mouseX < 500 && mouseY > 190 && mouseY < 215);
}

boolean s_frame_batch_() 
{
  return  (mouseX > 340 && mouseX < 500 && mouseY > 216 && mouseY < 230);
}


boolean delete_batch_() 
{
  return  (mouseX > 105 && mouseX < 190 && mouseY > 240 && mouseY < 260);
}
boolean extension_batch_() 
{
  return  (mouseX > 340 && mouseX < 500 && mouseY > 235 && mouseY < 255);
}

boolean path_batch_() 
{
  return  (mouseX > 145 && mouseX < 170 && mouseY > 100 && mouseY < 120);
}