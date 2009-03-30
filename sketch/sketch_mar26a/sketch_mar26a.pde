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
background(0);
DataInputStream data= openlog();


PFont font= loadFont("TrebuchetMS-48.vlw");
textFont(font);
 tbs= new TwisterBin[0];
 TwisterBin tb=readfromlog(data);
while(tb.timestamp >0 ){
MaxT=max(MaxT,(float)tb.timestamp/60);
MinT=min(MinT,(float)tb.timestamp/60);
   tb=readfromlog(data);

if (tb.timestamp > 0)
tbs=(TwisterBin[])append(tbs,tb);
Date d = new Date();
 d.setTime(tb.timestamp*1000);
 
  println( d.toString()); 
}

}

void draw(){
 
 //Date d = new Date();
 //d.setTime(1238107900*1000);
 //ill(0);
 //textSize(8);
 //text(d.toString() ,r,r);
 
for(int i=0; i < tbs.length;i++){
 float r = map((float)tbs[i].timestamp/60, MinT-60.0,MaxT+60.0,1.0,200.0);
 smooth();
 fill(#A6D785,10);
 noStroke();
 //stroke(#A6D785);
 //strokeWeight(5);
 //point(r,10);
ellipse(r,10,10,10);

}
 
}
