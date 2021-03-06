class CPicker{
  int x, y, w, h;
  int bbleft, bbright, bbtop, bbbottom;
  int tpSliderW = 40;
  int sliderWidth = 30;
  
  // closebutton
  int offset = 8;
  Rectangle closeButton = new Rectangle();
  
  // display colour area 
  int dH, dW;
  int gradHeight, gradWidth;
  color c;
  PVector pos;
  PGraphics pg, tSlider;
  PImage cpImage;
  
  // transparency and the wide colour box at the bottom
  Rectangle colorBox = new Rectangle();
  Rectangle tBox = new Rectangle();
    
	
  CPicker (PVector pos, int w, int h, color c ){
    this.pos = pos;
    this.x = int(pos.x + 20);
    this.y = int(pos.y + 20);
    this.bbtop = int(pos.y);
    this.bbright = int(pos.x + w);
    this.bbleft = int(pos.x);
    this.w = w - 40;
    this.h = h;
    this.c = c;
    this.gradHeight = h-80;
    this.gradWidth = w-40;
    cpImage = new PImage(gradWidth, gradHeight);
    init();
  
  }

	
  void init (){
    
    dH = gradHeight/8;
    pg = createGraphics(w+40+tpSliderW+5, h+80+5, JAVA2D);

    // where is the yellow at?    might have to write my own, and scrap this monster.
    int cw = w - 60;
    for( int i=0; i<cw; i++ ){
      float nColorPercent = i / (float)cw;
      float rad = (-360 * nColorPercent) * (PI / 180);
      int nR = (int)(cos(rad) * 127 + 128) << 16;
      int nG = (int)(cos(rad + 2 * PI / 3) * 127 + 128) << 8;
      int nB = (int)(Math.cos(rad + 4 * PI / 3) * 127 + 128);
      int nColor = nR | nG | nB;
			
      setGradient( i, 0, 1, gradHeight/2, 0xFFFFFF, nColor );
      setGradient( i, (gradHeight/2), 1, gradHeight/2, nColor, 0x000000 );
    }
  
    // black and white
    drawRect( cw, 0,   30, gradHeight/2, 0xFFFFFF );
    drawRect( cw, gradHeight/2, 30, gradHeight/2, 0 );
		
    // grey scale.
    for( int j = 0; j< int(gradHeight); j++ ){
      int g = 255 - (int)(j/(float)(gradHeight-1) * 255 );
      drawRect( int(250), j, 30, 1, color( g, g, g ) );
    }
    
   }


  void setGradient(int x, int y, float w, float h, int c1, int c2 ){
    float deltaR = red(c2) - red(c1);
    float deltaG = green(c2) - green(c1);
    float deltaB = blue(c2) - blue(c1);
    float r, g, b, JMinY;
    int combo;
    
    for (int j = y; j<(y+h); j++){
      JMinY = (j-y);
      r = red(c1) + JMinY * (deltaR/h);
      g = green(c1) + JMinY * (deltaG/h);
      b = blue(c1) + JMinY * (deltaB/h);
      combo = color(r, g, b);
      cpImage.set(x, j, combo);
    }
    
  }
	

  void drawRect( int rx, int ry, int rw, int rh, int rc ){
    for(int i=rx; i<rx+rw; i++){
      for(int j=ry; j<ry+rh; j++){
        cpImage.set( i, j, rc );
      }
    }
    
  }

	
  void display (){
    drawBackground();
    image(cpImage, (pos.x + 20), (pos.y + 20));
    updateColourFromMouse();  // the indicator 'colourbox'
   
    // colour box
    colorBox = new Rectangle(pos.x+20, pos.y+gradHeight+25, w, dH);
    drawCheckeredBackground(colorBox);
    drawColourBox(colorBox); 

    // draw alpha slider
    drawTransparencyPicker();
    updateAlphaFromMouse();
    
    // draw buttons
    drawCloseButton();
        
  }
 
 
  void drawBackground(){
    pg.beginDraw();
    pg.smooth();
    pg.noStroke();
    pg.fill(240);
    pg.rect(0, 0, w+40, h, 20,0,0,20);  //should join [todo]
    pg.rect(w+40,0,40,h,0,20,20,0);
    pg.endDraw();
    image(pg, pos.x, pos.y);

  } 
  
  
  void drawColourBox(Rectangle colorBox){
    fill(c);
    noStroke();
    rect(colorBox.x, colorBox.y, colorBox.w, colorBox.h);
  
  }
    
  
  void drawCheckeredBackground(Rectangle cBoxRect){
    
    // draw base colour (white)
    noStroke();
    fill(255);
    rect(cBoxRect.x, cBoxRect.y, cBoxRect.w, cBoxRect.h);

    // draw checkered.    
    fill(150);
    int bHeight = cBoxRect.h/4;
    int bWidth = cBoxRect.w/30;
    for (int i = 15; i <= 30; i += 1){
      for (int j = 0; j < 4; j += 1){
        if ( i % 2 == 0 && j % 2 == 0){
          rect(cBoxRect.x + (bWidth*i), cBoxRect.y + bHeight*j, bWidth, bHeight);
        }
        if ( i % 2 == 0 && j % 2 != 0 && i < 30){
          rect(cBoxRect.x + (bWidth*(i+1)), cBoxRect.y + bHeight*j, bWidth, bHeight);
        }
   
      }     
       
    }
    
        
  }
  
 
  void drawTransparencyPicker(){
    fill(255);
    int sliderX = int(310+pos.x);
    int sliderY = int(20+pos.y);
    tBox = new Rectangle(sliderX, sliderY, sliderWidth, gradHeight);
    rect(tBox.x, tBox.y, tBox.w, tBox.h);

    // draw checkered.    
    fill(150);
    int bHeight = tBox.h/30;
    int bWidth = tBox.w/3;
    for (int i = 0; i < 3; i += 1){
      for (int j = 0; j < 30; j += 1){
        if ( i % 2 == 0 && j % 2 == 0){
          rect(tBox.x + (bWidth*i), tBox.y + bHeight*j, bWidth, bHeight);
        }
        if ( i % 2 == 0 && j % 2 != 0 && i < 2){
          rect(tBox.x + (bWidth*(i+1)), tBox.y + bHeight*j, bWidth, bHeight);
        }
   
      }     
       
    }

    drawGradientOverlay();
     
  }
 
 
  void drawGradientOverlay(){
    tSlider = createGraphics(int(sliderWidth), int(gradHeight), JAVA2D);
    tSlider.beginDraw();  
    int alphaValueUnit = int(tBox.h/255);
    
    for (int m = 0; m < tBox.h; m+=1){
      tSlider.noStroke();   
      int alpVal = int(alphaValueUnit*m);
      tSlider.fill(red(c),green(c),blue(c),alpVal);
      tSlider.rect(0, m, 30, 1);
    }

    tSlider.endDraw();
    image(tSlider, tBox.x, tBox.y);
    
  }
 
 
 
  void drawCloseButton(){
    pushStyle();
      noStroke();
      fill(133);
      ellipseMode(CORNER);
      float tleftSide = (pos.x + 343);
      float trightSide = (tleftSide + 30);
      float ttopSide = pos.y - 15;
      float tbottomSide = (ttopSide + 30);
      closeButton = new Rectangle(tleftSide, ttopSide, 30, 30);
      ellipse(closeButton.x, closeButton.y, closeButton.w, closeButton.h); 
      
      stroke(255);
      strokeWeight(4);
      noFill();
      // rect(tleftSide, pos.y, 30, 30);
      int offset = 8;
      line(tleftSide + offset, ttopSide + offset, trightSide - offset, tbottomSide - offset);
      line(tleftSide + offset, tbottomSide - offset, trightSide - offset, ttopSide + offset);
    popStyle();
    
    
    
  }
 
 
  
  void updateColourFromMouse(){
    if (mousePressed &&
  	mouseX >= pos.x && 
  	mouseX < bbright-20 &&
  	mouseY >= pos.y &&
  	mouseY < pos.y + h )
        {
        c = get( mouseX, mouseY );
        }  
          
  }
 
 
   void updateAlphaFromMouse(){
     if (mousePressed && 
        mouseX > tBox.x && 
        mouseX < (tBox.x + tBox.w) &&
        mouseY > tBox.y && 
        mouseY < (tBox.y + tBox.h))
        {  
        float realVal = mouseY - tBox.y;
        int foundAlpha = int( 255.0/gradHeight*realVal );
        // print(foundAlpha + "\n");
        
        c = color(red(c),green(c),blue(c), foundAlpha);
        }
        
    }
 
   // looked at when mouseReleased is encountered, in main thread.
   boolean over(){
     if (mouseX > closeButton.x + offset&&
        mouseX < closeButton.x + closeButton.w -offset&&
        mouseY > closeButton.y + offset&&
        mouseY < closeButton.y + closeButton.h -offset)
        {
        return true; 
        }
     else{
        return false;  
        }
   }
 
 
 
}
