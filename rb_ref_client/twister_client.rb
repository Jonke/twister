require 'socket'

class Twister
  def initialize(host, port)
    @host = host
    @port = port
  end

  def log
    @socket = UDPSocket.open
    @socket.connect(@host, @port)
    t=Time.now.to_i
    msg=[t].pack("Q")
    myclock=[1].pack("Q")
    myid="a4".to_a.pack("a50")
    mycomment="comment".to_a.pack("a50")
    mymsg=[]
    mymsg << msg.reverse
    mymsg << myclock.reverse
    mymsg << myid
    mymsg << mycomment
    puts mymsg.inspect
    puts mymsg.join("").length
    puts mymsg.join("")
    @socket.send(mymsg.join(""), 0, @host, @port)
  end
end

client = Twister.new("localhost", 4000)
client.log
