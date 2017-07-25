/*
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
 * The Original Code is Copyright (C) 2017 Marcelo "Tanda" Cerviño. http://lodetanda.blogspot.com/ 
 * All rights reserved.
 *
 * Contributor(s):
 *
 * ***** END GPL LICENSE BLOCK *****
 */

PrintWriter write;

PImage bg;
PImage bg2;
PImage bg3;
PImage bpnone;

int gui = 0;

String info;

final String version = "BRENDERS v1.0 dev";
final String description = "GUI for BLENDER Command Line render options";

final color acolor = color(150);
final color icolor = color(50);
final color bcolor = color(200, 100, 50);
final color ccolor = color(50, 100, 120);
final color ecolor = color(150, 10, 10);

final color backgroundcolor = color(20, 25, 25);

boolean error;

String os;

int val = 0;

String esc;

void setup () {
  size(640, 360);

  bg = requestImage("Img_BG"+File.separator+"bg.png");
  bg2 = requestImage("Img_BG"+File.separator+"bg2.png");
  bg3 = requestImage("Img_BG"+File.separator+"bg3.png");
  bpnone = requestImage("Blend_Previews"+File.separator+"None.png");

  noLoop();

  os = System.getProperty("os.name");
  os = os.toLowerCase();
  if (os.indexOf("linux") != -1) os = "LINUX";
  else if (os.indexOf("windows") != -1) os = "WINDOWS";
  else if (os.indexOf("mac") != -1) os = "MACOSX";
  else os = "OTHER";

  initVarCommandLine(os);
}

void draw() {

  surface.setTitle(version);
  background(backgroundcolor);
  tint(180, 180, 200);
  image(bg, 0, 0);

  menuBar();
  switch (gui) {
  case 0:
    startGui();
    break;
  case 1:
    commandLineGenerator_Gui();
    break;
  case 2:
    //rendersStatus_Gui();
    inDev_Gui();
    break;
  case 3:
    multiBlend_Gui();
    inDev_Gui();
    break;
  case 4:
    ART_Gui();
    break;
  case 5:
    //batch_Gui();
    inDev_Gui();
    break;
  case 6:
    about();
    break;
  case 7:
    //  preferences_Gui();
    inDev_Gui();
    break;
  }
  println(mouseX+"--"+mouseY);
  // println(rendersname);
  //  println(keyCode);
  // println(settingsname);
  // println(settingsfolder);
  // println(settingspath);
  error = false;
  info = "-****************-----****************-";
}