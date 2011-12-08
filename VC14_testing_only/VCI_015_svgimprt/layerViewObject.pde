class LayerViewObject{
  
   // layers can store TextBoxes and SVG
   // layers are assigned a drawOrder.
   // accepts a LayersObject eventually.
   PVector pos;
   int numLayers = 0;
   int LAYER_WIDTH = int(LAYER_VIEW_WIDTH * 0.91); // or .96 if layersView needs a vertical slider
   int LAYER_HEIGHT = 30;
   int LAYER_SPACER = 3;
  
   LayerViewObject(PVector position){
    
     pos = position; 
     // numLayers = nLayers;
    
   } 
  
   void display(){
     
     // to prevent leakage.
     int yPos = int(pos.y + 10);
     
     pushStyle();
       fill(250, 250, 250);
       stroke(150,150,150);
       rect(pos.x, pos.y, LAYER_VIEW_WIDTH, 180, 4);
       
       for (int i = 0; i < numLayers; i+=1){
         
         drawLayer(new PVector(pos.x+10, yPos));
         yPos += (LAYER_HEIGHT + LAYER_SPACER);
         
       }
   
     popStyle();  
          
   }
  
  
   void addLayer(){
     numLayers += 1;  
     
   }
   
   void removeLayer(){
     if (numLayers >= 0) numLayers -= 1; 
     
   }
  
   void drawLayer(PVector layerPos){
     fill(255,255,255);
     stroke(220, 220, 220);
     
     rect(layerPos.x, layerPos.y, LAYER_WIDTH, LAYER_HEIGHT);
     
        
   } 
  
  
}
