import processing.opengl.*;
import processing.pdf.*;
import java.io.File;

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

TextBox tb1, tb2;
TextBox[] textBoxes = new TextBox[2];

SVGItem daLogo;
SVGItem[] svgItems;

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
    
  initTextBoxes();
  initSwitchButtons();
  initColourPickers();
  initValueChangers();
  
  initLayersMechanism();
  daLogo = new SVGItem("da_logo.svg", new PVector(centerA.x, centerA.y+240)); 
  svgItems = new SVGItem[]{daLogo, daLogo};
  
  for (int i = 0; i < 30; i+=1){
    daLogo.increaseScale();
  }
    
  //noLoop();
  //beginRecord(PDF, "filename.pdf"); 
  
  tb1.updateBody(getTrackNames("More2.txt"));

}  



//  d r a w   b o i l e r p l a t e


 
void draw() {

  resetDrawSettings();
  drawLabels();  
  drawConstructionElements();
  
  labelALayers.display();
  labelBLayers.display();
 
  // svg
  daLogo.display();
  
  // text   
  tb1.display();
  tb2.display();
  

  
  // clipmask
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
    checkTextBoxes();
    checkSVGItems(); 
  }

  
  // ui debug, comment out lateron // ontop
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


void checkTextBoxes(){
  
  for (TextBox tb : textBoxes){ 
    if (tb.over()){
      tb.selected = true;
    }else{
      tb.selected = false;
    }
  }
}


void checkSVGItems(){
  
  for (SVGItem svg : svgItems){ 
    if (svg.over()){
      svg.selected = true;
    }else{
      svg.selected = false;
    }
  }
}


void mousePressed(){
  
  // iterates through TextBox array until found.
  for (TextBox tb : textBoxes){
    if (tb.over()){
      tb.locked = false;
      xOffset = mouseX-tb.getXY().x;
      yOffset = mouseY-tb.getXY().y;
    }
    
  }
  
  for (SVGItem svg : svgItems){ 
    if (svg.over()){
      svg.locked = false;
      xOffset = mouseX-svg.getXY().x;
      yOffset = mouseY-svg.getXY().y;
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
  for (TextBox tb : textBoxes){
    if(!tb.locked){
      tb.setXY(new PVector(mouseX-xOffset, mouseY-yOffset));
    }    
  }
  
  for (SVGItem svg : svgItems){
    if(!svg.locked){
      svg.setXY(new PVector(mouseX-xOffset, mouseY-yOffset));
    }    
  }
}


void mouseReleased(){
  for (TextBox tb : textBoxes){ 
    tb.locked = true; 
  }
  
  for (SVGItem svg : svgItems){ 
    svg.locked = true; 
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


