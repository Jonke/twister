try {
InputStream inp = openStream("log.log");
DataInputStream data = new DataInputStream(inp);
long value = data.readLong();
println(value);
long valuec = data.readLong();
println(valuec);
int v = data.readInt();
println(v);
v = data.readInt();
println(v);
v = data.readInt();
println(v);
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
} catch(IOException e){
  e.printStackTrace();
}
