class TwisterBin{
  long timestamp;
  long logicclock;
  int appid;
  int funid;
  int signalid;
  String id;
  String comment;
  public TwisterBin(){
    
  }
  public TwisterBin(  long timestamp,  long logicclock,  int appid,  int funid,  int signalid,  String id,  String comment){
    this.timestamp=timestamp;
  this.logicclock=logicclock;
  this.appid=appid;
  this.funid=funid;
  this.signalid=signalid;
  this.id=id;
  this.comment=comment;
  }
}
