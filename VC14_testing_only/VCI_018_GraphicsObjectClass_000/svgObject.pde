class SVGObject extends GraphicsObject{ 
  
 PShape svgItem;
 float scaleValue;
 float svgWidthOriginal;
 float svgHeightOriginal; 
 float svgWidth;
 float svgHeight; 
 String filename;
 
 // constructor
 SVGObject(PVector pos, String _filename){
   super(pos);
   filename = _filename;
   svgItem = loadShape(_filename); 
   svgWidthOriginal = svgItem.width;
   svgHeightOriginal = svgItem.height; 

   scaleValue = .25;
   svgWidth = svgWidthOriginal * scaleValue;
   svgHeight = svgHeightOriginal * scaleValue;
   svgItem.scale(scaleValue);

 }
 
 
 void display(){
   // because scaling occurs from one side, and not uniform from the center 
   // (as far as i can tell) , it's necessary to do it this way.
   
   shapeMode(CORNER);
   shape(svgItem, pos.x - (svgWidth/2), pos.y - (svgHeight/2));
   
   bbleft = pos.x - (svgWidth/2);
   bbright = pos.x + (svgWidth/2);
   bbtop = pos.y - (svgHeight/2);
   bbbottom = pos.y + (svgHeight/2);
         
   if (selected) drawBoundingBox();
   
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
 
 
 String nature(){
    return "svg\n"; 
 
 }
 
 
}
