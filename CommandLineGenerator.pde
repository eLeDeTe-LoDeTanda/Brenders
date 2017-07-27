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

void initVarCommandLine (String os)
{
  if (os == "WINDOWS") {
    File f = new File(dataPath("Preferences"+File.separator+"extern_Windows.txt"));
    if (!f.exists()) {
      write = createWriter(dataPath("Preferences"+File.separator+"extern_Windows.txt"));
      write.println("[Blender]");
      write.println("C:"+File.separator+"Program Files"+File.separator+"Blender Foundation"+File.separator+"blender"+File.separator+"Blender.exe");
      write.println();
      write.println("[Terminal]");
      write.println("cmd.exe");
      write.println();
      write.println("[TextEditor]");
      write.println("NOTEPAD.exe");
      write.println();
      write.println("[FileManager]");
      write.println("explorer.exe");

      write.flush();
      write.close();
    }
    String lines[] = loadStrings(dataPath("Preferences"+File.separator+"extern_Windows.txt"));
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains("[Terminal]")) terminalpath = lines[i+1];
      if (lines[i].contains("[TextEditor]")) texteditorpath = lines[i+1];
      if (lines[i].contains("[FileManager]")) managerpath = lines[i+1];
      if (lines[i].contains("[Blender]")) blenderpath = lines[i+1];
    }
  } else {
    File f = new File(dataPath("Preferences"+File.separator+"extern_Linux.txt"));
    if (!f.exists()) {
      write = createWriter(dataPath("Preferences"+File.separator+"extern_Linux.txt"));
      write.println("[Blender]");
      write.println("/usr/bin/blender");
      write.println();
      write.println("[Terminal]");
      write.println("/usr/bin/xterm");
      write.println();
      write.println("[TextEditor]");
      write.println("/usr/bin/vi");
      write.println();
      write.println("[FileManager]");
      write.println("/usr/bin/nautilus");

      write.flush();
      write.close();
    }
    String lines[] = loadStrings(dataPath("Preferences"+File.separator+"extern_Linux.txt"));
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains("[Terminal]")) terminalpath = lines[i+1];
      if (lines[i].contains("[TextEditor]")) texteditorpath = lines[i+1];
      if (lines[i].contains("[FileManager]")) managerpath = lines[i+1];
      if (lines[i].contains("[Blender]")) blenderpath = lines[i+1];
    }
  }
  terminalfolder = new File (terminalpath);
  texteditorfolder = new File (texteditorpath);
  explorerfolder = new File (managerpath);
  blenderfolder = new File(blenderpath);

  blendpath = dataPath("Test")+File.separator;
  blendname = "BrenderTest.blend";

  settingspath = dataPath("Test"+File.separator+"BrenderTest.py");
  settingsname = "BrenderTest.py";

  outputpath = dataPath("Test"+File.separator+blendname.substring(0, blendname.lastIndexOf("."))+"_Renders")+File.separator;
  rendersname = blendname.substring(0, blendname.lastIndexOf("."))+"_####";
  playrendersfolder = new File(outputpath+rendersname);

  settingsfolder = new File(dataPath("Test"+File.separator+"BrenderTest.py"));
  blendfolder = new File(blendpath+blendname);
  outputfolder = new File(outputpath+rendersname);

  scenename = "Scene";

  generatepy = true;

  newoutput = false;

  valoption[pxX_id] = "1920";
  valoption[pxY_id] = "1080";
  valoption[percentage_id] = "50";
  valoption[anti_aliasing_id] = "True";
  valoption[anti_aliasing_samples_id] = "8";
  valoption[anti_aliasing_fullsamples_id] = "False";
  valoption[tile_x_id] = "64";
  valoption[tile_y_id] = "64";
  valoption[threads_mode_id] = "AUTO";
  valoption[threads_id] = "0";
  valoption[engine_id] = "BLENDER_RENDER";
  valoption[engine_cyclessamples_id] = "False";
  valoption[engine_cyclessamples_val_id] = "128";

  valoption[placeholder_id] = "False";
  valoption[overwrite_renders_id] = "True";
  valoption[file_format_id] = "PNG";

  valoption[add_extension_id] = "True";
  valoption[render_cache_id] = "False";

  valoption[stamp_id] = "True"; 
  valoption[use_stamp_textsize_id] = "12";
  valoption[stamp_background_id] = "(0.0,0.0,0.0,0.5)"; 
  valoption[stamp_foreground_id] = "(0.6,0.6,0.6,1)";  
  valoption[use_stamp_dlabels_id] = "True";  
  valoption[use_stamp_time_id] = "True";  
  valoption[use_stamp_camera_id] = "True";  
  valoption[use_stamp_date_id] = "True";  
  valoption[use_stamp_lens_id] = "False";  
  valoption[use_stamp_render_time_id] = "True"; 
  valoption[use_stamp_filename_id] = "True";  
  valoption[use_stamp_frame_id] = "True";  
  valoption[use_stamp_marker_id] = "False";  
  valoption[use_stamp_scene_id] = "True"; 
  valoption[use_stamp_sequencer_strip_id] = "False"; 
  valoption[use_stamp_memory_id] = "False"; 
  valoption[stamp_note_id] = "False"; 
  valoption[stamp_note_text_id] = "You note here"; 
  valoption[use_stamp_strip_meta_id] = "False"; 

  for (int i = 0; i <= 3; i++) {
    if (i == 3) {  
      fgrgba[3] = 160;
      bgrgba[3] = 160;
    } else {
      fgrgba[i] = 200;
      bgrgba[i] = 0;
    }
  }

  valoption[frame_id] = "";

  valoption[frame_start_id] = "0";
  valoption[frame_end_id] = "10";
  valoption[frame_step_id] = "1";

  valoption[dither_id] = "0";
  valoption[compositing_id] = "True"; 
  valoption[sequencer_id] = "True"; 

  for (int i = 0; i < fromblend.length; i++) {
    fromblend[i] = true;
    selectoption[i] = false;
  }
  for (int i = 0; i < 20; i++) {
    layers_id[i] = "False";
  }

  rgbmode = "RGB";
  depth = "8";

  compresion = "15";
  quality = "90";
  jpg2codec = "JP2";
  jpg2cinema = "False";
  jpg2cinema48 = "False";
  jpg2ycc = "False";
  openexcompresion = "ZIP";
  tiffcompresion  = "DEFLATE";
  openexrzbuffer = "False";
  openexrpreview = "False";
  dpxlog = "False";

  fromblend[scene_name_id] = true;

  for (int i = 0; i < 12; i++) multiblend[i] = "None";

  nameoption[pxX_id] = "Px_X"; 
  nameoption[pxY_id] = "Px_Y"; 
  nameoption[percentage_id] = "%"; 
  nameoption[anti_aliasing_id] = "Anti_aliasing"; 
  nameoption[anti_aliasing_samples_id] = "Anti_aliasing_samples"; 
  nameoption[anti_aliasing_fullsamples_id] = "Full";
  nameoption[tile_x_id] = "Tile_x"; 
  nameoption[tile_y_id] = "Tile_y"; 
  nameoption[threads_mode_id] = "Threads_mode"; 
  nameoption[threads_id] = "Threads"; 
  nameoption[engine_id] = "Engine"; 
  nameoption[engine_cyclessamples_id] = "Samples";  
  nameoption[engine_cyclessamples_val_id] = "Engine_cyclessamples_val"; 

  nameoption[scene_name_id] = "Scene_Name"; 
  nameoption[placeholder_id] = "Placeholder";  
  nameoption[overwrite_renders_id] = "Overwrite_Renders"; 
  nameoption[render_cache_id] = "Render_Cache";  
  nameoption[add_extension_id] = "Add_Extension"; 
  nameoption[file_format_id] = "File_Format"; 
  nameoption[file_format_comp_id] = "File_Format_Comp"; 
  nameoption[file_format_color_id] = "File_Format_Color"; 
  nameoption[file_format_depth_id] = "File_Format_Depth";

  nameoption[output_path_id] = "New_Output";  

  nameoption[stamp_id] = "Stamp";
  nameoption[stamp_background_id] = "BG"; 
  nameoption[stamp_foreground_id] = "FG";  
  nameoption[use_stamp_time_id] = "Time"; 
  nameoption[use_stamp_camera_id] = "Camera"; 
  nameoption[use_stamp_date_id] = "Date"; 
  nameoption[use_stamp_lens_id] = "Lens"; 
  nameoption[use_stamp_render_time_id] = "Render_time"; 
  nameoption[use_stamp_filename_id] = "Filename"; 
  nameoption[use_stamp_frame_id] = "Frames"; 
  nameoption[use_stamp_marker_id] = "Marker";  
  nameoption[use_stamp_scene_id] = "Scene";  
  nameoption[use_stamp_sequencer_strip_id] = "Seq_Strip";  
  nameoption[use_stamp_memory_id] = "Memory"; 
  nameoption[stamp_note_id] = "Note"; 
  nameoption[stamp_note_text_id] = "stamp_note_text"; 
  nameoption[use_stamp_strip_meta_id] = "Strip_Meta";  
  nameoption[use_stamp_dlabels_id] = "Labels"; 
  nameoption[use_stamp_textsize_id] = "Text_Size";  

  nameoption[frame_start_id] = "Frame_Start"; 
  nameoption[frame_end_id] = "Frame_End"; 
  nameoption[frame_step_id] = "Frame_Step"; 

  nameoption[animation_id] = "Animation";  
  nameoption[frame_id] = "Specify_Frame/s:"; 

  nameoption[renders_name_id] = "Renders_Name"; 

  nameoption[dither_id] = "Dither";  

  nameoption[compositing_id] = "Compositing"; 
  nameoption[sequencer_id] = "Sequencer";  

  nameoption[compresion_id] = "Compresion";
}

void settingsOpen(File selection) 
{
  if (selection != null) {
    String path  = selection.getAbsolutePath();
    if (path.endsWith(".py")) {
      loadPy(path);
    } else {  
      loadCommandline(path);
    }
    settingspath = path;
    settingsfolder = new File(path);
    settingsname = selection.getName();
    info = "'"+settingsname+ "' Loaded...";
    redraw();
  }
}

