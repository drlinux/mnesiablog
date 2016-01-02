%% -*- coding: utf-8 -*-

-module(category, [Id, Title::string(), Description::string(), Slug::string(), IsActive::boolean(), CreatedAt::datetime(), UpdatedAt::datetime(), DeletedAt::datetime()]).
-has({posts, many}).
-compile(export_all).
