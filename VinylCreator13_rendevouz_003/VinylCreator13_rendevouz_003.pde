/* 
Vinyl Art Work Generator. 
By Dealga McArdle Nov 2011.
Released under MIT license.

30 Nov. split into seperate files for readability.
1 Dec.  refactor and code rearrangement.

read the included prototype.txt for the list of things
i want to add to make this a full program.
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
  drawRaster(centerSideB);
  drawFauxClipPath(centerSideB);  
  drawTrackList("B");
  drawCrossHair(centerSideB, innerRadius/2);  
  drawBleed(centerSideB, color(250, 250, 250));
  drawGrid(centerSideB);
   
  // side A
  drawForcedBackground();
  drawOutlines(centerSideA);
  drawTrackList("A");  
  drawDAlogo();
  drawDescription();
  drawFauxClipPath(centerSideA);
  drawCrossHair(centerSideA, innerRadius/2);
  drawBleed(centerSideA, color(20, 20, 255));
  drawGrid(centerSideA);
    
  print("\nDone\n");
  exit();
  
  if (displayAfterwards){
    openPDF(albumName);
  }
  
}


/*    S I D E   B    */


// draws the non vector .png underneath the circular 'clippath'
void drawRaster(PVector rasterPos){
  PImage img = getImage();
  performTransformsAndDraw(rasterPos, img);  
  printImageStats(img);
}


void drawOutlines(PVector centrePoint){
 drawEllipse(centrePoint, outerRadius, outer);
 drawEllipse(centrePoint, innerRadius, inner);
}


/*    S I D E   A    */


void drawForcedBackground(){
 fill(250);
 noStroke();
 rect(0,0,2000,2000);
}


void drawDescription(){
  textFont(createFont("DroidSans", typeDescriptionHeight));
  textAlign(CENTER);  
  color textColour = color(80, 80, 80);
  drawText(multilineString1, new PVector(1000, descriptionYPos), textColour);
  drawText(multilineString2, new PVector(1000, descriptionYPos + lineDescriptionHeight), textColour);
}


/*     S H A R E D  F U N C T I O N S    */


void drawTrackList(String SIDE){  
  float x1 = leftAlignX;
  float y1 = typeInitY;
  textFont(createFont("DroidSans", typeHeight));
  
  textAlign(LEFT);
  if (SIDE.equals("A")){
    color textColour = color(80, 80, 80);
    drawText(track1A, new PVector(x1, y1), textColour);
    drawText(track2A, new PVector(x1, y1+lineHeight), textColour);
  }
  
  if (SIDE.equals("B")){
    x1 += 2000;
    if (BGNEEDED){
      PVector BGCoordinate = new PVector(x1,y1);
      drawBackgroundForTracknames(BGCoordinate, lineHeight); 
    }
    
    color textColour = color(250, 250, 250);
    drawText(track1B, new PVector(x1, y1+(lineHeight*0)), textColour);
    drawText(track2B, new PVector(x1, y1+(lineHeight*1)), textColour);
  }
}


// not very friendly if i want to make both A and B potentially 
// take a background under the trackname.
void drawBackgroundForTracknames(PVector co, float lineHeight){
  noStroke();    
  fill(0);
  float longestText = max(textWidth(track2B), textWidth(track1B)); 
  ellipseMode(CORNER);
  
  if (useRoundedTextBackground){
    
    if (roundedBGmode == 0){
      rect(co.x, co.y - textAdjustY, longestText, boxHeight);
      ellipse(co.x - (boxHeight/2), co.y - textAdjustY, boxHeight, boxHeight);     
      ellipse(co.x + longestText - (boxHeight/2),  co.y - textAdjustY, boxHeight, boxHeight); 
    }
    
    if (roundedBGmode == 1){     
      drawSpecialBGmode(co, lineHeight);
    }
    
  }
  else{  // no fx , just a blok of colour beneath the text.
    rect(co.x, co.y - textAdjustY, longestText, boxHeight);
  }
} 


void drawDAlogo(){
  PShape dalogo = loadShape("da_logo.svg");
  shapeMode(CENTER);
  dalogo.scale(.7);
  shape(dalogo, centerSideA.x, logoCenterY);
}


