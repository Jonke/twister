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
    mymsg="#{msg.reverse}#{msg.reverse}smurf"
    @socket.send(mymsg, 0, @host, @port)
  end
end

client = Twister.new("localhost", 4000)
client.log
