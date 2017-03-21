CREATE KEYSPACE IF NOT EXISTS sandbox1
WITH replication = {
	'class' : 'SimpleStrategy',
	'replication_factor' : 1
};

/**
 * Partition key only
 */
CREATE TABLE IF NOT EXISTS sandbox1.table1 (
	id int,
	name text,
	PRIMARY KEY (id)
);

insert into sandbox1.table1(id, name) values (1, 'a');
insert into sandbox1.table1(id, name) values (2, 'b');
insert into sandbox1.table1(id, name) values (3, 'c');
insert into sandbox1.table1(id, name) values (6, 'd');

select * from sandbox1.table1 where id in(2, 3, 6);

/**
 * Compound primary key
 */
CREATE TABLE IF NOT EXISTS sandbox1.table2 (
	id int,
	t int,
	name text,
	PRIMARY KEY (id, t)
);

insert into sandbox1.table2(id, t, name) values (1, 1, 'John');
insert into sandbox1.table2(id, t, name) values (1, 2, 'John');
insert into sandbox1.table2(id, t, name) values (2, 5, 'Michael');
insert into sandbox1.table2(id, t, name) values (2, 6, 'Mick');
insert into sandbox1.table2(id, t, name) values (3, 3, 'Mick');
insert into sandbox1.table2(id, t, name) values (3, 4, 'Mick');

select * from sandbox1.table2;

--error - partition key is required
select * from sandbox1.table2 where t = 2;
select * from sandbox1.table2 where t >= 3;

--ok
select * from sandbox1.table2 where t = 2 allow filtering;
select * from sandbox1.table2 where t >= 3 allow filtering;

--error - "ORDER BY is only supported when the partition key is restricted by an EQ or an IN."
select * from sandbox1.table2 where t >= 3 order by t asc limit 5 allow filtering;

--ok
select * from sandbox1.table2 where t >= 3 limit 5 allow filtering;

--ok, please use cqlsh
select * from sandbox1.table2 where id = 2 and  t >= 3 order by t asc limit 5;

--token range 
select * from sandbox1.table2 where token(id) < 0 and t > 0 allow filtering;


/**
 * Indexing table2 
 */
create index if not exists st2 on sandbox1.table2 (t);
--drop index sandbox1.st2;

--error, filtering multiple partitions
select * from sandbox1.table2 where t in (1, 2);

--ok
select * from sandbox1.table2 where t in (1, 2) allow filtering;
select * from sandbox1.table2 where t = 2;


drop index sandbox1.st2;
select * from sandbox1.table2 where t = 2;


/**
 * Compound primary key, compound clustering key
 */
CREATE TABLE IF NOT EXISTS sandbox1.timeline (
	day int,
	hour int,
	minute int,
	value text,
	PRIMARY KEY (day, hour, minute)
);

insert into sandbox1.timeline(day, hour, minute, value) values (1, 1, 10, 'a');
insert into sandbox1.timeline(day, hour, minute, value) values (1, 2, 11, 'b');
insert into sandbox1.timeline(day, hour, minute, value) values (2, 1, 12, 'a');
insert into sandbox1.timeline(day, hour, minute, value) values (2, 2, 13, 'b');
insert into sandbox1.timeline(day, hour, minute, value) values (2, 3, 133, 'b');
insert into sandbox1.timeline(day, hour, minute, value) values (3, 1, 14, 'a');
insert into sandbox1.timeline(day, hour, minute, value) values (3, 2, 15, 'b');

select * from sandbox1.timeline;

--ok, specified partition key
select * from sandbox1.timeline where day = 2 and (hour, minute) >= (1, 13);

--allow filtering is required, multiple partitions scanned
select * from sandbox1.timeline where (hour, minute) >= (2, 13) allow filtering;