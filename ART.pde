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
    for (int i = 0; i <= 5; i++) select_ART[i] = false;
    esc = str(H);
    select_ART[0] = !select_ART[0];
    val_ART[0] = "";
    H = 0;
  }
  if  (mouseX > 250 && mouseX < 370 && mouseY > 96 && mouseY < 120) {
    for (int i = 0; i <= 5; i++) select_ART[i] = false;
    esc = str(M);
    select_ART[1] = !select_ART[1];
    val_ART[1] = "";
    M = 0;
  }
  if  (mouseX > 250 && mouseX < 370 && mouseY > 121 && mouseY < 140) {
    for (int i = 0; i <= 5; i++) select_ART[i] = false;
    esc = str(S);
    select_ART[2] = !select_ART[2];
    val_ART[2] = "";
    S = 0;
  }
  if  (mouseX > 250 && mouseX < 370 && mouseY > 141 && mouseY < 155) {
    for (int i = 0; i <= 5; i++) select_ART[i] = false;
    esc = str(frames);
    select_ART[3] = !select_ART[3];
    val_ART[3] = "";
    frames = 1;
  }
  if  (mouseX > 250 && mouseX < 370 && mouseY > 156 && mouseY < 170) {
    for (int i = 0; i <= 5; i++) select_ART[i] = false;
    esc = str(fps);
    select_ART[4] = !select_ART[4];
    val_ART[4] = "";
    fps = 1;
  }
  if  (mouseX > 250 && mouseX < 370 && mouseY > 171 && mouseY < 195) {
    for (int i = 0; i <= 5; i++) select_ART[i] = false;
    esc = str(cpu);
    select_ART[5] = !select_ART[5];
    val_ART[5] = "";
    cpu = 1;
  }
}


void keyEventsART (String keypress)
{
  if (keypress == "number") {
    if (select_ART[0]) {
      if (val_ART[0].length() < 6) val_ART[0] += key;
      H = int(val_ART[0]);
    }
    if (select_ART[1]) {
      if (val_ART[1].length() < 6) val_ART[1] += key;
      M = int(val_ART[1]);
    }
    if (select_ART[2]) {
      if (val_ART[2].length() < 6) val_ART[2] += key;
      S = int(val_ART[2]);
    }
    if (select_ART[3]) {
      if (val_ART[3].length() < 6) val_ART[3] += key;
      frames = int(val_ART[3]);
    }
    if (select_ART[4]) {
      if (val_ART[4].length() < 6) val_ART[4] += key;
      fps = int(val_ART[4]);
    }
    if (select_ART[5]) {
      if (val_ART[5].length() < 6) val_ART[5] += key;
      cpu = int(val_ART[5]);
    }
  } else if (keypress == "ENTER") {
    for (int i = 0; i <= 5; i++) select_ART[i] = false;
    if (S == 60) { 
      S = 0;
      M = M + 1;
    }
    if (M == 60) { 
      M = 0;
      H = H + 1;
    }
  } else if (keypress == "BACKSPACE") {
    if (select_ART[0]) {
      if (val_ART[0].length() > 0) val_ART[0] = val_ART[0].substring(0, val_ART[0].length() - 1);
      H =  int(val_ART[0]);
    }
    if (select_ART[1]) {
      if (val_ART[1].length() > 0) val_ART[1] = val_ART[1].substring(0, val_ART[1].length() - 1);
      M =  int(val_ART[1]);
    }
    if (select_ART[2]) {
      if (val_ART[2].length() > 0) val_ART[2] = val_ART[2].substring(0, val_ART[2].length() - 1);
      S =  int(val_ART[2]);
    }
    if (select_ART[3]) {
      if (val_ART[3].length() > 0) val_ART[3] = val_ART[3].substring(0, val_ART[3].length() - 1);
      frames =  int(val_ART[3]);
    }
    if (select_ART[4]) {
      if (val_ART[0].length() > 0) val_ART[4] = val_ART[4].substring(0, val_ART[4].length() - 1);
      fps =  int(val_ART[4]);
    }
    if (select_ART[5]) {
      if (val_ART[0].length() > 0) val_ART[5] = val_ART[5].substring(0, val_ART[5].length() - 1);
      cpu =  int(val_ART[5]);
    }
  } else if (keypress == "27") {
    if (select_ART[0]) H = int(esc);
    if (select_ART[1]) M = int(esc);
    if (select_ART[2]) S = int(esc);
    if (select_ART[3]) frames = int(esc); 
    if (select_ART[4]) fps = int(esc);
    if (select_ART[5]) cpu = int(esc);
  }
}