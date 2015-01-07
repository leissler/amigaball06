class Bullet extends GameObject {

  Bullet(Player p) {
    img = loadImage("bullet.png");
    imageMode(CENTER);
    this.w = img.width;
    this.h = img.height;
    this.x = p.getX(); 
    this.y = p.getY() - p.getHeight()/2 - h/2;
    this.ySpeed = - 20;
  }  

  boolean collidesWith(AmigaBall b){
    return intersectsCircle(b.getX(), b.getY(), b.getRadius() );
  }
  
}