void drawText(String mString, PVector co, color tCol){
 fill(tCol);
 text(mString, co.x, co.y);
}


void drawCrossHair(PVector centrePoint, float hairLength){
  if (crossHair){
    stroke(130);
    strokeWeight(2);
    line(centrePoint.x, centrePoint.y + hairLength, centrePoint.x, centrePoint.y - hairLength);
    line(centrePoint.x -hairLength, centrePoint.y, centrePoint.x + hairLength, centrePoint.y);
    noStroke(); // reset to defaults
  }
}


void drawEllipse(PVector centrePoint, float mainRadius, boolean drawStroke){
 if (drawStroke){
    stroke(150, 150, 255);
    strokeWeight(4);
 }
 else{  
   noStroke();
 }
 noFill();
 ellipseMode(RADIUS);
 ellipse(centrePoint.x, centrePoint.y, mainRadius, mainRadius);
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
      
      // ideally one uses these two lines instead of the Runtime line above.
      // File myFile = new File(pathToFile);
      // Desktop.getDesktop().open(myFile);
 
   } catch (IOException ex) {
        print("no application registered for PDFs");
   }
 }
}
  
  
String getRandomImageName(){
  String[] imageNameArray = new String[2];
  imageNameArray[0] = "shape_005_03.png";
  imageNameArray[1] = "shape_005_03b.png";
  // etc..
  // etc..
  int arrayLength = imageNameArray.length;
  Random generator = new Random();
  int randomIndex = generator.nextInt(arrayLength);
  return imageNameArray[randomIndex];    
}


void rotateImage(PImage img){
  pushMatrix();
    translate(centerSideB.x, centerSideB.y);
    float randomRotation = random(0, TWO_PI);
    print("\ncurrent rotation: " + str(randomRotation));
    rotate(randomRotation);  
    image(img, 0, 0);
  popMatrix();
}


void setRandomTint(){
  Random tintR = new Random();
  Random tintG = new Random();
  Random tintB = new Random();
  int rTintR = tintR.nextInt(156) + 100;
  int rTintG = tintR.nextInt(156) + 100;
  int rTintB = tintR.nextInt(156) + 100;
  tint(rTintR, rTintG, rTintB);
      
  print("\n"); // in case it's cool
  print(str(rTintR) + "," + str(rTintG) + "," + str(rTintB));
}


void printImageStats(PImage img){
  print("using image name " + selectedImageName + "\n");  
  print("image width: " + img.width + ", " + "image height: " + img.height);
}


PVector getRandomPosition(PImage img){
    imageMode(CORNER);
    float xVariation = (img.width - 2000);
    float yVariation = (img.height - 2000);
    float x = random(2000, 2000-xVariation);
    float y = random(0, -yVariation);
    return new PVector(x, y);
}


String getImageName(){
  String imageName = "shape_005_03.png";
      
  if (randomImage){
    imageName = getRandomImageName();
  }
  return imageName;
}


void doTint(){
  if (semiRandomTintFX){
    setRandomTint();
  }else{
    noTint();
  }
}


PImage getImage(){
  imageMode(CENTER);
  String imageName = getImageName();
  doTint();
  selectedImageName = imageName;
  return loadImage(imageName);
}


void performTransformsAndDraw(PVector rasterPos, PImage img){
  if (randomImagePosition){
    rasterPos = getRandomPosition(img);
    image(img, rasterPos.x, rasterPos.y);  
  }
        
  if (randomImageRotate){
      rotateImage(img);
  }
}


PVector getVectorFromDegree(int i) {
  PVector coordinate = new PVector(cos(radians(i))*990, sin(radians(i))*990);
  return coordinate;
}


PVector getVectorFromDegreeAndRadius(int i, float rad) {
  PVector coordinate = new PVector(cos(radians(i))*rad, sin(radians(i))*rad);
  return coordinate;
}


