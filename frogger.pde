import ddf.minim.*;
Minim minim;

int s=millis()/1000 % 60;
int m=millis()/(1000*60) % 60;
int h= (millis()/(1000*60*60)) % 60;

AudioPlayer levelSong;
AudioPlayer finishSong;
AudioPlayer overSong;
AudioPlayer titleSong;
AudioPlayer player;

int xpos = 0;

boolean counting=false;

Frog frog;// call the frog class
Finishline finishline;// call the finishline class

Lilypad lilypads [];//create an array of lilypad class

boolean inPlayMode;//gameover or not

boolean previousPlayState = false;

String startMessage;//click to begin
float startxpos; // position of text along x-axis
float startvx; // speed of text in x-direction

String finishMessage;// finish

int gameState = 1;//to know if u should freeze game when u finish, 1 =playing, 2= finished, 3= gameover 

float frogsize = 20;

float vel = 20*6-20;//frog speed

PVector startfrogposition; 

float seconds = second();

void setup()
{ 
  fullScreen();

  minim = new Minim(this);

  levelSong =  minim.loadFile ("Level.wav");
  finishSong =  minim.loadFile ("finish.wav"); 
  titleSong =  minim.loadFile ("Titlescreen.wav");
  overSong =  minim.loadFile ("gameover.mp3");

  titleSong.loop();

  finishline = new Finishline();

  frog = new Frog();

  lilypads = new Lilypad [8];// make an array of 7 of that class

  lilypads[0] = new Lilypad();// special one that is static
  lilypads[0].lilyvelocity.x = (0);

  for (int i =1; i<8; i++)
  {
    lilypads[i] = new Lilypad();
    lilypads[i].lilyposition.y = -20 + height-vel*i ;
  }

  inPlayMode = false;

  startMessage = "Click to START! Use W to move forward";
  finishMessage = "FINISH! Press Q to exit and R to play again";

  startxpos = width/2;  // Initialise xPos to right of sketch startmessage
  startvx = -2; // Set speed in x-direction to -2 (moving left) startmessage

  startfrogposition = new PVector (width/2, height-frogsize);
}

void mouseClicked() {
  if (inPlayMode) {
  } // do nothin game is already running
  else {
    inPlayMode = true;
    gameState = 1;
    counting=true;
  }
}


void draw()
{  
  background(6, 0, 206);

  if (!previousPlayState && inPlayMode) {
    titleSong.pause();
    levelSong.loop();
  }

  if (gameState == 2) {
    levelSong.pause();
    finishSong.play();
  }

  if (gameState == 3) {
    levelSong.pause();
    overSong.play();
  }
  textAlign(CENTER);
  textSize(30);
  fill(255, 255, 255);
  text("Time=" +h+":"+m+":"+s, width-125, height-50);

  finishline.draw();

  for (int i=0; i<8; i++)
  {
    lilypads[i].draw();
  }

  fill(0, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(54);
  text("Kiran", width-75, 50);


  if (inPlayMode == false) // load screen
  {
    textSize(30);
    textAlign(CENTER);
    fill(255, 255, 255);
    startxpos = startxpos + startvx;  // Change x-position on each redraw
    text(startMessage, startxpos, height/2);

    if (startxpos < -textWidth (startMessage)/2) // loop load screen text
    {
      startxpos = width+textWidth (startMessage)/2;
    }
  } else //TRUE so playing 
  { 

    int onLily = 0;
    for (int i=0; i<8; i++)
    {
      if (dist(startfrogposition.x, startfrogposition.y, lilypads[i].lilyposition.x, lilypads[i].lilyposition.y) < 20) 
      {
        onLily++;
        startfrogposition.x=lilypads[i].lilyposition.x;
        startfrogposition.y=lilypads[i].lilyposition.y;
      }
    }

    if (onLily==0)
    {            
      gameState = 3;
    }

    if (startfrogposition.y<0)
    {
      gameState = 2;
      vel = 0;
    }

    if (gameState==1)// playing cause i clicked, but not finished
    {
      for (Lilypad l : lilypads)// start to move lilypads at random speeds
        l.move();


      if (counting) { 

        if (s<=59)
        { 
          s =s +1;
        } 
        if (s>59)
        { 
          m=m+1;
          s=0;
          if (m>59)
          {
            s=0;
            m=0;
            h=h+1;
          }
        }
      }
    } 

    if (gameState==2) //finished
    {

      textSize(54);
      textAlign(CENTER);
      fill(255, 255, 255);
      text(finishMessage, width/2, height/2);
      counting=false;
    }

    if (gameState==3) {

      textSize(54);
      textAlign(CENTER);
      fill(255, 255, 255);
      text("Game Over!", width/2, height/2);
      vel = 0;
      counting=false;
    }

    previousPlayState = inPlayMode;
  }

  frog.draw();//this should be last as it will appear to be on the things
}

void keyPressed()
{ 
  if (key == 'q')
  {
    System.exit(0);
  }

  if (inPlayMode == true)
  {
    if (keyPressed)
    {
      if (key == 'w')
      {
        startfrogposition.y = startfrogposition.y - vel;
      }
    }
  }
}