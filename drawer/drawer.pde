 import netP5.*;
import oscP5.*;
OscP5 oscP5;
String filter="/midi1";//フィルタリングするmessageをここで指定
String word="NO";//画面に出力する文字の初期値
float size=1.0;
float sizeGoal=0.0;
int initW = 400;
int initH = 400;
float maxWSize=initW/3.0;
float maxHSize=initH/3.0;
float alpha=0.0;
float framerate = 60;

//イージングアニメーション
float initValue=-100;  //初期値
float value=initValue;  //現フレームの値
float valueInChange=200; //最終的な変化量
float duration = 1.0; //初期値から最終的な値まで変化する時間(s)
float elapsedTime=0.0; //現フレームまでにすぎた時間(ms)
float elapsedTimeRate=0.0; //現フレームまでにすぎた時間(ms)

//

void settings(){
  size(initW, initH);
  //fullScreen();
}
void setup() {
  surface.setResizable(true);
  
  frameRate(framerate);
  //受信用のオブジェクト。ポート番号12000で受ける。
  oscP5 = new OscP5(this,12000);
 
// filterで設定したラベルを持つoscがきた場合にdrawTextという名前を持つファンクションを起動する
//(this[定型文] , "test"[という名前のファンクションを起動する],"/test"[/testのラベルがきたときに])
  oscP5.plug(this,"drawText",filter);
}

void update(){
   elapsedTime += 1/framerate;
     
   easingAnimation();
   maxWSize=width/3.0;
   maxHSize=height/3.0;
}
 
//〜.plugで指定したdrawTextという名前を持つ関数 
public void drawText(int noteNum) {// int noteNumにデータの値を受ける
  if(noteNum==69){
    sizeGoal=1.0;
  }
  if(sizeGoal<=size){
    
  }
  println("### plug event method. received a message "+filter);
  println("received noteNum: "+noteNum);//theAを画面に出力する  
  word="note_num "+str(noteNum);//画面に出力する文字列wordに受信したNumを文字列に変換していれる
  
}

void draw() {
  update();
  pushMatrix();
  fill(0, 250);
  rect(0,0,width, height);
  popMatrix();
  //background(0,0);
  textSize(50);
  textAlign(CENTER);//中心揃え
  pushMatrix();
  translate(value, 0);
  fill(255);
  rect(width/2-maxWSize*size/2.0, height/2-maxHSize*size/2.0, maxWSize*size, maxHSize*size);
  popMatrix();
  text(word,width/2,height/2);//wordを画面に出力
}


void keyPressed() {
  if (key == CODED) {      // コード化されているキーが押された
    if (keyCode == UP) {    // キーコードを判定
       background(255);
    } else if (keyCode == DOWN) {
       background(0);
    }
  }
  if(key == 'a'){
     initEase();
     background(255);
  }      
}

void initEase(){
  value = initValue;
  elapsedTime = 0;
}

// ノーマル(not EASING)
void linerAnimation(){
  if(elapsedTime<duration){
    elapsedTimeRate=elapsedTime/duration;
    value = initValue + (valueInChange-initValue) * elapsedTimeRate;
    println(elapsedTime);
  }else{
    value = valueInChange;
  }
}

void easingAnimation(){
  if(elapsedTime<duration){
    elapsedTimeRate=elapsedTime/duration;
    float valueChangeRate = 1-(float)Math.pow(elapsedTimeRate-1, 2);
    value = initValue + (valueInChange-initValue) * valueChangeRate;
    println(elapsedTime);
  }else{
    value = valueInChange;
  }
}
