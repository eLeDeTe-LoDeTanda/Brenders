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
 * The Original Code is Copyright (C) 2017 Marcelo "Tanda" Cerviño. http://lodetanda.blogspot.com/ 
 * All rights reserved.
 *
 * Contributor(s):
 *
 * ***** END GPL LICENSE BLOCK *****
 */

void  mousePressed()
{
  if (menu_0()) gui = 0;
  if (menu_1()) gui = 1;
  if (menu_2()) gui = 3;
  if (menu_3()) {
    if (renders_name.contains("#")) renders_name = renders_name.substring(0, renders_name.indexOf("#")); 
    gui = 2;
  }
  if (menu_4()) gui = 4;
  if (menu_5()) gui = 5;

  if (gui == 0) {
    if (commandlinegenerator_()) {
      gui = 1;
    }
    if (rendersStatus_()) {
      gui = 2;
    }
    if (renderingMultiBlend_()) {
      gui = 3;
    }
    if (renderTimeCalculator_()) {
      gui = 4;
    }
    if (batchProcessing_()) {
      gui = 5;
    }
    if  (mouseX > 30 && mouseX < 50 && mouseY > 330 && mouseY < 350) gui = 6;
    if  (mouseX > width - 60 && mouseX < width && mouseY > 330 && mouseY < 350) gui = 7;
  } else if (gui == 1) {
    if (mouseButton == LEFT) mouseEventsCommandLine();
    if (mouseButton == RIGHT) {
      if (selectoption[renders_name_id]) renders_name = esc;
      for (int i = 0; i < selectoption.length; i++) {
        if (selectoption[i]) valoption[i] = esc;
      }
      select_color = false;
    }
  } else if (gui == 2) {
    mouseEventsManager();
  } else if (gui == 3) {
    mouseEventsMultiblend();
  } else if (gui == 4) {
    eventsART();
  } else if (gui == 5) {
    mouseEventsBatch();
  } else if (gui == 6) {
    if  (mouseX > 270 && mouseX < 370 && mouseY > 145 && mouseY < 165) link("https://github.com/eLeDeTe-LoDeTanda/Brenders");
    if  (mouseX > 230 && mouseX < 410 && mouseY > 220 && mouseY < 240) link("http://lodetanda.blogspot.com/");
  } else if (gui == 7) {
    mouseEventsPreferences();
  }
  redraw();
}

void keyPressed() 
{
  if ('0' <= key && key <= '9') {
    if (gui == 1) keyEventsCommandLine("number");
    if (gui == 3) keyEventsMultiblend("number");
    if (gui == 4) keyEventsART("number");
    if (gui == 5) keyEventsBatch("number");
  }
  if (key==BACKSPACE) {
    if (gui == 1) keyEventsCommandLine("BACKSPACE");
    keyEventsART("BACKSPACE");
    if (gui == 5) keyEventsBatch("BACKSPACE");
  } else if (key==RETURN || key==ENTER) {
    rangeFix();
    if (gui == 1) keyEventsCommandLine("ENTER");
    if (gui == 4) keyEventsART("ENTER");
    if (gui == 5) keyEventsBatch("ENTER");
  } else if (keyCode == 27) {
    if (gui == 1) keyEventsCommandLine("27");
    if (gui == 4) keyEventsART("27");
    if (gui == 5) keyEventsBatch("27");
  } else if (key != CODED) {
    if (gui == 1) keyEventsCommandLine("CODED");
    if (gui == 5) keyEventsBatch("CODED");
  }
  if (keyCode == 123) {
    save(dataPath("")+"/Screenshots/"+version+"_"+day()+"-"+month()+"-"+year()+"_"+hour()+":"+minute()+":"+second()+".png");
    info = "Screenshot saved in: data/screenshot/";
  }
  if (keyCode == 27) key = 0;

  select_color = false;

  redraw();
}