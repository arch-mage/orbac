create schema orbac;

create table orbac.org (
  id            integer not null generated always as identity,
  name          text    not null,
  description   text,

  constraint org_pkey primary key (id),
  constraint org_name_length_check check (length(name) between 1 and 200),
  constraint org_description_length_check check (length(description) between 1 and 10000),
  constraint org_name_uniq unique (name)
);

create table orbac.role (
  id            integer not null generated always as identity,
  name          text    not null,
  description   text,

  constraint role_pkey primary key (id),
  constraint role_name_length_check check (length(name) between 1 and 200),
  constraint role_description_length_check check (length(description) between 1 and 10000),
  constraint role_name_uniq unique (name)
);

create table orbac.activity (
  id            integer not null generated always as identity,
  name          text    not null,
  description   text,

  constraint activity_pkey primary key (id),
  constraint activity_name_length_check check (length(name) between 1 and 200),
  constraint activity_description_length_check check (length(description) between 1 and 10000),
  constraint activity_name_uniq unique (name)
);

create table orbac.object (
  id            integer not null generated always as identity,
  name          text    not null,
  description   text,

  constraint object_pkey primary key (id),
  constraint object_name_length_check check (length(name) between 1 and 200),
  constraint object_description_length_check check (length(description) between 1 and 10000),
  constraint object_name_uniq unique (name)
);

create table orbac.subject (
  id            integer not null generated always as identity,
  name          text    not null,
  description   text,

  constraint subject_pkey primary key (id),
  constraint subject_name_length_check check (length(name) between 1 and 200),
  constraint subject_description_length_check check (length(description) between 1 and 10000),
  constraint subject_name_uniq unique (name)
);

create table orbac.action (
  id            integer not null generated always as identity,
  name          text    not null,
  description   text,

  constraint action_pkey primary key (id),
  constraint action_name_length_check check (length(name) between 1 and 200),
  constraint action_description_length_check check (length(description) between 1 and 10000),
  constraint action_name_uniq unique (name)
);

create table orbac.resource (
  id            integer not null generated always as identity,
  name          text    not null,
  description   text,

  constraint resource_pkey primary key (id),
  constraint resource_name_length_check check (length(name) between 1 and 200),
  constraint resource_description_length_check check (length(description) between 1 and 10000),
  constraint resource_name_uniq unique (name)
);

create table orbac.permission (
  org_id      integer not null,
  role_id     integer not null,
  activity_id integer not null,
  object_id   integer not null,

  constraint permission_pkey primary key (org_id, role_id, activity_id, object_id),
  constraint permission_org_id_fkey foreign key (org_id) references orbac.org (id) on update cascade on delete cascade,
  constraint permission_role_id_fkey foreign key (role_id) references orbac.role (id) on update cascade on delete cascade,
  constraint permission_activity_id_fkey foreign key (activity_id) references orbac.activity (id) on update cascade on delete cascade,
  constraint permission_object_id_fkey foreign key (object_id) references orbac.object (id) on update cascade on delete cascade
);

create index permission_org_id_idx on orbac.permission(org_id);
create index permission_role_id_idx on orbac.permission(role_id);
create index permission_activity_id_idx on orbac.permission(activity_id);
create index permission_object_id_idx on orbac.permission(object_id);

create table orbac.empower (
  org_id      integer not null,
  role_id     integer not null,
  subject_id  integer not null,

  constraint empower_pkey primary key (org_id, role_id, subject_id),
  constraint empower_org_id_fkey foreign key (org_id) references orbac.org (id) on update cascade on delete cascade,
  constraint empower_role_id_fkey foreign key (role_id) references orbac.role (id) on update cascade on delete cascade,
  constraint empower_subject_id_fkey foreign key (subject_id) references orbac.subject (id) on update cascade on delete cascade
);

create index empower_org_id_idx on orbac.empower(org_id);
create index empower_role_id_idx on orbac.empower(role_id);
create index empower_subject_id_idx on orbac.empower(subject_id);

create table orbac.consider (
  org_id      integer not null,
  action_id   integer not null,
  activity_id integer not null,

  constraint consider_pkey primary key (org_id, action_id, activity_id),
  constraint consider_org_id_fkey foreign key (org_id) references orbac.org (id) on update cascade on delete cascade,
  constraint consider_action_id_fkey foreign key (action_id) references orbac.action (id) on update cascade on delete cascade
);

create index consider_org_id_idx on orbac.consider(org_id);
create index consider_action_id_idx on orbac.consider(action_id);
create index consider_activity_id_idx on orbac.consider(activity_id);

create table orbac.use (
  org_id      integer not null,
  resource_id integer not null,
  object_id   integer not null,

  constraint use_pkey primary key (org_id, resource_id, object_id),
  constraint use_org_id_fkey foreign key (org_id) references orbac.org (id) on update cascade on delete cascade,
  constraint use_resource_id_fkey foreign key (resource_id) references orbac.resource (id) on update cascade on delete cascade,
  constraint use_object_id_fkey foreign key (object_id) references orbac.object (id) on update cascade on delete cascade
);

create index use_org_id_idx on orbac.use(org_id);
create index use_resource_id_idx on orbac.use(resource_id);
create index use_object_id_idx on orbac.use(object_id);
