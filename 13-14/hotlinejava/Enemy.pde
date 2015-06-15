class Enemy extends Player{
  Enemy(float x1,float y1,float x2,float y2){
    coor[0]=x1;
    coor[1]=y1;
    coor[2]=x2;
    coor[3]=y2;
    c = color(200,0,0);
  }
  void move(float x, float y){
    setxcor(x);
    setycor(y);
  }
  void setCoors(float[] newCoors){  
    for (int i=0;i<coor.length;i++){
      coor[i]=newCoors[i];
    }
  }
}
