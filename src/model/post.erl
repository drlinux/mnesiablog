%% -*- coding: utf-8 -*-
-module(post,[Id, Title::string(), Slug::string(), Body::string(), CategoryId, MemberId, Password::string(), Status::string(), ReadCount::integer(), CreatedAt::datetime(), UpdatedAt::datetime(), DeletedAt::datetime()]).
-belongs_to(member).
-has({categories, many}).
-compile(export_all).
