/* access */
create role web_anon nologin;

create role authenticator noinherit login password 'mysecretpassword';
grant web_anon to authenticator;

create role authed_user nologin;
grant authed_user to authenticator;
