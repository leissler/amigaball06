// Window variables
int winSize = 800;

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
  pf.mousePressed();
}

