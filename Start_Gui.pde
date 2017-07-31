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

PImage startimg;

void startGui()
{
  surface.setTitle(version);
  background(backgroundcolor);
  image(bg, 0, 0);
  menuBar();

  pushStyle();

  textAlign(CENTER, CENTER);
  fill(acolor);
  textSize(14);
  text("Render Time Calculator", width / 2.9, height / 1.3 + 15);
  text("Batch Processing", width / 1.5, height / 1.3 + 15);
  text("Command line generator", width / 2 - 200, height / 3 - 40);
  text("Render Manager", width / 2, height / 4 - 40);
  text("Render multi .blend", width / 2 + 200, height / 3 - 40);
  textSize(12);
  text("About", 40, height - 40);
  text(version, width / 2, height - 20);
  text("Preferences", width - 50, height - 40);

  fill(bcolor, 150);
  ellipse(width / 2 - 200, height / 3, 50, 50);
  ellipse(width / 2 + 200, height / 3, 50, 50);
  ellipse(width / 2, height / 4, 50, 50);
  ellipse(width / 2.9, height / 1.4, 50, 50);
  ellipse(width / 1.5, height / 1.4, 50, 50);
  ellipse(40, height - 20, 20, 20);
  ellipse(width - 50, height - 20, 20, 20);

  popStyle();
}

boolean commandlinegenerator_() 
{
  return  (mouseX > 90 && mouseX < 150 && mouseY > 95 && mouseY < 150);
}

boolean rendersStatus_() 
{
  return  (mouseX > 295 && mouseX < 345 && mouseY > 65 && mouseY < 115);
}

boolean renderingMultiBlend_() 
{
  return  (mouseX > 490 && mouseX < 545 && mouseY > 95 && mouseY < 145);
}

boolean renderTimeCalculator_() 
{
  return  (mouseX > 195 && mouseX < 250 && mouseY > 230 && mouseY < 280);
}

boolean batchProcessing_() 
{
  return  (mouseX > 400 && mouseX < 450 && mouseY > 230 && mouseY < 280);
}