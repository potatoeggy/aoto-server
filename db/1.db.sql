create schema api;

create table api.tags (
  id serial primary key,
  name varchar(255) not null unique,
  adult boolean not null default false,
  created_at timestamptz not null default now()
);

create table api.books (
  id serial primary key,
  title varchar(255) not null,
  author varchar(255) not null,
  description text default '',
  cover varchar(255) default '',
  created_at timestamptz not null default now()
);

create table api.tagmap (
  book_id integer not null references api.books (id),
  tag_id integer not null references api.tags (id),
  created_at timestamptz not null default now(),
  primary key (book_id, tag_id)
);

create table api.tagmap_minor {
  /* for minor tags */
  book_id integer not null references api.books (id),
  tag_id integer not null references api.tags (id),
  created_at timestamptz not null default now(),
  primary key (book_id, tag_id)
}


create table api.authors (
  id serial primary key,
  name varchar(255) not null,
  created_at timestamptz not null default now()
);


/* different endpoints */
create view api.books_view as
select
  b.id,
  b.title,
  b.author,
  b.description,
  b.cover,
  array_agg(t.name) as tags
from api.books b
left join api.tagmap tm on tm.book_id = b.id
left join api.tags t on t.id = tm.tag_id
group by b.id;


create view api.tags_view as
select
  t.id,
  t.name,
  t.adult,
  array_agg(b.title) as books
from api.tags t
left join api.tagmap tm on tm.tag_id = t.id
left join api.books b on b.id = tm.book_id
group by t.id;
