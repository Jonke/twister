DataInputStream openlog(){
 
   
InputStream inp = openStream("log.log");
DataInputStream data = new DataInputStream(inp);
 
return data ;  
}
TwisterBin readfromlog(DataInputStream data){
  TwisterBin tb;
try {

//while (true) {
  

long value = data.readLong();
println(value);
long valuec = data.readLong();
println(valuec);
int appid = data.readInt();
println(appid);
int funid = data.readInt();
println(funid);
int signalid = data.readInt();
println(signalid);
byte[] myid = new byte[50];
data.read(myid,0,50);
 String vs = new String(myid);
 println(trim(vs));
 
 byte[] mycomment = new byte[50];
data.read(mycomment,0,50);
 String vc = new String(mycomment);
 println(trim(vc));
 
 Date d = new Date();
 d.setTime(value*1000);
 println(d);
  tb= new TwisterBin(value,valuec,appid,funid,signalid,trim(vs),trim(vc));

//}
} catch(IOException e){
  e.printStackTrace();
  tb= new TwisterBin();
}

return tb;
}


TwisterBin[] tbs;
float MaxT=MIN_FLOAT;
float MinT=MAX_FLOAT;
void setup(){
 size(400,400);
 
 stroke(255);
background(255);
DataInputStream data= openlog();


PFont font= loadFont("TrebuchetMS-48.vlw");
textFont(font);
 tbs= new TwisterBin[0];

TwisterBin tb=readfromlog(data);
tbs=(TwisterBin[])append(tbs,tb);
tb=readfromlog(data);
MaxT=max(MaxT,(float)tb.timestamp);
MinT=min(MinT,(float)tb.timestamp);
tbs=(TwisterBin[])append(tbs,tb);
MaxT=max(MaxT,(float)tb.timestamp);
MinT=min(MinT,(float)tb.timestamp);
println(tb.comment);



Date d = new Date();
 d.setTime(1238453701*1000);

  println("ref " + d.toString()); 
}

void draw(){
 
 //Date d = new Date();
 //d.setTime(1238107900*1000);
 //ill(0);
 //textSize(8);
 //text(d.toString() ,r,r);
 
for(int i=0; i < tbs.length;i++){
 float r = map((float)tbs[i].timestamp, MinT-60,MaxT+60,1.0,200.0);
 fill(#FF4422);
 smooth();
 stroke(162,64,0);
 strokeWeight(5);
 point(r,10);

Date d = new Date();
 d.setTime(tbs[i].timestamp*1000);
 //println(MinT + " " + MaxT);
 // println(r + " " + tbs[i].comment+ " " + d.toString()); 
}
 
}
