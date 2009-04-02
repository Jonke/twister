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
  tw();
    return 0;
}
