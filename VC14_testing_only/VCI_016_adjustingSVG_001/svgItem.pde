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
 }
 
 void setLocation(PVector newLocation){
   pos = newLocation;
 }
 
 void increaseScale(float scaleValue){
   svgItem.scale(1.01);     
 }
 
 void decreaseScale(float scaleValue){
   svgItem.scale(.99);     
 }
 
 void resetScale(){
   svgItem = loadShape(filename);
   svgItem.scale(.25);
   
 }
  
}
