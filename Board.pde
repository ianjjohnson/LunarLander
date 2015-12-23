class Board
{
  float attempts = 5;
  float score;
  PFont newFont;
  PFont newFont2;
  boolean gameStarted = false;
  public Board()
  {
    
  }
  void drawAttempts()
  {
    for (int i = 0; i<attempts; i++)
    {
      image (lander.sprite, 20 + (i * lander.lander_width), 480 - (lander.lander_height + 5));
    }
  }
boolean gameOver()
    {
          if (attempts <=0)
          {
            return true;
          }
          else
          {
            return false;
          }
    }
  void makeBoard()
    {
  newFont = createFont("FFScala" , 12);
  textFont (newFont);
  text ("Score :" + score, 20, 415);
  text ("Fuel :" + controls.fuel + "%", 20, 430);
    fill(0, 0, 0);
    
    if (gameOver())
    {
      newFont2 = createFont("FFScala" , 36);
      textFont (newFont2);
      text ("GAME OVER", 300, 240);
    }
  }
}
