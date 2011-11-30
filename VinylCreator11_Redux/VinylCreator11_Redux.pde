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
    tXpos = random(2000, 2000-xVariation);
    tYpos = random(0, -yVariation);
  
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
  }
  else{
    if (randomRotateImage){
      pushMatrix();
        translate(3000,1000);
        float randomRotation = random(0, TWO_PI);
        print("\ncurrent rotation: " + str(randomRotation));
        rotate(randomRotation);  
        image(img, 0, 0);
      popMatrix();
    
    }
  }

}


void drawFauxClipPath(float cPointX, float cPointY){
  // the ugly way.. but it got the job done.
  
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

  // add faux clipping mask to snuggly clip the outline
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


void drawDescription(){
  float lineDescriptionHeight = float(typeDescriptionHeight) * lineRatio;
  textFont(createFont("DroidSans", typeDescriptionHeight));
    
  color textColour = color(80, 80, 80);
  textAlign(CENTER);
  drawText(multilineString1, 1000, descriptionYPos, textColour);
  drawText(multilineString2, 1000, descriptionYPos + lineDescriptionHeight, textColour);

}


// SHARED FUNCTIONS


void drawTrackList(String SIDE){  
  float x1 = leftAlignX;
  float y1 = typeInitY;
  float lineHeight = float(typeHeight) * lineRatio;
  textFont(createFont("DroidSans", typeHeight));
  
  textAlign(LEFT);
  if (SIDE.equals("A")){
    color textColour = color(80, 80, 80);
    drawText(track1A, x1, y1, textColour);
    drawText(track2A, x1, y1+lineHeight, textColour);

  }
  
  if (SIDE.equals("B")){
    x1 += 2000;
    
    boolean BGNEEDED = true;
    if (BGNEEDED){
      drawBackgroundForTracknames(x1, y1, lineHeight); 
    }
    
    color textColour = color(250, 250, 250);
    drawText(track1B, x1, y1+(lineHeight*0), textColour);
    drawText(track2B, x1, y1+(lineHeight*1), textColour);

  }
  
}

// not very friendly if i want to make both A and B potentially take a backgroud under the trackname.
void drawBackgroundForTracknames(float x1, float y1, float lineHeight){
  float boxHeight = 178;
  noStroke();    
  fill(0);
  float textAdjustY = typeHeight+3;
  float longestText = max(textWidth(track2B), textWidth(track1B)); 
  ellipseMode(CORNER);
  
  if (useRoundedTextBackground){
    
    if (roundedBGmode == 0){
      rect(x1, y1-textAdjustY, longestText, boxHeight);
      ellipse(x1 - (boxHeight/2), y1-textAdjustY, boxHeight, boxHeight);     
      ellipse(x1 + longestText - (boxHeight/2),  y1-textAdjustY, boxHeight, boxHeight); 

    }
    
    if (roundedBGmode == 1){     
      // a rect for each line of text
      rect(x1, (y1 - textAdjustY), textWidth(track1B), boxHeight/2);
      rect(x1, (y1 + lineHeight - textAdjustY), textWidth(track2B), boxHeight/2);
      float ellipseRadius = (y1+lineHeight-textAdjustY + (boxHeight/2)) - (y1 - textAdjustY);
   
      // ellipse on the left is full size
      ellipse(x1 - (ellipseRadius/2), y1-textAdjustY, ellipseRadius, ellipseRadius); // left
      
      // ellipse (2x) on the right are relative to the height of their rect.
      float r1X = (x1 + textWidth(track1B) - boxHeight/4);
      float r1Y = y1 - textAdjustY;
      float r2X = (x1 + textWidth(track2B) - boxHeight/4);
      float r2Y = y1 + lineHeight - textAdjustY;
      ellipse(r1X, r1Y, boxHeight/2, boxHeight/2); //right
      ellipse(r2X, r2Y, boxHeight/2, boxHeight/2); //right

    }
    
  }
  else{  // no fx , just a blok of colour beneat the text.
    rect(x1, y1-textAdjustY, longestText, boxHeight); // no fx, just black background.
  }
  
} 


void drawDAlogo(){
  PShape dalogo = loadShape("da_logo.svg");
  shapeMode(CENTER);
  dalogo.scale(.7);
  shape(dalogo, 1000, 1610);

}


void drawText(String mString, float dX, float dY, color tCol){
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
  
  



