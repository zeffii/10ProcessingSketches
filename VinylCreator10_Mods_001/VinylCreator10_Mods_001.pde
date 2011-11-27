/* 
Vinyl Art Work Generator. 
By Dealga McArdle Nov 2011.
Released under MIT license.
*/

import processing.pdf.*;
import java.util.Random;


// drawing variables, typographic constants
int typeHeight = 66;
int typeDescriptionHeight = 37;
float lineRatio = 1.167;
String albumName = "Wicked Batch of a Test";

// outline for during design, printing aids
boolean outer = true;
boolean inner = false;
boolean crossHair = true;
float outerRadius = 980;
float innerRadius = 60;

// random image properties
boolean randomImagePosition = true;
boolean randomImage = false; //true;
boolean semiRandomTintFX = false; //true;

void setup(){
  albumName += ".pdf";
  size(2000, 4000, PDF, albumName);
  textMode(SHAPE);  // necessary?

}


void draw(){

  background(230);
 
  // side B
  drawRaster(0, 2000);
  drawFauxClipPath(1000.0, 3000.0);  
  drawCentrePiece(1000.0, 3000.0);
  drawCrossHair(1000.0, 3000.0, innerRadius/2);  
   
  // side A
  drawForcedBackground();
  drawOutlines(1000.0);
  drawTrackList();  
  drawDAlogo();
  drawDescription();
  
  // Quit the program
  exit();

}

// SIDE B

// draws the non vector .png underneath the circular 'clippath'
void drawRaster(float tXpos, float tYpos){
  
  // fallback value.
  PImage img;
  String imageName = "shape_005_03.png";
    
  if (randomImage){
    String[] imageNameArray = new String[2];
    imageNameArray[0] = "shape_005_03.png";
    imageNameArray[1] = "shape_005_03b.png";
    // etc..
    // etc..
    int arrayLength = imageNameArray.length; 
    
    Random generator = new Random();
    int randomIndex = generator.nextInt(arrayLength);
    imageName = imageNameArray[randomIndex];  
  }
  
  img = loadImage(imageName);
  print("using image name " + imageName + "\n");
  
  if (randomImagePosition){
    float imgWidth = img.width;
    float imgHeight = img.height;
    print("image width: " + imgWidth + ", " + "image height: " + imgHeight);
    
    float xVariation = (imgWidth - 2000);
    float yVariation = (imgHeight - 2000);
    tXpos = random(0, -xVariation);
    tYpos = random(2000-yVariation, 2000);
  }
  
  if (semiRandomTintFX){
    Random tintR = new Random();
    Random tintG = new Random();
    Random tintB = new Random();
    int rTintR = tintR.nextInt(156) + 100;
    int rTintG = tintR.nextInt(156) + 100;
    int rTintB = tintR.nextInt(156) + 100;
    tint(rTintR, rTintG, rTintB);
    
    // in case it's cool
    print("\n");
    print(str(rTintR) + "," + str(rTintG) + "," + str(rTintB));
  } 
  
  image(img, tXpos, tYpos);
  
}


// because lazy is ok for now.
void drawFauxClipPath(float cPointX, float cPointY){
  ellipseMode(RADIUS);
  noFill();
  stroke(255);
  strokeWeight(600);
  ellipse(cPointX, cPointY, 1280.0, 1280.0);
    
}


// the small white area in the center of side B (artwork)
void drawCentrePiece(float cPointX, float cPointY){
 noStroke(); 
 fill(255);
 ellipseMode(RADIUS);
 ellipse(cPointX, cPointY, 60.0, 60.0);

}


void drawOutlines(float centrePoint){
 drawEllipse(centrePoint, outerRadius, outer);
 drawEllipse(centrePoint, innerRadius, inner);
 if (crossHair){
   drawCrossHair(centrePoint, centrePoint, innerRadius/2);
 }

}


// SIDE A 

void drawForcedBackground(){
 fill(250);
 noStroke();
 rect(0,0,2000,2000);
  
}


void drawTrackList(){  
  float x1 = 500;
  float y1 = 1290;
  float lineHeight = float(typeHeight) * lineRatio;
  
  textFont(createFont("DroidSans", typeHeight));
  textAlign(LEFT);
  color textColour = color(40, 40, 80);
  drawSomeText("1A. Some String bongo [4:23]", x1, y1, textColour);
  drawSomeText("1B. Some String bongo Remix [6:23]", x1, y1+lineHeight, textColour);
  drawSomeText("2A. Some Rochfort boolean [4:35]", x1, y1+(lineHeight*2), textColour);
  drawSomeText("2B. Some Massive true void [3:23]", x1, y1+(lineHeight*3), textColour);

}


void drawDescription(){
  float lineDescriptionHeight = float(typeDescriptionHeight) * lineRatio;
  textFont(createFont("DroidSans", typeDescriptionHeight));
  
  // draw production deatails
  String multilineString1 = "All tracks are licensed to Artificial recordings, additional mastering";
  String multilineString2 = "done by Totally Ridiculous Dynamics at Trendy studios";
  float descriptionYPos = 1790;
  color textColour = color(0,0,0);
  textAlign(CENTER);
  drawSomeText(multilineString1, 1000, descriptionYPos, textColour);
  drawSomeText(multilineString2, 1000, descriptionYPos + lineDescriptionHeight, textColour);

}


// SHARED FUNCTIONS


void drawDAlogo(){
  PShape dalogo = loadShape("da_logo.svg");
  shapeMode(CENTER);
  dalogo.scale(.7);
  shape(dalogo, 1000, 1670);

}


void drawSomeText(String mString, float dX, float dY, color tCol){
 fill(tCol);
 text(mString, dX, dY);

}


void drawCrossHair(float centrePointX, float centrePointY, float hairLength){
  stroke(130);
  strokeWeight(2);
  line(centrePointX, centrePointY+hairLength, centrePointX, centrePointY-hairLength);
  line(centrePointX-hairLength, centrePointY, centrePointX+hairLength, centrePointY);
  noStroke(); // reset to defaults
    
}


void drawEllipse(float centrePoint, float tRadius, boolean tDrawStroke){
 if (tDrawStroke){
    stroke(150, 150, 255);
    strokeWeight(4);
 }
 else{  
   noStroke();
 }
 noFill();
 ellipseMode(RADIUS);
 ellipse(centrePoint, centrePoint, tRadius, tRadius);
 noStroke(); // reset to defaults

}





