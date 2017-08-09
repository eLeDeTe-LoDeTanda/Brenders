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

  background(backgroundcolor);
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
  pathname = blenderpath;
  if (blenderpath.length() > 22) pathname = blenderpath.substring(0, 11)+"..."+blenderpath.substring(blenderpath.length() - 11);
  text(pathname, 265, 95);
  pathname = texteditorpath;
  if (texteditorpath.length() > 16) pathname = texteditorpath.substring(0, 8)+"..."+texteditorpath.substring(texteditorpath.length() - 8);
  text(pathname, 265, 175);
  pathname = managerpath;
  if (managerpath.length() > 16) pathname = managerpath.substring(0, 8)+"..."+managerpath.substring(managerpath.length() - 8);  
  text(pathname, 265, 215);
  pathname = terminalpath;
  if (terminalpath.length() > 20) pathname = terminalpath.substring(0, 10)+"..."+terminalpath.substring(terminalpath.length() - 10);  
  text(pathname, 265, 135);
  //if (os != "WINDOWS") {
  pathname = imageviewerpath;
  if (imageviewerpath.length() > 20) pathname = imageviewerpath.substring(0, 10)+"..."+imageviewerpath.substring(imageviewerpath.length() - 10);  
  text(pathname, 265, 255);
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