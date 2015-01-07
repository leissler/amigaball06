class GameObject {
  float x;
  float y;
  float w;
  float h;
  float xSpeed;
  float ySpeed;
  
  PImage img;
  PlayField pf;

  public float getX(){return x;}
  public float getY(){return y;}
  public float getWidth(){return w;}
  public float getHeight(){return h;}
  public float getXSpeed(){return xSpeed;}
  public void setXSpeed(float xs){xSpeed =xs;}
  public float getYSpeed(){return ySpeed;}
  public void setYSpeed(float ys){ySpeed =ys;}
  public PVector getPosition(){return new PVector(this.x,this.y);}
  public void setPosition(PVector v){this.x=v.x; this.y=v.y;}
  public void setPosition(float x, float y) {this.x=x;this.y=y;}
  public PVector getVelocity(){return new PVector(this.xSpeed, this.ySpeed);}
  public void setVelocity(PVector v){this.xSpeed=v.x; this.ySpeed=v.y;}
  
  public void display(){};
  public void update(){};
  
  boolean intersectsCircle(float cx, float cy, float r) {
    float circleDistanceX = abs(cx - x);
    float circleDistanceY = abs(cy - y);
    
    if (circleDistanceX > (w/2 + r)) { return false; }
    if (circleDistanceY > (h/2 + r)) { return false; }
    
    if (circleDistanceX <= (w/2)) { return true; } 
    if (circleDistanceY <= (h/2)) { return true; }
    
    float cornerDistance_sq = sq(circleDistanceX - w/2) +
                         sq(circleDistanceY - h/2);
    
    return (cornerDistance_sq <= (r*r));
  }
  

}

