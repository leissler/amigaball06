class Bullet extends GameObject {

  Bullet(Player p) {
    img = loadImage("bullet.png");
    imageMode(CENTER);
    this.w = img.width;
    this.h = img.height;
    this.x = p.getX(); 
    this.y = p.getY() - p.getHeight()/2 - h/2;
    this.ySpeed = 20;
  }  

  void display( ) {
    fill (255, 255, 255);
    image(img, x, y);
  }  

  void update() {
    if (y > (-95)) {
      y-=ySpeed;
    }
  }

}
