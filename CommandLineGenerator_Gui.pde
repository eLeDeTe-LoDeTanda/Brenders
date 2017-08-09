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

String Command_Line;
String command_play_anim;

boolean startrenders;
boolean oglrenders;

boolean savelogs;

boolean ssh;
String sshuser = "Name Machine";
String sship = "Address";

boolean generatepy;
boolean newoutput;

String blenderpath;
String blendpath;
String blendname;

String terminalpath;
String texteditorpath;
String imageviewerpath;
String managerpath;
String settingspath;
String settingsname;

File terminalfolder;
File texteditorfolder;
File imageviewerfolder;
File explorerfolder;
File settingsfolder;
File blenderfolder;
File blendfolder;
File outputfolder;
File playrendersfolder;

String commandlinepath;

String outputpath ;
String rendersname;

String scenename;

boolean[] fromblend = new boolean[54];
boolean[] selectoption = new boolean[54];
String[] valoption = new String[54];
final String[] nameoption = new String[54];

final int pxX_id = 0; 
final int pxY_id = 1; 
final int percentage_id = 2; 
final int anti_aliasing_id = 3; 
final int anti_aliasing_samples_id = 4; 
final int anti_aliasing_fullsamples_id = 5;
final int tile_x_id = 6; 
final int tile_y_id = 7; 
final int threads_mode_id = 8; 
final int threads_id = 9; 
final int engine_id = 10; 
final int engine_cyclessamples_id = 11; 
final int engine_cyclessamples_val_id = 12; 

final int scene_name_id = 13; 
final int placeholder_id = 14; 
final int overwrite_renders_id = 15; 
final int render_cache_id = 16; 
final int add_extension_id = 17; 
final int file_format_id = 18; 
final int file_format_comp_id = 19;
final int file_format_color_id = 20;
final int file_format_depth_id = 21;

final int output_path_id = 22; 

final int stamp_id = 23; 
final int stamp_background_id = 24; 
final int stamp_foreground_id = 25;  
final int use_stamp_time_id = 26; 
final int use_stamp_camera_id = 27; 
final int use_stamp_date_id = 28; 
final int use_stamp_lens_id = 29; 
final int use_stamp_render_time_id = 30; 
final int use_stamp_filename_id = 31; 
final int use_stamp_frame_id = 32; 
final int use_stamp_marker_id = 33; 
final int use_stamp_scene_id = 34; 
final int use_stamp_sequencer_strip_id = 35; 
final int use_stamp_memory_id = 36; 
final int stamp_note_id = 37; 
final int stamp_note_text_id = 38; 
final int use_stamp_strip_meta_id = 39; 
final int use_stamp_dlabels_id = 40; 
final int use_stamp_textsize_id = 41; 

boolean selectcolor;
boolean fgcolor;
boolean bgcolor;
int[] fgrgba = new int[4];
int[] bgrgba = new int[4];

final int animation_id = 42; 

final int frame_start_id = 43; 
final int frame_end_id = 44; 
final int frame_step_id = 45; 

final int frame_id = 46; 

final int renders_name_id = 47; 

final int dither_id = 48; 

final int compositing_id = 49; 
final int sequencer_id = 50; 

final int compresion_id = 51; 

final int sshuser_id = 52; 
final int sship_id = 53; 

final int png_id = 0; 
final int jpg_id = 1;
final int jpg2_id = 2;
final int tga_id = 3;
final int tgaraw_id = 4;
final int tiff_id = 5;
final int dpx_id = 6;
final int exr_id = 7;
final int exrm_id = 8;
final int bmp_id = 9;
final int iris_id = 10;
final int cineon_id = 11;
final int hdr_id = 12;

final String[] engines = new String[] {"BLENDER_RENDER", "CYCLES", "BLENDER_EEVEE", "BLENDER_CLAY"};

final String[] fileformat = new String[] {"PNG", "JPEG", "TARGA", "TARGA_RAW", "TIFF", "IRIS", "BMP", "JPEG2000", "OPEN_EXR", "OPEN_EXR_MULTILAYER", "CINEON", "DPX", "HDR"};
String rgbmode;
final String[] rgbmode_val = new String[] {"BW", "RGB", "RGBA"};
String depth;
final String[] depth_val = new String[] {"8", "10", "12", "16", "32"};

String compresion;
String quality;

final String[] tiffcomp = new String[] {"NONE", "DEFLATE", "LZW", "PACKBITS"};
String tiffcompresion;

final String[] openexrcodec = new String[] {"NONE", "PXR24", "ZIP2", "PIZ", "RLE", "ZIPS", "DWAA", "DWAB"};
String openexcompresion;
String openexrzbuffer;
String openexrpreview; 

String dpxlog;

final String[] jpg2codec_val = new String[] {"J2K", "JP2"};
String jpg2codec;
String jpg2cinema;
String jpg2cinema48;
String jpg2ycc;

String[] layers_id = new String[20];

boolean exist = false; 

String startrender;
String endrender;

String pathname;

