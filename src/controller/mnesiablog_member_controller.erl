-module(mnesiablog_user_controller, [Req]).
-compile(export_all).

login('GET', []) ->
	{ok, [{redirect, Req:header(referer)}]};

login('POST', []) ->
	Email = Req:post_param("email"),
	case boss_db:find(mnesiablog_user, [{email, 'equals', Email}]) of
		[MnesiablogUser] ->
			case MnesiablogUser:check_password(Req:post_param("password")) of
				true ->
					{redirect, proplists:get_value("redirect",
								       Req:post_params(), "/"), MnesiablogUser:login_cookies()};
				false ->
					{ok, [{error, "Authentication error"}]}
			end;
		[] ->
			{ok, [{error, "Authentication error"}]}
	end.

register('GET', []) ->
	{ok, []};

register('POST', []) ->
	Email = Req:post_param("email"),
	Email = Req:post_param("email"),
	Password = bcrypt:hashpw(Req:post_param("password"),bcrypt:gen_salt()),
	MnesiablogUser = mnesiablog_user:new(id, Email, Email, Password),
	Result = MnesiablogUser:save(),
	{ok, [Result]}.
