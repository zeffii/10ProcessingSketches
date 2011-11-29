/* 
Vinyl Art Work Generator. 
By Dealga McArdle Nov 2011.
Released under MIT license.

29 Nov, after experiments of bezierVertex..which didn't look great, i used straight
shapes instead.

*/

import processing.pdf.*;
import java.util.Random;
import java.awt.Desktop;
import java.io.IOException;
import java.io.File;


String path = "";

// typographic constants
int typeHeight = 65; // for copy text
int typeDescriptionHeight = 40;  // for information
float lineRatio = 1.167;
float leftAlignX = 274.0;
float typeInitY = 1370.0;

// drawing variables, fluff, background fx 
boolean useRoundedTextBackground = true;
int roundedBGmode = 1;  // 0 or 1 are slightly different flavours, ignored if useRoundedTextBackground is false;
int clipPathMethod = 1;  // 0=old, 1=new (but still lame) , [todo] 2=trig.
boolean drawSideBClipLimits = false;

// text (track names)
String albumName = "Wicked_Batch_of_a_Test" + ".pdf";
String track1A = "1A. Via Osmosis (Original Mix) 3:42";
String track2A = "2A. Carpool Tunnel Syndrome (Disjointed Mix) 7:23";
String track1B = "1B. Via Osmosis (Stigma Mix) 4:35";
String track2B = "2B. Insufficient Parameters (boolean Mix) 5:13";

// text production and license details
String multilineString1 = "All tracks are licensed to Artificial recordings, additional mastering";
String multilineString2 = "done by Totally Ridiculous Dynamics at Trendy studios";
float descriptionYPos = 1730;

// outline for design, printing aids
boolean outer = true;
boolean inner = false;
boolean crossHair = true;
float outerRadius = 980;
float innerRadius = 60;

// random image properties, to declare images for selecting add them to drawRaster
boolean randomImagePosition = false;
boolean randomImage = false; //true;
boolean semiRandomTintFX = false; //true;
boolean displayAfterwards = true;


void setup(){
  path = sketchPath;
  size(4000, 2000, PDF, albumName);
  textMode(SHAPE);  // necessary?

}


void draw(){
  print("running...\n");
  
  background(230);
 
  // side B
  drawRaster(3000, 1000);
  drawFauxClipPath(3000.0, 1000.0);  
  drawTrackList("B");
  //drawCentrePiece(3000.0, 1000.0);
  drawCrossHair(3000.0, 1000.0, innerRadius/2);  
   
  // side A
  drawForcedBackground();
  drawOutlines(1000.0);
  drawTrackList("A");  
  drawDAlogo();
  drawDescription();
  
  print("\nDone\n");
  // Quit the program
  exit();
  
  if (displayAfterwards){
    openPDF(albumName);
  }
  
}

// SIDE B

