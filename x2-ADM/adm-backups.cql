CREATE KEYSPACE IF NOT EXISTS backup
WITH REPLICATION = {
	'class': 'SimpleStrategy',
	'replication_factor': 1
}; 

create table if not exists backup.test (
	id int,
	s int,
	z int,
	d text,
	primary key(id, s, z)
);

insert into backup.test(id, s, z, d) values(1, 1, 1, 'a');
insert into backup.test(id, s, z, d) values(1, 2, 2, 'b');
insert into backup.test(id, s, z, d) values(1, 3, 3, 'c');
insert into backup.test(id, s, z, d) values(3, 4, 4, 'd');
insert into backup.test(id, s, z, d) values(3, 5, 5, 'e');
insert into backup.test(id, s, z, d) values(2, 6, 6, 'f');
insert into backup.test(id, s, z, d) values(2, 7, 7, 'g');
insert into backup.test(id, s, z, d) values(4, 8, 9, 'g');
insert into backup.test(id, s, z, d) values(5, 8, 9, 'g');
insert into backup.test(id, s, z, d) values(7, 8, 9, 'g');
insert into backup.test(id, s, z, d) values(8, 8, 9, 'g');

select * from backup.test;
-- nodetool flush -- backup test
-- nodetool listsnapshots
-- nodetool snapshot -t s1 -cf test -- backup
-- nodetool clearsnapshot -t s1 -- backup 

delete from backup.test where id = 4 and s = 8 and z = 9;
delete from backup.test where id = 2 and s = 7 and z = 7;

select * from backup.test;

truncate backup.test;
select * from backup.test;
-- nodetool refresh backup test

select * from backup.test;

--nodetool disablebackup
--nodetool enablebackup	