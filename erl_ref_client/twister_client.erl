%%%-------------------------------------------------------------------
%%% File    : twister_client.erl
%%% Author  :  <jonke@MEDICHAM>
%%% Description : 
%%%
%%% Created : 19 Mar 2009 by  <jonke@MEDICHAM>
%%%-------------------------------------------------------------------
-module(twister_client).

%% API
-export([connect/0]).

%%====================================================================
%% API
%%====================================================================
%%--------------------------------------------------------------------
%% Function: 
%% Description:
%%--------------------------------------------------------------------
connect()->
    connect0().
%%====================================================================
%% Internal functions
%%====================================================================
connect0() ->
    {ok, Sock} = gen_udp:open(0),
    MyTimeStamp=calendar:datetime_to_gregorian_seconds(calendar:universal_time())-86400 *719528,
    MyLogicClock=1,
    MyMsg="someid",
    MyBinMsg1=list_to_binary(MyMsg),
    MyBinMsg=pad_to(50,MyBinMsg1),
    MyComment=pad_to(50,list_to_binary("cook it")),
    Mem = << MyTimeStamp:64, MyLogicClock:64, MyBinMsg/binary,MyComment/binary >>,
    gen_udp:send(Sock,"localhost",4000,Mem),
    void.

loop() ->
    io:format("waiting response...~n"),
    receive
	{udp, Peer, PeerIP, PeerPort, Packet } ->
	    io:format("~p:~p ==> ~p~n",[PeerIP,PeerPort,Packet])
    after 1000 ->
	    io:format("timeout..~n")
    end.


pad_to(Bsize, Binary1) ->
    Binary=case size(Binary1) > Bsize of
	       false -> Binary1;
	       true -> B2=split_binary(Binary1,Bsize),
		       {Bg,_}=B2,
		       Bg
	   end,
    
    case (Bsize - size(Binary) rem Bsize) rem Bsize of 
	0 -> Binary;
	N -> <<Binary/binary, 0:(N*8)>>
		 end.
