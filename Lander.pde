class Lander {
  float xpos, ypos, xvel, yvel, thrust;
  float lander_height = 42;
  float lander_width = 28;
  float cellsize = 2;
  int columns, rows;
  PImage sprite;
  boolean exploding = false;
  int explode_radius = 0;
  Landscape landscape;
   float explodeTimer = 0; 
   PFont newFont3;
 // Controls controls;
  
  /**
   * Constructor
   */
  public Lander(float initial_x, float initial_y, Landscape l) {
    xpos = initial_x;
    ypos = initial_y;
    landscape = l;
    sprite = loadImage("data/lander1.jpg");
  }
  
  boolean didCollideWithLandscape(Landscape landscape) {
    float lander_bottom_y = ypos + lander_width;
    float lander_left_bottom_x = this.xpos;
    float lander_right_bottom_x = this.xpos + this.lander_width;
    if (lander_bottom_y > landscape.maxHeightInRange(lander_left_bottom_x, lander_right_bottom_x)) {
      return true;
    } else {
      return false;
    }
  }
  
  void draw() {
    if (this.exploding) { 
      this.explode(explode_radius++);
    } else {
      
      image(sprite, xpos, ypos);
    }
    if (xpos >= 771) {xpos = 770;} 
    if (xpos <= 1) {xpos = 2;}
  }
  
  void explode(int r) {
    // explode the lander into 1x1 pixels shooting outward from lander center
    float lander_center_x = xpos + lander_width/2;
    float lander_center_y = ypos + lander_height/2;
    for (int px = 0; px < lander_width; px+=2) {
    for (int py = 0; py < lander_height; py+=2) {
    // now we're on an image pixel, find the direction vector
    speed += .0001;
    float vec_x = (px - (lander_width/2))  / speed;
    float vec_y = (py - (lander_height/2)) / speed;
    PImage shard = sprite.get(px, py, 2, 2);
    float original_pixel_pos_x = xpos + px;
    float original_pixel_pos_y = ypos + px;
    int new_pixel_pos_x = Math.round(original_pixel_pos_x - r * vec_x);
    float new_pixel_pos_y = Math.round(original_pixel_pos_y - r * vec_y);
    if (new_pixel_pos_x >= 798 || new_pixel_pos_x < 0) {continue;}   
    // println("Drawing shard at " + new_pixel_pos_x + ", " + new_pixel_pos_y);
   // println (vec_y);
    fill(255);
    if (new_pixel_pos_x>0 && new_pixel_pos_x <800 && new_pixel_pos_y > landscape.maxHeightInRange(new_pixel_pos_x, new_pixel_pos_x +2))
    {
      new_pixel_pos_y = landscape.maxHeightInRange(new_pixel_pos_x, new_pixel_pos_x +2);
      continue;
    }
    image(shard, new_pixel_pos_x, new_pixel_pos_y);
      }
    }
  }
  
  boolean exploding()
  {
    if (exploding == false)
    {
      return false;
    }
    explodeTimer += 1;
    if (explodeTimer > 250)
    {
      endExplosion();
    }
    return this.exploding;
  }
  
  void startExplosion()
  {
    if (exploding ==  true)
    {
      return;
    }
    // beggining of explosion
    fill(0);
    
    newFont3 = createFont ("FFScala" , 12); 
    textFont  (newFont3);
    text("LANDER RAN INTO LANDSCAPE WITH VERTICAL VELOCITY " + lander.yvel, 200,200);
    explodeTimer = 0;
    exploding = true;

  }
  
  void endExplosion()
  {
    if (exploding == false)
    {
      return;
    }
    exploding = false;
    //end of explosion
     yvel = 0;
     ypos = 50;
     xpos = 50;
     speed = 1;
     board.attempts -=1; 
     explode_radius = 0;
     controls.fuel = 100;
}
  
  
  void update() {
    // The pull of gravity on the lander
    if (controls.thrust)
    {
      yvel -=.1;
    }
    xpos +=controls.rotation;
    if (ypos <= 10)
    {
      ypos = 10;
      yvel = 0;
    }
    if (ypos+lander_height > landscape.maxHeightInRange(xpos,xpos+lander_width)){}
    else
    {yvel += 0.0098f;}
    // Update position based on velocity
    xpos += xvel;
    ypos += yvel;
  }
}
