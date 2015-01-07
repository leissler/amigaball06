class Player extends GameObject {

  int coolDownTime;
  private int fireCooldown;

  ArrayList<GameObject> bulletList;

  Player(PlayField p) {
    this.pf = p;
    this.img = loadImage("rocket.png");
    imageMode(CENTER);
    this.w = img.width;
    this.h = img.height;
    this.x = pf.getWidth()/2; 
    this.y = pf.getHeight() - h/2;
    this.xSpeed = 5;

    bulletList = new ArrayList<GameObject>();
    fireCooldown = 0;
    coolDownTime = 20;
  }

  void display() {
    super.display();

    for (GameObject bullet : bulletList) {
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

    for (int i=0; i<bulletList.size(); i++) {
      bulletList.get(i).update();
      if(bulletList.get(i).getY() < 0){
        bulletList.remove(i);
      }
    }
  }

  void fire() {
    if (fireCooldown == 0) {
      bulletList.add(new Bullet(this));
      fireCooldown = coolDownTime;
    }
  }
  
  boolean collidesWith(AmigaBall b){
    return intersectsCircle(b.getX(), b.getY(), b.getRadius() );
  }
  
  ArrayList<GameObject> getBulletList(){
    return bulletList;
  }

}