void commandLineGenerator_Gui()
{
  pushStyle();
  
  pathname = blendname;
  if (blendname.length() > 20) pathname = blendname.substring(0, 10)+"..."+blendname.substring(blendname.length() - 10);
  surface.setTitle("ComandLineGenerator -"+pathname+"- "+version);
  background(backgroundcolor);
  tint(230, 230, 250);
  image(bg2, 0, 0);

  menuBar();

  stroke(icolor);

  textAlign(LEFT);

  fill(acolor);
  textSize(14);
  text("BLENDER path", 15, 45);
  textSize(10);
  text("-Open<", 120, 45);

  textSize(12);
  text("TERMINAL", 345, 40);
  textSize(10);
  text("-Open<", 435, 40);

  textSize(12);
  text("Text EDITOR", 210, 40);
  textSize(10);
  text("-Open<", 290, 40);

  textSize(12);
  text("File MANAGER", 345, 80);
  textSize(10);
  text("-Open<", 435, 80);

  textSize(12);
  text("SETTINGS path", 345, 130);
  textSize(10);
  text("-Open<", 435, 130);

  textSize(14);
  text(".BLEND path", 15, 85);
  textSize(10);
  text("-Open Blend<", 110, 85);
  text("-Open Blend Folder<", 190, 85);

  textSize(14);
  text("RENDERS output path", 15, 125);
  textSize(10);
  text("-Open<", 170, 125);
  textSize(12);
  text("-Play anim<", 220, 125);

  textSize(14);
  fill(bcolor);
  rect(174, 145, 295, 25);
  if (error) fill(ecolor);
  else fill(icolor);
  textAlign(CENTER);
  text(info, width / 2, 162);
  textAlign(LEFT);

  fill(bcolor);
  rect(15, 52, 15, 15, 4);
  rect(210, 46, 15, 15, 4);
  rect(345, 46, 15, 15, 4);
  rect(15, 92, 15, 15, 4);
  rect(345, 87, 15, 15, 4);
  rect(15, 132, 15, 15, 4);

  fill(icolor);
  textSize(11);
  text("...", 18, 61);
  text("...", 348, 55);
  text("...", 212, 55);
  text("...", 18, 101);
  text("...", 348, 96);
  text("...", 18, 141);

  fill(bcolor);
  textSize(14);
  ellipse(605, 40, 40, 40);
  fill(icolor);
  text("Go!", 595, 45);
  fill(bcolor);
  rect(580, 70, 50, 12);
  rect(580, 90, 50, 12);
  rect(505, 40, 50, 12);
  rect(505, 60, 50, 12);
  rect(580, 110, 50, 12);
  fill(ccolor);
  rect(491, 20, 76, 12);
  fill(icolor);
  textSize(10);
  text("ADD to MULTI", 495, 30);
  text("SAVE", 518, 50);
  text("MV-REN", 510, 70);

  text("OPEN", 592, 80);
  text("RELOAD", 586, 100);
  text("EDIT", 595, 120);

  fill(acolor);
  textSize(10);

  if (generatepy) {
    text("o in OpenGL", 510, 115);
    if (oglrenders) {
      fill(ccolor);
      ellipse(513, 112, 8, 8);
      fill(acolor);
    }
  }
  text("o Save Logs", 510, 132);
  if (savelogs) {
    fill(ccolor);
    ellipse(513, 129, 8, 8);
    fill(acolor);
  }
  text("o SSH", 510, 150);
  if (ssh) {
    fill(ccolor);
    ellipse(513, 146, 8, 8);
    fill(acolor);
  } else fill(icolor);
  text("USER: "+sshuser+" <<", 490, 162);
  if (selectoption[sshuser_id]) line(textWidth(sshuser) + 523, 152, textWidth(sshuser) + 523, 162);
  text("IP:  "+sship+" <<", 490, 172);
  if (selectoption[sship_id]) line(textWidth(sship) + 510, 162, textWidth(sship) + 510, 172);

  fill(acolor);
  textSize(11);
  if (generatepy) fill(acolor);
  else fill(icolor);

  if (selectoption[pxX_id]) {
    noFill();
    rect(55, 198, 110, 15);
  }
  text("o "+nameoption[pxX_id], 15, 210);   
  if (fromblend[pxX_id]) text("From blend", 100, 210);
  else {
    fill(ccolor);
    ellipse(17, 206, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
    text(valoption[pxX_id], 55, 210);
    if (selectoption[pxX_id]) line(textWidth(valoption[pxX_id]) + 58, 200, textWidth(valoption[pxX_id]) + 58, 210);
  }

  if (selectoption[pxY_id]) {
    noFill();
    rect(55, 218, 110, 15);
  }
  text("o "+nameoption[pxY_id], 15, 230); 
  if (fromblend[pxY_id]) text("From blend", 100, 230);
  else {
    fill(ccolor);
    ellipse(17, 226, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
    text(valoption[pxY_id], 55, 230);
    if (selectoption[pxY_id]) line(textWidth(valoption[pxY_id]) + 58, 220, textWidth(valoption[pxY_id]) + 58, 230);
  }

  if (selectoption[percentage_id]) {
    noFill();
    rect(38, 236, 25, 15);
  }
  text("o "+nameoption[percentage_id], 15, 250); 
  if (fromblend[percentage_id]) text("From blend", 100, 250);
  else { 
    fill(ccolor);
    ellipse(17, 246, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
    text(valoption[percentage_id], 40, 250); 
    if (selectoption[percentage_id]) line(textWidth(valoption[percentage_id]) + 43, 240, textWidth(valoption[percentage_id]) + 43, 250);
    if (!fromblend[pxX_id]) text("("+(int(valoption[pxX_id])*int(valoption[percentage_id]))/100+"x"+(int(valoption[pxY_id])*int(valoption[percentage_id]))/100+")", 65, 250);
  }
  if (selectoption[anti_aliasing_id]) {
    noFill();
    rect(100, 258, 94, 15);
  }
  text("o "+nameoption[anti_aliasing_id], 15, 270); 
  if (fromblend[anti_aliasing_id]) text("From blend", 100, 270);
  else {
    fill(ccolor);
    ellipse(17, 266, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
    text(valoption[anti_aliasing_id], 100, 270);
    if (valoption[anti_aliasing_id] == "True") {
      text(valoption[anti_aliasing_samples_id], 132, 270);
      if (selectoption[anti_aliasing_samples_id]) line(textWidth(valoption[anti_aliasing_samples_id]) + 135, 260, textWidth(valoption[anti_aliasing_samples_id]) + 135, 270);
      textSize(9);
      text("o "+nameoption[anti_aliasing_fullsamples_id], 154, 269);
      if (valoption[anti_aliasing_fullsamples_id] == "True") {
        fill(ccolor);
        ellipse(156, 267, 6, 6);
        if (generatepy) fill(acolor);
        else fill(icolor);
      }
      textSize(11);
    }
  }
  if (selectoption[tile_x_id]) {
    noFill();
    rect(60, 278, 102, 15);
  }
  text("o "+nameoption[tile_x_id], 15, 290);
  if (fromblend[tile_x_id]) text("From blend", 100, 290);
  else {
    fill(ccolor);
    ellipse(17, 286, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
    text(valoption[tile_x_id], 70, 290);
    if (selectoption[tile_x_id]) line(textWidth(valoption[tile_x_id]) + 73, 280, textWidth(valoption[tile_x_id]) + 73, 290);
  }
  if (selectoption[tile_y_id]) {
    noFill();
    rect(60, 298, 102, 15);
  }
  text("o "+nameoption[tile_y_id], 15, 310);
  if (fromblend[tile_y_id]) text("From blend", 100, 310);
  else {
    fill(ccolor);
    ellipse(17, 306, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
    text(valoption[tile_y_id], 70, 310);
    if (selectoption[tile_y_id]) line(textWidth(valoption[tile_y_id]) + 73, 300, textWidth(valoption[tile_y_id]) + 73, 310);
  }

  if (selectoption[placeholder_id]) {
    noFill();
    rect(280, 218, 105, 15);
  }
  text("o "+nameoption[placeholder_id], 200, 230);   
  if (fromblend[placeholder_id]) text("From blend", 320, 230);
  else {
    fill(ccolor);
    ellipse(202, 227, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
    text(valoption[placeholder_id], 280, 230);
  }
  if (selectoption[overwrite_renders_id]) {
    noFill();
    rect(312, 238, 73, 15);
  }
  text("o "+nameoption[overwrite_renders_id], 200, 250);   
  if (fromblend[overwrite_renders_id]) text("From blend", 320, 250);
  else {
    fill(ccolor);
    ellipse(202, 247, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
    text(valoption[overwrite_renders_id], 320, 250);
  }
  if (selectoption[render_cache_id]) {
    noFill();
    rect(285, 258, 100, 15);
  }
  text("o "+nameoption[render_cache_id], 200, 270);   
  if (fromblend[render_cache_id]) text("From blend", 320, 270);
  else {
    fill(ccolor);
    ellipse(202, 267, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
    text(valoption[render_cache_id], 290, 270);
  }

  if (selectoption[stamp_id]) {
    noFill();
    rect(468, 198, 35, 15);
  }
  text("o "+nameoption[stamp_id], 410, 210);   
  if (fromblend[stamp_id]) {
    text("From blend", 500, 210);
    fill(icolor);
  } else {
    fill(ccolor);
    ellipse(412, 206, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
    text(valoption[stamp_id], 465, 210);
    textSize(10);
    text("o "+nameoption[use_stamp_strip_meta_id], 500, 212);   
    if (valoption[use_stamp_strip_meta_id] == "True") {
      fill(ccolor);
      ellipse(503, 209, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
  }
  if (!fromblend[stamp_id]) fill(acolor);
  else fill(icolor);

  textSize(10);
  text("o "+nameoption[use_stamp_dlabels_id], 580, 212); 
  text("o "+nameoption[use_stamp_time_id], 410, 222);   
  text("o "+nameoption[use_stamp_date_id], 410, 232);
  text("o "+nameoption[use_stamp_render_time_id], 410, 242);
  text("o "+nameoption[use_stamp_frame_id], 410, 252); 
  text("o "+nameoption[use_stamp_scene_id], 410, 262);  
  text("o "+nameoption[use_stamp_camera_id], 500, 222); 
  text("o "+nameoption[use_stamp_memory_id], 580, 222);  
  text("o "+nameoption[use_stamp_lens_id], 500, 232);   
  text("o "+nameoption[use_stamp_filename_id], 500, 242);  
  text("o "+nameoption[use_stamp_marker_id], 500, 252);   
  text("o "+nameoption[use_stamp_sequencer_strip_id], 500, 262);
  text("o "+nameoption[stamp_note_id], 400, 275);
  textSize(10);
  text("o "+nameoption[stamp_foreground_id], 585, 238); 
  text("o "+nameoption[stamp_background_id], 585, 256);

  if (!fromblend[stamp_id]) {
    if (valoption[use_stamp_time_id] == "True") {
      fill(ccolor);
      ellipse(413, 219, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[use_stamp_dlabels_id] == "True") {
      fill(ccolor);
      ellipse(583, 209, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[use_stamp_date_id] == "True") {
      fill(ccolor);
      ellipse(413, 229, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[use_stamp_render_time_id] == "True") {
      fill(ccolor);
      ellipse(413, 239, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[use_stamp_frame_id] == "True") {
      fill(ccolor);
      ellipse(413, 249, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[use_stamp_scene_id] == "True") {
      fill(ccolor);
      ellipse(413, 259, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[use_stamp_camera_id] == "True") {
      fill(ccolor);
      ellipse(503, 219, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[use_stamp_memory_id] == "True") {
      fill(ccolor);
      ellipse(583, 219, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[use_stamp_lens_id] == "True") { 
      fill(ccolor);
      ellipse(503, 229, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[use_stamp_filename_id] == "True") {
      fill(ccolor);
      ellipse(503, 239, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[use_stamp_marker_id] == "True") {
      fill(ccolor);
      ellipse(503, 249, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[use_stamp_sequencer_strip_id] == "True") {
      fill(ccolor);
      ellipse(503, 259, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }
    if (valoption[stamp_note_id] == "True") {
      fill(ccolor);
      ellipse(403, 272, 5, 5);
      if (generatepy) fill(acolor);
      else fill(icolor);
    }

    rect(475, 266, 155, 12);

    fill(icolor);
    pathname = valoption[stamp_note_text_id];
    if (valoption[stamp_note_text_id].length() > 20) pathname = "..."+valoption[stamp_note_text_id].substring(valoption[stamp_note_text_id].length() - 20);
    text(pathname, 480, 276);
    if (selectoption[stamp_note_text_id]) line(textWidth(valoption[stamp_note_text_id]) + 483, 266, textWidth(valoption[stamp_note_text_id]) + 483, 276);
    fill(fgrgba[0], fgrgba[1], fgrgba[2], fgrgba[3]);
    rect(565, 228, 15, 15);
    fill(bgrgba[0], bgrgba[1], bgrgba[2], bgrgba[3]);

    rect(565, 246, 15, 15);
  }

  if (generatepy) fill(acolor);
  else fill(icolor);

  text("o "+nameoption[dither_id], 557, 287);
  if (!fromblend[dither_id]) {
    text(valoption[dither_id], 570, 297);
    if (selectoption[dither_id]) line(textWidth(valoption[dither_id]) + 573, 287, textWidth(valoption[dither_id]) + 573, 297);
    fill(ccolor);
    ellipse(559, 285, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
  } else  text("From blend", 555, 295);

  text("o "+nameoption[compositing_id], 557, 307);
  if (!fromblend[compositing_id]) {
    text(valoption[compositing_id], 570, 317);
    fill(ccolor);
    ellipse(559, 304, 8, 8);
    if (generatepy) fill(acolor);
    else fill(icolor);
  } else  text("From blend", 555, 315);

  text("o "+nameoption[sequencer_id], 557, 327);
  if (!fromblend[sequencer_id]) {
    text(valoption[sequencer_id], 570, 337);
    fill(ccolor);
    ellipse(559, 325, 8, 8);
  } else  text("From blend", 555, 335);

  // No python Script

  textSize(11);
  fill(acolor);

  if (selectoption[threads_mode_id]) {
    noFill();
    rect(70, 318, 96, 15);
  }
  text("o "+nameoption[threads_id], 15, 330);
  if (fromblend[threads_mode_id]) text("From blend", 100, 330);
  else {
    fill(ccolor);
    ellipse(17, 326, 8, 8);
    fill(acolor);
    text(valoption[threads_mode_id], 75, 330);
    if (valoption[threads_mode_id] == "FIXED") text(valoption[threads_id], 130, 330);
    if (selectoption[threads_id]) line(textWidth(valoption[threads_id]) + 133, 320, textWidth(valoption[threads_id]) + 133, 330);
  }
  if (selectoption[engine_id]) {
    noFill();
    rect(65, 338, 101, 15);
  }
  text("o "+nameoption[engine_id], 15, 350);
  if (fromblend[engine_id]) text("From blend", 100, 350);
  else {
    fill(ccolor);
    ellipse(17, 346, 8, 8);
    fill(acolor);
    textSize(9);
    text("-"+valoption[engine_id], 65, 350);

    if (valoption[engine_id] == "CYCLES") {
      if (generatepy) {
        textSize(7);
        text(nameoption[engine_cyclessamples_id], 105, 350);
        textSize(9);
        if (valoption[engine_cyclessamples_id] == "True") {
          text(valoption[engine_cyclessamples_val_id], 136, 350);
          if (selectoption[engine_cyclessamples_val_id]) line(textWidth(valoption[engine_cyclessamples_val_id]) + 139, 340, textWidth(valoption[engine_cyclessamples_val_id]) + 139, 350);
        } else text("From blend", 136, 350);
      }
    }
  }
  textSize(11);

  if (selectoption[scene_name_id]) {
    noFill();
    rect(280, 198, 105, 15);
  }
  text("o "+nameoption[scene_name_id], 200, 210);   
  if (fromblend[scene_name_id]) text("From blend", 320, 210);
  else {
    fill(ccolor);
    ellipse(202, 207, 8, 8);
    fill(acolor);
    pathname = scenename;
    if (scenename.length() > 14) pathname = "..."+scenename.substring(scenename.length() - 14);
    text(pathname, 280, 210);
  }

  if (selectoption[add_extension_id]) {
    noFill();
    rect(290, 278, 94, 15);
  }
  text("o "+nameoption[add_extension_id], 200, 290);   
  if (fromblend[add_extension_id]) text("From blend", 320, 290);
  else {
    fill(ccolor);
    ellipse(202, 287, 8, 8);
    fill(acolor);
    text(valoption[add_extension_id], 300, 290);
  }
  if (selectoption[file_format_id]) {
    noFill();
    rect(274, 298, 111, 15);
  }
  text("o "+nameoption[file_format_id], 200, 310);   
  if (fromblend[file_format_id]) text("From blend", 320, 310);
  else {
    fill(ccolor);
    ellipse(202, 307, 8, 8);
    fill(acolor);
    textSize(9);
    text(valoption[file_format_id], 280, 310);
  }
  if (!fromblend[file_format_id]) fill(acolor);
  else fill(icolor);
  textSize(9);
  if (generatepy) {
    if (valoption[file_format_id] == "PNG") {
      text("Compresion:", 185, 322); 
      text(compresion+"<", 250, 322); 
      text("Mode:", 185, 334);  
      text(rgbmode+"<", 215, 334); 
      text("Depth:", 342, 322);
      text(depth+"<", 375, 322);
    } else  if (valoption[file_format_id] == "JPEG") {
      text("Quality:", 185, 322);   
      text(quality+"<", 230, 322); 
      text("Mode:", 185, 334);
      text(rgbmode+"<", 215, 334);
    } else if (valoption[file_format_id] == "JPEG2000") {
      text("Quality:", 185, 322);   
      text(quality+"<", 220, 322); 
      text("Mode:", 185, 334); 
      text(rgbmode+"<", 215, 334); 
      text("Depth:", 342, 322);
      text(depth+"<", 375, 322);
      text("Codec:", 255, 334);
      text(jpg2codec+"<", 290, 334);
      text("o Cinema<", 288, 322);
      if (jpg2cinema == "True") ellipse(291, 319, 5, 5);
      text("o Cinema(48)<", 325, 334);
      if (jpg2cinema48 == "True") ellipse(328, 331, 5, 5);
      text("o YCC<", 250, 322);
      if (jpg2ycc == "True") ellipse(253, 319, 5, 5);
    } else if (valoption[file_format_id] == "OPEN_EXR") {  
      text("Codec:", 185, 322);
      text(openexcompresion, 218, 322);
      text("Mode:", 185, 334);  
      text(rgbmode+"<", 215, 334); 
      text("Depth:", 342, 322);
      text(depth+"<", 375, 322);
      text("o ZBuffer<", 345, 334);
      if (openexrzbuffer  == "True") ellipse(348, 331, 5, 5);
      text("o Preview<", 280, 334);
      if (openexrpreview == "True") ellipse(283, 331, 5, 5);
    } else if (valoption[file_format_id] == "OPEN_EXR_MULTILAYER") {
      text("Codec:", 185, 322);
      text(openexcompresion, 218, 322);  
      text("Mode", 185, 334);   
      text(rgbmode+"<", 215, 334); 
      text("Depth:", 342, 322);
      text(depth+"<", 375, 322);
    } else  if (valoption[file_format_id] == "TARGA") {  
      text("Mode:", 185, 334);
      text(rgbmode+"<", 215, 334);
    } else  if (valoption[file_format_id] == "TARGA_RAW") {  
      text("Mode:", 185, 334);
      text(rgbmode+"<", 215, 334);
    } else  if (valoption[file_format_id] == "BMP") {  
      text("Mode:", 185, 334);
      text(rgbmode+"<", 215, 334);
    } else  if (valoption[file_format_id] == "IRIS") {  
      text("Mode:", 185, 334);
      text(rgbmode+"<", 215, 334);
    } else  if (valoption[file_format_id] == "DPX") {  
      text("Mode:", 185, 334);
      text(rgbmode+"<", 215, 334);
      text("Depth", 342, 322);
      text(depth+"<", 375, 322);
      text("o Log<", 300, 334);
      if (dpxlog== "True") ellipse(303, 331, 5, 5);
    } else  if (valoption[file_format_id] == "HDR") {  
      text("Mode:", 185, 334);
      text(rgbmode+"<", 215, 334);
    } else  if (valoption[file_format_id] == "TIFF") {  
      text("Compresion:", 185, 322); 
      text(tiffcompresion+"<", 243, 322);  
      text("Mode:", 185, 334);
      text(rgbmode+"<", 215, 334); 
      text("Depth:", 342, 322);
      text(depth+"<", 375, 322);
    } else  if (valoption[file_format_id] == "CINEON") {   
      text("Mode:", 185, 334);
      text(rgbmode+"<", 215, 334);
    }
  }  

  textSize(11);
  fill(acolor);
  if (selectoption[frame_start_id]) {
    noFill();
    rect(476, 293, 50, 15);
  }
  text("o "+nameoption[frame_start_id], 400, 305);   
  if (fromblend[frame_start_id]) text("From blend", 480, 305);
  else {
    fill(ccolor);
    ellipse(402, 301, 8, 8);
    fill(acolor);
    text(valoption[frame_start_id], 480, 305);
    if (selectoption[frame_start_id]) line(textWidth(valoption[frame_start_id]) + 483, 295, textWidth(valoption[frame_start_id]) + 483, 305);
  }
  if (selectoption[frame_end_id]) {
    noFill();
    rect(476, 308, 50, 15);
  }
  text("o "+nameoption[frame_end_id], 400, 320);   
  if (fromblend[frame_end_id]) text("From blend", 480, 320);
  else {
    fill(ccolor);
    ellipse(402, 317, 8, 8);
    fill(acolor);
    text(valoption[frame_end_id], 480, 320);
    if (selectoption[frame_end_id]) line(textWidth(valoption[frame_end_id]) + 483, 310, textWidth(valoption[frame_end_id]) + 483, 320);
  }
  if (selectoption[frame_step_id]) {
    noFill();
    rect(476, 321, 50, 15);
  }
  text("o "+nameoption[frame_step_id], 400, 335);   
  if (fromblend[frame_step_id]) text("From blend", 480, 335);
  else {
    fill(ccolor);
    ellipse(402, 332, 8, 8);
    fill(acolor);
    text(valoption[frame_step_id], 480, 335);
    if (selectoption[frame_step_id]) line(textWidth(valoption[frame_step_id]) + 483, 325, textWidth(valoption[frame_step_id]) + 483, 335);
  }

  text("o "+nameoption[animation_id], 400, 290);
  if (!fromblend[animation_id]) {
    fill(ccolor);
    ellipse(402, 287, 8, 8);
    fill(acolor);
  }
  text("o "+nameoption[frame_id], 187, 350);
  if (!fromblend[frame_id]) {
    fill(ccolor);
    ellipse(189, 346, 8, 8);
    fill(acolor);
    rect(288, 340, 340, 12);
    fill(icolor);
    pathname = valoption[frame_id];
    if (valoption[frame_id].length() > 50) pathname = "..."+valoption[frame_id].substring(valoption[frame_id].length() - 50);
    text(pathname, 290, 350);
    if (selectoption[frame_id]) line(textWidth(valoption[frame_id]) + 293, 340, textWidth(valoption[frame_id]) + 293, 350);
  } else {
    fill(icolor);
    rect(288, 340, 340, 12);
    fill(acolor);
    if (!generatepy) text(" frame      frame,frame,frame      start..end      +frame   -frame", 290, 350);
    else text(" frame", 290, 350);
  }

  textSize(12);
  fill(acolor);
  text("o Generate Python Script", 15, 190); 
  if (generatepy) {
    fill(ccolor);
    ellipse(17, 185, 10, 10);
    fill(acolor);
  }

  text("o New Output", 200, 190);
  if (newoutput) {
    fill(ccolor);
    ellipse(202, 185, 10, 10);
    fill(acolor);
  }

  if (!newoutput) fill(icolor);
  text("Renders NAME:", 320, 190);
  rect(410, 178, 220, 15);
  fill(icolor);
  pathname = rendersname;
  if (rendersname.length() > 28) pathname = rendersname.substring(0, 14)+"..."+rendersname.substring(rendersname.length() - 14);
  text(pathname, 414, 190);
  if (selectoption[renders_name_id]) line(textWidth(rendersname) + 418, 180, textWidth(rendersname) + 418, 190);
  textSize(10);
  fill(acolor);
  if (!newoutput)text("From blend", 420, 190);
  pathname = blenderpath;
  if (blenderpath.length() > 22) pathname = blenderpath.substring(0, 11)+"..."+blenderpath.substring(blenderpath.length() - 11);
  text(pathname, 35, 65);
  pathname = terminalpath;
  if (terminalpath.length() > 16) pathname = terminalpath.substring(0, 8)+"..."+terminalpath.substring(terminalpath.length() - 8);
  text(pathname, 365, 60);
  pathname = texteditorpath;
  if (texteditorpath.length() > 16) pathname = texteditorpath.substring(0, 8)+"..."+texteditorpath.substring(texteditorpath.length() - 8);
  text(pathname, 230, 60);
  pathname = managerpath;
  if (managerpath.length() > 16) pathname = managerpath.substring(0, 8)+"..."+managerpath.substring(managerpath.length() - 8);  
  text(pathname, 365, 100);
  pathname = blendname;
  if (blendname.length() > 20) pathname = blendname.substring(0, 10)+"..."+blendname.substring(blendname.length() - 10);  
  text(File.separator+pathname, 35, 105);

  valoption[renders_name_id] = outputpath;
  pathname = valoption[renders_name_id];
  if (valoption[renders_name_id].length() > 20) pathname = valoption[renders_name_id].substring(0, 10)+"..."+valoption[renders_name_id].substring(valoption[renders_name_id].length() - 10);  
  if (!newoutput) pathname = "From blend";
  text(pathname, 35, 145);

  popStyle();

  if (selectcolor) selectColor();
}

boolean generate_py_() 
{
  return  (mouseX > 10 && mouseX < 160 && mouseY > 180 && mouseY < 195);
}
boolean new_output_() 
{
  return  (mouseX > 195 && mouseX < 400 && mouseY > 180 && mouseY < 195);
}
boolean renders_name_() 
{
  return  (mouseX > 350 && mouseX < 700 && mouseY > 180 && mouseY < 195);
}

boolean terminal_path_() 
{
  return  (mouseX > 340 && mouseX < 360 && mouseY > 45 && mouseY < 65);
}
boolean terminal_open_() 
{
  return  (mouseX > 430 && mouseX < 480 && mouseY > 30 && mouseY < 45);
}

boolean file_manager_path_() 
{
  return  (mouseX > 340 && mouseX < 370 && mouseY > 85 && mouseY < 105);
}
boolean file_manager_open_() 
{
  return  (mouseX > 430 && mouseX < 480 && mouseY > 65 && mouseY < 85);
}

boolean text_editor_path_() 
{
  return  (mouseX > 210 && mouseX < 230 && mouseY > 40 && mouseY < 60);
}
boolean text_editor_open_() 
{
  return  (mouseX > 280 && mouseX < 330 && mouseY > 25 && mouseY < 45);
}

/*boolean settings_path_() 
 {
 return  (mouseX > 315 && mouseX < 330 && mouseY > 97 && mouseY < 135);
 }*/
boolean settings_path_open_() 
{
  return  (mouseX > 435 && mouseX < 480 && mouseY > 120 && mouseY < 135);
}

boolean blender_path_() 
{
  return  (mouseX > 15 && mouseX < 30 && mouseY > 52 && mouseY < 67);
}
boolean blender_open_() 
{
  return  (mouseX > 80 && mouseX < 180 && mouseY > 30 && mouseY < 55);
}

boolean blend_path_() 
{
  return  (mouseX > 15 && mouseX < 30 && mouseY > 92 && mouseY < 107);
}
boolean blend_open_() 
{
  return  (mouseX > 80 && mouseX < 180 && mouseY > 70 && mouseY < 95);
}
boolean blend_open_folder_() 
{
  return  (mouseX > 200 && mouseX < 300 && mouseY > 70 && mouseY < 95);
}
boolean new_output_path_() 
{
  return  (mouseX > 15 && mouseX < 30 && mouseY > 132 && mouseY < 147);
}
boolean new_output_open_() 
{
  return  (mouseX > 160 && mouseX < 220 && mouseY > 110 && mouseY < 135);
}
boolean output_play_() 
{
  return  (mouseX > 230 && mouseX < 300 && mouseY > 110 && mouseY < 135);
}

boolean add_to_multi_() 
{
  return  (mouseX > 490 && mouseX < 570 && mouseY > 15 && mouseY < 35);
}

boolean save_settings_() 
{
  return  (mouseX > 505 && mouseX < 560 && mouseY > 40 && mouseY < 55);
}
boolean rename_settings_() 
{
  return  (mouseX > 505 && mouseX < 560 && mouseY > 60 && mouseY < 75);
}

boolean go_() 
{
  return  (mouseX > 585 && mouseX < 630 && mouseY > 15 && mouseY < 65);
}

boolean settingsOpen_() 
{
  return  (mouseX > 580 && mouseX < 650 && mouseY > 60 && mouseY < 80);
}
boolean settingsReload_() 
{
  return  (mouseX > 580 && mouseX < 650 && mouseY > 81 && mouseY < 100);
}
boolean settingsEdit_() 
{
  return  (mouseX > 580 && mouseX < 650 && mouseY > 110 && mouseY < 120);
}

boolean in_ogl_() 
{
  return  (mouseX > 490 && mouseX < 560 && mouseY > 105 && mouseY < 120);
}
boolean savelogs_() 
{
  return  (mouseX > 490 && mouseX < 560 && mouseY > 121 && mouseY < 139);
}
boolean ssh_() 
{
  return  (mouseX > 505 && mouseX < 550 && mouseY > 140 && mouseY < 150);
}
boolean ssh_user_() 
{
  return  (mouseX > 490 && mouseX < 630 && mouseY > 151 && mouseY < 160);
}
boolean ssh_ip_() 
{
  return  (mouseX > 490 && mouseX < 630 && mouseY > 161 && mouseY < 170);
}

boolean pxX_() 
{
  return  (mouseX > 10 && mouseX < 50 && mouseY > 200 && mouseY < 215);
}
boolean pxX_val() 
{
  return  (mouseX > 55 && mouseX < 165 && mouseY > 200 && mouseY < 215);
}
boolean pxY_() 
{
  return  (mouseX > 10 && mouseX < 50 && mouseY > 220 && mouseY < 235);
}
boolean pxY_val() 
{
  return  (mouseX > 55 && mouseX < 165 && mouseY > 220 && mouseY < 235);
}
boolean percentage_() 
{
  return  (mouseX > 10 && mouseX < 35 && mouseY > 240 && mouseY < 255);
}
boolean percentage_val() 
{
  return  (mouseX > 40 && mouseX < 165 && mouseY > 240 && mouseY < 255);
}
boolean anti_aliasing_() 
{
  return  (mouseX > 10 && mouseX < 90 && mouseY > 260 && mouseY < 275);
}
boolean use_anti_aliasing_() 
{
  return  (mouseX > 95 && mouseX < 125 && mouseY > 260 && mouseY < 275);
}
boolean anti_aliasing_val() 
{
  return  (mouseX > 130 && mouseX < 145 && mouseY > 260 && mouseY < 275);
}
boolean anti_aliasing_fullsample_val() 
{
  return  (mouseX > 150 && mouseX < 180 && mouseY > 255 && mouseY < 280);
}
boolean tile_x_() 
{
  return  (mouseX > 10 && mouseX < 50 && mouseY > 280 && mouseY < 295);
}
boolean tile_x_val() 
{
  return  (mouseX > 55 && mouseX < 165 && mouseY > 280 && mouseY < 295);
}
boolean tile_y_() 
{
  return  (mouseX > 10 && mouseX < 50 && mouseY > 300 && mouseY < 315);
}
boolean tile_y_val() 
{
  return  (mouseX > 55 && mouseX < 165 && mouseY > 300 && mouseY < 315);
}
boolean threads_() 
{
  return  (mouseX > 10 && mouseX < 66 && mouseY > 320 && mouseY < 335);
}
boolean threads_mode_() 
{
  return  (mouseX > 70 && mouseX < 100 && mouseY > 320 && mouseY < 335);
}
boolean threads_val() 
{
  return  (mouseX > 105 && mouseX < 165 && mouseY > 320 && mouseY < 335);
}
boolean engine_() 
{
  return  (mouseX > 10 && mouseX < 60 && mouseY > 340 && mouseY < 355);
}
boolean engine_val() 
{
  return  (mouseX > 65 && mouseX < 95 && mouseY > 340 && mouseY < 355);
}
boolean engine_cyclessamples_() 
{
  return  (mouseX > 100 && mouseX < 125 && mouseY > 340 && mouseY < 355);
}
boolean engine_cyclessamples_val() 
{
  return  (mouseX > 130 && mouseX < 175 && mouseY > 340 && mouseY < 355);
}

boolean scene_name_() 
{
  return  (mouseX > 195 && mouseX < 275 && mouseY > 200 && mouseY < 215);
}
boolean scene_name_val() 
{
  return  (mouseX > 280 && mouseX < 385 && mouseY > 200 && mouseY < 215);
}
boolean placeholder_() 
{
  return  (mouseX > 195 && mouseX < 275 && mouseY > 220 && mouseY < 235);
}
boolean placeholder_val() 
{
  return  (mouseX > 280 && mouseX < 385 && mouseY > 220 && mouseY < 235);
}
boolean overwrite_renders_() 
{
  return  (mouseX > 195 && mouseX < 310 && mouseY > 240 && mouseY < 255);
}
boolean overwrite_renders_val() 
{
  return  (mouseX > 312 && mouseX < 385 && mouseY > 240 && mouseY < 255);
}
boolean render_cache_() 
{
  return  (mouseX > 195 && mouseX < 280 && mouseY > 260 && mouseY < 275);
}
boolean render_cache_val() 
{
  return  (mouseX > 285 && mouseX < 385 && mouseY > 260 && mouseY < 275);
}
boolean add_extension_() 
{
  return  (mouseX > 195 && mouseX < 290 && mouseY > 280 && mouseY < 295);
}
boolean add_extension_val() 
{
  return  (mouseX > 295 && mouseX < 385 && mouseY > 280 && mouseY < 295);
}
boolean file_format_() 
{
  return  (mouseX > 195 && mouseX < 275 && mouseY > 300 && mouseY < 315);
}
boolean file_format_val() 
{
  return  (mouseX > 280 && mouseX < 385 && mouseY > 300 && mouseY < 315);
}
boolean rgb_mode_() 
{
  return  (mouseX > 150 && mouseX < 250 && mouseY > 325 && mouseY < 340);
}
boolean jpg2codec_() 
{
  return  (mouseX > 250 && mouseX < 320 && mouseY > 330 && mouseY < 340);
}
boolean jpg2cinema48_() 
{
  return  (mouseX > 330 && mouseX < 400 && mouseY > 330 && mouseY < 340);
}
boolean jpg2ycc_() 
{
  return  (mouseX > 250 && mouseX < 280 && mouseY > 315 && mouseY < 325);
}
boolean jpg2cinema_() 
{
  return  (mouseX > 280 && mouseX < 340 && mouseY > 315 && mouseY < 325);
}
boolean depth_() 
{
  return  (mouseX > 340 && mouseX < 385 && mouseY > 315 && mouseY < 325);
}
boolean compresion_() 
{
  return  (mouseX > 150 && mouseX < 250 && mouseY > 315 && mouseY < 325);
}

boolean stamp_() 
{
  return  (mouseX > 405 && mouseX < 465 && mouseY > 200 && mouseY < 215);
}
boolean stamp_var() 
{
  return  (mouseX > 460 && mouseX < 500 && mouseY > 200 && mouseY < 215);
}
boolean stamp_stripmeta_() 
{
  return  (mouseX > 490 && mouseX < 550 && mouseY > 200 && mouseY < 215);
}
boolean stamp_dlabels_() 
{
  return  (mouseX > 570 && mouseX < 640 && mouseY > 205 && mouseY < 215);
}
boolean stamp_time_() 
{
  return  (mouseX > 405 && mouseX < 465 && mouseY > 215 && mouseY <  225);
}
boolean stamp_camera_() 
{
  return  (mouseX > 490 && mouseX < 550 && mouseY > 215 && mouseY < 225);
}
boolean stamp_memory_() 
{
  return  (mouseX > 570 && mouseX < 640 && mouseY > 215 && mouseY < 225);
}
boolean stamp_date_() 
{
  return  (mouseX > 405 && mouseX < 465 && mouseY > 225 && mouseY < 235);
}
boolean stamp_lens_() 
{
  return  (mouseX > 490 && mouseX < 550 && mouseY > 225 && mouseY < 235);
}
boolean stamp_rendertime_() 
{
  return  (mouseX > 405 && mouseX < 465 && mouseY > 235 && mouseY < 245);
}
boolean stamp_filename_() 
{
  return  (mouseX > 490 && mouseX < 550 && mouseY > 235 && mouseY < 245);
}
boolean stamp_frame_() 
{
  return  (mouseX > 405 && mouseX < 465 && mouseY > 245 && mouseY < 255);
}
boolean stamp_marker_() 
{
  return  (mouseX > 490 && mouseX < 550 && mouseY > 245 && mouseY < 255);
}
boolean stamp_scene_() 
{
  return  (mouseX > 405 && mouseX < 465 && mouseY > 255 && mouseY < 265);
}
boolean stamp_seqstrip_() 
{
  return  (mouseX > 490 && mouseX < 550 && mouseY > 255 && mouseY < 265);
}
boolean stamp_stampnote_() 
{
  return  (mouseX > 390 && mouseX < 500 && mouseY > 270 && mouseY < 280);
}
boolean stamp_fg_() 
{
  return  (mouseX > 560 && mouseX < 640 && mouseY > 225 && mouseY < 245);
}
boolean stamp_bg_() 
{
  return  (mouseX > 560 && mouseX < 640 && mouseY > 245 && mouseY < 265);
}
boolean select_color_() 
{
  return  (mouseX > 35 && mouseX < 595 && mouseY > 85 && mouseY < 205);
}
boolean select_color_val() 
{
  return  (mouseX > 50 && mouseX < 567 && mouseY > 105 && mouseY < 145);
}

boolean stamp_stampnote_val() 
{
  return  (mouseX > 490 && mouseX < 700 && mouseY > 270 && mouseY < 280);
}


boolean frame_start_() 
{
  return  (mouseX > 395 && mouseX < 465 && mouseY > 295 && mouseY < 305);
}
boolean frame_start_var() 
{
  return  (mouseX > 470 && mouseX < 537 && mouseY > 295 && mouseY < 305);
}
boolean frame_end_() 
{
  return  (mouseX > 395 && mouseX < 465 && mouseY > 305 && mouseY < 320);
}
boolean frame_end_var() 
{
  return  (mouseX > 470 && mouseX < 537 && mouseY > 305 && mouseY < 320);
}
boolean frame_step_() 
{
  return  (mouseX > 395 && mouseX < 465 && mouseY > 320 && mouseY < 335);
}
boolean frame_step_var() 
{
  return  (mouseX > 470 && mouseX < 537 && mouseY > 320 && mouseY < 335);
}
boolean animation_() 
{
  return  (mouseX > 395 && mouseX < 465 && mouseY > 280 && mouseY < 295);
}
boolean frame_() 
{
  return  (mouseX > 185 && mouseX < 285 && mouseY > 340 && mouseY < 355);
}
boolean frame_var() 
{
  return  (mouseX > 285 && mouseX < 700 && mouseY > 340 && mouseY < 355);
}

boolean dither_() 
{
  return  (mouseX > 555 && mouseX < 635 && mouseY > 280 && mouseY < 290);
}
boolean dither_val() 
{
  return  (mouseX > 555 && mouseX < 635 && mouseY > 290 && mouseY < 300);
}
boolean compositing_() 
{
  return  (mouseX > 555 && mouseX < 635 && mouseY > 300 && mouseY < 310);
}
boolean compositing_val() 
{
  return  (mouseX > 555 && mouseX < 635 && mouseY > 310 && mouseY < 320);
}
boolean sequencer_() 
{
  return  (mouseX > 555 && mouseX < 635 && mouseY > 320 && mouseY < 330);
}
boolean sequencer_val() 
{
  return  (mouseX > 555 && mouseX < 635 && mouseY > 330 && mouseY < 340);
}