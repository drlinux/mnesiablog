%% -*- coding: utf-8 -*-

-module(mnesiablog_frontend_controller, [Req]).
-compile(export_all).

index('GET', []) ->
    
    S=boss_db:find_first(setting,[]),
    Posts = boss_db:find(post, [{status,'equals',"published"}], [{},{},{order_by,'created_at'}, descending]),

    {ok, [{setting, S},{posts, Posts}]}.

posts('GET',[Id]) ->
    
    Ct = boss_db:count(post, [{slug, 'equals', Id}]),

    if Ct=:=0 ->  {output, "Yoğ"};
	   true -> 
        S=boss_db:find_first(setting,[]),
        Post=boss_db:find_first(post, [{slug, 'equals', Id}]),
        {ok, [{setting, S},{post, Post}]}
    end.

author_posts('GET',[Id]) ->
    
    Ct = boss_db:count(member, [{slug, 'equals', Id}]),

    if Ct=:=0 ->  {output, "Yoğ"};
	   true ->
        Member = boss_db:find_first(member, [{slug, 'equals', Id}]),
        S=boss_db:find_first(setting,[]),
        Posts=boss_db:find(post, [{memberId, 'equals', Member:slug()}]),
        {render_other, [{action, "index"}], [{setting, S},{posts, Posts}]}
    end.
