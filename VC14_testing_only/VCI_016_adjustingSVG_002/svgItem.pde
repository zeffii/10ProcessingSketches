/*

void drawDAlogo() {
  float scaleAmount = 0.7;
  PShape dalogo = loadShape("da_logo.svg");
  float logoWidth = dalogo.width * scaleAmount;
  float logoHeight = dalogo.height * scaleAmount;
  
  dalogo.scale(scaleAmount);
  shapeMode(CORNER);
  shape(dalogo, centerSideA.x - (logoWidth/2), logoCenterY - (logoHeight/2));
}

*/

class SVGItem{
  
 PShape svgItem;
 float scaleValue;
 PVector pos;
 float svgWidthOriginal;
 float svgHeightOriginal; 
 float svgWidth;
 float svgHeight; 
 String filename;
 boolean state = true;
 float bbleft, bbright, bbtop, bbbottom;
 boolean selected = false;
 boolean hidden = false;
 boolean locked = true;
 
 SVGItem(String filename, PVector pos){
   
   this.filename = filename;
   this.svgItem = loadShape(filename); 
   this.pos = pos;
   svgWidthOriginal = this.svgItem.width;
   svgHeightOriginal = this.svgItem.height; 

   this.scaleValue = .25;
   svgWidth = svgWidthOriginal * scaleValue;
   svgHeight = svgHeightOriginal * scaleValue;
   svgItem.scale(scaleValue);

 }
 
 void display(){
      
   shapeMode(CORNER);
   shape(svgItem, pos.x - (svgWidth/2), pos.y - (svgHeight/2));
   
   // should be an if, instead of a function call here. shouldn't be too difficult.
   // problem exists in TextBox class too.
   drawBoundingBox();
   
 }
 
 void drawBoundingBox(){
   bbleft = pos.x - (svgWidth/2);
   bbtop = pos.y - (svgHeight/2);
   bbright = pos.x + (svgWidth/2);
   bbbottom = pos.y + (svgWidth/2);

   if (selected){
     stroke(255, 150, 150);
     rect(bbleft, pos.y - (svgHeight/2), svgWidth, svgHeight); 
     
     // check for keypresses
     // increaseScale();
     // decreaseScale();
     
   }
 }
 
 void setLocation(PVector newLocation){
   pos = newLocation;
 }
 
 void increaseScale(){ 
   adjustDimensions(1.01);
      
 }
 
 void decreaseScale(){
   adjustDimensions(.99);
   
 }
 
 void adjustDimensions(float scaleVal){
   svgItem.scale(scaleVal);
   svgWidth *= scaleVal;
   svgHeight *= scaleVal; 
   
 }
 
 void resetScale(){
   svgItem = loadShape(filename);
   svgItem.scale(.25);
   
 }
  
 boolean over(){
    if (mouseX > bbleft && mouseX < bbright &&
        mouseY > bbtop && mouseY < bbbottom){
      return true;
    } else{
      return false;
    }
  }
  
  
  // getter setter.
  
  
  void setXY(PVector nPos){
      pos = nPos;
          
  }
    
  PVector getXY(){
     return pos; 
    
  }
  
  void hide(){
    hidden = true;   
  }
  
  void show(){
    hidden = false; 
  }
  
}
