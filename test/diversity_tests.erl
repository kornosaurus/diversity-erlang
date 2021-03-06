-module(diversity_tests).

-include_lib("eunit/include/eunit.hrl").

render_test_() ->
    {setup,
     fun start/0,
     fun stop/1,
     {timeout, 30, fun render_page/0}
    }.

start() ->
    application:ensure_all_started(diversity),
    ok.

stop(_Pid) ->
    application:stop(diversity).

render_page() ->
    Context = #{<<"language">> => <<"en">>,
                <<"webshop">> => 32208,
                <<"webshopUrl">> => <<"https://shop.heynicebeard.com">>,
                <<"apiUrl">> => <<"ws://shop.textalk.se/jsonrpc/v1">>,
                <<"swsUrl">> => <<"https://api.diversity.io/components">>},
    {ok, ParamsJSON} = file:read_file("test/params.json"),
    Params = jiffy:decode(ParamsJSON, [return_maps]),
    Result = diversity:render(Params, Context),
    ?debugFmt("~nResult: ~p~n", [Result]),
    ?assert(false).
