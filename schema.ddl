-- -*- mode: sql -*-
drop schema if exists ping_pong cascade;
create schema ping_pong;

drop user if exists ping_pong;
create user ping_pong password 'ping_pong';
grant all on schema ping_pong to ping_pong;

drop type if exists skill_level;
create type skill_level as enum ('BEGINNER', 'INTERMEDIATE', 'PRO STATUS');

drop type if exists match_type;
create type match_type as enum ('SINGLES', 'DOUBLES', 'ROUNDROBIN');

drop type if exists team;
create type team as enum ('CHALLENGER', 'CHALLENGED');

--
-- table ping_pong.matches
--
drop table if exists ping_pong.matches;
create table ping_pong.matches (
  match_key bigserial not null,
  constraint pk_matches primary key (match_key)
);
alter table ping_pong.matches owner to ping_pong;


--
-- table ping_pong.players
--
drop table if exists ping_pong.players;
create table ping_pong.players (
  player_key bigserial not null,
  name text not null,
  hipchat_name text null,
  email_address text null,
  skill_level skill_level null,
  tagline text null,
  constraint pk_player primary key (player_key)
);
alter table ping_pong.players owner to ping_pong;
grant all on table ping_pong.players to ping_pong;
--create index on ping_pong.players(player_key, skill_level);

insert into ping_pong.players (name, hipchat_name, email_address, skill_level, tagline)
values ('molsen', '@molsen', 'matthewo@porch.com', 'INTERMEDIATE', 'YeaH BuddY!');

insert into ping_pong.players (name, hipchat_name, email_address, skill_level, tagline)
values ('TheZACH (admin)', '@ZacharyRichards', 'zachr@porch.com', 'PRO STATUS', null);


--
-- table ping_pong.match_player
--
drop table if exists ping_pong.match_player;
create table ping_pong.match_player (
  match_player_key bigserial not null,
  match_key bigint not null,
  player_key bigint not null,
  team team not null,
  constraint pk_match_player primary key (match_player_key)
);
alter table ping_pong.match_player owner to ping_pong;


--
-- table ping_pong.match_queue
--
drop table if exists ping_pong.match_queue;
create table ping_pong.match_queue (
  match_queue_key bigserial not null,
  match_key bigint null,
  queued_dtm timestamp with time zone not null default now(),
  started_dtm timestamp with time zone null,
  completed_dtm timestamp with time zone null,
  cancelled_dtm timestamp with time zone null,
  constraint pk_match_queue primary key (match_queue_key)
);
alter table ping_pong.match_queue owner to ping_pong;


--
-- table ping_pong.challenges
--
drop table if exists ping_pong.challenges;
create table ping_pong.challenges (
  challenge_key bigserial not null,
  match_key bigint null,
  challenge_dtm timestamp with time zone not null default now(),
  accepted_dtm timestamp with time zone null,
  rejected_dtm timestamp with time zone null,
  cancelled_dtm timestamp with time zone null,
  constraint pk_challenges primary key (challenge_pool_key)
);
alter table ping_pong.challenges owner to ping_pong;


--
-- table ping_pong.outcomes
--
drop table if exists ping_pong.outcomes;
create table ping_pong.outcomes (
  outcome_key bigserial not null,
  match_key bigint not null,
  winning_team team not null,
  winning_score int not null,
  losing_score int not null,
  recorded_dtm timestamp with time zone not null default now(),
  constraint pk_outcomes primary key (outcome_key)
);
alter table ping_pong.outcomes owner to ping_pong;


--
-- table ping_pong.single_player_pool
--
drop table if exists ping_pong.single_player_pool;
create table ping_pong.single_player_pool (
  single_player_pool_key bigserial not null,
  player_key bigint not null,
  skill_level skill_level null,
  match_type match_type null,
  added_dtm timestamp with time zone null default now(),
  constraint pk_single_player_pool primary key (single_player_pool_key)
);
alter table ping_pong.single_player_pool owner to ping_pong;
