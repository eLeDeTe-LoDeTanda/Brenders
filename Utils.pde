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

void selectColor()
{
  pushStyle();

  textAlign(CENTER, CENTER);
  textSize(10);
  fill(80);
  rect(43, 91, 550, 114);
  fill(220);
  rect(45, 95, 545, 107);
  fill(icolor);
  text("R:", 70, 155);
  if (fgcolor) text(map(fgrgba[0], 0, 255, 0, 1), 90, 155);
  else if (bgcolor) text(map(bgrgba[0], 0, 255, 0, 1), 90, 155);
  text("G:", 70, 165);
  if (fgcolor) text(map(fgrgba[1], 0, 255, 0, 1), 90, 165);
  else if (bgcolor) text(map(bgrgba[1], 0, 255, 0, 1), 90, 165);
  text("B:", 70, 175);
  if (fgcolor) text(map(fgrgba[2], 0, 255, 0, 1), 90, 175);
  else if (bgcolor) text(map(bgrgba[2], 0, 255, 0, 1), 90, 175);
  text("A:", 70, 185);
  if (fgcolor) text(map(fgrgba[3], 0, 255, 0, 1), 90, 185);
  else if (bgcolor) text(map(bgrgba[3], 0, 255, 0, 1), 90, 185);

  fill(bgrgba[0], bgrgba[1], bgrgba[2], bgrgba[3]);
  rect(160, 147, 280, 48);
  fill(fgrgba[0], fgrgba[1], fgrgba[2], fgrgba[3]);

  textSize(int(valoption[use_stamp_textsize_id]));
  text("FG Text", 300, 164);

  textSize(10);
  fill(icolor);
  if (fgcolor) {
    text("Foreground Color", 540, 195);

    if  (mouseX > 500 && mouseX < 540 && mouseY > 160 && mouseY < 170) valoption[use_stamp_textsize_id] = str(constrain(int(valoption[use_stamp_textsize_id]) - 1, 8, 64));
    if  (mouseX > 540 && mouseX < 580 && mouseY > 160 && mouseY < 170) valoption[use_stamp_textsize_id] = str(constrain(int(valoption[use_stamp_textsize_id]) + 1, 8, 64));
    text("Font Size: << "+valoption[use_stamp_textsize_id]+" >>", 520, 168);
  }
  if (bgcolor) text("Background Color", 540, 195);
  for (int i = 0; i < 256; i++) {
    noStroke();
    fill(i, 0, 0, i);
    rect(55+i*2, 105, 2, 10);
    fill(0, i, 0, i);
    rect(55+i*2, 115, 2, 10);
    fill(0, 0, i, i);
    rect(55+i*2, 125, 2, 10);
    fill(0, 0, 0, i);
    rect(55+i*2, 135, 2, 10);
  }
  popStyle();
}


String fullDate ()
{
  String fulldate =  nf(month(), 2)+"-"+nf(day(), 2)+"-"+nf(year(), 2)+"_"+nf(hour(), 2)+":"+nf(minute(), 2)+":"+nf(second(), 2);
  return fulldate;
}


void menuBar()
{
  pushStyle();

  textAlign(CENTER, CENTER);

  textSize(7);
  fill(acolor, 100);
  text("HOME", 20, 20);
  text("C-LINE", 50, 20);
  text("MULTI", 80, 20);
  text("MANAGER", 110, 20);
  text("CAL", 140, 20);
  text("BATCH", 170, 20);

  if (gui == 0) {
    textSize(15);
    fill(bcolor, 200);
    text(description, width / 2 + 135, 5);
    fill(ccolor);
  } else fill(bcolor, 100);
  ellipse(20, 10, 15, 15);
  if (gui == 1) {
    textSize(14);
    fill(bcolor, 200);
    path_name = settings_name;
    if (settings_name.length() > 20) path_name = settings_name.substring(0, 10)+"..."+settings_name.substring(settings_name.length() - 10);
    text(path_name, width / 2, 5);
    text("Command line generator", width / 2 + 230, 5);
    fill(ccolor);
  } else fill(bcolor, 100);
  ellipse(50, 10, 15, 15);
  if (gui == 2) {
    textSize(14);
    fill(bcolor, 200);
    text("Render Manager", width / 2 + 255, 5);
    fill(ccolor);
  } else fill(bcolor, 100);
  ellipse(110, 10, 15, 15); 
  if (gui == 3) {
    textSize(14);
    fill(bcolor, 200);
    text("Rendering multiblend", width / 2 + 240, 5);
    fill(ccolor);
  } else fill(bcolor, 100);
  ellipse(80, 10, 15, 15);
  if (gui == 4) {
    textSize(14);
    fill(bcolor, 200);
    text("Approximate Render Time", width / 2 + 220, 5);
    fill(ccolor);
  } else fill(bcolor, 100);
  ellipse(140, 10, 15, 15); 
  if (gui == 5) {
    textSize(14);
    fill(bcolor, 200);
    text("Batch Processing", width / 2 + 255, 5);
    fill(ccolor);
  } else fill(bcolor, 100);
  ellipse(170, 10, 15, 15);

  popStyle();
}

boolean menu_0() 
{
  return (mouseX > 0 && mouseX < 40 && mouseY > 0 && mouseY < 30) ;
}
boolean menu_1() 
{
  return (mouseX > 40 && mouseX < 70 && mouseY > 0 && mouseY < 30) ;
}
boolean menu_2() 
{
  return (mouseX > 70 && mouseX < 90 && mouseY > 0 && mouseY < 30) ;
}
boolean menu_3() 
{
  return (mouseX > 90 && mouseX < 120 && mouseY > 0 && mouseY < 30) ;
}
boolean menu_4() 
{
  return (mouseX > 120 && mouseX < 150 && mouseY > 0 && mouseY < 30) ;
}
boolean menu_5() 
{
  return (mouseX > 150 && mouseX < 180 && mouseY > 0 && mouseY < 30) ;
}