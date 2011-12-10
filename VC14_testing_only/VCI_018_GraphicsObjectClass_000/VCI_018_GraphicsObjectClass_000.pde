/*
MIT license.
Dealga McArdle Dec 2011.

Thanks to pomax of irc freenode #processing for clarifications.
*/


import processing.opengl.*;
import processing.pdf.*;
import java.io.File;
import java.util.ArrayList;

// from the same folder:
// requires colourPicker.pde
// requires drawingFunctions.pde
// requires globals.pde
// requires switchButton.pde
// requires textBox.pde
// requires valueChanger.pde

String[] tNamesA;
String[] tNamesB;
PVector tPosA, tPosB;

ArrayList<GraphicsObject> gobjs;

SwitchButton sbCrosshair;
SwitchButton sbContour;
SwitchButton sbBleed;
SwitchButton sbGrid;
SwitchButton[] buttons = new SwitchButton[4];

ColourPicker colCrosshairLeft, colCrosshairRight;
ColourPicker colContourLeft, colContourRight;
ColourPicker colBleedLeft, colBleedRight;
ColourPicker colGridLeft, colGridRight;
ColourPicker colLabelLeft, colLabelRight;
ColourPicker[] colourPickers;

ValueChanger gridRowChanger;
ValueChanger gridColumnChanger;
ValueChanger[] changers;

LayerViewObject labelALayers, labelBLayers;

String path;

void setup() {
  
  path = sketchPath;
  
  monoFont = createFont("DroidSansMono.ttf", uiTypeHeight);
  labelFont = createFont("DroidSans.ttf", uiTypeHeight);
  designFont = createFont("DroidSans.ttf", tHeight);
    
  size(APP_WIDTH, APP_HEIGHT);
  centerA = new PVector(300.0, 300.0);
  centerB = new PVector(APP_WIDTH-300, 300.0);
  
  gobjs = new ArrayList<GraphicsObject>();  
  
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

  for (GraphicsObject go : gobjs){
    go.display();
  } 
  
  drawFauxClipPath(centerA);
  drawFauxClipPath(centerB);
    
  if (mouseY > uiTopY && mouseX > APP_WIDTH/2 - 129 && mouseX < APP_WIDTH/2 + 129){
    
    // draw buttons
    sbCrosshair.display();
    sbContour.display();
    sbBleed.display();
    sbGrid.display();
      
    // draw colour pickers
    displayColourPickers();
    
    // draw grid changers
    if (sbGrid.state){
      gridRowChanger.display();
      gridColumnChanger.display();
    }
      
    checkButtons();
    
  }  
  else{  
    // check for user interaction with the UI. always
    checkGraphicsObjects();
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
  
  for (GraphicsObject go : gobjs){ 
    if (go.over()){
      go.selected = true;
    }else{
      go.selected = false;
    }
  }
}



void mousePressed(){
  
  // iterates through GraphicsObjects ArrayList
  for (GraphicsObject go : gobjs){
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
  for (GraphicsObject go : gobjs){
    if(!go.locked){
      go.setXY(new PVector(mouseX-xOffset, mouseY-yOffset));
    }    
  }
 
}


void mouseReleased(){
  for (GraphicsObject go : gobjs){ 
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



// t y p o g r a p h i c   e l e m e n t s



String[] getTrackNames(String fileName){

  // 09 Dec. Addition, 
  // - TextBox.updateBody(filename)  was added, so this can be modified lateron.
  // - performs validity check on function call, will return empty String[] if nothing is found.
  // - platform OS independant path separator lookup.
  
  // Initial state of the function.
  // This function assumes a few things:
  // - you have a file called TRACK_A.txt and TRACK_B.txt, located in /data 
  // - that they have a few lines of text terminated by newline
  // - if your are loading a UTF-8 textfile (for non ascii character sets) 
  // then you must add #UTF8 to the start of your textfile:  
  // - non utf-8 files require no such extra line at the top.
  // - test the font in an external editor to see if it contains those special characters.
  
  // example , if you want u with an accent you have to save it as .txt set to utf-8 and it should look like this
  /*
   #UTF8
   1A. Charlote brÃ»te
   2A. MenoÃ®t (palermo) 
 */ 
 
  // perform small validity check first, 
  String separator = new File(path).separator;
  
  File file = new File(path + separator + "data" + separator + fileName);
  if (file.exists()) {
        
    String[] trackNames = loadStrings(fileName);
    String[] trackNamesRedux;
    int numTracks = trackNames.length;
    
    if (numTracks == 0) print("checked " + fileName + " but didn't find any tracks, the readme has some suggestions!\n");  
   
    if (trackNames[0].contains("#UTF8")){
   
      print("Found UTF8 indicator in " + fileName + "\n");
      numTracks -= 1;
      trackNamesRedux = new String[numTracks];
      for (int i = 0; i < numTracks; i+=1){
        trackNamesRedux[i] = trackNames[i+1];  
      }
  
      trackNames = trackNamesRedux;
    
    }
    
    for (String track : trackNames){
      print(track + "\n");    
    }
    
    return trackNames;
  }
  else{
    print("\n" + fileName + " was not found in the data directory\nplaceholder text added instead");
    return new String[]{"detroit\n","pump\n"};
  }  
}


