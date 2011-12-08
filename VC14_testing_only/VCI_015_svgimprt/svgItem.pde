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
 PVector position;
 float svgWidth;
 float svgHeight; 
 
 SVGItem(String filename, PVector pos, float scaleValue){
   
   this.svgItem = loadShape(filename); 
   this.position = pos;
   this.scaleValue = scaleValue;
   this.svgWidth = this.svgItem.width * scaleValue;
   this.svgHeight = this.svgItem.height * scaleValue; 
   this.svgItem.scale(scaleValue);
 }
 
 void display(){
      
   shapeMode(CORNER);
   shape(svgItem, position.x - (svgWidth/2), position.y - (svgHeight/2)); 
 }
 
 void setLocation(PVector newLocation){
   position = newLocation;
 }
 
 void setScale(float scaleValue){
   svgItem.scale(1.0); // back to normal.
   svgItem.scale(scaleValue);
   this.scaleValue = scaleValue;
      
 }
 
 
  
}
