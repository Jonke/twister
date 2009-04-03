#include <winsock2.h>
#include <string.h>
#include <windows.h>
#include <stdio.h>
#include <malloc.h>
#include "twister_client.h"


#define DBG_ASSERT(x) if ((x) == 0) __asm { int 3 }
#pragma comment(lib, "ws2_32.lib")
int main(int argc, char *argv[])
{
  __time64_t now;
  __int64 lc=1;
  int appid=4;
  int funid=1;
  int signalid=100;
  char * id="c2376";
  char * comment="lsls";
  struct TwisterSocket_tag tws;
_time64 (&now);
  tw_pre_W();
  tws=tw_pre();
  tw(tws,now,lc,appid,funid, signalid,id, comment);
  tw_post(tws);
  tw_post_W();
  return 0;
}
