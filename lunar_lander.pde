 float timer = 0;
 float speed = 1;
 boolean runningOnDevice = false;
Landscape landscape;
Lander lander;
Controls controls;
Board board;
Buttons start_button;
void setup()
{
  size(800,480);
  landscape = new Landscape(800,480);
  board = new Board();
   controls = new Controls();
  lander = new Lander(50, 50, landscape);
  PFont font;
  start_button = new Buttons ("Start Game", 400, 200, 50, 50);
  font = createFont ("FFScala" , 12);
       textFont (font);
}

void draw()
{
  background(255);
  stroke(0);
  fill(0);
  smooth();
  if (start_button.touched == true)
  {
   board.gameStarted = true;
  }
  board.drawAttempts();
  board.makeBoard();
  landscape.draw();
  if (!board.gameStarted)
  {
   start_button.draw();
   return;
  }
  lander.update();
  controls.processInputs();
  
  if (lander.didCollideWithLandscape(landscape))
 {
   if (lander.xpos < ((landscape.pad_start_i - (landscape.pad_width / 2)) * landscape.chunk_size) || lander.xpos > (landscape.pad_start_i + (landscape.pad_width / 2)) * landscape.chunk_size)
   {
    lander.startExplosion();
    lander.exploding();
   }
   else
   {
     lander.yvel = 0;
     lander.ypos = 50;
     lander.xpos = 50;
     board.score +=50;
     controls.fuel = 100;
     landscape = new Landscape(800,480);
   }
 }  
 

  
  // Draw
  
  if (!board.gameOver() && board.gameStarted)
  {
  lander.draw();
  }
}
