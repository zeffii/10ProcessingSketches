void drawLabels(){
  noStroke();
  ellipseMode(CENTER);
  fill(leftLabelColour);
  ellipse(centerA.x, centerA.y, LABEL_DIAMETER, LABEL_DIAMETER);  
    
  ellipseMode(CENTER);
  fill(rightLabelColour);
  ellipse(centerB.x, centerB.y, LABEL_DIAMETER, LABEL_DIAMETER);  
    
}


void drawCrossHair(PVector pos, color xColor){
  float arm = 5;
  strokeWeight(1);
  stroke(xColor);
  line(pos.x-arm, pos.y+arm, pos.x+arm, pos.y-arm);
  line(pos.x-arm, pos.y-arm, pos.x+arm, pos.y+arm);
  
}


void drawContour(PVector pos, float circRadius, color contourColour){
  strokeWeight(1);
  stroke(contourColour);
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


// for design
void drawGrid(PVector cPoint, color gridColor) {
    
  float leftX = cPoint.x - OUTER_MOST_RADIUS;
  float rightMost = leftX + LABEL_DIAMETER;  
  float topY = cPoint.y - OUTER_MOST_RADIUS;
  float bottomY = cPoint.y + OUTER_MOST_RADIUS;
  float gridRowHeight = LABEL_DIAMETER / (gridRows);
  float gridColWidth = LABEL_DIAMETER / (gridCols);
  
  strokeWeight(1);
  stroke(gridColor);

  for (int j = 0; j <= gridRows; j++) {
    float yvar = gridRowHeight*j;
    line(leftX, topY + yvar, rightMost, topY + yvar);
  }

  for (int i = 0; i <= gridCols; i++) {
    line(leftX, topY, leftX, bottomY);
    leftX += gridColWidth;
  }
  
}


void drawFauxClipPath(PVector cPoint) {
  // first loose outer fit, then snug tight final fit. 
  drawLoosePath(cPoint);
  drawSnugPath(cPoint);
  stroke(1);
 
}


void drawLoosePath(PVector cPoint) {
  fill(255);
  noStroke();

  // leftside  
  beginShape();
  for (int i = 90; i <= 270; i++) {
    PVector coordinate = getVectorFromDegreeAndRadius(i, OUTER_MOST_RADIUS+5);
    vertex(coordinate.x + cPoint.x, coordinate.y + cPoint.y);
  } 
  vertex(cPoint.x, 0);
  vertex(cPoint.x-OUTER_MOST_RADIUS-10, 0);
  vertex(cPoint.x-OUTER_MOST_RADIUS-10, cPoint.y + OUTER_MOST_RADIUS+20);
  vertex(cPoint.x, cPoint.y + OUTER_MOST_RADIUS+20);
  endShape(CLOSE);

  // rightside
  beginShape();
  for (int i = 90; i >= -90; i--) {
    PVector coordinate = getVectorFromDegreeAndRadius(i, OUTER_MOST_RADIUS+5);
    vertex(coordinate.x + cPoint.x, coordinate.y + cPoint.y);
  } 
  vertex(cPoint.x, 0);
  vertex(cPoint.x+OUTER_MOST_RADIUS+10, 0);
  vertex(cPoint.x+OUTER_MOST_RADIUS+10, cPoint.y + OUTER_MOST_RADIUS+20);
  vertex(cPoint.x, cPoint.y + OUTER_MOST_RADIUS+20);
  endShape(CLOSE);
  
  // draw gap filler
  float junkOffset = 6;
  beginShape();
    vertex(APP_WIDTH/2 - junkOffset, 0);
    vertex(APP_WIDTH/2 + junkOffset, 0);
    vertex(APP_WIDTH/2 + junkOffset, cPoint.y + OUTER_MOST_RADIUS+20);
    vertex(APP_WIDTH/2 - junkOffset, cPoint.y + OUTER_MOST_RADIUS+20);
 endShape(CLOSE);
  
}


void drawSnugPath(PVector cPoint) {
  noFill();
  strokeWeight(7);
  stroke(255);
  float cRad = LABEL_DIAMETER+8;
  // float cRad = 300;
  ellipseMode(CENTER);
  ellipse(cPoint.x, cPoint.y, cRad, cRad);
  strokeWeight(1);

} 



// U I   d e b u g   d r a w i n g



void drawUIGrid() {
  
  // thar be dragons 'ere! 
  // 06 Dec, i had to rename variables to prevent collision, which i think
  // might be a bug in the scope resolution, but it's probably my newbness.
  
  int uiGridRows = 14;
  int uiGridCols = 14*3;
  float leftX = 0;
  float rightX = APP_WIDTH;
  float bottomY = APP_HEIGHT;
  float uiGridRowHeight = (bottomY - uiTopY) / uiGridRows;
  float uiGridColWidth = rightX / uiGridCols;
    
  strokeWeight(1);
  stroke(uiGridColour);
 
  for (int j = 0; j <= uiGridRows; j++) {
    float yvar = uiGridRowHeight*j;
    line(leftX, uiTopY + yvar, rightX, uiTopY + yvar);
  }

  for (int i = 0; i <= uiGridCols; i++){
    float xvar = uiGridColWidth*i;
    line(leftX + xvar, uiTopY, leftX + xvar, bottomY);
  }
 
}



// m a t h y   d r a w i n g   s t u f f 



PVector getVectorFromDegreeAndRadius(int i, float rad) {
  PVector coordinate = new PVector(cos(radians(i))*rad, sin(radians(i))*rad);
  return coordinate;
}

