create schema api;

create table api.tags (
  id serial primary key,
  name varchar(255) not null unique,
  adult boolean default false,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table api.books (
  id serial primary key,
  title varchar(255) not null,
  author varchar(255) not null,
  isbn varchar(255) not null unique,
  description text default '',
  cover varchar(255) default '',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table api.tagmap (
  book_id int references api.books (id),
  tag_id int references api.tags (id),
  created_at timestamptz default now(),
  primary key (book_id, tag_id)
);


create table api.authors (
  id serial primary key,
  name varchar(255) not null,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);


/* different endpoints */
create view api.books_view as
select
  b.*,
  array_agg(t.name) as tags
from api.books b
left join api.tagmap tm on tm.book_id = b.id
left join api.tags t on t.id = tm.tag_id
group by b.id;


create view api.tags_view as
select
  t.*,
  array_agg(b.title) as books
from api.tags t
left join api.tagmap tm on tm.tag_id = t.id
left join api.books b on b.id = tm.book_id
group by t.id;


/* tag search architecture
 * if there is an exact match, use that exact match
 * otherwise, use the first match
 */