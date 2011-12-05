import processing.opengl.*;
import processing.pdf.*;

// from the same folder:
// requires colourPicker.pde
// requires drawingFunctions.pde
// requires globals.pde
// requires switchButton.pde
// requires textBox.pde
// requires valueChanger.pde 

String[] tNamesA = new String[0];
String[] tNamesB = new String[0];
PVector tPosA;
PVector tPosB;


TextBox tb1;
TextBox tb2;
TextBox[] textBoxes = new TextBox[2];

SwitchButton sbCrosshair;
SwitchButton sbContour;
SwitchButton sbBleed;
SwitchButton sbGrid;
SwitchButton[] buttons = new SwitchButton[4];

ColourPicker colGridLeft;
ColourPicker colBleedLeft;

ValueChanger gridRowChanger;
ValueChanger gridColumnsChanger;

void setup() {
      
  size(APP_WIDTH, APP_HEIGHT);
  
  setupTextFields();  
  initTextFields();
  initSwitchButtons();
  
  // colour pickers, may become redundant and subclassed.
  colGridLeft = new ColourPicker(leftGridColour, new PVector(160, buttonStartX), "left grid colour");
  colBleedLeft = new ColourPicker(leftBleedColour, new PVector(260, buttonStartX), "left bleed colour");
     
  // noLoop();
  //beginRecord(PDF, "filename.pdf"); 

}  



//  d r a w   b o i l e r p l a t e


 
void draw() {

  initDrawSettings();  
  drawConstructionElements();
  
  // text fields  
  tb1.display();
  tb2.display();
  
  // clipmask should go here.
  drawFauxClipPath(centerA);
  drawFauxClipPath(centerB);
  
  // draw buttons
  sbCrosshair.display();
  sbContour.display();
  sbBleed.display();
  sbGrid.display();
  
  // draw colour pickers
  colGridLeft.display();
  colBleedLeft.display();
  
  // check for user interaction with the UI.
  checkTextBoxes(); 
  checkButtons();
  
  //endRecord();
}



// m a s s   i n i t s



void initDrawSettings(){
  centerA = new PVector(300.0, 300.0);
  centerB = new PVector(APP_WIDTH-300, 300.0);
  background(252);
  smooth();
    
}


void setupTextFields(){
  tNamesA = getTrackNames("SIDE_A.txt");
  tNamesB = getTrackNames("SIDE_B.txt");
  float textBox1X = 300 - 230;
  float textBox2X = APP_WIDTH - 300 - 230;
  tPosA = new PVector(textBox1X, 370.0);
  tPosB = new PVector(textBox2X, 370.0);

}


void initTextFields(){
  tb1 = new TextBox(tNamesA, tPosA, tHeight, 0, myCol); 
  tb2 = new TextBox(tNamesB, tPosB, tHeight, 0, myCol);
  textBoxes[0] = tb1;
  textBoxes[1] = tb2;

}


void initSwitchButtons(){
   
  sbCrosshair = new SwitchButton("Crosshair", new PVector(10, buttonStartX));
  sbContour = new SwitchButton("Contour", new PVector(10, buttonStartX + buttonSpacing));
  sbBleed = new SwitchButton("Bleed", new PVector(10, buttonStartX + (2*buttonSpacing)));
  sbGrid = new SwitchButton("Grid", new PVector(10, buttonStartX + (3*buttonSpacing)));
  buttons[0] = sbCrosshair;
  buttons[1] = sbContour;
  buttons[2] = sbBleed;
  buttons[3] = sbGrid;
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
    drawContour(centerA, OUTER_MOST_RADIUS*2);
    drawContour(centerB, OUTER_MOST_RADIUS*2);
  }
  
  if (sbCrosshair.state){
    drawCrossHair(centerA);
    drawCrossHair(centerB);
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

  // WARNING MY DEAR FRIEND!
  // if you read this, it means i have not yet implemented a proper
  // error handling mechanism. poor coding practices ahead. 
  
  // This function assumes you:
  // - have a file called TRACK_A.txt or TRACK_B.txt. 
  // - that they have a few lines of text terminated by newline
  // - It doesn't care what encoding (ansi and utf-8 are fine, great for extend charset)
  // - please no unicode, ever. 
  
  String[] trackNames = loadStrings(fileName);
  int numTracks = trackNames.length;
  
  if (numTracks == 0) print("checked " + fileName + " but didn't find any tracks, the readme has some suggestions!\n");  
  for (String track : trackNames){
    print(track + "\n");    
  }
  return trackNames;
   
}

