class CPicker{
  int x, y, w, h, c;
  
  // display colour area 
  int dH, dW;
  int gradHeight, gradWidth;
  PVector pos;
  PGraphics pg;
  PImage cpImage;
  boolean IS_VISIBLE = true;
  
  int bbleft, bbright, bbtop, bbbottom;
	
  CPicker (PVector pos, int w, int h, int c ){
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
    pg = createGraphics(w+40, h+80, JAVA2D);
    
    int cw = w - 60;
    for( int i=0; i<cw; i++ ){
      float nColorPercent = i / (float)cw;
      float rad = (-360 * nColorPercent) * (PI / 180);
      int nR = (int)(cos(rad) * 127 + 128) << 16;
      int nG = (int)(cos(rad + 2 * PI / 3) * 127 + 128) << 8;
      int nB = (int)(Math.cos(rad + 4 * PI / 3) * 127 + 128);
      
      // note the Bitwise inclusive OR operator.
      int nColor = nR | nG | nB;
			
      setGradient( i, 0, 1, gradHeight/2, 0xFFFFFF, nColor );
      setGradient( i, (gradHeight/2), 1, gradHeight/2, nColor, 0x000000 );
    }
  
    drawRect( cw, 0,   30, gradHeight/2, 0xFFFFFF );
    drawRect( cw, gradHeight/2, 30, gradHeight/2, 0 );
		
    // draw grey scale.
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
    int c;
    
    for (int j = y; j<(y+h); j++){
      JMinY = (j-y);
      r = red(c1) + JMinY * (deltaR/h);
      g = green(c1) + JMinY * (deltaG/h);
      b = blue(c1) + JMinY * (deltaB/h);
      c = color(r, g, b);
      cpImage.set(x, j, c);
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

    pg.beginDraw();
    pg.fill(240);
    pg.smooth();
    pg.noStroke();
    pg.rect(0, 0, w+40, h, 20);
    pg.endDraw();
    image(pg, pos.x, pos.y);
  
    image( cpImage, pos.x+20, pos.y+20 );
    if( mousePressed &&
	mouseX >= pos.x && 
	mouseX < bbright-20 &&
	mouseY >= pos.y &&
	mouseY < pos.y + h )
    {
      c = get( mouseX, mouseY );
    }
    
    // output colour.
    fill( c );
    noStroke();
    rect( pos.x+20, pos.y+gradHeight+25, w, dH);

    
  }


}
