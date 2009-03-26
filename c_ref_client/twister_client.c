#include <winsock2.h>
#include <string.h>
#include <windows.h>
#include <stdio.h>
#include <malloc.h>



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




void main() {
  
  struct WSAData wsaData;
  SOCKET SendSocket;
  struct sockaddr_in RecvAddr;
  int Port = 4000;
  char id[50];
  char comment[50];
  char SendBuf[128];
  int BufLen = 128;
  __time64_t now;
  char *p;
  int i;
  byte b[8];
  byte *bp;
  byte a[4];
  //---------------------------------------------
  // Initialize Winsock
  WSAStartup(MAKEWORD(2,2), &wsaData);

  //---------------------------------------------
  // Create a socket for sending data
  SendSocket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);

  //---------------------------------------------
  // Set up the RecvAddr structure with the IP address of
  // the receiver (in this example case "123.456.789.1")
  // and the specified port number.
  RecvAddr.sin_family = AF_INET;
  RecvAddr.sin_port = htons(Port);
  RecvAddr.sin_addr.s_addr = inet_addr("127.0.0.1");

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

  
  memset(id,0,sizeof(id));

  _snprintf(id,sizeof(id)-1, "c4");
  memmove(p,id,sizeof(id));
  p += sizeof(id);
  memset(comment,0,sizeof(comment));
  _snprintf(comment,sizeof(comment)-1, "comment");
  memmove(p,comment,sizeof(comment));
  for(i=0; i < 128;i++)
    printf("%c",SendBuf[i]);

  sendto(SendSocket, 
    SendBuf, 
    128, 
    0, 
    (struct sockaddr *) &RecvAddr, 
    sizeof(RecvAddr));

  Sleep(10000);
  //---------------------------------------------
  // When the application is finished sending, close the socket.
  printf("Finished sending. Closing socket.\n");
  closesocket(SendSocket);

  //---------------------------------------------
  // Clean up and quit.
  printf("Exiting.\n");
  WSACleanup();
  return;
}

