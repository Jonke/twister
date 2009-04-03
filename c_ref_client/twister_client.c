#include <winsock2.h>
#include <string.h>
#include <windows.h>
#include <stdio.h>
#include <malloc.h>

#include "twister_client.h"

#define DBG_ASSERT(x) if ((x) == 0) __asm { int 3 }
#pragma comment(lib, "ws2_32.lib")

typedef unsigned char byte;
byte* tobytei32(byte *trip ,int i){

  trip[0]=(i >> 24) & 0xFF;
  trip[1]=(i >> 16) & 0xFF;
  trip[2]= (i >> 8) & 0xFF;
  trip[3] = (i >> 0) & 0xFF;
  return trip;
}
byte* tobytei64(byte *trip ,__int64 i){

  trip[0]=(i >> 56) & 0xFF;
  trip[1]=(i >> 48) & 0xFF;
  trip[2]= (i >> 40) & 0xFF;
  trip[3] = (i >> 32) & 0xFF;

  trip[4]=(i >> 24) & 0xFF;
  trip[5]=(i >> 16) & 0xFF;
  trip[6]= (i >> 8) & 0xFF;
  trip[7] = (i >> 0) & 0xFF;
  return trip;
}



void tw_pre_W(){
  struct WSAData wsaData;
 //---------------------------------------------
  // Initialize Winsock
  WSAStartup(MAKEWORD(2,2), &wsaData);

}
void tw_post_W(){
  WSACleanup();
}


struct TwisterSocket_tag tw_pre(){
 SOCKET SendSocket;
 struct sockaddr_in RecvAddr;
 struct TwisterSocket_tag tws;
 int Port=4000;
 char *host="127.0.0.1";
 //---------------------------------------------
 // Create a socket for sending data
 SendSocket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
 
 //---------------------------------------------
 // Set up the RecvAddr structure with the IP address of
 // the receiver (in this example case "123.456.789.1")
  // and the specified port number.
 RecvAddr.sin_family = AF_INET;
 RecvAddr.sin_port = htons(Port);
 RecvAddr.sin_addr.s_addr = inet_addr(host);
 

 tws.SendSocket=SendSocket;
 tws.RecvAddr=RecvAddr;
 return tws;
}


void tw_post(struct TwisterSocket_tag tws){

  //---------------------------------------------
  // When the application is finished sending, close the socket.
  printf("Finished sending. Closing socket.\n");
  closesocket(tws.SendSocket);

  //---------------------------------------------
  // Clean up and quit.
  printf("Exiting.\n");

}

void tw(struct TwisterSocket_tag tws,__int64 timestamp, __int64 logicclock, int appid, int funid, int signalid, char * id, char *comment){

  SOCKET  SendSocket;
  struct sockaddr_in RecvAddr;

  char mid[50];
  char mcomment[50];
  char SendBuf[128];
  int BufLen = 128;
  __time64_t now;
  char *p;
  int i;
  byte b[8];
  byte *bp;
  byte a[4];
 
 
  SendSocket =tws.SendSocket;
  RecvAddr=tws.RecvAddr;

  //---------------------------------------------
  // Send a datagram to the receiver
  printf("Sending a datagram to the receiver...\n");
  _time64 (&now);

  bp=tobytei64(b, now);


  memset(SendBuf,0,100);
  p=SendBuf;
  memmove(p,bp,sizeof(b));
  p += sizeof(now);
  memmove(p,bp,sizeof(b));
  p += sizeof(now);

  bp=tobytei32(a,41);
  memmove(p,bp,sizeof(a));
  p += sizeof(a);

  bp=tobytei32(a,42);
  memmove(p,bp,sizeof(a));
  p += sizeof(a);

  bp=tobytei32(a,43);
  memmove(p,bp,sizeof(a));
  p += sizeof(a);

  
  memset(mid,0,sizeof(mid));

  _snprintf(mid,sizeof(mid)-1, "c4");
  memmove(p,mid,sizeof(mid));
  p += sizeof(mid);
  memset(mcomment,0,sizeof(mcomment));
  _snprintf(mcomment,sizeof(mcomment)-1, "comment");
  memmove(p,mcomment,sizeof(mcomment));
  for(i=0; i < 128;i++)
    printf("%c",SendBuf[i]);

  sendto(SendSocket, 
    SendBuf, 
    128, 
    0, 
    (struct sockaddr *) &RecvAddr, 
    sizeof(RecvAddr));



 
  return;
}

