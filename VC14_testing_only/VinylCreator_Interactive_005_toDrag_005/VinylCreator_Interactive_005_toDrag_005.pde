import processing.opengl.*;
import processing.pdf.*;
 
PVector centerA, centerB;
float OUTER_MOST_RADIUS = 290.0;
float OFFSET_FROM_EDGES = 10.0;
int APP_WIDTH = 1190;
int APP_HEIGHT = 800;
float xOffset = 0.0; 
float yOffset = 0.0; 

TextBox tb1;
PVector tPos = new PVector(70.0, 370.0);

void setup() {
  
  
  
  
  String[] tNames = getTrackNames();
  int tHeight = 20;
  color myCol = color(60,60,60);
  
  size(APP_WIDTH, APP_HEIGHT);
  tb1 = new TextBox(tNames, tPos, tHeight, 0, myCol); 
  // noLoop();
  //beginRecord(PDF, "filename.pdf"); 
}  

 
void draw() {
  // print("frame");
  initDrawSettings();  
  drawConstructionElements();
  drawUI();
    
  tb1.display();  
  
  if (tb1.over()){
    tb1.selected = true;
  }else{
    tb1.selected = false;
  }
  
  //endRecord();
}



void mousePressed(){
  if (tb1.over()){
    tb1.locked = false;
  xOffset = mouseX-tb1.getXY().x;
  yOffset = mouseY-tb1.getXY().y;
   
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


void drawUI(){
  stroke(160, 160, 160);
  fill(240, 240, 240);
  rectMode(CORNER);
  rect(10, 750, 80, 40, 4);
}


void drawConstructionElements(){
  centerA = new PVector(300.0, 300.0);
  centerB = new PVector(APP_WIDTH-300, 300.0);
  drawEllipse(centerA, OUTER_MOST_RADIUS*2);
  drawEllipse(centerB, OUTER_MOST_RADIUS*2);
  drawCrossHair(centerA);
  drawCrossHair(centerB);
}


void drawCrossHair(PVector pos){
  float arm = 5;
  strokeWeight(1);
  stroke(170,170,255);
  line(pos.x-arm, pos.y+arm, pos.x+arm, pos.y-arm);
  line(pos.x-arm, pos.y-arm, pos.x+arm, pos.y+arm);
}


void drawEllipse(PVector pos, float circRadius){
  strokeWeight(1);
  stroke(170,170,255);
  ellipseMode(CENTER);
  noFill();
  ellipse(pos.x, pos.y, circRadius, circRadius);  
}

// UI stuff

String[] getTrackNames(){
  
  String[] tNames = new String[3];
  tNames[0] = "1A. Stix n Stones";
  tNames[1] = "2A. aStix n Sterwones";
  tNames[2] = "3A. Sertix wn Stones";
  return tNames; 
}
