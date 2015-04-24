// Window variables
int winSize = 1100;

PlayField pf;

void setup() {
  size(winSize, winSize);
  int i= height;
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
