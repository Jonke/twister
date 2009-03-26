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
        {udp, Socket, Host, Port, Packet}  ->
	    io:format("size of packet is ~p ~n",[size(Packet)]),
	    case size(Packet) of
		128 ->
	    {Header,Body}=split_binary(Packet,28),
	    << MyTimeStamp:64, MyLogicClock:64, AppID:32,FunID:32, SignalID:32 >> = Header, 
	    
	    {MyBinMsg,MyComment}  =split_binary(Body,50),
	    TimeStamp=calendar:gregorian_seconds_to_datetime(MyTimeStamp+86400 *719528),
		    file:write_file("log.log",Packet,[append]),
	    io:format("Got ~p ~p ~p ~p ~p ~p ~p ~p ~n",[Host, Port,[X || X <- binary_to_list(MyBinMsg), X =/= 0],[X || X <- binary_to_list(MyComment), X =/= 0], TimeStamp, AppID, FunID, SignalID]);
	    %% gen_udp:send(Socket, Host, Port, Packet),
		    O ->
		    io:format("Malformed size of packet is ~p ~n",[O])
	    end,
	    loop(Socket);
	%%    void;
	
	Other ->
	    io:format("Other ~p ~n",[Other])
    end.


