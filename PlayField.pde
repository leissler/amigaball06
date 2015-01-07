class PlayField {

  // Games current state
  // 0 = Game Running
  // 1 = Game Over
  int gameState; 
  
  // Grid variables
  private float padding;
  private int numVLines;
  private int numHLines;
  private float gridSize;
  private int height;
  private int width;

  // The list of balls
  private ArrayList<GameObject> balls;
  
  int[][] ballCollisionMatrix = new int[20][20];
  
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
    balls = new ArrayList<GameObject>(); 
    player = new Player(this);
    
    upPressed = false;
    downPressed = false;
    leftPressed = false;
    rightPressed = false;
    spacePressed = false;
    
    gameState = 0; // Running
    
  }

  public float getHeight(){return this.height;}
  public float getWidth(){return this.height;}

  public void update() {
    switch(gameState){
      case 0: // Running
        for (GameObject ball : balls) {
          ball.update();
        }
        checkBallBallCollisions();
        checkBallPlayfieldCollisions();
        checkBallBulletCollisions();
        checkBallPlayerCollisions();
        player.update();     
      break;
      
      case 1: // Over
        if(spacePressed){
          gameState = 0;
          balls.clear();
          player = new Player(this);
        }
      break;
    }
  }

  private void checkBallBulletCollisions() {
    ArrayList<GameObject> bullets = player.getBulletList();
    int n = bullets.size();
    int m = balls.size();
    Bullet bullet;
    AmigaBall ball;
    for (int i=0; i<n; i++) { // Each bullet
      for (int j=0; j<m; j++) { // Each ball
        bullet = (Bullet)bullets.get(i);
        ball = (AmigaBall)balls.get(j);
        if(bullet.collidesWith(ball)){
          balls.remove(j);
          bullets.remove(i);
          return;
        }
      }
    }
  }

  private void checkBallPlayerCollisions() {
    int n = balls.size();
    AmigaBall ball;
    for (int i=0; i<n; i++) { // Each ball
      ball = (AmigaBall)balls.get(i);
      if(player.collidesWith(ball)){
        gameState = 1; // Over
      }
    }
  }

  private void checkBallBallCollisions() {
    int n = balls.size();
    AmigaBall b1,b2;
    for (int i=0; i<n; i++) {
      for (int j=i+1; j<n; j++) {
        if(ballCollisionMatrix[i][j] == 0){
          b1 = (AmigaBall)balls.get(i);
          b2 = (AmigaBall)balls.get(j);
          if (b1.collidesWithBall(b2)) {
            b1.resolveBallBallCollision(b2);
            ballCollisionMatrix[i][j] = 5;
          }
        } else { // ballCollisionMatrix[i][j] != 0
          ballCollisionMatrix[i][j]--;
        }
      }
    }
  }
  
  
  private void checkBallPlayfieldCollisions(){
    int n = balls.size();
    for (int i=0; i<n; i++) {
      AmigaBall b = (AmigaBall)balls.get(i);
      int pfc = b.collidesWithPlayfield(this);
      if(pfc != 0){
        b.resolvePlayfieldCollision(pfc);
      }
    }
  }


  public void display() {
    switch(gameState){
      case 0: // Running
        background(189, 189, 189);
        drawGrid();
    
        for (GameObject ball : balls) {
          ball.display();
        }
        
        player.display();
      break;

      case 1: // Over
        fill(255,0,0);
        textAlign(CENTER);
        textSize(100);
        text("GAME OVER", this.width/2, this.height/2);
        textSize(50);
        text("(Press SPACE)", this.width/2, this.height/2+70);
      break;
    }
    
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

