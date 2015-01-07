class Player extends GameObject {

  int coolDownTime;
  private int fireCooldown;

  ArrayList<Bullet> bulletList;

  Player(PlayField p) {
    this.pf = p;
    this.img = loadImage("rocket.png");
    imageMode(CENTER);
    this.w = img.width;
    this.h = img.height;
    this.x = pf.getWidth()/2; 
    this.y = pf.getHeight() - h/2;
    this.xSpeed = 5;

    bulletList = new ArrayList<Bullet>();
    fireCooldown = 0;
    coolDownTime = 10;
  }

  void display() {
    image(img, x, y);

    for (Bullet bullet : bulletList) {
      bullet.display();
    }
  }

  void update() {
    if (pf.leftPressed) {
      x -= xSpeed;
    }
    if (pf.rightPressed) {
      x += xSpeed;
    }
    if (pf.spacePressed) {
      fire();
    }

    if (fireCooldown > 0) {
      fireCooldown--;
    } 

    for (Bullet bullet : bulletList) {
      bullet.update();
    }
  }

  void fire() {
    if (fireCooldown == 0) {
      bulletList.add(new Bullet(this));
      fireCooldown = coolDownTime;
    }
  }

}

