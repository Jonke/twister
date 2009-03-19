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

%%====================================================================
%% Internal functions
%%====================================================================
connect() ->
    {ok, Sock} = gen_udp:open(0),
    MyTimeStamp=calendar:datetime_to_gregorian_seconds(calendar:universal_time())-86400 *719528,
    MyLogicClock=1,
    MyMsg="hello twister",
    MyBinMsg=list_to_binary(MyMsg),
    Mem = << MyTimeStamp:64, MyLogicClock:64, MyBinMsg/binary >>,
    gen_udp:send(Sock,"localhost",4000,Mem),
    loop().

loop() ->
    io:format("waiting response...~n"),
    receive
	{udp, Peer, PeerIP, PeerPort, Packet } ->
	    io:format("~p:~p ==> ~p~n",[PeerIP,PeerPort,Packet])
    after 1000 ->
	    io:format("timeout..~n")
    end.
