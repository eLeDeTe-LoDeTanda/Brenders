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

void preferences_Gui()
{
  pushStyle();

  background(background_color);
  tint(230, 230, 250);
  image(bg2, 0, 0);

  menuBar();

  stroke(icolor);

  textAlign(LEFT);

  fill(acolor);

  text("DEFAULT aplications:", 265, 40);

  textSize(14);
  text("BLENDER", 245, 75);
  textSize(10);
  text("-Open<", 350, 75);

  textSize(14);
  text("TERMINAL", 245, 115);
  textSize(10);
  text("-Open<", 350, 115);
  ;

  textSize(14);
  text("Text EDITOR", 245, 155);
  textSize(10);
  text("-Open<", 350, 155);

  textSize(14);
  text("file MANAGER", 245, 195);
  textSize(10);
  text("-Open<", 350, 195);

  textSize(14);
  text("image VIEWER", 245, 235);
  textSize(10);
  text("-Open<", 350, 235);

  fill(bcolor);
  rect(245, 82, 15, 15, 4);
  rect(245, 122, 15, 15, 4);
  rect(245, 162, 15, 15, 4);
  rect(245, 202, 15, 15, 4);
  rect(245, 242, 15, 15, 4);

  fill(icolor);
  textSize(11);
  text("...", 248, 91);
  text("...", 248, 131);
  text("...", 248, 171);
  text("...", 248, 211);
  text("...", 248, 251);

  fill(acolor);
  path_name = blender_path;
  if (blender_path.length() > 22) path_name = blender_path.substring(0, 11)+"..."+blender_path.substring(blender_path.length() - 11);
  text(path_name, 265, 95);
  path_name = text_editor_path;
  if (text_editor_path.length() > 16) path_name = text_editor_path.substring(0, 8)+"..."+text_editor_path.substring(text_editor_path.length() - 8);
  text(path_name, 265, 175);
  path_name = manager_path;
  if (manager_path.length() > 16) path_name = manager_path.substring(0, 8)+"..."+manager_path.substring(manager_path.length() - 8);  
  text(path_name, 265, 215);
  path_name = terminal_path;
  if (terminal_path.length() > 20) path_name = terminal_path.substring(0, 10)+"..."+terminal_path.substring(terminal_path.length() - 10);  
  text(path_name, 265, 135);
  //if (os != "WINDOWS") {
  path_name = image_viewer_path;
  if (image_viewer_path.length() > 20) path_name = image_viewer_path.substring(0, 10)+"..."+image_viewer_path.substring(image_viewer_path.length() - 10);  
  text(path_name, 265, 255);
  // }
  fill(bcolor);
  textSize(14);

  text(">>Load Factory preferences<<", 220, 300);

  popStyle();
}


boolean blender_default_() 
{
  return  (mouseX > 245 && mouseX < 265 && mouseY > 80 && mouseY < 100);
}
boolean blender_default_open_() 
{
  return  (mouseX > 340 && mouseX < 400 && mouseY > 65 && mouseY < 80);
}

boolean terminal_default_() 
{
  return  (mouseX > 245 && mouseX < 265 && mouseY > 115 && mouseY < 140);
}
boolean terminal_default_open_() 
{
  return  (mouseX > 340 && mouseX < 400 && mouseY > 105 && mouseY < 120);
}

boolean texteditor_default_() 
{
  return  (mouseX > 245 && mouseX < 265 && mouseY > 160 && mouseY < 180);
}
boolean texteditor_default_open_() 
{
  return  (mouseX > 340 && mouseX < 400 && mouseY > 145 && mouseY < 160);
}

boolean filemanager_default_() 
{
  return  (mouseX > 245 && mouseX < 265 && mouseY > 200 && mouseY < 220);
}
boolean filemanager_default_open_() 
{
  return  (mouseX > 340 && mouseX < 400 && mouseY > 185 && mouseY < 200);
}

boolean imageviewer_default_() 
{
  return  (mouseX > 245 && mouseX < 265 && mouseY > 240 && mouseY < 260);
}
boolean imageviewer_default_open_() 
{
  return  (mouseX > 340 && mouseX < 400 && mouseY > 225 && mouseY < 240);
}

boolean load_factory_() 
{
  return  (mouseX > 215 && mouseX < 435 && mouseY > 285 && mouseY < 305);
}