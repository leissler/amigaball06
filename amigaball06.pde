// Window variables
int winSize = 900;

PlayField pf;

void setup() {
  size(winSize, winSize);
  pf = new PlayField(width, height);
};

void draw() {  
  pf.update();
  pf.display();
};

void mousePressed(){
  pf.mousePressed(mouseButton);
}

void keyPressed(){
  pf.keyPressed(key,keyCode);
}

void keyReleased(){
  pf.keyReleased(key,keyCode);
}
