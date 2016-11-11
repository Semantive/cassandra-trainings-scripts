/**
 * Fast growing journal 
 */
create keyspace if not exists exercise_2  
with replication = {
	'class': 'SimpleStrategy',
	'replication_factor': 1
}; 

use exercise_2;

create table if not exists fast_growing_jourlal(
	ms_part decimal,
	event_ts timeuuid,
	employee varchar,
	event_data varchar,
	primary key((ms_part), event_ts)	
) with clustering order by (event_ts asc);

insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(0, minTimeuuid('2015-01-01'), 'jkowalski', 'Error 1'); 
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(1, minTimeuuid('2015-01-02'), 'jkowalski', 'Error 2');
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(1, minTimeuuid('2015-01-06'), 'jkowalski', 'Error 22');
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(2, minTimeuuid('2015-01-03'), 'jkowalski', 'Error 3');
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(3, minTimeuuid('2015-01-04'), 'jkowalski', 'Error 4');
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(3, minTimeuuid('2015-01-05'), 'jnowak', 'Error 6');
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(3, minTimeuuid('2012-01-05'), 'jnowak', 'Error 61');
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(3, now(), 'jnowak', 'Error 62');
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(3, now(), 'jnowak', 'Error 7');
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(4, now(), 'jkowalski', 'Error 71');
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(0, now(), 'knowak', 'Info 8');
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(9, now(), 'knowak', 'Info 9');
insert into fast_growing_jourlal(ms_part, event_ts, employee, event_data) values(7, now(), 'knowak', 'Info 10');

select ms_part, dateOf(event_ts), employee, event_data from fast_growing_jourlal;
select ms_part, dateOf(event_ts), employee, event_data from fast_growing_jourlal where ms_part = 3;
select ms_part, dateOf(event_ts), employee, event_data from fast_growing_jourlal where ms_part = 3 order by event_ts desc;

select * from fast_growing_jourlal where ms_part in (0,1,2,3) order by event_ts desc;
select * from fast_growing_jourlal where ms_part in (0,1,2,3) order by event_ts asc;

 



