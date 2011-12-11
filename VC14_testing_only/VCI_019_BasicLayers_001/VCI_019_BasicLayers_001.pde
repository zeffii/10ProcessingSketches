/*
MIT license. Dealga McArdle Dec 2011.
Thanks to pomax of irc freenode #processing for clarifications.
*/


import processing.opengl.*;
import processing.pdf.*;
import java.io.File;
import java.util.ArrayList;


void setup() {
  
  path = sketchPath;
  
  monoFont = createFont("DroidSansMono.ttf", uiTypeHeight);
  labelFont = createFont("DroidSans.ttf", uiTypeHeight);
  // designFont = createFont("DroidSans.ttf", tHeight);
    
  size(APP_WIDTH, APP_HEIGHT);
  centerA = new PVector(300.0, 300.0);
  centerB = new PVector(APP_WIDTH-300, 300.0);
  
  gobjsA = new ArrayList<GraphicsObject>();
  gobjsB = new ArrayList<GraphicsObject>();
  
  initGraphicsObjects();  
  initSwitchButtons();
  initColourPickers();
  initValueChangers();
  initLayersMechanism();
          
  //noLoop();
  //beginRecord(PDF, "filename.pdf"); 
    
}  



//  d r a w   b o i l e r p l a t e


 
void draw() {

  resetDrawSettings();
  drawLabels();  
  drawConstructionElements();
  
  labelALayers.display();
  labelBLayers.display();
  
  drawFauxClipPath(centerA);
  drawFauxClipPath(centerB);
    
  if (mouseY > uiTopY && mouseX > APP_WIDTH/2 - 129 && mouseX < APP_WIDTH/2 + 129){
    drawUI();
    checkButtons();
  }  
  else{  
    checkGraphicsObjects(); // if the mouse is not in the buttons area. we check graphics area.
  }

  // drawUIGrid();   
  
  //endRecord();

}



// u s e r   i n t e r a c t i o n



void checkButtons(){
  
  for (SwitchButton button : buttons){
    if (button.over()){
      button.inRange = true;
    } else{
      button.inRange = false;
    }
  }

}


void checkGraphicsObjects(){
  
  for (GraphicsObject go : gobjsA){ 
    if (go.over()){
      go.selected = true;
    }else{
      go.selected = false;
    }
  }
  
  for (GraphicsObject go : gobjsB){ 
    if (go.over()){
      go.selected = true;
    }else{
      go.selected = false;
    }
  }
  
    
}



void mousePressed(){
  
  // iterates through GraphicsObjects ArrayList
  for (GraphicsObject go : gobjsA){
    if (go.over()){
      go.locked = false;
      xOffset = mouseX-go.getXY().x;
      yOffset = mouseY-go.getXY().y;
    }
    
  }
   
  for (GraphicsObject go : gobjsB){
    if (go.over()){
      go.locked = false;
      xOffset = mouseX-go.getXY().x;
      yOffset = mouseY-go.getXY().y;
    }
    
  }
  
  
    
  for (SwitchButton button : buttons){
    if (button.over()){
      if (!button.state){
        button.state = true;
      }else{
        button.state = false;
      }  
    }
  }
  
  // these 4 ifs are muck, requires heavy consideration. [ TODO ] 
  
  if (gridRowChanger.isMinus()){
    gridRowChanger.reduce();
    gridRows = gridRowChanger.currentValue;    
  }
  
  if (gridRowChanger.isPlus()){
    gridRowChanger.increase();
    gridRows = gridRowChanger.currentValue;    
  }
  
  if (gridColumnChanger.isMinus()){
    gridColumnChanger.reduce();
    gridCols = gridColumnChanger.currentValue;    
  }
  
  if (gridColumnChanger.isPlus()){
    gridColumnChanger.increase();
    gridCols = gridColumnChanger.currentValue;    
  }
     
}


void mouseDragged(){
  for (GraphicsObject go : gobjsA){
    if(!go.locked){
      go.setXY(new PVector(mouseX-xOffset, mouseY-yOffset));
    }    
  }
  
  for (GraphicsObject go : gobjsB){
    if(!go.locked){
      go.setXY(new PVector(mouseX-xOffset, mouseY-yOffset));
    }    
  }
 
}


void mouseReleased(){
  for (GraphicsObject go : gobjsA){ 
    go.locked = true; 
  }
  
  for (GraphicsObject go : gobjsB){ 
    go.locked = true; 
  }
  
}



// d e l i g a t e   d r a w i n g   v i s u a l   a i d e s



void drawConstructionElements(){
  
  if (sbContour.state){
    drawContour(centerA, OUTER_MOST_RADIUS*2, leftContourColour);
    drawContour(centerB, OUTER_MOST_RADIUS*2, rightContourColour);
  }
  
  if (sbCrosshair.state){
    drawCrossHair(centerA, leftCrosshairColour);
    drawCrossHair(centerB, rightCrosshairColour);
  }

  if (sbBleed.state){
    drawBleed(centerA, leftBleedColour);
    drawBleed(centerB, rightBleedColour);  
  }

  if (sbGrid.state){
    drawGrid(centerA, leftGridColour);
    drawGrid(centerB, rightGridColour);
  }
  
}



// T e x t O b j e c t   B o d y   L o a d i n g.



String[] getTrackNames(String fileName){
  
  /*
  - [TODO]  make me pretty.
  - performs validity check, will return placeholder String[] if nothing is found.
  - platform OS independant path separator lookup.
  - loading a UTF-8 textfile, you must add #UTF8 to the start of your textfile:  
  - non utf-8 files require no such extra line at the top.
  
  example, if you want u with an accent you have to save it as .txt 
  set to utf-8 and it should look like this
  
     #UTF8
     1A. Charlote brÃ»te
     2A. MenoÃ®t (palermo) 
   
 */ 
 
  // perform small validity check first, 
  String separator = new File(path).separator;
  File file = new File(path + separator + "data" + separator + fileName);

  if (file.exists()) { 
    return parseFile(fileName); 
  }
  else{
    print("\n" + fileName + " was not found in the data directory\nplaceholder text added instead");
    return placeHolder;
  }  


}


String[] parseFile(String fileName){
  String[] trackNames = loadStrings(fileName);
  String[] trackNamesRedux;
  int numTracks = trackNames.length;
  
  // Empty file, end early.
  if (numTracks == 0) {
    print("checked " + fileName + ", appears empty!\n");
    return placeHolder;  
  }
  
  // incase UTF8
  if (trackNames[0].contains("#UTF8")){
    print("Found UTF8 indicator in " + fileName + "\n");
    numTracks -= 1;
    trackNamesRedux = new String[numTracks];

    for (int i = 0; i < numTracks; i+=1){
      trackNamesRedux[i] = trackNames[i+1];  
    }

    trackNames = trackNamesRedux;
  }
  
  // UTF and NORMAL
  for (String track : trackNames){
    print(track + "\n");    

  }
  
  return trackNames;
}

