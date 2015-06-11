class Barrier{
    float[] coor = new float[4];
    color c;
    void draw(){
      rectMode(CORNERS);
      fill(c);
      rect(coor[0],coor[1],coor[2],coor[3]);
    }
    Barrier(float x,float y, float w, float l){
      c = color(0,0,0);
      coor[0]=x-(w/2);
      coor[1]=y-(l/2);
      coor[2]=x+(w/2);
      coor[3]=y+(l/2);
    }
    void setColor(int r, int g,int b){
      c = color(r,g,b);
    }
    float[] getCoors(){
      return coor;
    }
}
