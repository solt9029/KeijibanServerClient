import processing.net.*;
Server myServer =new Server(this,2222);
int [][] lights =new int [20][10];
void setup(){
  size(400,200);
  background(255);
  for(int i=0; i<20; i++){
    for(int j=0; j<10; j++){
      lights[i][j]=0;
    }
  }
}
void mousePressed(){
  int x=int(mouseX/20);
  int y=int(mouseY/20);
  myServer.write(x+","+y);
  if(lights[x][y]==0){
    lights[x][y]=1;
  }else{
    lights[x][y]=0;
  }
}
void stop(){
  myServer.stop();
}
void draw(){
  background(255);
  for(int i=0; i<20; i++){
    for(int j=0; j<10; j++){
      if(lights[i][j]==1){
        fill(255,0,0);
      }else{
        fill(255);
      }
      ellipse(i*20+10,j*20+10,20,20);
    }
  }
  Client nextClient=myServer.available();
  if(nextClient !=null){
    String recvStr =nextClient.readString();
    String [] data =split(recvStr,",");
    if(lights[int(data[0])][int(data[1])]==0){
      lights[int(data[0])][int(data[1])]=1;
    }else{
      lights[int(data[0])][int(data[1])]=0;
    }
  }
}

