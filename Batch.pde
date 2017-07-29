void keyEventsBatch (String keypress)
{
  if (keypress == "BACKSPACE") {
    if (select_del) {
      if (ext_del.length() > 0) ext_del = ext_del.substring(0, ext_del.length() - 1);
    }
  } else if (keypress == "CODED") {
    if (select_del) {
      ext_del += key;
    }
  }
}

void batchDelete()
{
  File folder = new File(path_batch);
  File fList[] = folder.listFiles();

  for (File f : fList) {
    if (f.getName().endsWith("."+ext_del)) {
      f.delete();
    }
  }
}

void  mouseEventsBatch()
{
  if (path_batch_()) {
    selectInput("Select path:", "pathBatch");
  }
  if (delete_batch_()) { 
    select_del = false;
    batchDelete();
  }
  if (extension_batch_()) {
    ext_del = "";
    select_del = true;
  }
}

void pathBatch(File selection) 
{
  if (selection != null) {
    path_batch = selection.getAbsolutePath();
    
    ext_del = selection.getName();
    ext_del = ext_del.substring(ext_del.lastIndexOf(".")+1);

    path_batch = path_batch.substring(0, path_batch.lastIndexOf(File.separator)+1);

    redraw();
  }
}