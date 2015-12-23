class Buttons
{
  int x, y, Width, Height;
  boolean touched = false;
  public Buttons(String label, int x, int y, int Width, int Height)
  {
    this.x = x;
    this.y = y;
    this.Width = Width;
    this.Height = Height;
  }
  
  PFont buttonFont;
  void draw()
  {
   if (!runningOnDevice && mousePressed)
   {
   if (mouseX > x && mouseX < x + Width && mouseY > y && mouseY < y + Height)
  {
    touched = true;
  }
   }
   buttonFont = createFont ("FFScala" , 14);
   textFont (buttonFont);
   rect (x, y, Width, Height); 
  }
}
