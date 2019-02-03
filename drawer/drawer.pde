import netP5.*;
import oscP5.*;

OscP5 oscP5; //osc受信
String filter="/midi1"; //oscのフィルタリング
String word="NO"; //出力文字列
 
 
void setup() {
  size(400,400);
  surface.setResizable(true);
  frameRate(60);
  //osc受信
  //port:12000
  oscP5 = new OscP5(this,12000);
  //oscを受け取った時ラベルがフィルタと一致したときdrawText実行
  oscP5.plug(this,"drawText",filter);
}
  
public void drawText(int noteNum) {
  println("midi num: "+noteNum);  
  word="midi_num "+str(noteNum); 
}

void draw() {
  background(0);
  textSize(50);
  textAlign(CENTER);
  text(word,width/2,height/2);
}
