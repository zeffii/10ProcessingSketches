import processing.opengl.*;
import processing.pdf.*;

// from the same folder:
// requires colourPicker.pde
// requires drawingFunctions.pde
// requires globals.pde
// requires switchButton.pde
// requires textBox.pde
 

TextBox tb1;
TextBox tb2;
TextBox[] textBoxes = new TextBox[2];

SwitchButton sbCrosshair;
SwitchButton sbContour;
SwitchButton sbBleed;
SwitchButton sbGrid;
SwitchButton[] buttons = new SwitchButton[4];
ColourPicker colGridLeft;


void setup() {
  
  // init some variables, maybe not the best place?  
  String[] tNamesA = getTrackNamesA();
  String[] tNamesB = getTrackNamesB();
  float textBox1X = 300 - 230;
  float textBox2X = APP_WIDTH - 300 - 230;
  PVector tPosA = new PVector(textBox1X, 370.0);
  PVector tPosB = new PVector(textBox2X, 370.0);
  
  size(APP_WIDTH, APP_HEIGHT);
    
  // setting up text fields
  tb1 = new TextBox(tNamesA, tPosA, tHeight, 0, myCol); 
  tb2 = new TextBox(tNamesB, tPosB, tHeight, 0, myCol);
  textBoxes[0] = tb1;
  textBoxes[1] = tb2;

  // setting up switchs / buttons
  sbCrosshair = new SwitchButton("Crosshair", new PVector(10, buttonStartX));
  sbContour = new SwitchButton("Contour", new PVector(10, buttonStartX + buttonSpacing));
  sbBleed = new SwitchButton("Bleed", new PVector(10, buttonStartX + (2*buttonSpacing)));
  sbGrid = new SwitchButton("Grid", new PVector(10, buttonStartX + (3*buttonSpacing)));
  buttons[0] = sbCrosshair;
  buttons[1] = sbContour;
  buttons[2] = sbBleed;
  buttons[3] = sbGrid;
  
  // colour pickers, may become redundant and subclassed.
  colGridLeft = new ColourPicker(leftGridColour, new PVector(160, buttonStartX), "left grid colour");
  
     
  // noLoop();
  //beginRecord(PDF, "filename.pdf"); 

}  

 
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
  
  // check buttons
  checkTextBoxes(); 
  checkButtons();
  
  //endRecord();
}


void initDrawSettings(){
  centerA = new PVector(300.0, 300.0);
  centerB = new PVector(APP_WIDTH-300, 300.0);
  background(252);
  smooth();
    
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



// d r a w i n g   v i s u a l   a i d e s



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



String[] getTrackNamesA(){
  
  String[] tNames = new String[3];
  tNames[0] = "1A. Damajâ Jùdo";
  tNames[1] = "2A. Singapore Chowmein";
  tNames[2] = "3A. Soul Punch";
  return tNames; 
}


String[] getTrackNamesB(){
  
  String[] tNames = new String[3];
  tNames[0] = "1B. Line one";
  tNames[1] = "2B. Singapore Chowmein was not tastey";
  tNames[2] = "3B. Insufficient Parameters (boolean mix)";
  return tNames; 
}


