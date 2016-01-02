%% -*- coding: utf-8 -*-
-module(bloghelper).
-compile(export_all).

generate_slug(M,C,S) ->
    A=M,
    B=C,
	Mm = list_to_atom(M),
	Mc = list_to_atom(C),
	Sg = erl_slug:slugify(S),
	Ct = boss_db:count(Mm, [{Mc, 'equals', Sg}]),
	if Ct=:=0 -> Sg;
	   true ->

           NewSl = string:concat(S, integer_to_list(Ct)),
           generate_slug(A, B, NewSl)
	end.

is_integer("") ->
    false;
is_integer(S) ->
    lists:all(fun (D) -> D >= $0 andalso D =< $9 end, S).