// draws the non vector .png underneath the circular 'clippath'
void drawRaster(float tXpos, float tYpos){
  
  // fallback value.
  PImage img;
  String imageName = "shape_005_03.png";
  imageMode(CENTER);
    
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
  float imgWidth = img.width;
  float imgHeight = img.height;
    
  if (randomImagePosition){
    print("image width: " + imgWidth + ", " + "image height: " + imgHeight);
    imageMode(CORNER);
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
  
  if (randomImagePosition){
    image(img, tXpos, tYpos);
  }else{
    pushMatrix();
    translate(3000,1000);
    rotate(1.6);  
    image(img, 0, 0);
    popMatrix();
  }
  
}


// because lazy is ok for now.
void drawFauxClipPath(float cPointX, float cPointY){
  // the ugly way.. but it got the job done.
  if (clipPathMethod == 0){
    ellipseMode(RADIUS);
    noFill();
    stroke(255);
    strokeWeight(600);
    ellipse(cPointX, cPointY, 1280.0, 1280.0);
    
  }
  
  // different, equally inelegant, method.
  if (clipPathMethod == 1){ 
    
    // draw quadrant clips, so the eventual thickness of the upper clipping path
    // doesn't have to 255 wide :)
    fill(255);
    noStroke();
        
    beginShape();  //top right, first quadrant
      vertex(3500, 0);
      vertex(4000, 0);
      vertex(4000, 500);
      vertex(3500, 0);
    endShape();
    
    beginShape();
      vertex(4000, 1500);
      vertex(4000, 2000);
      vertex(3500, 2000);
      vertex(4000, 1500);
    endShape();
    
    beginShape();
      vertex(2500, 2000);
      vertex(2000, 2000);
      vertex(2000, 1500);
      vertex(2500, 2000);
    endShape();
    
    beginShape();
      vertex(2500, 0);
      vertex(2000, 500);
      vertex(2000, 0);
      vertex(2500, 0);
    endShape();
  
    // add faux clipping mask v2
    noFill();
    strokeWeight(180);
    stroke(255);
    float cRad = 2142;
    ellipse(cPointX, cPointY, cRad, cRad);
     
  
  
    if (drawSideBClipLimits){  
      // the white underneath should not be visible inside the green boundary.
      stroke(0, 255, 0);
      strokeWeight(4);
      noFill();
      ellipseMode(RADIUS);
      ellipse(cPointX, cPointY, outerRadius, outerRadius);
    }
     
  }
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


void drawTrackList(String SIDE){  
  float x1 = leftAlignX;
  float y1 = typeInitY;
  float lineHeight = float(typeHeight) * lineRatio;
  
  textFont(createFont("DroidSans", typeHeight));
  
  if (SIDE.equals("A")){
    textAlign(LEFT);
    color textColour = color(80, 80, 80);
    drawSomeText(track1A, x1, y1, textColour);
    drawSomeText(track2A, x1, y1+lineHeight, textColour);
  }
  
  if (SIDE.equals("B")){
    textAlign(LEFT);
    x1 += 2000;
    
    boolean BGNEEDED = true;
    if (BGNEEDED){
      
      float boxHeight = 178;
      noStroke();    
      fill(0);
      float textAdjustY = typeHeight+3;
             
      float longestText = max(textWidth(track2B), textWidth(track1B)); 
      
      if (useRoundedTextBackground){
        if (roundedBGmode == 0){
          // ellpises on both sides are the same radius
          rect(x1, y1-textAdjustY, longestText, boxHeight);
          ellipseMode(CORNER);
          ellipse(x1 - (boxHeight/2), y1-textAdjustY, boxHeight, boxHeight);     
          ellipse(x1 + longestText - (boxHeight/2),  y1-textAdjustY, boxHeight, boxHeight); 
        }
        if (roundedBGmode == 1){     
          // we draw two different rects
          rect(x1, (y1 - textAdjustY), textWidth(track1B), boxHeight/2);
          rect(x1, (y1 + lineHeight - textAdjustY), textWidth(track2B), boxHeight/2);
          float ellipseRadius = (y1+lineHeight-textAdjustY + (boxHeight/2)) - (y1 - textAdjustY);
       
          // ellipse on the left is full size, and ellipses on the right are typeheight
          // and positioned at line width (textWidth).
          ellipseMode(CORNER);
          ellipse(x1 - (ellipseRadius/2), y1-textAdjustY, ellipseRadius, ellipseRadius); // left
          
          // rightside parameters
          float r1X = (x1 + textWidth(track1B) - boxHeight/4);
          float r1Y = y1 - textAdjustY;
          float r2X = (x1 + textWidth(track2B) - boxHeight/4);
          float r2Y = y1 + lineHeight - textAdjustY;
          ellipse(r1X, r1Y, boxHeight/2, boxHeight/2); //right
          ellipse(r2X, r2Y, boxHeight/2, boxHeight/2); //right
        }
        
      }
      else{
        rect(x1, y1-textAdjustY, longestText, boxHeight); // no fx, just black background.
      }
      
    }  // end of if bg needed.
    
    color textColour = color(250, 250, 250);
    drawSomeText(track1B, x1, y1+(lineHeight*0), textColour);
    drawSomeText(track2B, x1, y1+(lineHeight*1), textColour);
  }
}


void drawDescription(){
  float lineDescriptionHeight = float(typeDescriptionHeight) * lineRatio;
  textFont(createFont("DroidSans", typeDescriptionHeight));
    
  color textColour = color(80, 80, 80);
  textAlign(CENTER);
  drawSomeText(multilineString1, 1000, descriptionYPos, textColour);
  drawSomeText(multilineString2, 1000, descriptionYPos + lineDescriptionHeight, textColour);

}


// SHARED FUNCTIONS


void drawDAlogo(){
  PShape dalogo = loadShape("da_logo.svg");
  shapeMode(CENTER);
  dalogo.scale(.7);
  shape(dalogo, 1000, 1610);

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


void openPDF(String albumName){
  
 // replace this with current path.
 String pathToFile = path + "\\" + albumName;
 print(pathToFile + "\n");
 
 if (Desktop.isDesktopSupported()) {
   try {
     // apparently this isn't cosher, but while developling i'm ok with this.
      Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler " + pathToFile);
      
      // ideally one uses these two lines insteaf of the Runtime line above.
      // File myFile = new File(pathToFile);
      // Desktop.getDesktop().open(myFile);
 
   } catch (IOException ex) {
        print("no application registered for PDFs");
   }
   
  }
   
}
  
  



