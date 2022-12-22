grant usage on schema api to web_anon;
grant select on api.tags to web_anon;
grant select on api.books to web_anon;
grant select on api.tagmap to web_anon;
grant select on api.tags_view to web_anon;
grant select on api.books_view to web_anon;

grant usage on schema api to authed_user;
grant all on api.books to authed_user;
grant all on api.tags to authed_user;
grant all on api.tagmap to authed_user;
grant usage, select on sequence api.books_id_seq to authed_user;
grant usage, select on sequence api.tags_id_seq to authed_user;
grant usage, select on sequence api.tagmap_id_seq to authed_user;
