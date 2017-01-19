class Frog
{
  color frogColour;

  Frog()
  {
    frogColour = color (0, 255, 0);
  }

  void draw()
  {
    noStroke();
    fill (frogColour);
    rectMode(CENTER);

    rect(startfrogposition.x, startfrogposition.y, frogsize, frogsize);
  }
}