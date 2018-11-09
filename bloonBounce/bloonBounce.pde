bloon[] Balls;
int bloonsAlive=0,numColors,score,bounceX;
int[] colors;
boolean red,blue,green,yellow,pink;

void setup(){
  size(1000,600);
  Balls=new bloon[20];
  colors=new int[20];
  for (int i=0;i<20;i++){
    Balls[i]=new bloon();
  }
  for (int i=0;i<20;i++){
    colors[i]=Balls[i].colorGetter();
  }
  background(66,134,230);
  noCursor();
}

void draw(){
  background(66,134,230);
  scoring();
  bounceMove();
  fill(0,0,150,80);
  textSize(50);
  text("Score: "+score,300,100);
  textSize(30);
  text("Use 'a' and 'd' or <-- and --> to move",200,200);
  text("Both number of balloons and number of \ncolors remaining factor into your score!",200,300);
  textSize(20);
  for (int i=0;i<20 ;i++){
    bloonsAlive+=Balls[i].alive();
  }
  text("Number of balloons: "+bloonsAlive,20,40);
  bloonsAlive=0;
  text("Number of colors: "+numColors,790,40);
  for (int i=0;i<20 ;i++){
    Balls[i].move();
    Balls[i].show();
  }
  fill(0);
  stroke(0);
  rect(bounceX,550,120,20);
  fill(66,134,230);
  stroke(66,134,230);
  rect(0,570,width,30);
  numColors=0;
}

void scoring(){
  for (int i=0;i<20 ;i++){
    bloonsAlive+=Balls[i].alive();
  }
  text("Number of balloons: "+bloonsAlive,20,40);
  numColors=numberColors();
  score+=(numColors*bloonsAlive);
  bloonsAlive=0;
}

int numberColors(){
  int c=0;
  for (int i=0;i<20;i++){
    if (Balls[i].getPop()==false){
      if (colors[i]==0){
        red=true;
      }
      if (colors[i]==1){
        blue=true;
      } 
      if (colors[i]==2){
        green=true;
      }
      if (colors[i]==3){
        yellow=true;
      }
      if (colors[i]==4){
        pink=true;
      }
    }
  }
  if(red==true){
    c++;
  }
  if(blue==true){
    c++;
  }
  if(green==true){
    c++;
  }
  if(yellow==true){
    c++;
  }
  if(pink==true){
    c++;
  }
  red=false;
  blue=false;
  green=false;
  yellow=false;
  pink=false;
  return c;
}
void bounceMove(){
  if(keyPressed){
    if((key=='a'||keyCode==LEFT)&&bounceX>=0){
      bounceX-=20;
    }
    else if((key=='d'||keyCode==RIGHT)&&bounceX<=880){
      bounceX+=20;
    }
  }
}
class bloon{
  int bloonX=(int)(Math.random()*800+100);
  double bloonY=Math.random()*100+450;
  double bloonV=100;
  double bloonTime=0;
  double xInc=(Math.random()*7)-3;
  int colorPick=(int)(Math.random()*5);
  int bloonR,bloonG,bloonB;
  boolean popped=false;
  void move(){
    bloonTime+=.001;
    if(bloonX>960||bloonX<0){
      xInc*=-1;
    }
    bloonX+=xInc;
    bloonY-=(bloonV*bloonTime)+(.49*bloonTime*bloonTime);
    bloonV-=9.8*bloonTime;
    if (bloonY>500){
      contact();
    }
  }
  void show(){
    if(colorPick==0){
      bloonR=200;
      bloonG=20;
      bloonB=20;
    }
    if(colorPick==1){
      bloonR=0;
      bloonG=153;
      bloonB=0;
    }
    if(colorPick==2){
      bloonR=51;
      bloonG=51;
      bloonB=255;
    }
    if(colorPick==3){
      bloonR=225;
      bloonG=225;
      bloonB=0;
    }
    if(colorPick==4){
      bloonR=255;
      bloonG=153;
      bloonB=204;
    }
    fill(bloonR,bloonG,bloonB);
    stroke(0);
    triangle(bloonX,(int)bloonY+40,bloonX-10,(int)bloonY+60,bloonX+10,(int)bloonY+60);
    ellipse(bloonX,(int)bloonY,80,95);
  }
  void reset(){
    bloonY-=30;
    bloonTime=0;
    bloonV*=-1;
    xInc=(Math.random()*7)-3;
  }
  void contact(){
     if (Math.abs(bounceX-bloonX)<150){
       reset();
     }
     else if (bloonY>=600){
       bloonX=1300;
       popped=true;
     }
   }
   int alive(){
     if (bloonX>1000){
       return 0;
     }
     return 1;
   }
   int colorGetter(){
     return colorPick;
   }
   boolean getPop(){
     return popped;
   }
}
