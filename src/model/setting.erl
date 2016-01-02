%% -*- coding: utf-8 -*-
-module(setting,[Id, SiteTitle::string(), SiteDescription::string(), SiteTheme::string(), IsActive::boolean(), PostsPerPage::integer(), SiteCustomFooterCode::string(), SiteAnalyticsCode::string(), MemberId, CreatedAt::datetime(), UpdatedAt::datetime()]).
-belongs_to(member).
-compile(export_all).
