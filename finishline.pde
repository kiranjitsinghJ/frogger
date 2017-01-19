class Finishline
{
  PVector lineposition;
  PVector velocity;
  float linesize;
  color lineColour;
  color squareColour;

  Finishline()
  {
    linesize = 20;
    lineposition = new PVector (width/2, linesize/2);
    lineColour = color (255, 255, 255);
    squareColour = color (0, 0, 0);
  }

  void draw()
  {
    fill(lineColour);
    rectMode(CENTER);
    rect (lineposition.x, lineposition.y, width, linesize);

    for (int row = 0; row<2; row = row +1)
    {
      for (int i=0; i<width/linesize; i = i + 1)
      {
        fill(squareColour);
        rectMode(CORNER); 
        rect((row*0.5+i)*linesize, row*linesize/2, linesize/2, linesize/2);
      }
    }
  }
}