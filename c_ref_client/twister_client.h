struct TwisterSocket_tag{
  SOCKET SendSocket;
  struct sockaddr_in RecvAddr;
};
void tw_pre_W();
struct TwisterSocket_tag tw_pre();

void tw(struct TwisterSocket_tag tws,__int64 timestamp, __int64 logicclock, int appid, int funid, int signalid, char * id, char *comment);

void tw_post(struct TwisterSocket_tag tws);
void tw_post_W();
