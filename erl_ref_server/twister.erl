%%%-------------------------------------------------------------------
%%% File    : twister.erl
%%% Author  :  <jonke@MEDICHAM>
%%% Description : 
%%%
%%% Created : 19 Mar 2009 by  <jonke@MEDICHAM>
%%%-------------------------------------------------------------------
-module(twister).

%% API
-export([start/0]).

%%====================================================================
%% API
%%====================================================================
%%--------------------------------------------------------------------
%% Function: 
%% Description:
%%--------------------------------------------------------------------

%%====================================================================
%% Internal functions
%%====================================================================

start() ->
    spawn(fun() -> twister_server(4000) end).

twister_server(Port) ->
    {ok, Socket} = gen_udp:open(Port, [binary]),
    loop(Socket).

loop(Socket) ->
    receive
        {udp, Socket, Host, Port, Packet} = Msg ->
	     << MyTimeStamp:64, MyLogicClock:64, MyBinMsg/binary >> =Packet,
	    TimeStamp=calendar:gregorian_seconds_to_datetime(MyTimeStamp+86400 *719528),
	    file:write_file("log.log",Packet,[append]),
	    io:format("Got ~p ~p ~p ~p  ~n",[Host, Port,MyBinMsg, TimeStamp]),
            gen_udp:send(Socket, Host, Port, Packet),
            loop(Socket)
    end.


