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



// m a t h y   d r a w i n g   s t u f f 



PVector getVectorFromDegreeAndRadius(int i, float rad) {
  PVector coordinate = new PVector(cos(radians(i))*rad, sin(radians(i))*rad);
  return coordinate;
}
