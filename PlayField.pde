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
  
  int[][] collisionMatrix = new int[20][20];
  
  // The Player
  Player player;

  boolean upPressed;
  boolean downPressed;
  boolean leftPressed;
  boolean rightPressed;
  boolean spacePressed;

  public PlayField(int w, int h) {
    this.width = w;
    this.height = h;
    padding = winSize*5.0/100.0;
    numVLines = 16;
    numHLines = 13;
    gridSize = winSize-2*padding;
    balls = new ArrayList<AmigaBall>(); 
    player = new Player(this);
    
    upPressed = false;
    downPressed = false;
    leftPressed = false;
    rightPressed = false;
    spacePressed = false;
    
  }

  public float getHeight(){return this.height;}
  public float getWidth(){return this.height;}

  public void update() {


    
    for (AmigaBall ball : balls) {
      ball.update();
    }
    checkBallBallCollisions();
    checkBallPlayfieldCollisions();
    player.update();

  }

  private void checkBallBallCollisions() {
    int n = balls.size();
    for (int i=0; i<n; i++) {
      for (int j=i+1; j<n; j++) {
        if(collisionMatrix[i][j] == 0){
          AmigaBall b1 = balls.get(i);
          AmigaBall b2 = balls.get(j);
          if (b1.collidesWithBall(b2)) {
            b1.resolveBallBallCollision(b2);
            collisionMatrix[i][j] = 7;
          }
        } else { // collisionMatrix[i][j] != 0
          collisionMatrix[i][j]--;
        }
      }
    }
  }
  
  
  private void checkBallPlayfieldCollisions(){
    int n = balls.size();
    for (int i=0; i<n; i++) {
      AmigaBall b = balls.get(i);
      int pfc = b.collidesWithPlayfield(this);
      if(pfc != 0){
        b.resolvePlayfieldCollision(pfc);
      }
    }
  }


  public void display() {
    background(189, 189, 189);
    drawGrid();

    for (AmigaBall ball : balls) {
      ball.display();
    }
    
    player.display();
  }

  public void addBall() {
    balls.add(new AmigaBall());
  }

  public void mousePressed(int button) {
    if (button == LEFT) {
      balls.add(new AmigaBall());
    } else if (button == RIGHT && balls.size()>1 ) {
      balls.remove(0);
    }
  }

  void keyPressed(int k, int c) {
    if (k == CODED) {
      if (c == UP) {
        upPressed = true;
      }
      else if (c == DOWN) {
        downPressed = true;
      }
      else if (c == LEFT) {
        leftPressed = true;
      }
      else if (c == RIGHT) {
        rightPressed = true;
      }
    }else{
      if(k == ' '){
        spacePressed = true;
      }
    }
  }
  
  void keyReleased(int k, int c) {
    if (k == CODED) {
      if (c == UP) {
        upPressed = false;
      }
      else if (c == DOWN) {
        downPressed = false;
      }
      else if (c == LEFT) {
        leftPressed = false;
      }
      else if (c == RIGHT) {
        rightPressed = false;
      }
    }else{
      if(k == ' '){
        spacePressed = false;
      }
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

