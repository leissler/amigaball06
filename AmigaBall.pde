

class AmigaBall {

  // Ball parameters
  private int facets; //  = 7;
  private float rotation; // = radians(15);
  private color color1; // = color(255,255,255);
  private color color2; // = color(255,0,0);
  private float rotSpeed; // = PI/150;
  private float radius; // = 100;

  // Physics
  private float x; // = winSize/2;
  private float y; // = winSize/3;
  private float ySpeed; // = 0.0;
  private float yAcceleration; // = 0.25;
  private float xSpeed; // = 1.4;

  // Constructor without parameters (random ball)
  AmigaBall() {
    facets = int(random(4, 11));
    rotation = radians(random(-20, 20));
    int r = (int) random(255);
    int g = (int) random(255);
    int b = (int) random(255);
    color1 = color(r, g, b);
    color2 = color(255-r, 255-g, 255-b);
    rotSpeed = radians(random(1, 5));
    radius = random(30, 100);

    x = mouseX;//random(radius, winSize-radius);
    y = mouseY;//random(winSize/3, 2*winSize/3);
    ySpeed = 0.0;
    xSpeed = random(-3, 3);
    yAcceleration = 0.25;
  }

  // Constructor with all parameters
  AmigaBall(float xpos, float ypos, float radius, int facets, color c1, color c2, float yrot, float zrot, float xspeed, float yspeed, float rotspeed, float acc) {
    this.facets = facets;
    this.rotation = zrot;
    this.color1 = c2;
    this.color2 = c1;
    this.radius = radius;
    this.x = xpos;
    this.y = ypos;
    this.ySpeed = yspeed;
    this.xSpeed = xspeed;
    this.yAcceleration = acc;
  }

  public void draw() {
    // Draw the balls shadow
    noStroke();
    fill(0, 0, 0, 110);
    ellipse (x+20, y+20, radius*2, radius*2);

    // Finally draw our ball
    drawAmigaBall(x, y, radius, facets, color1, color2, x*rotSpeed*0.1, rotation);
  }

  public void update() {
    updatePosition();
  }

  public float getX(){return x;}
  public float getY(){return y;}
  public float getRadius(){return radius;}
  public float getXSpeed(){return xSpeed;}
  public void setXSpeed(float xs){xSpeed =xs;}
  public float getYSpeed(){return ySpeed;}
  public void setYSpeed(float ys){ySpeed =ys;}
  public PVector getPosition(){return new PVector(this.x,this.y);}
  public void setPosition(PVector v){this.x=v.x; this.y=v.y;}
  public void setPosition(float x, float y) {this.x=x;this.y=y;}
  public PVector getVelocity(){return new PVector(this.xSpeed, this.ySpeed);}
  public void setVelocity(PVector v){this.xSpeed=v.x; this.ySpeed=v.y;}

  public boolean collidesWith(AmigaBall b) {
    float x1 = this.x;
    float y1 = this.y;
    float x2 = b.getX();
    float y2 = b.getY();
    float vx = (x2-x1);
    float vy = (y2-y1);
    float d = vx*vx + vy*vy;
    float r = b.getRadius();

    if (d < sq(this.radius + r)) {
      return true;
    }
    return false;
  }
  
  
  public int collidesWith(PlayField pf) {

  }
  
  private void resolvePlayfieldCollision(int collisionMask) {

  }
  
  public void resolveBallCollision(AmigaBall b){
    float x1 = this.x;
    float y1 = this.y;
    float x2 = b.getX();
    float y2 = b.getY();
    float dx = (x2-x1);
    float dy = (y2-y1);
    float r1 = radius;
    float r2 = b.getRadius();
    float restitution = 1.0f;
  
    // Get the components of the velocity vectors which are parallel to the collision.
    // The perpendicular component remains the same for both
    PVector collision = PVector.sub(getPosition(), b.getPosition());
    float distance = collision.mag();
    
    collision.div(distance);
    float aci = this.getVelocity().dot(collision);
    float bci = b.getVelocity().dot(collision);

    // Solve for the new velocities using the 1-dimensional elastic collision equations.
    // Turns out it's really simple when the masses are the same.
    float acf = bci;
    float bcf = aci;

    // Replace the collision velocity components with the new ones
    this.setVelocity(PVector.add(this.getVelocity(),PVector.mult(collision,(acf-aci))));
    b.setVelocity(PVector.add(b.getVelocity(),PVector.mult(collision,(bcf-bci))));
  }


  // Private functions for drawing and behavior

  private void updatePosition() {
    // Update the balls x position
    x += xSpeed;

    // Update y position by using acceleration (physics)
    y += ySpeed;
  }




  private void drawAmigaBall(float xpos, float ypos, float radius, int facets, color c1, color c2, float yrot, float zrot) {
    if (yrot > 2*PI) {
      yrot -= int((yrot/(2*PI)))*2*PI;
    } else if (yrot < 0) {
      yrot += int((yrot/(2*PI)))*2*PI;
    } 
    float sLong = radians(180/facets);
    noStroke();
    translate(xpos, ypos);
    rotate(zrot);
    boolean colorFlag = false;
    for (float deg = 0; deg < PI- (sLong/2); deg += sLong)
    {
      drawBand(radius, facets, deg, deg + sLong, colorFlag, c1, c2, yrot);
      colorFlag = !colorFlag;
    } 
    resetMatrix();
  }

  private void drawBand(float radius, float facets, float long1, float long2, boolean cf, color col1, color col2, float ani) {
    float sLat = radians(180/facets);
    float sLong = sLat;
    float ty = cos(long2) * radius;
    float by = cos(long1) * radius;
    float a = radius * sin(long1 + sLong);
    float b = radius * sin(long1);
    float tx1, bx1, tx2, bx2, c, c1;

    for ( float latDeg = -ani; latDeg < (PI- (sLat/2)); latDeg += sLat ) {
      c = cos(latDeg);
      c1 = cos(latDeg + sLat);
      tx1 = c * a;
      bx1 = c * b;
      tx2 = c1 * a;
      bx2 = c1 * b;
      if (cf) { 
        fill(col2);
      } else { 
        fill(col1);
      }
      cf = !cf;
      quad(tx1, ty, tx2, ty, bx2, by, bx1, by);
    }
  };
}

