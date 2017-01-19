class Lilypad
{

  float lilydiameter;
  PVector lilyposition;
  color lilycolour;
  PVector lilyvelocity;

  Lilypad()
  {
    lilyvelocity = new PVector(random(-5, 5), 0);
    lilydiameter = 2*frogsize; 
    lilyposition = new PVector (width/2, height-frogsize);
    lilycolour = color (7, 82, 10);
  }

  void draw()
  {
    noStroke();
    fill(lilycolour);
    ellipse(lilyposition.x, lilyposition.y, lilydiameter, lilydiameter);
  }    

  void move()
  {
    lilyposition.x = lilyposition.x + lilyvelocity.x;

    if (lilyposition.x < lilydiameter/2)
    {
      lilyvelocity.x = -1 * lilyvelocity.x; // If we are left of sketch move  right.
    } else if (lilyposition.x > width-lilydiameter/2)
    {
      lilyvelocity.x = -1 * lilyvelocity.x; // If we are right of sketch move  left.
    }
  }
}