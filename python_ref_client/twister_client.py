from socket import *
import string
import time
import array
import struct
host = "127.0.0.1"
port = 4000
UDPSock = socket(AF_INET,SOCK_DGRAM)
timestamp= struct.pack('Q',int(time.time()))[::-1]
lc=struct.pack('Q',1)[::-1]
appid=struct.pack('!L',31)	
funid=struct.pack('!L',32)	
signalid=struct.pack('!L',33)	
myid=struct.pack('50s',"p5")
comment=struct.pack('50s',"python comment")

UDPSock.sendto(timestamp+lc+appid+funid+ signalid +myid+comment, (host,port))
