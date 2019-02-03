 import netP5.*;
import oscP5.*;

OscP5 oscP5;//受信用、OscP5クラスのoscP5と名前を持つ変数を作る。
String filter="/midi1";//フィルタリングするmessageをここで指定
String word="NO";//画面に出力する文字の初期値
 
 
void setup() {
  size(400,400);
  surface.setResizable(true);
  frameRate(25);
  //受信用のオブジェクト。ポート番号12000で受ける。
  oscP5 = new OscP5(this,12000);
 
// filterで設定したラベルを持つoscがきた場合にdrawTextという名前を持つファンクションを起動する
//(this[定型文] , "test"[という名前のファンクションを起動する],"/test"[/testのラベルがきたときに])
  oscP5.plug(this,"drawText",filter);
}
 
//〜.plugで指定したdrawTextという名前を持つ関数 
public void drawText(int noteNum) {// int noteNumにデータの値を受ける
  println("### plug event method. received a message "+filter);
  println("received noteNum: "+noteNum);//theAを画面に出力する  
  word="note_num "+str(noteNum);//画面に出力する文字列wordに受信したNumを文字列に変換していれる
  
}

void draw() {
  background(0);
  textSize(50);
  textAlign(CENTER);//中心揃え
  text(word,width/2,height/2);//wordを画面に出力
}