void drawFauxClipPath(PVector cPoint){
  // first loose outer fit, then snug tight final fit. 
  drawLoosePath(cPoint);
  drawSnugPath(cPoint);
     
  if (drawSideBClipLimits){  
    drawOuterBounds(cPoint);
  }
}


void drawLoosePath(PVector cPoint){
  fill(255);
  noStroke();
  
  // leftside  
  beginShape();
    for (int i = 90; i <= 270; i++){
      PVector coordinate = getVectorFromDegreeAndRadius(i, 990);
      vertex(coordinate.x + cPoint.x, coordinate.y + cPoint.y); 
    } 
    vertex(cPoint.x, 0);
    vertex(cPoint.x-1000, 0);
    vertex(cPoint.x-1000, 2000);
    vertex(cPoint.x, 2000);
  endShape(CLOSE);

  // rightside
  beginShape();
    for (int i = 90; i >= -90; i--){
      PVector coordinate = getVectorFromDegreeAndRadius(i, 990);
      vertex(coordinate.x + cPoint.x, coordinate.y + cPoint.y); 
    } 
    vertex(cPoint.x, 0);
    vertex(cPoint.x+1000, 0);
    vertex(cPoint.x+1000, 2000);
    vertex(cPoint.x, 2000);
  endShape(CLOSE);
}


void drawBleed(PVector cPoint, color bColor){
   noFill();
   stroke(bColor);
   strokeWeight(2);

   for (int i = 0; i < 360-1; i+=2){
     if (i%2 == 0){
       stroke(bColor);
     }else{
       noStroke();  
     }
     PVector coord = getVectorFromDegreeAndRadius(i, bleedRadius);
     PVector coord2 = getVectorFromDegreeAndRadius(i+1, bleedRadius);
     line(coord.x + cPoint.x, coord.y + cPoint.y, coord2.x + cPoint.x, coord2.y + cPoint.y);
   }
}


void drawSnugPath(PVector cPoint){
  noFill();
  strokeWeight(20);
  stroke(255);
  float cRad = 1984;
  // float cRad = 300;
  ellipseMode(CENTER);
  ellipse(cPoint.x, cPoint.y, cRad, cRad);
} 


void drawOuterBounds(PVector cPoint){
  // the white underneath should not be visible inside the green boundary.
  stroke(0, 255, 0);
  strokeWeight(4);
  noFill();
  ellipseMode(RADIUS);
  ellipse(cPoint.x, cPoint.y, outerRadius, outerRadius);
}


void drawSpecialBGmode(PVector co, float lineHeight){

  // a rect for each line of text
  rect(co.x, (co.y - textAdjustY), textWidth(track1B), boxHeight/2);
  rect(co.x, (co.y + lineHeight - textAdjustY), textWidth(track2B), boxHeight/2);
  float ellipseRadius = (co.y + lineHeight-textAdjustY + (boxHeight/2)) - (co.y - textAdjustY);
 
  // ellipse on the left is full size
  ellipse(co.x - (ellipseRadius / 2), co.y - textAdjustY, ellipseRadius, ellipseRadius); // left
  
  // ellipse (2x) on the right are relative to the height of their rect.
  float r1X = (co.x + textWidth(track1B) - boxHeight/4);
  float r1Y = co.y - textAdjustY;
  float r2X = (co.x + textWidth(track2B) - boxHeight/4);
  float r2Y = co.y + lineHeight - textAdjustY;
  ellipse(r1X, r1Y, boxHeight/2, boxHeight/2); //right
  ellipse(r2X, r2Y, boxHeight/2, boxHeight/2); //right
}


void drawGrid(PVector cPoint){
  
  float leftX = cPoint.x - 980;
  float topY = cPoint.y - 980;
  float bottomY = cPoint.y + 980;
  
  strokeWeight(1);
  stroke(gridColor);

  float rightMost = leftX + totalWidth;
  for (int j = 0; j <= gridRows; j++){
    float yvar = gridRowHeight*j;
    line(leftX, topY + yvar , rightMost, topY + yvar);
  }
  
  for (int i = 0; i <= gridCols; i++){
    line(leftX, topY, leftX, bottomY);
    leftX += gridColWidth;  
    
  }
  
}

