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

void eventsART()
{
  if  (mouseX > 250 && mouseX < 370 && mouseY > 70 && mouseY < 95) {
    for (int i = 0; i <= 5; i++) selectART[i] = false;
    esc = str(H);
    selectART[0] = !selectART[0];
    valART[0] = "";
    H = 0;
  }
  if  (mouseX > 250 && mouseX < 370 && mouseY > 96 && mouseY < 120) {
    for (int i = 0; i <= 5; i++) selectART[i] = false;
    esc = str(M);
    selectART[1] = !selectART[1];
    valART[1] = "";
    M = 0;
  }
  if  (mouseX > 250 && mouseX < 370 && mouseY > 121 && mouseY < 140) {
    for (int i = 0; i <= 5; i++) selectART[i] = false;
    esc = str(S);
    selectART[2] = !selectART[2];
    valART[2] = "";
    S = 0;
  }
  if  (mouseX > 250 && mouseX < 370 && mouseY > 141 && mouseY < 155) {
    for (int i = 0; i <= 5; i++) selectART[i] = false;
    esc = str(frames);
    selectART[3] = !selectART[3];
    valART[3] = "";
    frames = 1;
  }
  if  (mouseX > 250 && mouseX < 370 && mouseY > 156 && mouseY < 170) {
    for (int i = 0; i <= 5; i++) selectART[i] = false;
    esc = str(fps);
    selectART[4] = !selectART[4];
    valART[4] = "";
    fps = 1;
  }
  if  (mouseX > 250 && mouseX < 370 && mouseY > 171 && mouseY < 195) {
    for (int i = 0; i <= 5; i++) selectART[i] = false;
    esc = str(cpu);
    selectART[5] = !selectART[5];
    valART[5] = "";
    cpu = 1;
  }
}


void keyEventsART (String keypress)
{
  if (keypress == "number") {
    if (selectART[0]) {
      if (valART[0].length() < 6) valART[0] += key;
      H = int(valART[0]);
    }
    if (selectART[1]) {
      if (valART[1].length() < 6) valART[1] += key;
      M = int(valART[1]);
    }
    if (selectART[2]) {
      if (valART[2].length() < 6) valART[2] += key;
      S = int(valART[2]);
    }
    if (selectART[3]) {
      if (valART[3].length() < 6) valART[3] += key;
      frames = int(valART[3]);
    }
    if (selectART[4]) {
      if (valART[4].length() < 6) valART[4] += key;
      fps = int(valART[4]);
    }
    if (selectART[5]) {
      if (valART[5].length() < 6) valART[5] += key;
      cpu = int(valART[5]);
    }
  } else if (keypress == "ENTER") {
    for (int i = 0; i <= 5; i++) selectART[i] = false;
    if (S == 60) { 
      S = 0;
      M = M + 1;
    }
    if (M == 60) { 
      M = 0;
      H = H + 1;
    }
  } else if (keypress == "BACKSPACE") {
    if (selectART[0]) {
      if (valART[0].length() > 0) valART[0] = valART[0].substring(0, valART[0].length() - 1);
      H =  int(valART[0]);
    }
    if (selectART[1]) {
      if (valART[1].length() > 0) valART[1] = valART[1].substring(0, valART[1].length() - 1);
      M =  int(valART[1]);
    }
    if (selectART[2]) {
      if (valART[2].length() > 0) valART[2] = valART[2].substring(0, valART[2].length() - 1);
      S =  int(valART[2]);
    }
    if (selectART[3]) {
      if (valART[3].length() > 0) valART[3] = valART[3].substring(0, valART[3].length() - 1);
      frames =  int(valART[3]);
    }
    if (selectART[4]) {
      if (valART[0].length() > 0) valART[4] = valART[4].substring(0, valART[4].length() - 1);
      fps =  int(valART[4]);
    }
    if (selectART[5]) {
      if (valART[0].length() > 0) valART[5] = valART[5].substring(0, valART[5].length() - 1);
      cpu =  int(valART[5]);
    }
  } else if (keypress == "27") {
    if (selectART[0]) H = int(esc);
    if (selectART[1]) M = int(esc);
    if (selectART[2]) S = int(esc);
    if (selectART[3]) frames = int(esc); 
    if (selectART[4]) fps = int(esc);
    if (selectART[5]) cpu = int(esc);
  }
}