import processing.opengl.*;
import processing.pdf.*;
 
float OUTER_MOST_RADIUS = 290.0;
float OFFSET_FROM_EDGES = 10.0;
float BLEED_RADIUS = 273.5849;  // 290+290 : 106   x/2 = 100
float LABEL_DIAMETER = OUTER_MOST_RADIUS * 2; 
int APP_WIDTH = int(10.0 + LABEL_DIAMETER + 30.0 + LABEL_DIAMETER + 10.0); // depends
int APP_HEIGHT = 800;
float xOffset = 0.0; 
float yOffset = 0.0; 
float buttonSpacing = 20.0;
float buttonStartX = 680.0;

// just in case sides are totally different.
color leftBleedColour = color(170,170,255);
color rightBleedColour = color(170,170,255);
color myCol = color(60,60,60);
color leftGridColour = color(244, 20, 130, 20);
color rightGridColour = color(244, 20, 130, 20);

// typographic constants, rename please.
int tHeight = 20;

// grid drawing
int gridRows = 12;
int gridCols = 12;
float gridRowHeight = LABEL_DIAMETER / (gridRows);
float gridColWidth = LABEL_DIAMETER / (gridCols);


TextBox tb1;
SwitchButton sbCrosshair;
SwitchButton sbContour;
SwitchButton sbBleed;
SwitchButton sbGrid;
SwitchButton[] buttons = new SwitchButton[4];

PVector tPos = new PVector(70.0, 370.0);
PVector centerA, centerB;

void setup() {
  
  // init some variables, maybe not the best place?  
  String[] tNames = getTrackNames();
  size(APP_WIDTH, APP_HEIGHT);
  
  // setting up text fields
  tb1 = new TextBox(tNames, tPos, tHeight, 0, myCol); 

  // setting up switchs / buttons
  sbCrosshair = new SwitchButton("Crosshair", new PVector(10, buttonStartX));
  sbContour = new SwitchButton("Contour", new PVector(10, buttonStartX + buttonSpacing));
  sbBleed = new SwitchButton("Bleed", new PVector(10, buttonStartX + (2*buttonSpacing)));
  sbGrid = new SwitchButton("Grid", new PVector(10, buttonStartX + (3*buttonSpacing)));
  
  // so that we can iterate over an array of the class 'SwitchButton'.
  buttons[0] = sbCrosshair;
  buttons[1] = sbContour;
  buttons[2] = sbBleed;
  buttons[3] = sbGrid;
    
  // noLoop();
  //beginRecord(PDF, "filename.pdf"); 

}  

 
void draw() {
  // print("frame");
  initDrawSettings();  
  drawConstructionElements();
  // drawUI();
  
  // text fields  
  tb1.display();
  
  // clipmask should go here.
  drawFauxClipPath(centerA);
  drawFauxClipPath(centerB);
  
  // draw buttons
  sbCrosshair.display();
  sbContour.display();
  sbBleed.display();
  sbGrid.display();
  
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
  if (tb1.over()){
    tb1.selected = true;
  }else{
    tb1.selected = false;
  }
 
}


void mousePressed(){
  if (tb1.over()){
    tb1.locked = false;
  xOffset = mouseX-tb1.getXY().x;
  yOffset = mouseY-tb1.getXY().y;
   
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
   
}


void mouseDragged(){
  if(!tb1.locked){
    tb1.setXY(new PVector(mouseX-xOffset, mouseY-yOffset));
  }    
}


void mouseReleased(){
   tb1.locked = true; 
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


void drawCrossHair(PVector pos){
  float arm = 5;
  strokeWeight(1);
  stroke(170,170,255);
  line(pos.x-arm, pos.y+arm, pos.x+arm, pos.y-arm);
  line(pos.x-arm, pos.y-arm, pos.x+arm, pos.y+arm);
  
}


void drawContour(PVector pos, float circRadius){
  strokeWeight(1);
  stroke(170,170,255);
  ellipseMode(CENTER);
  noFill();
  ellipse(pos.x, pos.y, circRadius, circRadius);  

}


void drawBleed(PVector cPoint, color bColor){
  noFill();
  stroke(bColor);
  strokeWeight(1);

  for (int i = 0; i < 360-1; i+=2) {
    if (i%2 == 0) {
      stroke(bColor);
    }
    else {
      noStroke();
    }
    PVector coord = getVectorFromDegreeAndRadius(i, BLEED_RADIUS);
    PVector coord2 = getVectorFromDegreeAndRadius(i+1, BLEED_RADIUS);
    line(coord.x + cPoint.x, coord.y + cPoint.y, coord2.x + cPoint.x, coord2.y + cPoint.y);
  }
   
}


void drawGrid(PVector cPoint, color gridColor) {
    
  float leftX = cPoint.x - OUTER_MOST_RADIUS;
  float topY = cPoint.y - OUTER_MOST_RADIUS;
  float bottomY = cPoint.y + OUTER_MOST_RADIUS;

  strokeWeight(1);
  stroke(gridColor);

  float rightMost = leftX + LABEL_DIAMETER;
  for (int j = 0; j <= gridRows; j++) {
    float yvar = gridRowHeight*j;
    line(leftX, topY + yvar, rightMost, topY + yvar);
  }

  for (int i = 0; i <= gridCols; i++) {
    line(leftX, topY, leftX, bottomY);
    leftX += gridColWidth;
  }
  
}




// t y p o g r a p h i c   e l e m e n t s



String[] getTrackNames(){
  
  String[] tNames = new String[3];
  tNames[0] = "1A. Stix n Stones";
  tNames[1] = "2A. aStix n Sterwones";
  tNames[2] = "3A. Sertix wn Stones";
  return tNames; 
}




