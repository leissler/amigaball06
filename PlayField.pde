class PlayField {

  // Grid variables
  private float padding;
  private int numVLines;
  private int numHLines;
  private float gridSize;
  private int height;
  private int width;

  // The list of balls
  private ArrayList<AmigaBall> balls;

  private boolean checkBallCollisions;

  public PlayField(int w, int h) {
    this.width = w;
    this.height = h;
    padding = winSize*5.0/100.0;
    numVLines = 16;
    numHLines = 13;
    gridSize = winSize-2*padding;
    balls = new ArrayList<AmigaBall>();
    checkBallCollisions = true;
  }

  public void update() {
    for (AmigaBall ball : balls) {
      ball.update();
    }
    checkBallBallCollisions();
  }

  private void checkBallBallCollisions() {
    int n = balls.size();
    for (int i=0; i<n; i++) {
      for (int j=i+1; j<n; j++) {
        AmigaBall b1 = balls.get(i);
        AmigaBall b2 = balls.get(j);
        if (b1.collidesWith(b2)) {
          b1.resolveCollision(b2);
        }
      }
    }
  }
  
  private void checkBallPlayfieldCollisions(){
    int n = balls.size();
    for (int i=0; i<n; i++) {
      
    }
  }
  


  public void display() {
    background(189, 189, 189);
    drawGrid();

    for (AmigaBall ball : balls) {
      ball.draw();
    }
  }

  public void addBall() {
    balls.add(new AmigaBall());
  }

  public void mousePressed() {
    if (mouseButton == LEFT) {
      balls.add(new AmigaBall());
    } else if (mouseButton == RIGHT && balls.size()>1 ) {
      balls.remove(0);
    }
  }

  private void drawGrid() {
    stroke(155, 29, 227);
    strokeWeight(3);

    float xpos = padding;
    float ypos = padding;

    float xStep = gridSize/(numVLines-1);
    float yStep = gridSize/(numHLines-1);

    for (int vlines = 0; vlines < numVLines; vlines++) {
      line(xpos, padding, xpos, padding+gridSize);
      xpos += xStep;
    }

    for (int hlines = 0; hlines < numHLines; hlines++) {
      line(padding, ypos, padding+gridSize, ypos);
      ypos += yStep;
    }
  }
}

