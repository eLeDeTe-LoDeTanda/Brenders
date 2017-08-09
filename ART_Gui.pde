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

int time;
int frames = 1;
int H = 0;
int M = 0;
int S = 0;
int fps = 24;
int cpu = 1;
int d = 0;
int h = 0;
int m = 0;
int s = 0;
int ah = 0;
int am = 0;
int as = 0;
int aniDuration;

boolean[] selectART = new boolean[6];
String [] valART = new String[6];

void ART_Gui()
{
  pushStyle();

  surface.setTitle("ART -Approximate Render Time Calculator-");
  background(backgroundcolor);
  tint(220, 220, 230);
  image(bg3, 0, 0);

  menuBar();

  S = constrain(S, 0, 60);
  M = constrain(M, 0, 60);
  frames = constrain(frames, 1, 9999999);
  fps = constrain(fps, 1, 999);
  cpu = constrain(cpu, 1, 99999);

  textAlign(CENTER);

  textSize(20);

  fill(ecolor);
  text(d+"d:"+h+"h:"+m+"m:"+s+"s", width / 2, height - 40);
  textSize(20);
  fill(ccolor);
  text(ah+"h:"+am+"m:"+as+"s", width / 2, height - 90);
  textSize(16);
  fill(acolor);
  text("Approximate render time:", width / 2, height - 65);
  text("Time per frame:", width / 2, 70);
  textSize(14);
  if (selectART[0]) fill(bcolor);
  else  fill(acolor);
  text(">>H: "+H+"<<", width / 2, 90);
  if (selectART[1]) fill(bcolor);
  else  fill(acolor);
  text(">>M: "+M+"<<", width / 2, 110);
  if (selectART[2]) fill(bcolor);
  else  fill(acolor);
  text(">>S: "+S+"<<", width / 2, 130);
  if (selectART[3]) fill(bcolor);
  else  fill(acolor);
  text(">>FRAMES: "+frames+"<<", width/ 2, 150);
  if (selectART[4]) fill(bcolor);
  else  fill(acolor);
  text(">>FPS: "+fps+"<<", width / 2, 170);
  if (selectART[5]) fill(bcolor);
  else  fill(acolor);
  text(">>CPU: "+cpu+"<<", width / 2, 190);

  fill(acolor);
  text("Animation:", width / 2, height - 115);

  aniDuration = frames / fps;

  if (cpu > frames) {
    cpu = frames;
  }

  time = ((frames * (((H * 60) + M) * 60 + S)) / cpu);

  s = time % 60;
  m = time/60;
  h = m / 60;
  m = m % 60;
  d = h / 24;
  h = h - d * 24;

  as = aniDuration % 60;
  am = aniDuration/60;
  ah = am / 60;
  am = am % 60;

  popStyle();
}