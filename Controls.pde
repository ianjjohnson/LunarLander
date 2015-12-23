class Controls {
float fuel = 100;
float rotation = 0;
boolean thrust = false;
float xDir;

public Controls() {}
void processInputs()
{
if (keyPressed == true && key == CODED && keyCode == DOWN && fuel>0)
{
  thrust = true;
  fuel -= .75;
  println (fuel);
}
else
{
  thrust = false;
}

if (keyPressed == true && key == CODED && keyCode == RIGHT)
{
  //@todo rotate the rocket and XY vector...
  rotation = 1;
}
else if (keyPressed == true && key == CODED && keyCode == LEFT)
{
  rotation = -1;
}
else
{
  rotation = 0;
}
}
}