void loadCommandline(String pypath)
{
  String lines[] = loadStrings(pypath);
  String quotes = str('"');

  for (int i = 0; i <  fromblend.length; i++) fromblend[i] = true;

  generatepy = false;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains(" -b ") || lines[i].contains(" --background ")) {
      if (lines[i].contains("ssh ")) {
        ssh = true;
        sshuser = trim(lines[i].substring(lines[i].indexOf("ssh ") + 4, lines[i].indexOf("@")));
        println(sshuser);
        sship = trim(lines[i].substring(lines[i].indexOf("@") + 1, lines[i].indexOf(" ", lines[i].indexOf("@") + 1)));
        println(sship);
        blenderpath = trim(lines[i].substring(lines[i].indexOf(sship) + sship.length(), lines[i].indexOf(" -")));
        if  (blenderpath.contains(quotes)) blenderpath = blenderpath.substring(blenderpath.indexOf(quotes) + 1, blenderpath.lastIndexOf(quotes));
        blenderfolder = new File(blenderpath);
        println(blenderpath);
      } else {
        ssh = false;
        blenderpath = trim(lines[i].substring(0, lines[i].indexOf(" -")));
        if  (blenderpath.contains(quotes)) blenderpath = blenderpath.substring(blenderpath.indexOf(quotes) + 1, blenderpath.lastIndexOf(quotes));
        blenderfolder = new File(blenderpath);
        println(blenderpath);
      }
      if (lines[i].contains(" -b ")) blendpath = trim(lines[i].substring(lines[i].indexOf(" -b "), lines[i].indexOf(" -", lines[i].indexOf(" -") + 1)));
      if (lines[i].contains(" --background ")) blendpath = trim(lines[i].substring(lines[i].indexOf(" --background "), lines[i].indexOf(" -", lines[i].indexOf(" -") + 1)));
      if  (blendpath.contains(quotes)) blendpath = blendpath.substring(blendpath.indexOf(quotes) + 1, blendpath.lastIndexOf(quotes));
      blendfolder = new File(blendpath);
      blendname = blendpath.substring(blendpath.lastIndexOf(File.separator) + 1);
      blendpath = blendpath.substring(0, blendpath.lastIndexOf(File.separator) + 1);
      println(blendpath);
      println(blendname);
      if (lines[i].contains(" -o") || lines[i].contains(" --render-output")) {
        newoutput = true;
        fromblend[output_path_id] = false;
        if (lines[i].contains(" -o")) outputpath = trim(lines[i].substring(lines[i].indexOf(" -o"), lines[i].indexOf(" -", lines[i].indexOf(" -o") + 1)));
        if (lines[i].contains(" --render-output")) outputpath = trim(lines[i].substring(lines[i].indexOf(" --render-output"), lines[i].indexOf(" -", lines[i].indexOf(" --render-output") + 1)));
        if  (outputpath.contains(quotes)) outputpath = outputpath.substring(outputpath.indexOf(quotes) + 1, outputpath.lastIndexOf(quotes));
        outputfolder = new File(outputpath);
        rendersname = outputpath.substring(outputpath.lastIndexOf(File.separator) + 1);
        outputpath = outputpath.substring(0, outputpath.lastIndexOf(File.separator) + 1);
        println(outputpath);
        println(rendersname);
      } else {
        newoutput = false;
        fromblend[output_path_id] = true;
      }
      if (lines[i].contains(" -S") || lines[i].contains(" --scene")) {
        fromblend[scene_name_id] = false;
        if (lines[i].contains(" -S")) scenename = trim(lines[i].substring(lines[i].indexOf(" -S") + 3, lines[i].indexOf(" -", lines[i].indexOf(" -S") + 1)));
        if (lines[i].contains(" --scene")) scenename = trim(lines[i].substring(lines[i].indexOf(" --scene") + 8, lines[i].indexOf(" -", lines[i].indexOf(" --scene") + 1)));
        if  (scenename.contains(quotes)) scenename = scenename.substring(scenename.indexOf(quotes) + 1, scenename.lastIndexOf(quotes));
        println(scenename);
      } else fromblend[scene_name_id] = true;
      if (lines[i].contains(" -E") || lines[i].contains(" --engine")) {
        fromblend[engine_id] = false;
        if (lines[i].contains(" -E")) valoption[engine_id] = trim(lines[i].substring(lines[i].indexOf(" -E") + 3, lines[i].indexOf(" -", lines[i].indexOf(" -E") + 1)));
        if (lines[i].contains(" --engine")) valoption[engine_id] = trim(lines[i].substring(lines[i].indexOf(" --engine") + 9, lines[i].indexOf(" -", lines[i].indexOf(" --engine") + 1)));
        if  (valoption[engine_id].contains(quotes)) valoption[engine_id] = valoption[engine_id].substring(valoption[engine_id].indexOf(quotes) + 1, scenename.lastIndexOf(quotes));
        println(valoption[engine_id]);
      } else fromblend[engine_id] = true;
      if (lines[i].contains(" -F") || lines[i].contains(" --render-format")) {
        fromblend[file_format_id] = false;
        if (lines[i].contains(" -F")) valoption[file_format_id] = trim(lines[i].substring(lines[i].indexOf(" -F") + 3, lines[i].indexOf(" -", lines[i].indexOf(" -F") + 1)));
        if (lines[i].contains(" --render-format")) valoption[file_format_id] = trim(lines[i].substring(lines[i].indexOf(" --render-format") + 16, lines[i].indexOf(" -", lines[i].indexOf(" --render-format") + 1)));
        if  (valoption[file_format_id].contains(quotes)) valoption[file_format_id] = valoption[file_format_id].substring(valoption[file_format_id].indexOf(quotes) + 1, valoption[file_format_id].lastIndexOf(quotes));
        println(valoption[file_format_id]);
      } else fromblend[file_format_id] = true;
      if (lines[i].contains(" -x") || lines[i].contains(" --use-extension")) {
        fromblend[add_extension_id] = false;
        if (lines[i].contains(" -x")) valoption[add_extension_id] = trim(lines[i].substring(lines[i].indexOf(" -x") + 3, lines[i].indexOf(" -", lines[i].indexOf(" -x") + 1)));
        if (lines[i].contains(" --use-extension")) valoption[add_extension_id] = trim(lines[i].substring(lines[i].indexOf(" --use-extension") + 16, lines[i].indexOf(" -", lines[i].indexOf(" --use-extension") + 1)));
        if (int(valoption[add_extension_id]) == 1) valoption[add_extension_id] = "True";
        else valoption[add_extension_id] = "False";
        println(valoption[add_extension_id]);
      } else fromblend[add_extension_id] = true;
      if (lines[i].contains(" -t") || lines[i].contains(" --threads")) {
        fromblend[threads_id] = false;
        fromblend[threads_mode_id] = false;
        if (lines[i].contains(" -t")) valoption[threads_id] = trim(lines[i].substring(lines[i].indexOf(" -t") + 3, lines[i].indexOf(" -", lines[i].indexOf(" -t") + 1)));
        if (lines[i].contains(" --threads")) valoption[threads_id] = trim(lines[i].substring(lines[i].indexOf(" --threads") + 10, lines[i].indexOf(" -", lines[i].indexOf(" --threads") + 1)));
        println(valoption[threads_id]);
      } else {
        fromblend[threads_id] = true;
        fromblend[threads_mode_id] = true;
      }
      if (lines[i].contains(" -a") || lines[i].contains(" --render-anim")) {
        fromblend[frame_id] = true;
      }
      if (lines[i].contains(" -s") || lines[i].contains(" --frame-start")) {
        fromblend[animation_id] = false;
        fromblend[frame_id] = true;
        fromblend[frame_start_id] = false;
        fromblend[frame_end_id] = false;
        fromblend[frame_step_id] = false;
        if (lines[i].contains(" -s")) valoption[frame_start_id] = trim(lines[i].substring(lines[i].indexOf(" -s") + 3, lines[i].indexOf(" -", lines[i].indexOf(" -s") + 1)));
        if (lines[i].contains(" --frame-start")) valoption[frame_start_id] = trim(lines[i].substring(lines[i].indexOf(" --frame-start") + 14, lines[i].indexOf(" -", lines[i].indexOf(" --frame-start") + 1)));
        println(valoption[frame_start_id]);
      } else {
        fromblend[animation_id] = true;
        fromblend[frame_start_id] = true;       
        fromblend[frame_end_id] = true;
        fromblend[frame_step_id] = true;
      }
      if (lines[i].contains(" -e") || lines[i].contains(" --frame-end")) {
        fromblend[animation_id] = false;
        fromblend[frame_id] = true;
        fromblend[frame_start_id] = false;
        fromblend[frame_end_id] = false;
        fromblend[frame_step_id] = false;
        if (lines[i].contains(" -e")) valoption[frame_end_id] = trim(lines[i].substring(lines[i].indexOf(" -e") + 3, lines[i].indexOf(" -", lines[i].indexOf(" -e") + 1)));
        if (lines[i].contains(" --frame-end")) valoption[frame_end_id] = trim(lines[i].substring(lines[i].indexOf(" --frame-end") + 12, lines[i].indexOf(" -", lines[i].indexOf(" --frame-end") + 1)));
        println(valoption[frame_end_id]);
      } else {
        fromblend[animation_id] = true;
        fromblend[frame_start_id] = true;       
        fromblend[frame_end_id] = true;
        fromblend[frame_step_id] = true;
      }
      if (lines[i].contains(" -j") || lines[i].contains(" --frame-jump")) {
        fromblend[animation_id] = false;
        fromblend[frame_id] = true;
        fromblend[frame_start_id] = false;
        fromblend[frame_end_id] = false;
        fromblend[frame_step_id] = false;
        if (lines[i].contains(" -j")) valoption[frame_step_id] = trim(lines[i].substring(lines[i].indexOf(" -j") + 3, lines[i].indexOf(" -", lines[i].indexOf(" -j") + 1)));
        if (lines[i].contains(" --frame-jump")) valoption[frame_step_id] = trim(lines[i].substring(lines[i].indexOf(" --frame-jump") + 13, lines[i].indexOf(" -", lines[i].indexOf(" --frame-jump") + 1)));
        println(valoption[frame_step_id]);
      } else {
        fromblend[animation_id] = true;
        fromblend[frame_start_id] = true;       
        fromblend[frame_end_id] = true;
        fromblend[frame_step_id] = true;
      }

      if (lines[i].contains(" tee"))  savelogs = true;
      else  savelogs = false;

      if (lines[i].contains(" -f") || lines[i].contains(" --render-frame")) {
        fromblend[frame_id] = false;
        fromblend[animation_id] = true;
        fromblend[frame_start_id] = true;
        fromblend[frame_end_id] = true;
        fromblend[frame_step_id] = true;
        if (savelogs) {
          if (lines[i].contains(" -f")) valoption[frame_id] = trim(lines[i].substring(lines[i].indexOf(" -f") + 3, lines[i].indexOf(" |", lines[i].indexOf(" -f") + 1)));
          if (lines[i].contains(" --render-frame")) valoption[frame_id] = trim(lines[i].substring(lines[i].indexOf(" --render-frame") + 15, lines[i].indexOf(" |", lines[i].indexOf(" --render-frame") + 1)));
        } else {
          if (lines[i].contains(" -f")) valoption[frame_id] = trim(lines[i].substring(lines[i].indexOf(" -f") + 3));
          if (lines[i].contains(" --render-frame")) valoption[frame_id] = trim(lines[i].substring(lines[i].indexOf(" --render-frame") + 15));
        }
        println(valoption[frame_id]);
      } else fromblend[frame_id] = true;
    }
  }
}

