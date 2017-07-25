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


void about()
{
  pushStyle();
  background(backgroundcolor);
  tint(100, 100, 100);
  image(bg, 0, 0);

  menuBar();
  textAlign(CENTER, CENTER);
  fill(10, 50);
  ellipse(width / 2, height / 2, 250, 250);
  fill(acolor);
  textSize(14);
  text("GPL", width / 2, 80);
  text("Open Software", width / 2, 100);
  textSize(10);
  text(version, width / 2, 120);
  textSize(20);
  text(">Github<", width / 2, 155);
  textSize(14);
  text("Code and design by:", width / 2, 190);
  textSize(12);
  text("Marcelo 'TANDA' Cerviño", width / 2, 210);
  textSize(10);
  text("lodetanda @ gmail.com", width / 2, 220);
  text("http://lodetanda.blogspot.com", width / 2, 230);
  text("eLeDeTe -LoDeTanda-", width / 2, height / 2 + 100);
  text("cc 2017", width / 2, height / 2 + 110);

  popStyle();
}