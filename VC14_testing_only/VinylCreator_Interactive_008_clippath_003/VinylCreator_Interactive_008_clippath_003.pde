import processing.opengl.*;
import processing.pdf.*;
 
PVector centerA, centerB;
float OUTER_MOST_RADIUS = 290.0;
float OFFSET_FROM_EDGES = 10.0;
float BLEED_RADIUS = 273.5849;  // 290+290 : 106   x/2 = 100
int APP_WIDTH = 1190;
int APP_HEIGHT = 800;
float xOffset = 0.0; 
float yOffset = 0.0; 
float buttonSpacing = 20.0;
float buttonStartX = 600.0;

// just in case sides are totally different.
color leftBleedColour = color(170,170,255);
color rightBleedColour = color(170,170,255);
color myCol = color(60,60,60);

// typographic constants, rename please.
int tHeight = 20;

TextBox tb1;
SwitchButton sbCrosshair;
SwitchButton sbContour;
SwitchButton sbBleed;
SwitchButton[] buttons = new SwitchButton[3];

PVector tPos = new PVector(70.0, 370.0);

void setup() {
  
  String[] tNames = getTrackNames();
  size(APP_WIDTH, APP_HEIGHT);
  
  // setting up text fields
  tb1 = new TextBox(tNames, tPos, tHeight, 0, myCol); 


  // setting up switchs / buttons
  sbCrosshair = new SwitchButton("Crosshair", new PVector(50, buttonStartX));
  sbContour = new SwitchButton("Contour", new PVector(50, buttonStartX + buttonSpacing));
  sbBleed = new SwitchButton("Bleed", new PVector(50, buttonStartX + (2*buttonSpacing)));
  
  // note to self, this sticks all the buttons currently listed
  // into an array of the class 'SwitchButton'. this allows
  // you to loop through the items instead of doing the checks
  // for each individually. This looks better too.    
  buttons[0] = sbCrosshair;
  buttons[1] = sbContour;
  buttons[2] = sbBleed;
  
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
  
  // draw buttons
  sbCrosshair.display();
  sbContour.display();
  sbBleed.display();
  
  // check buttons
  checkTextBoxes(); 
  checkButtons();
  
  
  //endRecord();
}


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



void initDrawSettings(){
  background(252);
  smooth();
}



void drawConstructionElements(){
  
  centerA = new PVector(300.0, 300.0);
  centerB = new PVector(APP_WIDTH-300, 300.0);
  
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


}


//  User assisting elements


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



// UI stuff

String[] getTrackNames(){
  
  String[] tNames = new String[3];
  tNames[0] = "1A. Stix n Stones";
  tNames[1] = "2A. aStix n Sterwones";
  tNames[2] = "3A. Sertix wn Stones";
  return tNames; 
}

// mathy drawing stuff 

PVector getVectorFromDegreeAndRadius(int i, float rad) {
  PVector coordinate = new PVector(cos(radians(i))*rad, sin(radians(i))*rad);
  return coordinate;
}