void loadPy(String pypath)
{
  String lines[] = loadStrings(pypath);
  String quotes = str('"');

  generatepy = true;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains(" -P ") || lines[i].contains(" --python ")) {
      if (!lines[i].contains(" -b ") || !lines[i].contains(" --background ")) oglrenders = true;
      else oglrenders = false;
      if (lines[i].contains("ssh ")) {
        ssh = true;
        sshuser = trim(lines[i].substring(lines[i].indexOf("ssh ") + 4, lines[i].indexOf("@")));
        println(sshuser);
        sship = trim(lines[i].substring(lines[i].indexOf("@") + 1, lines[i].indexOf(" ", lines[i].indexOf("@") + 1)));
        println(sship);
        blenderpath = trim(lines[i].substring(lines[i].indexOf(sship) + sship.length(), lines[i].indexOf(" -")));
        if  (blenderpath.contains(quotes)) blenderpath = blenderpath.substring(blenderpath.indexOf(quotes) + 1, blenderpath.lastIndexOf(quotes));
        blenderfolder = new File(blenderpath);
        println(blenderpath);
      } else {
        ssh = false;
        blenderpath = trim(lines[i].substring(0, lines[i].indexOf(" -")));
        if  (blenderpath.contains(quotes)) blenderpath = blenderpath.substring(blenderpath.indexOf(quotes) + 1, blenderpath.lastIndexOf(quotes));
        blenderfolder = new File(blenderpath);
        println(blenderpath);
      }

      blendpath = trim(lines[i].substring(lines[i].indexOf(" -"), lines[i].indexOf(" -", lines[i].indexOf(" -") + 1)));
      if  (blendpath.contains(quotes)) blendpath = blendpath.substring(blendpath.indexOf(quotes) + 1, blendpath.lastIndexOf(quotes));
      blendfolder = new File(blendpath);
      blendname = blendpath.substring(blendpath.lastIndexOf(File.separator) + 1);
      blendpath = blendpath.substring(0, blendpath.lastIndexOf(File.separator) + 1);
      println(blendpath);
      println(blendname);
    }

    if  (!trim(lines[i]).startsWith("#")) {
      if  (lines[i].contains("render.resolution_x")) {
        fromblend[pxX_id] = false;
        valoption[pxX_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.resolution_y")) {
        fromblend[pxY_id] = false;
        valoption[pxY_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.resolution_percentage")) {
        fromblend[percentage_id] = false;
        valoption[percentage_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_antialiasing")) {
        selectoption[anti_aliasing_id] = true;
        fromblend[anti_aliasing_id] = false;
        valoption[anti_aliasing_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.antialiasing_samples")) {
        fromblend[anti_aliasing_id] = false;
        valoption[anti_aliasing_samples_id] = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if (lines[i].contains("render.use_full_sample")) {
        fromblend[anti_aliasing_id] = false;
        valoption[anti_aliasing_fullsamples_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if  (lines[i].contains("render.tile_x")) {
        fromblend[tile_x_id] = false;
        valoption[tile_x_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if  (lines[i].contains("render.tile_y")) {
        fromblend[tile_y_id] = false;
        valoption[tile_y_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.threads_mode")) {
        fromblend[threads_mode_id] = false;
        valoption[threads_mode_id] = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if  (lines[i].contains("render.threads")) {
        valoption[threads_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.engine")) {
        fromblend[engine_id] = false;
        valoption[engine_id] = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if (lines[i].contains("cycles.samples")) {
        fromblend[engine_id] = false;
        valoption[engine_id] = "CYCLES";
        valoption[engine_cyclessamples_id] = "True";
        valoption[engine_cyclessamples_val_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      }//
      else if (lines[i].contains("render.dither_intensity")) {
        fromblend[dither_id] = false;
        valoption[dither_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_compositing")) {
        fromblend[compositing_id] = false;
        valoption[compositing_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_sequencer")) {
        fromblend[sequencer_id] = false;
        valoption[sequencer_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } 
      //
      else if (lines[i].contains("render.filepath")) {
        newoutput = true;
        outputpath = lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf(File.separator) + 1);
        outputfolder = new File(outputpath);
        rendersname = lines[i].substring(lines[i].lastIndexOf(File.separator)+1, lines[i].lastIndexOf('"'));
      } else if (lines[i].contains("render.use_placeholder")) {
        fromblend[placeholder_id] = false;
        valoption[placeholder_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_overwrite")) {
        fromblend[overwrite_renders_id] = false;
        valoption[overwrite_renders_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_render_cache")) {
        fromblend[render_cache_id] = false;
        valoption[render_cache_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_file_extension")) {
        fromblend[add_extension_id] = false;
        valoption[add_extension_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.image_settings.file_format")) {
        fromblend[file_format_id] = false;
        valoption[file_format_id] = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if (lines[i].contains("render.image_settings.compression")) {
        compresion = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.image_settings.quality")) {
        quality = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.image_settings.exr_codec")) {
        openexcompresion = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.image_settings.tiff_codec")) {
        tiffcompresion = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if (lines[i].contains("render.image_settings.color_mode")) {
        rgbmode = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if (lines[i].contains("render.image_settings.color_depth")) {
        depth = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if (lines[i].contains("render.image_settings.use_jpeg2k_cinema_preset")) {
        jpg2cinema = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if (lines[i].contains("render.image_settings.use_jpeg2k_cinema_48")) {
        jpg2cinema48 = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if (lines[i].contains("render.image_settings.use_jpeg2k_ycc")) {
        jpg2ycc = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if (lines[i].contains("render.image_settings.jpeg2k_codec")) {
        jpg2codec = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if (lines[i].contains("render.image_settings.use_zbuffer")) {
        openexrzbuffer = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.image_settings.use_preview")) {
        openexrpreview = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.image_settings.use_cineon_log")) {
        dpxlog = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      }
      //
      else if (lines[i].contains("render.use_stamp")) {
        fromblend[stamp_id] = false;
        valoption[stamp_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.stamp_font_size")) {
        fromblend[use_stamp_textsize_id] = false;
        valoption[use_stamp_textsize_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.stamp_background")) {
        fromblend[stamp_background_id] = false;
        valoption[stamp_background_id] = trim(lines[i].substring(lines[i].indexOf('(') + 1, lines[i].lastIndexOf(')')));
      } else if (lines[i].contains("render.stamp_foreground")) {
        fromblend[stamp_foreground_id] = false;
        valoption[stamp_foreground_id] = trim(lines[i].substring(lines[i].indexOf('(') + 1, lines[i].lastIndexOf(')')));
      } else if (lines[i].contains("render.use_stamp_labels")) {
        fromblend[use_stamp_dlabels_id] = false;
        valoption[use_stamp_dlabels_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_time")) {
        fromblend[use_stamp_time_id] = false;
        valoption[use_stamp_time_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_camera")) {
        fromblend[use_stamp_camera_id] = false;
        valoption[use_stamp_camera_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_memory")) {
        fromblend[use_stamp_memory_id] = false;
        valoption[use_stamp_memory_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_date")) {
        fromblend[use_stamp_date_id] = false;
        valoption[use_stamp_date_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_lens")) {
        fromblend[use_stamp_lens_id] = false;
        valoption[use_stamp_lens_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_render_time")) {
        fromblend[use_stamp_render_time_id] = false;
        valoption[use_stamp_render_time_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_filename")) {
        fromblend[use_stamp_filename_id] = false;
        valoption[use_stamp_filename_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_frame")) {
        fromblend[use_stamp_frame_id] = false;
        valoption[use_stamp_frame_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_marker")) {
        fromblend[use_stamp_marker_id] = false;
        valoption[use_stamp_marker_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_scene")) {
        fromblend[use_stamp_scene_id] = false;
        valoption[use_stamp_scene_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_sequencer_strip")) {
        fromblend[use_stamp_sequencer_strip_id] = false;
        valoption[use_stamp_sequencer_strip_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_note")) {
        fromblend[stamp_note_id] = false;
        valoption[stamp_note_id] = trim(lines[i].substring(lines[i].indexOf('"') + 1, lines[i].lastIndexOf('"')));
      } else if (lines[i].contains("render.stamp_note_text")) {
        fromblend[stamp_note_text_id] = false;
        valoption[stamp_note_text_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_strip_meta")) {
        fromblend[use_stamp_strip_meta_id] = false;
        valoption[use_stamp_strip_meta_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } 
      //
      else if (lines[i].contains("frame_start")) {
        fromblend[animation_id] = false;
        fromblend[frame_start_id] = false;
        valoption[frame_start_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("frame_end")) {
        fromblend[animation_id] = false;
        fromblend[frame_end_id] = false;
        valoption[frame_end_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("frame_step")) {
        fromblend[animation_id] = false;
        fromblend[frame_step_id] = false;
        valoption[frame_step_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      }
    } else {
      if (lines[i].contains("render.resolution_x")) {
        fromblend[pxX_id] = true;
      } else if (lines[i].contains("render.resolution_y")) {
        fromblend[pxY_id] = true;
      } else if (lines[i].contains("render.resolution_percentage")) {
        fromblend[percentage_id] = true;
      } else if (lines[i].contains("render.use_antialiasing")) {
        fromblend[anti_aliasing_id] = true;
        fromblend[anti_aliasing_id] = true;
      } else if (lines[i].contains("render.antialiasing_samples")) {
        fromblend[anti_aliasing_id] = true;
        fromblend[anti_aliasing_samples_id] = true;
      } else if (lines[i].contains("render.use_full_sample")) {
        fromblend[anti_aliasing_id] = true;
        fromblend[anti_aliasing_fullsamples_id] = true;
      } else if (lines[i].contains("render.tile_x")) {
        fromblend[tile_x_id] = true;
      } else if (lines[i].contains("render.tile_y")) {
        fromblend[tile_y_id] = true;
      } else if (lines[i].contains("render.threads_mode")) {
        fromblend[threads_mode_id] = true;
      } else if (lines[i].contains("render.threads")) {
      } else if (lines[i].contains("render.engine")) {
        fromblend[engine_id] = true;
      } else if (lines[i].contains("cycles.samples")) {
        valoption[engine_cyclessamples_id] = "False";
      }
      //
      else if (lines[i].contains("render.dither_intensity")) {
        fromblend[dither_id] = true;
      } else if (lines[i].contains("render.use_compositing")) {
        fromblend[compositing_id] = true;
      } else if (lines[i].contains("render.use_sequencer")) {
        fromblend[sequencer_id] = true;
      }
      //
      else if (lines[i].contains("render.filepath")) {
        newoutput = false;
      } else if (lines[i].contains("render.use_placeholder")) {
        fromblend[placeholder_id] = true;
      } else if (lines[i].contains("render.use_overwrite")) {
        fromblend[overwrite_renders_id] = true;
      } else if (lines[i].contains("render.use_render_cache")) {
        fromblend[render_cache_id] = true;
      } else if (lines[i].contains("render.use_file_extension")) {
        fromblend[add_extension_id] = true;
      } else if (lines[i].contains("render.image_settings.file_format")) {
        fromblend[add_extension_id] = true;
      }
      //
      else if (lines[i].contains("render.use_stamp")) {
        fromblend[stamp_id] = true;
      } else if (lines[i].contains("render.stamp_font_size")) {
        fromblend[use_stamp_textsize_id] = true;
      } else if (lines[i].contains("render.stamp_background")) {
        fromblend[stamp_background_id] = true;
      } else if (lines[i].contains("render.stamp_foreground")) {
        fromblend[stamp_foreground_id] = true;
      } else if (lines[i].contains("render.use_stamp_labels")) {
        fromblend[use_stamp_dlabels_id] = true;
      } else if (lines[i].contains("render.use_stamp_time")) {
        fromblend[use_stamp_time_id] = true;
      } else if (lines[i].contains("render.use_stamp_camera")) {
        fromblend[use_stamp_camera_id] = true;
      } else if (lines[i].contains("render.use_stamp_memory")) {
        fromblend[use_stamp_memory_id] = true;
      } else if (lines[i].contains("render.use_stamp_date")) {
        fromblend[use_stamp_date_id] = true;
      } else if (lines[i].contains("render.use_stamp_lens")) {
        fromblend[use_stamp_lens_id] = true;
      } else if (lines[i].contains("render.use_stamp_render_time")) {
        fromblend[use_stamp_render_time_id] = true;
      } else if (lines[i].contains("render.use_stamp_filename")) {
        fromblend[use_stamp_filename_id] = true;
      } else if (lines[i].contains("render.use_stamp_frame")) {
        fromblend[use_stamp_frame_id] = true;
      } else if (lines[i].contains("render.use_stamp_marker")) {
        fromblend[use_stamp_marker_id] = true;
      } else if (lines[i].contains("render.use_stamp_scene")) {
        fromblend[use_stamp_scene_id] = true;
        valoption[use_stamp_scene_id] = trim(lines[i].substring(lines[i].lastIndexOf("=") + 1));
      } else if (lines[i].contains("render.use_stamp_sequencer_strip")) {
        fromblend[use_stamp_sequencer_strip_id] = true;
      } else if (lines[i].contains("render.use_stamp_note")) {
        fromblend[stamp_note_id] = true;
      } else if (lines[i].contains("render.stamp_note_text")) {
        fromblend[stamp_note_text_id] = true;
      } else if (lines[i].contains("render.use_stamp_strip_meta")) {
        fromblend[use_stamp_strip_meta_id] = true;
      }
      //
      else if (lines[i].contains("frame_start")) {
        fromblend[animation_id] = true;
        fromblend[frame_start_id] = true;
      } else if (lines[i].contains("frame_end")) {
        fromblend[animation_id] = true;
        fromblend[frame_end_id] = true;
      } else if (lines[i].contains("frame_step")) {
        fromblend[animation_id] = true;
        fromblend[frame_step_id] = true;
      }
    }
  }
}

void commandLineOptions()
{
  if (generatepy) {
    if (ssh) Command_Line = "ssh "+sshuser+"@"+sship+" ";
    else Command_Line = "";
    if (oglrenders) Command_Line += '"'+blenderpath+'"'+" - "+'"'+blendpath+blendname+'"'+" -P "+'"'+settingspath+'"';
    else Command_Line += '"'+blenderpath+'"'+" -b "+'"'+blendpath+blendname+'"'+" -P "+'"'+settingspath+'"';
  } else { 
    if (ssh) Command_Line = "ssh "+sshuser+"@"+sship+" ";
    else Command_Line = "";

    Command_Line += '"'+blenderpath+'"'+" -b "+'"'+blendpath+blendname+'"';

    if (!fromblend[output_path_id]) {
      Command_Line += " -o "+'"'+outputpath+rendersname+'"';
    }
    if (!fromblend[scene_name_id]) {
      Command_Line += " -S "+scenename;
    }
    if (!fromblend[engine_id]) {
      Command_Line += " -E "+valoption[engine_id];
    }
    if (!fromblend[file_format_id]) {
      Command_Line += " -F "+valoption[file_format_id];
    }
    if (!fromblend[add_extension_id]) {
      int extension;
      if (valoption[add_extension_id] == "True") extension = 1;
      else extension = 0;
      Command_Line += " -x "+extension;
    }
    if (!fromblend[threads_mode_id]) {
      Command_Line += " -t "+valoption[threads_id];
    }
    if (!fromblend[frame_id]) {
      Command_Line += " -f "+valoption[frame_id];
    }
    if (!fromblend[frame_start_id]) {
      Command_Line += " -s "+valoption[frame_start_id];
    }
    if (!fromblend[frame_end_id]) {
      Command_Line += " -e "+valoption[frame_end_id];
    }
    if (!fromblend[frame_step_id]) {
      Command_Line += " -j "+valoption[frame_step_id];
    }
    if (fromblend[frame_id]) {
      Command_Line += " -a";
    }
  }

  if (savelogs) {
    if (os == "WINDOWS") {
      Command_Line += " > "+'"'+settingspath.substring(0, settingspath.lastIndexOf("."))+"_"+fullDate()+".log"+'"';
    } else {
      Command_Line += " | tee "+'"'+settingspath.substring(0, settingspath.lastIndexOf("."))+"_"+fullDate()+".log"+'"';
    }
  }

  if (!fromblend[output_path_id]) command_play_anim = '"'+blenderpath+'"'+" -a "+'"'+outputpath+"*"+'"';
  else command_play_anim = '"'+blenderpath+'"'+" -a "+"<Renders path from "+blendname+">";
}

void command_Line()
{
  write.println("Command Line:");
  write.println();
  write.println(Command_Line);
  write.println();
  write.println("Blender player:");
  write.println();
  write.println(command_play_anim);
}

void sh_command_Line_Save(String path)
{
  write = createWriter(path);

  write.println("#!/bin/bash");
  write.println();
  write.println("# Auto-generated by " + version);
  write.println();
  write.println("# Command Line:");
  write.println();
  write.print("xterm -e ");
  write.println(Command_Line);

  write.flush();
  write.close();

  File f = new File(path);
  f.setExecutable(true, false);
}

void bat_command_Line_Save(String path)
{
  write = createWriter(path);
  write.println("@ECHO OFF");
  write.println("COLOR 8F");
  write.print("type "+settingspath);
  write.println();
  write.println("@ECHO -");
  write.println("@ECHO START renders...");
  write.println("@ECHO -");
  write.println("PAUSE");
  write.println("@ECHO -");
  write.println("@ECHO RENDERING...");
  write.println("@ECHO -");
  write.print("call ");
  write.println(Command_Line);
  write.println("@ECHO -");
  write.println("@ECHO FINISH!");
  write.println("@ECHO -");
  write.println("PAUSE");
  write.print("exit");

  write.flush();
  write.close();
}

void Command_Line_Save(String path)
{
  write = createWriter(path);

  write.println("# Auto-generated by "+version);
  write.println("# https://github.com/eLeDeTe-LoDeTanda/Brenders");
  write.println();
  changeforblend();
  write.println();
  command_Line();

  write.flush();
  write.close();
}

void py_Save(String pypath)
{

  write = createWriter(pypath);

  write.println("# Auto-generated by "+version);
  write.println("# https://github.com/eLeDeTe-LoDeTanda/Brenders");
  write.println();
  write.println("'''");
  changeforblend();
  write.println();
  command_Line();
  write.println("'''");
  write.println();
  write.println("import bpy");
  write.println();
  write.println("# Render Options to change");
  write.println("############################");
  write.println();

  write.println("# Scene Name");
  write.print("Scenename = ");
  if (fromblend[scene_name_id]) write.println("bpy.context.scene.name");
  else write.println('"'+scenename+'"');
  write.println();
  write.println("# Render Quality");
  if (fromblend[pxX_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.resolution_x = ");
  write.println(valoption[pxX_id]);
  if (fromblend[pxY_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.resolution_y = ");
  write.println(valoption[pxY_id]);
  if (fromblend[percentage_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.resolution_percentage = ");
  write.println(valoption[percentage_id]);
  if (fromblend[anti_aliasing_id] || valoption[engine_id] == "CYCLES") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_antialiasing = ");
  write.println(valoption[anti_aliasing_id]);
  if (fromblend[anti_aliasing_id] || valoption[anti_aliasing_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.antialiasing_samples = ");
  write.println('"'+valoption[anti_aliasing_samples_id]+'"');
  if (fromblend[anti_aliasing_id] || valoption[anti_aliasing_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_full_sample = ");
  write.println(valoption[anti_aliasing_fullsamples_id]);
  if (fromblend[tile_x_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.tile_x = ");
  write.println(valoption[tile_x_id]);
  if (fromblend[tile_y_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.tile_y = ");
  write.println(valoption[tile_y_id]);
  if (fromblend[threads_mode_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.threads_mode = ");
  write.println('"'+valoption[threads_mode_id]+'"');
  if (fromblend[threads_mode_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.threads = ");
  write.println(valoption[threads_id]);
  if (fromblend[engine_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.engine = ");
  write.println('"'+valoption[engine_id]+'"');
  if (fromblend[engine_id] || valoption[engine_cyclessamples_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].cycles.samples = ");
  write.println(valoption[engine_cyclessamples_val_id]);
  write.println();
  if (fromblend[dither_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.dither_intensity = ");
  write.println(valoption[dither_id]);

  if (fromblend[compositing_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_compositing = ");
  write.println(valoption[compositing_id]);
  if (fromblend[sequencer_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_sequencer = ");
  write.println(valoption[sequencer_id]);

  write.println();

  write.println("# Output");
  if (fromblend[output_path_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.filepath = ");
  write.println('"'+outputpath+rendersname+'"');
  if (fromblend[placeholder_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_placeholder = ");
  write.println(valoption[placeholder_id]);
  if (fromblend[overwrite_renders_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_overwrite = ");
  write.println(valoption[overwrite_renders_id]);
  if (fromblend[file_format_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.image_settings.file_format = ");
  write.println('"'+valoption[file_format_id]+'"');
  if (!fromblend[file_format_id]) {
    if (valoption[file_format_id] == "PNG") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.compression = ");
      write.println(compresion);
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
    } else if (valoption[file_format_id] == "JPEG") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.quality = ");
      write.println(quality);
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else if (valoption[file_format_id] == "TARGA") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else if (valoption[file_format_id] == "TARGA_RAW") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else   if (valoption[file_format_id] == "TIFF") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.tiff_codec = ");
      write.println('"'+tiffcompresion+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
    } else if (valoption[file_format_id] == "IRIS") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else if (valoption[file_format_id] == "BMP") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else if (valoption[file_format_id] == "JPEG2000") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.quality = ");
      write.println(quality);
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.jpeg2k_codec = ");
      write.println('"'+jpg2codec+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_jpeg2k_cinema_preset = ");
      write.println('"'+jpg2cinema+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_jpeg2k_cinema_48 = ");
      write.println('"'+jpg2cinema48+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_jpeg2k_ycc = ");
      write.println('"'+jpg2ycc+'"');
    } else if (valoption[file_format_id] == "OPEN_EXR") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.exr_codec = ");
      write.println('"'+openexcompresion+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_zbuffer = ");
      write.println(openexrzbuffer);
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_preview = ");
      write.println(openexrpreview);
    } else if (valoption[file_format_id] == "OPEN_EXR_MULTILAYER") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.exr_codec = ");
      write.println('"'+openexcompresion+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
    } else if (valoption[file_format_id] == "CINEON") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    } else if (valoption[file_format_id] == "DPX") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_depth = ");
      write.println('"'+depth+'"');
      write.print("bpy.data.scenes[Scenename].render.image_settings.use_cineon_log = ");
      write.println(dpxlog);
    } else if (valoption[file_format_id] == "HDR") {
      write.print("bpy.data.scenes[Scenename].render.image_settings.color_mode = ");
      write.println('"'+rgbmode+'"');
    }
  }
  if (fromblend[add_extension_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_file_extension = ");
  write.println(valoption[add_extension_id]);
  if (fromblend[render_cache_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_render_cache = ");
  write.println(valoption[render_cache_id]);
  write.println();

  write.println("# stamp");
  if (fromblend[stamp_id]) write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp = ");
  write.println(valoption[stamp_id]);
  if (fromblend[use_stamp_textsize_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.stamp_font_size = ");
  write.println(valoption[use_stamp_textsize_id]);
  if (fromblend[stamp_background_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.stamp_background = ");
  write.println(valoption[stamp_background_id]);
  if (fromblend[stamp_foreground_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.stamp_foreground = ");
  write.println(valoption[stamp_foreground_id]);
  if (fromblend[use_stamp_dlabels_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_labels = ");
  write.println(valoption[use_stamp_dlabels_id]);
  if (fromblend[use_stamp_time_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_time = ");
  write.println(valoption[use_stamp_time_id]);
  if (fromblend[use_stamp_camera_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_camera = ");
  write.println(valoption[use_stamp_camera_id]);
  if (fromblend[use_stamp_date_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_date = ");
  write.println(valoption[use_stamp_date_id]);
  if (fromblend[use_stamp_lens_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_lens = ");
  write.println(valoption[use_stamp_lens_id]);
  if (fromblend[use_stamp_render_time_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_render_time = ");
  write.println(valoption[use_stamp_render_time_id]);
  if (fromblend[use_stamp_filename_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_filename = ");
  write.println(valoption[use_stamp_filename_id]);
  if (fromblend[use_stamp_frame_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_frame = ");
  write.println(valoption[use_stamp_frame_id]);
  if (fromblend[use_stamp_marker_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_marker = ");
  write.println(valoption[use_stamp_marker_id]);
  if (fromblend[use_stamp_scene_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_scene = ");
  write.println(valoption[use_stamp_scene_id]);
  if (fromblend[use_stamp_sequencer_strip_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_sequencer_strip = ");
  write.println(valoption[use_stamp_sequencer_strip_id]);
  if (fromblend[stamp_note_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_note = ");
  write.println(valoption[stamp_note_id]);
  if (fromblend[stamp_note_text_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.stamp_note_text = ");
  write.println('"'+valoption[stamp_note_text_id]+'"');
  if (fromblend[use_stamp_memory_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_memory = ");
  write.println(valoption[use_stamp_memory_id]);
  if (fromblend[use_stamp_strip_meta_id] || valoption[stamp_id] == "False") write.print("#");
  write.print("bpy.data.scenes[Scenename].render.use_stamp_strip_meta = ");
  write.println(valoption[use_stamp_strip_meta_id]);
  write.println();

  write.println();
  write.println("# Render frames");

  if (!fromblend[frame_id]) {
    if  (!valoption[frame_id].contains(".") && !valoption[frame_id].contains(",") && !valoption[frame_id].contains("+") && !valoption[frame_id].contains("-")) {
      write.print("bpy.data.scenes[Scenename].frame_start = ");
      write.println(valoption[frame_id]);
      write.print("bpy.data.scenes[Scenename].frame_end = ");
      write.println(valoption[frame_id]);
    }
  } else {
    if (fromblend[frame_start_id]) write.print("#");
    write.print("bpy.data.scenes[Scenename].frame_start = ");
    write.println(valoption[frame_start_id]);
    if (fromblend[frame_end_id]) write.print("#");
    write.print("bpy.data.scenes[Scenename].frame_end = ");
    write.println(valoption[frame_end_id]);
    if (fromblend[frame_step_id]) write.print("#");
    write.print("bpy.data.scenes[Scenename].frame_step = ");
    write.println(valoption[frame_step_id]);
  }

  if (oglrenders) write.print("#");
  write.println("bpy.ops.render.render(animation=True,scene=Scenename)");
  write.println();
  write.println("# Render OpenGL");
  if (!oglrenders) write.print("#");
  write.println("bpy.ops.render.opengl(animation=True,view_context = False)");
  if (!oglrenders) write.print("#");
  write.println("bpy.ops.wm.quit_blender()");

  write.println();
  write.print("####################################");

  write.flush();
  write.close();
}

void settingsName()
{
  if (!generatepy) {
    if (!fromblend[animation_id]) {
      settingsname = blendname.substring(0, blendname.lastIndexOf("."))+"_"+valoption[frame_start_id]+"-"+valoption[frame_end_id]+".txt";
    } else if (!fromblend[frame_id]) {
      settingsname = blendname.substring(0, blendname.lastIndexOf("."))+"_f"+valoption[frame_id]+".txt";
    } else {
      settingsname = blendname.substring(0, blendname.lastIndexOf("."))+".txt";
    }
  } else {
    String ogl = "";
    if (oglrenders && valoption[engine_id] == "BLENDER_RENDER") ogl = "-ogl";
    else if (oglrenders && valoption[engine_id] == "BLENDER_CLAY") ogl = "-Clay";
    else if (oglrenders && valoption[engine_id] == "BLENDER_EEVEE") ogl = "-Eevee";
    if (!fromblend[animation_id]) {
      settingsname = blendname.substring(0, blendname.lastIndexOf("."))+"_"+valoption[frame_start_id]+"-"+valoption[frame_end_id]+ogl+".py";
    } else if (!fromblend[frame_id]) {
      settingsname = blendname.substring(0, blendname.lastIndexOf("."))+"_f"+valoption[frame_id]+ogl+".py";
    } else {
      settingsname = blendname.substring(0, blendname.lastIndexOf("."))+ogl+".py";
    }
  }
}

void terminalSelect(File selection) 
{
  if (selection != null) {
    terminalpath = selection.getAbsolutePath();
    terminalfolder = new File(terminalpath);

    if (os == "WINDOWS") {
      write = createWriter(dataPath("")+File.separator+"/tmp/cmd.bat");
      write.println("start ");
      write.print(terminalpath);
      write.flush();
      write.close();
    }
    info = "*Test it with '-Open<' bottom.";
    redraw();
  }
}

void texteditorSelect(File selection) 
{
  if (selection != null) {
    texteditorpath = selection.getAbsolutePath();
    texteditorfolder = new File(texteditorpath);

    info = "*Test it with '-Open<' bottom.";
    redraw();
  }
}

void managerSelect(File selection) 
{
  if (selection != null) {
    managerpath = selection.getAbsolutePath();
    explorerfolder = new File(managerpath);

    info = "*Test it with '-Open<' bottom.";
    redraw();
  }
}

void settingsSave(File selection) 
{
  if (selection != null) {
    settingspath = selection.getAbsolutePath();
    if ((generatepy && settingspath.endsWith(".py")) || (!generatepy && settingspath.endsWith(".txt")) ) {
      settingsfolder = new File(settingspath);
      settingsname = selection.getName();

      commandLineOptions();

      if (generatepy) {
        py_Save(settingspath);
        if (os == "WINDOWS") {
          bat_command_Line_Save(settingspath.substring(0, settingspath.lastIndexOf("."))+".py.bat");
          if (startrenders) {
            String cmd[]= {terminalpath, "/c", "start", "/w", settingspath.substring(0, settingspath.lastIndexOf("."))+".py.bat"};
            exec(cmd);
          }
        } else {
          sh_command_Line_Save(settingspath.substring(0, settingspath.lastIndexOf("."))+".py.sh");
          if (startrenders) {
            String cmd[] = {terminalpath, "-e", settingspath.substring(0, settingspath.lastIndexOf("."))+".py.sh"};
            exec(cmd);
          }
        }
      } else {
        Command_Line_Save(settingspath);
        if (os == "WINDOWS") {
          bat_command_Line_Save(settingspath.substring(0, settingspath.lastIndexOf("."))+".txt.bat");
          if (startrenders) {
            String cmd[]= {terminalpath, "/c", "start", "/w", settingspath.substring(0, settingspath.lastIndexOf("."))+".txt.bat"};
            exec(cmd);
          }
        } else {
          sh_command_Line_Save(settingspath.substring(0, settingspath.lastIndexOf("."))+".txt.sh");
          if (startrenders) {
            String cmd[] = {terminalpath, "-e", settingspath.substring(0, settingspath.lastIndexOf("."))+".txt.sh"};
            exec(cmd);
          }
        }
      }
      
      startrenders = false;
      
    } else {
      error = true;
      if (generatepy) info = "*Warning No '.py' selected";
      else info = "*Warning No '.txt' selected";
    }
    redraw();
  }
}

void settingsRename(File selection) 
{
  if (selection != null) {
    String newFile = selection.getAbsolutePath();

    File originalname = new File(settingspath);
    File newname = new File(newFile);

    settingsfolder = newname;
    settingspath = newFile;
    settingsname = selection.getName();
    originalname.renameTo(newname);

    if (generatepy) {
      String lines[] = loadStrings(settingspath);
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].contains(" -b ")) {
          commandLineOptions();
          lines[i] =  Command_Line;
        }
      }
      saveStrings(newname, lines);
    }
  }
  redraw();
}

void blenderSelect(File selection) 
{
  if (selection != null) {
    blenderpath = selection.getAbsolutePath();
    blenderfolder = new File(blenderpath);

    if (blenderpath.endsWith("blender") || blenderpath.endsWith("Blender") || blenderpath.endsWith("blender.exe") || blenderpath.endsWith("Blender.exe")) {
      info = "*You can test it with '-Open<' bottom.";
    } else {
      error = true;
      info = "*Warning No blender executable selected.";
    }
    redraw();
  }
}

void blendSelect(File selection) 
{
  if (selection != null) {
    blendpath = selection.getAbsolutePath();
    blendfolder = new File(blendpath);
    blendpath = blendpath.substring(0, blendpath.lastIndexOf(File.separator)+1);  
    settingspath = blendpath;
    settingsfolder = new File(blendpath);

    blendname = selection.getName();

    rendersname = blendname.substring(0, blendname.lastIndexOf("."))+"_####";
    outputpath = blendpath+blendname.substring(0, blendname.lastIndexOf("."))+"_Renders"+File.separator;

    if (blendname.endsWith(".blend")) {
      info = "*You can test it with '-Open<' bottom.";
    } else {
      error = true;
      info = "***Warning No .blend selected.";
    }
    redraw();
  }
}

void newOutputSelect(File selection) 
{
  if (selection != null) {
    outputpath = selection.getAbsolutePath();
    rendersname = selection.getName();
    outputfolder = new File(outputpath);
    outputpath = outputpath.substring(0, outputpath.lastIndexOf(File.separator)+1);

    info = "*You can test it with '-Open<' bottom.";
    redraw();
  }
}

void startRendersToPlaySelect(File selection) 
{
  if (selection != null) {
    startrender = selection.getAbsolutePath();
    playrendersfolder = new File(startrender);
    selectInput("Select END Render - Cancel to ALL", "endRendersToPlaySelect", playrendersfolder);
  }
}
void endRendersToPlaySelect(File selection) 
{
  if (selection != null) {
    endrender = selection.getAbsolutePath();
    if (os == "WINDOWS") {
      write = createWriter(dataPath("")+File.separator+"tmp"+File.separator+"playrenders.bat");
      write.print("call ");
      write.print('"'+blenderpath+'"'+" -a -s "+'"'+startrender+'"'+" -e "+'"'+endrender+'"');
      write.flush();
      write.close();
      exec(dataPath("")+File.separator+"tmp"+File.separator+"playrenders.bat");
    } else {
      String cmd[] = {terminalpath, "-e", blenderpath+" -a -s "+startrender+" -e "+endrender};
      exec(cmd);
    }
  } else {
    if (os == "WINDOWS") {
      write = createWriter(dataPath("")+File.separator+"tmp"+File.separator+"playrenders.bat");
      write.print("call ");
      write.print('"'+blenderpath+'"'+" -a "+'"'+startrender+'"');
      write.flush();
      write.close();
      exec(dataPath("")+File.separator+"tmp"+File.separator+"playrenders.bat");
    } else {
      String cmd[] = {terminalpath, "-e", blenderpath+" -a "+startrender};
      exec(cmd);
    }
  }
}

void rangeFix() 
{
  valoption[pxX_id] = str(constrain(int(valoption[pxX_id]), 100, 65536));
  valoption[pxY_id] = str(constrain(int(valoption[pxY_id]), 100, 65536));
  valoption[percentage_id] = str(constrain(int(valoption[percentage_id]), 1, 500));
  if (valoption[anti_aliasing_id] == "True") {
    if (int(valoption[anti_aliasing_samples_id]) <= 5) valoption[anti_aliasing_samples_id] = "5";
    else if (int(valoption[anti_aliasing_samples_id]) > 5 && int(valoption[anti_aliasing_samples_id]) <= 8) valoption[anti_aliasing_samples_id] = "8";
    else if (int(valoption[anti_aliasing_samples_id]) > 8 && int(valoption[anti_aliasing_samples_id]) <= 11) valoption[anti_aliasing_samples_id] = "11";
    else if (int(valoption[anti_aliasing_samples_id]) > 11) valoption[anti_aliasing_samples_id] = "16";
  }
  valoption[tile_x_id] = str(constrain(int(valoption[tile_x_id]), 8, 65536));
  valoption[tile_y_id] = str(constrain(int(valoption[tile_y_id]), 8, 65536));
  if (valoption[threads_mode_id] == "AUTO") valoption[threads_id] = "0";
  else valoption[threads_id] = str(constrain(int(valoption[threads_id]), 1, 64));
  valoption[engine_cyclessamples_val_id] = str(constrain(int(valoption[engine_cyclessamples_val_id]), 1, 999999999));

  compresion = str(constrain(int(compresion), 0, 100));
  quality = str(constrain(int(quality), 0, 100));

  if (valoption[file_format_id] == "OPEN_EXR" || valoption[file_format_id] == "OPEN_EXR_MULTILAYER")
    if (depth != "16" || openexcompresion != "32") depth = "32";

  if (valoption[file_format_id] == "BMP" || valoption[file_format_id] == "JPEG" || valoption[file_format_id] == "CINEON")
    if (rgbmode == "RGBA") rgbmode = "RGB";

  valoption[dither_id] = str(constrain(float(valoption[dither_id]), 0, 2));

  valoption[frame_start_id] = str(constrain(int(valoption[frame_start_id]), 0, 300000));
  valoption[frame_end_id] = str(constrain(int(valoption[frame_end_id]), 0, 300000));
  valoption[frame_step_id] = str(constrain(int(valoption[frame_step_id]), 1, 100));
}

void changeforblend() 
{
  boolean allfromblend = true;
  write.println("Render options to change:");
  write.println();
  for (int i = 0; i < fromblend.length; i++) {
    if (!fromblend[i]) {
      if (generatepy) {
        if (i == pxX_id
          || i == pxY_id 
          || i == percentage_id 
          || i == anti_aliasing_id 
          || i == tile_x_id 
          || i == tile_y_id 
          || i == threads_mode_id 
          || i == engine_id 
          || i == threads_mode_id 
          || i == engine_id 
          || i == scene_name_id 
          || i == placeholder_id
          || i == overwrite_renders_id
          || i == render_cache_id
          || i == add_extension_id
          || i == file_format_id
          || i == output_path_id
          || i == stamp_id
          || i == frame_start_id
          || i == frame_end_id
          || i == frame_step_id
          || i == frame_id
          || i == dither_id
          || i == compositing_id
          || i == sequencer_id
          ) {
          allfromblend = false;
          write.println("- "+nameoption[i]);
        }
      } else {
        if (i == threads_mode_id 
          || i == scene_name_id 
          || i == engine_id 
          || i == add_extension_id
          || i == file_format_id
          || i == frame_start_id
          || i == frame_end_id
          || i == frame_step_id
          || i == frame_id
          || i == output_path_id
          ) {
          allfromblend = false;
          write.println("- "+nameoption[i]);
        }
      }
    }
  }
  if (allfromblend) write.println("- All render options from "+blendname);
  else  write.println("- Others from "+blendname);
}

void mouseEventsCommandLine ()
{
  if (!selectcolor) {
    if (terminal_path_()) selectInput("Select Terminal executable:", "terminalSelect", terminalfolder);
    if (terminal_open_()) {
      info = "*Opening...";
      if (os == "WINDOWS") {
        write = createWriter(dataPath("")+File.separator+"tmp"+File.separator+"cmd.bat");
        write.println("start ");
        write.print(terminalpath);
        write.flush();
        write.close();

        exec(dataPath("")+File.separator+"tmp"+File.separator+"cmd.bat");
      } else exec(terminalpath);
    }
    if (text_editor_path_()) selectInput("Select Text editor executable:", "texteditorSelect", texteditorfolder);
    if (text_editor_open_()) {
      info = "*Opening...";
      if (os == "WINDOWS") exec(texteditorpath);
      else {
        String cmd[] = {terminalpath, "-e", texteditorpath};
        exec(cmd);
      }
    }
    if (file_manager_path_()) selectInput("Select File Manager executable:", "managerSelect", explorerfolder);
    if (file_manager_open_()) {
      info = "*Opening...";
      exec(managerpath);
    }
    if (settings_path_open_()) {
      info = "*Opening...";
      String cmd[] = {managerpath, settingspath.substring(0, settingspath.lastIndexOf(File.separator)+1)};
      exec(cmd);
    }
    if (blender_path_()) selectInput("Select Blender executable:", "blenderSelect", blenderfolder);
    if (blender_open_()) {
      info = "*Opening Blender...";
      exec(blenderpath);
    }
    if (blend_path_()) selectInput("Select your blend file:", "blendSelect", blendfolder);
    if (blend_open_()) {
      info = "*Opening "+blendname+" ...";
      String cmd[] = {blenderpath, blendpath+blendname};
      exec(cmd);
    } 
    if (blend_open_folder_()) {
      info = "*Opening...";
      String cmd[] = {managerpath, blendpath};
      exec(cmd);
    }
    if (new_output_path_()) {
      if (newoutput)  selectOutput("Select render path and image name:", "newOutputSelect", outputfolder);
      else info = "*No 'New Output' selected.";
    }
    if (new_output_open_()) {
      if (fromblend[output_path_id]) {
        info = "*path from: '"+blendname;
      } else {
        info = "*Opening Renders Output...";
        String cmd[] = {managerpath, outputpath};
        exec(cmd);
      }
    }
    if (output_play_()) {
      selectInput("Select START Render:", "startRendersToPlaySelect", playrendersfolder);
      info = "*Playing renders...";
    }
    if (add_to_multi_()) {
      gui = 2;
    }
    if (save_settings_()) {
      if  (!fromblend[frame_id] && generatepy && (valoption[frame_id].contains(".") || valoption[frame_id].contains(",") || valoption[frame_id].contains("+") || valoption[frame_id].contains("-") || valoption[frame_id] == "")) {
        error = true;
        info = "*Error in "+nameoption[frame_id];
      } else {
        settingsName();
        settingsfolder = new File(settingspath.substring(0, settingspath.lastIndexOf(File.separator)+1)+settingsname);
        selectOutput("Settings to write to:", "settingsSave", settingsfolder);
      }
    } 
    if (rename_settings_()) {
      settingsName();
      settingsfolder = new File(settingspath.substring(0, settingspath.lastIndexOf(File.separator)+1)+settingsname);
      selectOutput("Move and/or Rename: "+settingsname+" -Save changes-", "settingsRename", settingsfolder);
    }

    if (in_ogl_()) {
      if (generatepy) {
        valoption[renders_name_id] = "OGL"+valoption[renders_name_id];
        if (valoption[engine_id] == "BLENDER_RENDER" || valoption[engine_id] == "CYCLES") oglrenders = !oglrenders;
      }
    }
    if (go_()) {
      startrenders = true;
      settingsName();
      settingsfolder = new File(settingspath.substring(0, settingspath.lastIndexOf(File.separator)+1)+settingsname);
      selectOutput("Settings to write to:", "settingsSave", settingsfolder);
    }
    if (settingsOpen_()) selectInput("Select your .py or commandline file", "settingsOpen", settingsfolder);
    if (settingsReload_()) {
      if (settingsname.endsWith(".py")) loadPy(settingspath);
      else loadCommandline(settingspath);
      info = "'"+settingsname+ "' Reloaded...";
    }
    if (settingsEdit_()) {
      if (os == "WINDOWS") exec(texteditorpath, settingspath);
      else {
        String cmd[] = {terminalpath, "-e", texteditorpath, settingspath};
        exec(cmd);
      }
    }

    if (savelogs_()) savelogs = !savelogs;

    if (generatepy) {
      if (pxX_()) {
        fromblend[pxX_id] = !fromblend[pxX_id];
        if (!fromblend[pxX_id]) {
          fromblend[pxY_id] = false;
          fromblend[percentage_id] = false;
        } else {
          fromblend[pxY_id] = true;
          fromblend[percentage_id] = true;
        }
      }
      if (pxY_()) {
        fromblend[pxY_id] = !fromblend[pxY_id];
        if (!fromblend[pxY_id]) {
          fromblend[pxX_id] = false;
          fromblend[percentage_id] = false;
        } else {
          fromblend[pxX_id] = true;
          fromblend[percentage_id] = true;
        }
      }
      if (percentage_()) fromblend[percentage_id] = !fromblend[percentage_id];
      if (valoption[engine_id] == "BLENDER_RENDER") {
        if (anti_aliasing_())  fromblend[anti_aliasing_id] = !fromblend[anti_aliasing_id];
      }
      if (tile_x_()) fromblend[tile_x_id] = !fromblend[tile_x_id];
      if (tile_y_()) fromblend[tile_y_id] = !fromblend[tile_y_id];

      if (placeholder_()) fromblend[placeholder_id] = !fromblend[placeholder_id];
      if (overwrite_renders_()) fromblend[overwrite_renders_id] = !fromblend[overwrite_renders_id];
      if (render_cache_()) fromblend[render_cache_id] = !fromblend[render_cache_id];

      if (stamp_()) {
        fromblend[stamp_id] = !fromblend[stamp_id];
        fromblend[use_stamp_textsize_id] = !fromblend[use_stamp_textsize_id];
        fromblend[stamp_background_id] = !fromblend[stamp_background_id];
        fromblend[stamp_foreground_id] = !fromblend[stamp_foreground_id];
        fromblend[use_stamp_dlabels_id] = !fromblend[use_stamp_dlabels_id];
        fromblend[use_stamp_time_id] = !fromblend[use_stamp_time_id];
        fromblend[use_stamp_camera_id] = !fromblend[use_stamp_camera_id];
        fromblend[use_stamp_memory_id] = !fromblend[use_stamp_memory_id];
        fromblend[use_stamp_date_id] = !fromblend[use_stamp_date_id];
        fromblend[use_stamp_lens_id] = !fromblend[use_stamp_lens_id];
        fromblend[use_stamp_render_time_id] = !fromblend[use_stamp_render_time_id];
        fromblend[use_stamp_filename_id] = !fromblend[use_stamp_filename_id];
        fromblend[use_stamp_frame_id] = !fromblend[use_stamp_frame_id];
        fromblend[use_stamp_marker_id] = !fromblend[use_stamp_marker_id];
        fromblend[use_stamp_scene_id] = !fromblend[use_stamp_scene_id];
        fromblend[use_stamp_sequencer_strip_id] = !fromblend[use_stamp_sequencer_strip_id];
        fromblend[stamp_note_id] = !fromblend[stamp_note_id];
        fromblend[stamp_note_text_id] = !fromblend[stamp_note_text_id];
        fromblend[use_stamp_strip_meta_id] = !fromblend[use_stamp_strip_meta_id];
      }
      if (dither_()) {
        fromblend[dither_id] = !fromblend[dither_id];
      }
      if (compositing_()) {
        fromblend[compositing_id] = !fromblend[compositing_id];
      }
      if (compositing_val()) {
        if (valoption[compositing_id] == "True") {
          valoption[compositing_id] = "False";
        } else valoption[compositing_id] = "True";
      }
      if (sequencer_()) {
        fromblend[sequencer_id] = !fromblend[sequencer_id];
      }
      if (sequencer_val()) {
        if (valoption[sequencer_id] == "True") {
          valoption[sequencer_id] = "False";
        } else valoption[sequencer_id] = "True";
      }
    }

    if (threads_()) fromblend[threads_mode_id] = !fromblend[threads_mode_id];
    if (engine_()) fromblend[engine_id] = !fromblend[engine_id];

    if (scene_name_()) fromblend[scene_name_id] = !fromblend[scene_name_id];
    if (add_extension_()) fromblend[add_extension_id] = !fromblend[add_extension_id];
    if (file_format_()) fromblend[file_format_id] = !fromblend[file_format_id];

    if (frame_start_()) {
      fromblend[animation_id] = !fromblend[animation_id];
      fromblend[frame_start_id] = !fromblend[frame_start_id];
      fromblend[frame_end_id] = !fromblend[frame_end_id];
      fromblend[frame_step_id] = !fromblend[frame_step_id];
    }
    if (frame_end_()) {
      fromblend[animation_id] = !fromblend[animation_id];
      fromblend[frame_start_id] = !fromblend[frame_start_id];
      fromblend[frame_end_id] = !fromblend[frame_end_id];
      fromblend[frame_step_id] = !fromblend[frame_step_id];
    }
    if (frame_step_()) {
      fromblend[animation_id] = !fromblend[animation_id];
      fromblend[frame_start_id] = !fromblend[frame_start_id];
      fromblend[frame_end_id] = !fromblend[frame_end_id];
      fromblend[frame_step_id] = !fromblend[frame_step_id];
    }
    if (animation_()) {
      fromblend[animation_id] = !fromblend[animation_id];
      fromblend[frame_start_id] = !fromblend[frame_start_id];
      fromblend[frame_end_id] = !fromblend[frame_end_id];
      fromblend[frame_step_id] = !fromblend[frame_step_id];
      if (!fromblend[animation_id]) fromblend[frame_id] =  true;
    }

    if (frame_()) {
      fromblend[frame_id] = !fromblend[frame_id];
      if (!fromblend[frame_id]) {
        fromblend[animation_id] = true;
        fromblend[frame_start_id] = true;
        fromblend[frame_end_id] = true;
        fromblend[frame_step_id] = true;
      }
    }

    if (generate_py_()) {
      generatepy = !generatepy;
      settingsName();
      settingsfolder = new File(settingspath.substring(0, settingspath.lastIndexOf(File.separator)+1)+settingsname);
    }

    if (new_output_()) {
      rendersname = blendname.substring(0, blendname.lastIndexOf("."))+"_####";
      newoutput = !newoutput;
      if (newoutput) fromblend[output_path_id] = false;
      else  fromblend[output_path_id] = true;
    }

    rangeFix();
    for (int i = 0; i <  selectoption.length; i++) selectoption[i] = false;

    if (pxX_val()) {
      if (!fromblend[pxX_id]) {
        esc = valoption[pxX_id];
        selectoption[pxX_id] = true;
        valoption[pxX_id] = "";
      }
    }
    if (pxY_val()) {
      if (!fromblend[pxY_id]) {
        esc = valoption[pxY_id];
        selectoption[pxY_id] = true;
        valoption[pxY_id] = "";
      }
    } 
    if (percentage_val()) {  
      if (!fromblend[percentage_id]) {
        esc = valoption[percentage_id];
        selectoption[percentage_id] = true;
        valoption[percentage_id] = "";
      }
    } 
    if (valoption[engine_id] == "BLENDER_RENDER") {
      if (use_anti_aliasing_()) {      
        if (!fromblend[anti_aliasing_id]) {
          esc = valoption[anti_aliasing_id];
          selectoption[anti_aliasing_id] = true;
          if (valoption[anti_aliasing_id] == "True") valoption[anti_aliasing_id] = "False";
          else valoption[anti_aliasing_id] = "True";
        }
      }
      if (anti_aliasing_val()) {      
        if (!fromblend[anti_aliasing_id]) {
          esc = valoption[anti_aliasing_samples_id];
          selectoption[anti_aliasing_samples_id] = true;
          valoption[anti_aliasing_samples_id] = "";
        }
      }
      if (anti_aliasing_fullsample_val()) {      
        if (!fromblend[anti_aliasing_id]) {
          esc = valoption[anti_aliasing_fullsamples_id];
          if (valoption[anti_aliasing_fullsamples_id] == "True") valoption[anti_aliasing_fullsamples_id] = "False";
          else valoption[anti_aliasing_fullsamples_id] = "True";
        }
      }
    }
    if (tile_x_val()) {      
      if (!fromblend[tile_x_id]) {
        esc = valoption[tile_x_id];
        selectoption[tile_x_id] = true;
        valoption[tile_x_id] = "";
      }
    }
    if (tile_y_val()) {      
      if (!fromblend[tile_y_id]) {
        esc = valoption[tile_y_id];
        selectoption[tile_y_id] = true;
        valoption[tile_y_id] = "";
      }
    }
    if (threads_mode_()) {       
      if (!fromblend[threads_mode_id]) {
        esc = valoption[threads_mode_id];
        selectoption[threads_mode_id] = true;
        if (valoption[threads_mode_id] == "AUTO") {
          valoption[threads_mode_id] = "FIXED";
        } else {
          valoption[threads_mode_id] = "AUTO";
        }
      }
    }
    if (threads_val()) {       
      if (!fromblend[threads_mode_id]) {
        if (valoption[threads_mode_id] == "FIXED") {
          selectoption[threads_id] = true;
          esc = valoption[threads_id];
          valoption[threads_id] = "";
        }
      }
    }
    if (engine_val()) {      
      if (!fromblend[engine_id]) {
        esc = valoption[engine_id];
        val = val + 1;
        if (val > 3) val = 0;
        valoption[engine_id] = engines[val];
      }
      if (valoption[engine_id] == "BLENDER_EEVEE" || valoption[engine_id] == "BLENDER_CLAY") {
        oglrenders = true;
        error = true;
        info = "*Only Blender 2.80";
      }
    }
    if (engine_cyclessamples_()) { 
      if (!fromblend[engine_id]) {
        esc = valoption[engine_cyclessamples_id];
        if (valoption[engine_cyclessamples_id] == "True") valoption[engine_cyclessamples_id] = "False";
        else valoption[engine_cyclessamples_id] = "True";
      }
    }
    if (engine_cyclessamples_val()) { 
      selectoption[engine_cyclessamples_val_id] = true;
      if (!fromblend[engine_id]) {
        if (valoption[engine_cyclessamples_id] == "True") {
          esc = valoption[engine_cyclessamples_val_id];
          valoption[engine_cyclessamples_val_id] = "";
        }
      }
    }

    if (scene_name_val()) {       
      if (!fromblend[scene_name_id]) { 
        esc = valoption[scene_name_id];
        selectoption[scene_name_id] = true;
      }
    }
    if (placeholder_val()) {      
      if (!fromblend[placeholder_id]) {
        esc = valoption[placeholder_id];
        selectoption[placeholder_id] = true;
        if (valoption[placeholder_id] == "True") valoption[placeholder_id] = "False";
        else valoption[placeholder_id] = "True";
      }
    }
    if (overwrite_renders_val()) {       
      if (!fromblend[overwrite_renders_id]) {
        esc = valoption[overwrite_renders_id];
        selectoption[overwrite_renders_id] = true;
        if (valoption[overwrite_renders_id] == "True") valoption[overwrite_renders_id] = "False";
        else valoption[overwrite_renders_id] = "True";
      }
    }
    if (render_cache_val()) {      
      if (!fromblend[render_cache_id]) {
        esc = valoption[render_cache_id];
        selectoption[render_cache_id] = true;
        if (valoption[render_cache_id] == "True") valoption[render_cache_id] = "False";
        else valoption[render_cache_id] = "True";
      }
    }
    if (add_extension_val()) {      
      if (!fromblend[add_extension_id]) {
        esc = valoption[add_extension_id];
        selectoption[add_extension_id] = true;
        if (valoption[add_extension_id] == "True") valoption[add_extension_id] = "False";
        else valoption[add_extension_id] = "True";
      }
    }
    if (file_format_val()) { 
      if (!fromblend[file_format_id]) {
        esc = valoption[file_format_id];
        selectoption[file_format_id] = true;
        val = val + 1;
        if (val > 12) val = 0;
        valoption[file_format_id] = fileformat[val];
      }
    }
    if (!fromblend[file_format_id]) {
      if (rgb_mode_()) { 
        if (valoption[file_format_id] == "PNG") {
          val = val + 1;
          if (val > 2) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "JPEG") {
          val = val + 1;
          if (val > 1) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "TARGA") {
          val = val + 1;
          if (val > 2) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "TARGA_RAW") {
          val = val + 1;
          if (val > 2) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "TIFF") {
          val = val + 1;
          if (val > 2) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "IRIS") {
          val = val + 1;
          if (val > 2) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "BMP") {
          val = val + 1;
          if (val > 1) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "JPEG2000") {
          val = val + 1;
          if (val > 2) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "OPEN_EXR") {
          val = val + 1;
          if (val > 2) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "OPEN_EXR_MULTILAYER") {
          val = val + 1;
          if (val > 2) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "CINEON") {
          val = val + 1;
          if (val > 1) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "DPX") {
          val = val + 1;
          if (val > 2) val = 0;
          rgbmode = rgbmode_val[val];
        } else if (valoption[file_format_id] == "HDR") {
          val = val + 1;
          if (val > 2) val = 0;
          rgbmode = rgbmode_val[val];
        }
      }
      if (depth_()) { 
        if (valoption[file_format_id] == "PNG") {
          val = val + 3;
          if (val > 3) val = 0;
          depth = depth_val[val];
        } else if (valoption[file_format_id] == "TIFF") {
          val = val + 3;
          if (val > 3) val = 0;
          depth = depth_val[val];
        } else if (valoption[file_format_id] == "JPEG2000") {
          val = val + 1;
          if (val == 1) val = 2;
          if (val > 3) val = 0;
          depth = depth_val[val];
        } else if (valoption[file_format_id] == "OPEN_EXR") {
          val = val + 1;
          if (val == 0 || val == 1 || val == 2) val = 3;
          if (val > 4) val = 3;
          depth = depth_val[val];
        } else if (valoption[file_format_id] == "OPEN_EXR_MULTILAYER") {
          val = val + 1;
          if (val == 0 || val == 1 || val == 2) val = 3;
          if (val > 4) val = 3;
          depth = depth_val[val];
        } else if (valoption[file_format_id] == "DPX") {
          val = val + 1;
          if (val > 3) val = 0;
          depth = depth_val[val];
        }
      }
      if (compresion_()) {
        selectoption[compresion_id] = true;
        if (valoption[file_format_id] == "PNG") {
          esc = compresion;
          compresion = "";
        } else if (valoption[file_format_id] == "JPEG") {
          esc = compresion;
          compresion = "";
        } else if (valoption[file_format_id] == "OPEN_EXR") {
          val = val + 1;
          if (val > 7) val = 0;
          openexcompresion = openexrcodec[val];
        } else if (valoption[file_format_id] == "OPEN_EXR_MULTILAYER") {
          val = val + 1;
          if (val > 7) val = 0;
          openexcompresion = openexrcodec[val];
        } else if (valoption[file_format_id] == "TIFF") {
          val = val + 1;
          if (val > 3) val = 0;
          tiffcompresion = tiffcomp[val];
        } else if (valoption[file_format_id] == "JPEG2000") {
          esc = quality;
          quality = "";
        }
      }
      if (jpg2codec_()) {
        if (valoption[file_format_id] == "JPEG2000") {
          val = val + 1;
          if (val > 1) val = 0;
          jpg2codec = jpg2codec_val[val];
        }
        if (valoption[file_format_id] == "OPEN_EXR") {
          if (openexrpreview == "True") openexrpreview = "False";
          else openexrpreview = "True";
        }          
        if (valoption[file_format_id] == "DPX") {
          if (dpxlog == "True") dpxlog = "False";
          else dpxlog = "True";
        }
      }
      if (jpg2cinema_()) {
        if (valoption[file_format_id] == "JPEG2000") {
          if (jpg2cinema == "True") jpg2cinema = "False";
          else jpg2cinema = "True";
        }
      }
      if (jpg2cinema48_()) {
        if (valoption[file_format_id] == "JPEG2000") {
          if (jpg2cinema48 == "True") jpg2cinema48 = "False";
          else jpg2cinema48 = "True";
        }
        if (valoption[file_format_id] == "OPEN_EXR") {
          if (openexrzbuffer == "True") openexrzbuffer = "False";
          else openexrzbuffer = "True";
        }
      }
      if (jpg2ycc_()) {
        if (valoption[file_format_id] == "JPEG2000") {
          if (jpg2ycc == "True") jpg2ycc = "False";
          else jpg2ycc = "True";
        }
      }
    }

    if (stamp_var()) {       
      if (!fromblend[stamp_id]) {
        esc = valoption[stamp_id];
        selectoption[stamp_id] = true;
        if (valoption[stamp_id] == "True") valoption[stamp_id] = "False";
        else valoption[stamp_id] = "True";
      }
    }
    if (stamp_stripmeta_()) {       
      if (!fromblend[use_stamp_strip_meta_id]) {
        esc = valoption[use_stamp_strip_meta_id];
        selectoption[use_stamp_strip_meta_id] = true;
        if (valoption[use_stamp_strip_meta_id] == "True") valoption[use_stamp_strip_meta_id] = "False";
        else valoption[use_stamp_strip_meta_id] = "True";
      }
    }
    if (stamp_dlabels_()) {       
      if (!fromblend[use_stamp_dlabels_id]) {
        esc = valoption[use_stamp_dlabels_id];
        selectoption[use_stamp_dlabels_id] = true;
        if (valoption[use_stamp_dlabels_id] == "True") valoption[use_stamp_dlabels_id] = "False";
        else valoption[use_stamp_dlabels_id] = "True";
      }
    }
    if (stamp_time_()) {       
      if (!fromblend[use_stamp_time_id]) {
        esc = valoption[use_stamp_time_id];
        selectoption[use_stamp_time_id] = true;
        if (valoption[use_stamp_time_id] == "True") valoption[use_stamp_time_id] = "False";
        else valoption[use_stamp_time_id] = "True";
      }
    }
    if (stamp_camera_()) {       
      if (!fromblend[use_stamp_camera_id]) {
        esc = valoption[use_stamp_camera_id];
        selectoption[use_stamp_camera_id] = true;
        if (valoption[use_stamp_camera_id] == "True") valoption[use_stamp_camera_id] = "False";
        else valoption[use_stamp_camera_id] = "True";
      }
    }
    if (stamp_memory_()) {       
      if (!fromblend[use_stamp_memory_id]) {
        esc = valoption[use_stamp_memory_id];
        selectoption[use_stamp_memory_id] = true;
        if (valoption[use_stamp_memory_id] == "True") valoption[use_stamp_memory_id] = "False";
        else valoption[use_stamp_memory_id] = "True";
      }
    }
    if (stamp_date_()) {       
      if (!fromblend[use_stamp_date_id]) {
        esc = valoption[use_stamp_date_id];
        selectoption[use_stamp_date_id] = true;
        if (valoption[use_stamp_date_id] == "True") valoption[use_stamp_date_id] = "False";
        else valoption[use_stamp_date_id] = "True";
      }
    }
    if (stamp_lens_()) {       
      if (!fromblend[use_stamp_lens_id]) {
        esc = valoption[use_stamp_lens_id];
        selectoption[use_stamp_lens_id] = true;
        if (valoption[use_stamp_lens_id] == "True") valoption[use_stamp_lens_id] = "False";
        else valoption[use_stamp_lens_id] = "True";
      }
    }
    if (stamp_rendertime_()) {       
      if (!fromblend[use_stamp_render_time_id]) {
        esc = valoption[use_stamp_render_time_id];
        selectoption[use_stamp_render_time_id] = true;
        if (valoption[use_stamp_render_time_id] == "True") valoption[use_stamp_render_time_id] = "False";
        else valoption[use_stamp_render_time_id] = "True";
      }
    }
    if (stamp_filename_()) {       
      if (!fromblend[use_stamp_filename_id]) {
        esc = valoption[use_stamp_filename_id];
        selectoption[use_stamp_filename_id] = true;
        if (valoption[use_stamp_filename_id] == "True") valoption[use_stamp_filename_id] = "False";
        else valoption[use_stamp_filename_id] = "True";
      }
    }
    if (stamp_frame_()) {       
      if (!fromblend[use_stamp_frame_id]) {
        esc = valoption[use_stamp_frame_id];
        selectoption[use_stamp_frame_id] = true;
        if (valoption[use_stamp_frame_id] == "True") valoption[use_stamp_frame_id] = "False";
        else valoption[use_stamp_frame_id] = "True";
      }
    }
    if (stamp_marker_()) {       
      if (!fromblend[use_stamp_marker_id]) {
        esc = valoption[use_stamp_marker_id];
        selectoption[use_stamp_marker_id] = true;
        if (valoption[use_stamp_marker_id] == "True") valoption[use_stamp_marker_id] = "False";
        else valoption[use_stamp_marker_id] = "True";
      }
    }
    if (stamp_scene_()) {       
      if (!fromblend[use_stamp_scene_id]) {
        esc = valoption[use_stamp_scene_id];
        selectoption[use_stamp_scene_id] = true;
        if (valoption[use_stamp_scene_id] == "True") valoption[use_stamp_scene_id] = "False";
        else valoption[use_stamp_scene_id] = "True";
      }
    }
    if (stamp_seqstrip_()) {       
      if (!fromblend[use_stamp_sequencer_strip_id]) {
        esc = valoption[use_stamp_sequencer_strip_id];
        selectoption[use_stamp_sequencer_strip_id] = true;
        if (valoption[use_stamp_sequencer_strip_id] == "True") valoption[use_stamp_sequencer_strip_id] = "False";
        else valoption[use_stamp_sequencer_strip_id] = "True";
      }
    }
    if (stamp_stampnote_()) {       
      if (!fromblend[stamp_note_id]) {
        esc = valoption[stamp_note_id];
        selectoption[stamp_note_id] = true;
        if (valoption[stamp_note_id] == "True") valoption[stamp_note_id] = "False";
        else valoption[stamp_note_id] = "True";
      }
    }
    if (stamp_stampnote_val()) {       
      if (!fromblend[stamp_note_id]) {
        esc = valoption[stamp_note_text_id];
        selectoption[stamp_note_text_id] = true;
        valoption[stamp_note_text_id] = "";
      }
    }

    if (frame_start_var()) {      
      if (!fromblend[frame_start_id]) {
        esc = valoption[frame_start_id];
        selectoption[frame_start_id] = true;
        valoption[frame_start_id] = "";
      }
    }
    if (frame_end_var()) {        
      if (!fromblend[frame_end_id]) {
        esc = valoption[frame_end_id];
        selectoption[frame_end_id] = true;
        valoption[frame_end_id] = "";
      }
    }
    if (frame_step_var()) {        
      if (!fromblend[frame_step_id]) {
        esc = valoption[frame_step_id];
        selectoption[frame_step_id] = true;
        valoption[frame_step_id] = "";
      }
    }
    if (animation_()) { 
      if (!fromblend[animation_id]) {
        esc = valoption[animation_id];
        selectoption[animation_id] = true;
      }
    }
    if (frame_var()) {      
      if (!fromblend[frame_id]) {
        esc = valoption[frame_id];
        selectoption[frame_id] = true;
      }
    }
    if (renders_name_()) {  
      if (newoutput)  selectOutput("Select a new name or path for renders:", "newOutputSelect", outputfolder);
      else info = "*No 'New Output' selected.";
    }
    if (dither_val()) {
      esc = valoption[dither_id];
      selectoption[dither_id] = true;
      valoption[dither_id] = "0";
    }
  }

  if (selectcolor) {
    if (select_color_val()) {
      String r;
      String g;
      String b;
      String a;
      int col = constrain(floor(map(mouseY, 105, 145, 0, 4)), 0, 4);
      int val = constrain(floor(map(mouseX, 50, 564, 0, 255)), 0, 255);
      if (fgcolor) {
        fgrgba[col] = val;
        r = str(map(fgrgba[0], 0, 255, 0, 1));
        g = str(map(fgrgba[1], 0, 255, 0, 1));
        b = str(map(fgrgba[2], 0, 255, 0, 1));
        a = str(map(fgrgba[3], 0, 255, 0, 1));
        valoption[stamp_foreground_id] = "("+r+","+g+","+b+","+a+")";
      } else if (bgcolor) {
        bgrgba[col] = val;
        r = str(map(bgrgba[0], 0, 255, 0, 1));
        g = str(map(bgrgba[1], 0, 255, 0, 1));
        b = str(map(bgrgba[2], 0, 255, 0, 1));
        a = str(map(bgrgba[3], 0, 255, 0, 1));
        valoption[stamp_background_id] = "("+r+","+g+","+b+","+a+")";
      }
    }
    if (!select_color_()) {
      selectcolor = false;
      fgcolor = false;
      bgcolor = false;
    }
  }
  if (stamp_fg_()) {      
    if (!fromblend[stamp_id]) {
      selectcolor = true;
      fgcolor = true;
      selectoption[stamp_foreground_id] = true;
    }
  }
  if (stamp_bg_()) {      
    if (!fromblend[stamp_id]) {
      selectcolor = true;
      bgcolor = true;
      selectoption[stamp_background_id] = true;
    }
  }
  if (ssh_()) ssh = !ssh;
  if (ssh_user_()) {
    selectoption[sshuser_id] = true;
    sshuser = "";
  }
  if (ssh_ip_()) {
    selectoption[sship_id] = true;
    sship = "";
  }
}

void keyEventsCommandLine (String keypress)
{
  if (keypress == "number") {
    if (selectoption[pxX_id]) if (valoption[pxX_id].length() < 5) valoption[pxX_id] += key;
    if (selectoption[pxY_id]) if (valoption[pxY_id].length() < 5) valoption[pxY_id] += key;
    if (selectoption[percentage_id]) if (valoption[percentage_id].length() < 3) valoption[percentage_id] += key;
    if (selectoption[anti_aliasing_samples_id] && valoption[anti_aliasing_id] == "True") if (valoption[anti_aliasing_samples_id].length() < 2) valoption[anti_aliasing_samples_id] += key;
    if (selectoption[tile_x_id]) if (valoption[tile_x_id].length() < 5) valoption[tile_x_id] += key;
    if (selectoption[tile_y_id]) if (valoption[tile_y_id].length() < 5) valoption[tile_y_id] += key;
    if (selectoption[threads_id]) if (valoption[threads_id].length() < 2) valoption[threads_id] += key;
    if (selectoption[engine_cyclessamples_val_id]) if (valoption[engine_cyclessamples_val_id].length() < 9) valoption[engine_cyclessamples_val_id] += key;

    if (selectoption[compresion_id]) {
      if (valoption[file_format_id] == "PNG") {
        if (compresion.length() < 3) compresion += key;
      } else if (valoption[file_format_id] == "JPEG") {
        if (quality.length() < 3) quality += key;
      } else if (valoption[file_format_id] == "JPEG2000") {
        if (quality.length() < 3) quality += key;
      }
    }

    if (selectoption[dither_id]) if (valoption[dither_id].length() < 5) valoption[dither_id] += key;

    if (selectoption[frame_start_id]) if (valoption[frame_start_id].length() < 6) valoption[frame_start_id] += key;
    if (selectoption[frame_end_id]) if (valoption[frame_end_id].length() < 6) valoption[frame_end_id] += key;
    if (selectoption[frame_step_id]) if (valoption[frame_step_id].length() < 3) valoption[frame_step_id] += key;

    if (selectoption[frame_id]) {
      if (valoption[frame_id].length() < 100) valoption[frame_id] += key;
    }
  } else if (keypress == "BACKSPACE") {
    if (selectoption[pxX_id]) if (valoption[pxX_id].length() > 0) valoption[pxX_id] = valoption[pxX_id].substring(0, valoption[pxX_id].length() - 1);
    if (selectoption[pxY_id]) if (valoption[pxY_id].length() > 0) valoption[pxY_id] = valoption[pxY_id].substring(0, valoption[pxY_id].length() - 1);
    if (selectoption[percentage_id]) if (valoption[percentage_id].length() > 0) valoption[percentage_id] = valoption[percentage_id].substring(0, valoption[percentage_id].length() - 1);
    if (selectoption[anti_aliasing_samples_id]) if (valoption[anti_aliasing_samples_id].length() > 0) valoption[anti_aliasing_samples_id] = valoption[anti_aliasing_samples_id].substring(0, valoption[anti_aliasing_samples_id].length() - 1);
    if (selectoption[tile_x_id]) if (valoption[tile_x_id].length() > 0) valoption[tile_x_id] = valoption[tile_x_id].substring(0, valoption[tile_x_id].length() - 1);
    if (selectoption[tile_y_id]) if (valoption[tile_y_id].length() > 0) valoption[tile_y_id] = valoption[tile_y_id].substring(0, valoption[tile_y_id].length() - 1);
    if (selectoption[threads_id]) if (valoption[threads_id].length() > 0) valoption[threads_id] = valoption[threads_id].substring(0, valoption[threads_id].length() - 1);
    if (selectoption[engine_cyclessamples_val_id]) if (valoption[engine_cyclessamples_val_id].length() > 0) valoption[engine_cyclessamples_val_id] = valoption[engine_cyclessamples_val_id].substring(0, valoption[engine_cyclessamples_val_id].length() - 1);

    if (selectoption[file_format_id]) {
      if (valoption[file_format_id] == "PNG") {
        if (compresion.length() > 0) compresion = compresion.substring(0, compresion.length() - 1);
      } else if (valoption[file_format_id] == "JPEG") {
        if (quality.length() > 0) quality = quality.substring(0, quality.length() - 1);
      } else if (valoption[file_format_id] == "JPEG2000") {
        if (quality.length() > 0) quality = quality.substring(0, quality.length() - 1);
      }
    }

    if (selectoption[dither_id]) if (valoption[dither_id].length() > 0) valoption[dither_id] = valoption[dither_id].substring(0, valoption[dither_id].length() - 1);

    if (selectoption[scene_name_id]) if (scenename.length() > 0) scenename = scenename.substring(0, scenename.length() - 1);

    if (selectoption[stamp_note_text_id]) if (valoption[stamp_note_text_id].length() > 0) valoption[stamp_note_text_id] = valoption[stamp_note_text_id].substring(0, valoption[stamp_note_text_id].length() - 1);

    if (selectoption[frame_start_id]) if (valoption[frame_start_id].length() > 0) valoption[frame_start_id] = valoption[frame_start_id].substring(0, valoption[frame_start_id].length() - 1);
    if (selectoption[frame_end_id]) if (valoption[frame_end_id].length() > 0) valoption[frame_end_id] = valoption[frame_end_id].substring(0, valoption[frame_end_id].length() - 1);
    if (selectoption[frame_step_id]) if (valoption[frame_step_id].length() > 0) valoption[frame_step_id] = valoption[frame_step_id].substring(0, valoption[frame_step_id].length() - 1);

    if (selectoption[frame_id]) {
      if (valoption[frame_id].length() > 0) valoption[frame_id] = valoption[frame_id].substring(0, valoption[frame_id].length() - 1);
      if (valoption[frame_id].length() == 0) valoption[frame_id] = "0";
    }
    if (selectoption[sshuser_id]) if (sshuser.length() > 0) sshuser = sshuser.substring(0, sshuser.length() - 1);
    if (selectoption[sship_id]) if (sship.length() > 0) sship = sship.substring(0, sship.length() - 1);
  } else if (keypress == "ENTER") {
    for (int i = 0; i < selectoption.length; i++) selectoption[i] = false;
  } else if (keypress == "27") {
    if (selectoption[renders_name_id]) rendersname = esc;
    for (int i = 0; i < selectoption.length; i++) {
      if (selectoption[i]) valoption[i] = esc;
    }
    for (int i = 0; i < selectoption.length; i++) selectoption[i] = false;
  } else if (keypress == "CODED") {

    if (selectoption[scene_name_id]) scenename += key;

    if (selectoption[stamp_note_text_id]) valoption[stamp_note_text_id] += key;

    if (selectoption[dither_id]) {
      if (key==46) valoption[dither_id] += ".";
    }

    if (selectoption[frame_id] && !generatepy) {
      if (key==32) valoption[frame_id] += ",";

      if (key==44) valoption[frame_id] += ",";

      if (key==46) valoption[frame_id] += ".";

      if (keyCode==107) valoption[frame_id] += "+";

      if (keyCode==109) valoption[frame_id] += "-";
    }

    if (selectoption[sshuser_id]) if (sshuser.length() < 10) sshuser += key;
    if (selectoption[sship_id]) if (sship.length() < 10) sship += key;
  }
}