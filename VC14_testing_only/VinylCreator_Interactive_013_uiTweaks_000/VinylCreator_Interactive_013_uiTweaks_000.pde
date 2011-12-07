import processing.opengl.*;
import processing.pdf.*;

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


void setup() {
      
  size(APP_WIDTH, APP_HEIGHT);
  
  initTextBoxes();
  initSwitchButtons();
  initColourPickers();
  initValueChangers();
  
  //noLoop();
  //beginRecord(PDF, "filename.pdf"); 

}  



//  d r a w   b o i l e r p l a t e


 
void draw() {

  initDrawSettings();
  drawLabels();  
  drawConstructionElements();
  
  // ui debug, comment out lateron // base
  // drawUIGrid(); 
 
  // text   
  tb1.display();
  tb2.display();
  
  // clipmask
  drawFauxClipPath(centerA);
  drawFauxClipPath(centerB);
    
  if (mouseY > uiTopY){
    
    // draw buttons
    sbCrosshair.display();
    sbContour.display();
    sbBleed.display();
    sbGrid.display();
      
    // draw colour pickers
    displayColourPickers();
    
    // draw grid changers
    gridRowChanger.display();
    gridColumnChanger.display();
  
    //if (mouseX > APP_WIDTH - midButton && mouseX < APP_WIDTH + midButton){
    checkButtons();
    //}
  
    
  }  
  else{  
    // check for user interaction with the UI. always
    checkTextBoxes(); 
  }

  
  // ui debug, comment out lateron // ontop
  // drawUIGrid();   
  
  //endRecord();
}



// m a s s   i n i t s



void initDrawSettings(){
  centerA = new PVector(300.0, 300.0);
  centerB = new PVector(APP_WIDTH-300, 300.0);
  background(252);
  smooth();
    
}


void initTextBoxes(){
  tNamesA = getTrackNames("SIDE_A.txt");
  tNamesB = getTrackNames("SIDE_B.txt");
  float textBox1X = 300 - 230;
  float textBox2X = APP_WIDTH - 300 - 230;
  tPosA = new PVector(textBox1X, 370.0);
  tPosB = new PVector(textBox2X, 370.0);
  
  tb1 = new TextBox(tNamesA, tPosA, tHeight, 0, myCol); 
  tb2 = new TextBox(tNamesB, tPosB, tHeight, 0, myCol);
  textBoxes[0] = tb1;
  textBoxes[1] = tb2;

}


void initSwitchButtons(){
  float midButtonsPosX = (APP_WIDTH/2) - midButton;
  sbCrosshair = new SwitchButton(1, "", new PVector(midButtonsPosX, buttonStartY));
  sbBleed = new SwitchButton(1, "", new PVector(midButtonsPosX, buttonStartY + buttonSpacing));
  sbContour = new SwitchButton(1, "", new PVector(midButtonsPosX, buttonStartY + buttonSpacing*2));
  sbGrid = new SwitchButton(1, "", new PVector(midButtonsPosX, buttonStartY + (buttonSpacing*3)));
  buttons = new SwitchButton[]{sbCrosshair, sbBleed, sbContour, sbGrid};

}


void initColourPickers(){
  float leftButtonsPosX = (APP_WIDTH/2)-37;
  float rightButtonsPosX = leftButtonsPosX + 57;

  colLabelLeft = new ColourPicker(0, leftLabelColour, new PVector(leftButtonsPosX, buttonStartY + (buttonSpacing*-1)), "Label A");
  colLabelRight = new ColourPicker(1, rightLabelColour, new PVector(rightButtonsPosX, buttonStartY + (buttonSpacing*-1)), "Label B");

  colCrosshairLeft = new ColourPicker(0, leftCrosshairColour, new PVector(leftButtonsPosX, buttonStartY + (buttonSpacing*0)), "");
  colBleedLeft = new ColourPicker(0, leftBleedColour, new PVector(leftButtonsPosX, buttonStartY + (buttonSpacing*1)), "");
  colContourLeft = new ColourPicker(0, leftContourColour, new PVector(leftButtonsPosX, buttonStartY + (buttonSpacing*2)), "");
  colGridLeft = new ColourPicker(0, leftGridColour, new PVector(leftButtonsPosX, buttonStartY + (buttonSpacing*3)), "");
  
  colCrosshairRight = new ColourPicker(1, rightCrosshairColour, new PVector(rightButtonsPosX, buttonStartY + (buttonSpacing*0)), "");
  colBleedRight = new ColourPicker(1, rightBleedColour, new PVector(rightButtonsPosX, buttonStartY + (buttonSpacing*1)), "");
  colContourRight = new ColourPicker(1, rightContourColour, new PVector(rightButtonsPosX, buttonStartY + (buttonSpacing*2)), "");
  colGridRight = new ColourPicker(1, rightGridColour, new PVector(rightButtonsPosX, buttonStartY + (buttonSpacing*3)), "");

  
  // [todo], add background color for oth sides, and draw filled circles under clippath with those colours. 
  colourPickers = new ColourPicker[]{  colCrosshairLeft, colBleedLeft, colContourLeft, colGridLeft, 
                                        colCrosshairRight, colBleedRight, colContourRight, colGridRight,
                                      colLabelLeft, colLabelRight}; 

}


void initValueChangers(){
  // grid buttons ( (PVector itemLocation, String label, int low, int high, int defaultValue) ) 
  PVector locRowChanger = new PVector((APP_WIDTH/2)-37, LABEL_DIAMETER + 40);
  PVector locColChanger = new PVector(locRowChanger.x+57, locRowChanger.y);
  gridRowChanger = new ValueChanger(locRowChanger, "Row", 2, 15, 10);
  gridColumnChanger = new ValueChanger(locColChanger, "Column", 2, 15, 10);
  changers = new ValueChanger[]{gridRowChanger, gridColumnChanger};

}


void displayColourPickers(){
   for (ColourPicker colourPicker : colourPickers){
       colourPicker.display();
   } 
    
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


void mousePressed(){
  
  // iterates through TextBox array until found.
  for (TextBox tb : textBoxes){
    if (tb.over()){
      tb.locked = false;
      xOffset = mouseX-tb.getXY().x;
      yOffset = mouseY-tb.getXY().y;
    }
  }
  
  // iterates through SwitchButton array until found.
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
}


void mouseReleased(){
  for (TextBox tb : textBoxes){ 
    tb.locked = true; 
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
   1A. Charlote brûte
   2A. Menoît (palermo) 
 */ 
   
  
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

