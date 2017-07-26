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

String proyectname = "NONAME";
String[] namesmultiblend = new String[10];
String[] multiblend = new String[12];
int blendnumber;

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
  text("Proyect Name:", 50, 50);
  rect(170, 30, 300, 25);
  fill(ccolor);
  textSize(16);
  text("NEW PROYECT", 180, 50);
  fill(bcolor);
  text("ADD Blend", 250, 80);

  text(".BLENDS for rendering", 10, 90);

  fill(ccolor);
  text(multiblend[blendnumber], 300, 120);

  for (int i = 0; i < 12; i++) {
    textSize(10);
    text(nf(i, 3)+"-"+multiblend[i], 20, 110 + 22*i);
  }

  pushMatrix();
  translate(10, 140);
  rotate(-HALF_PI);
  textSize(12);
  text(">>", 0, 0);
  text("<<", -200, 0);
  popMatrix();

  fill(acolor);
  text("Render order: 000     <<->>", 300, 150);

  image(bpnone, 480, 130);
  text("Preview", 490, 250);
  fill(bcolor);
  text("New preview", 510, 275);
  textSize(10);
  fill(ccolor);
  text("Frame: 0", 500, 290);
  text("                       <<", 500, 290);

  popStyle();
}