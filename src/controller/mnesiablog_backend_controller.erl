%% -*- coding: utf-8 -*-
-module(mnesiablog_backend_controller, [Req]).
-compile(export_all).

index('GET', []) ->
	{ok, []}.

newpost('GET', []) ->
	{ok, []}.

newuser('GET', []) ->
	Members = boss_db:find(member,[]),
	{ok, [{members, Members}]}.

posts('GET', []) ->
	Posts = boss_db:find(post,[]),
	{ok, [{posts, Posts}]}.

%%module(post,[Id, Title::string(), Body::string(), CategoryId, MemberId, Password::string(), IsActive::boolean(), ReadCount::integer(), CreatedAt::datetime(), UpdatedAt::datetime(), DeletedAt::datetime()]).


login('GET', []) ->
	{ok, [{redirect, Req:header(referer)}]};

login('POST', []) ->
	Email = Req:post_param("email"),
	case boss_db:find(member, [{email, 'equals', Email}]) of
		[Member] ->
			case Member:check_password(Req:post_param("password")) of

				true ->
					{redirect, proplists:get_value("redirect", Req:post_params(), "/"), Member:login_cookies()};
				
				false ->
					{ok, [{error, "Authentication error"}]}
			end;
		[] ->
			{ok, [{error, "Authentication error"}]}
	end.

register('GET', []) ->
	{ok, []};

%%-module(member,[Id, Name::string(), Slug::string(), Email::string(), Password::string(), IsAdmin::boolean(), IsActive::boolean(), Rights::string(), CreatedAt::datetime(), UpdatedAt::datetime(), DeletedAt::datetime(), LastLogin::datetime()]).

register('POST', []) ->
	Email = Req:post_param("email"),
	Name = Req:post_param("name"),
	%%slug generation
	Slug = "aaaa",
	Password = bcrypt:hashpw(Req:post_param("password"),bcrypt:gen_salt()),
	Member = member:new(id, Email, Email, Password),
	Result = Member:save(),
	{ok, [Result]}.


