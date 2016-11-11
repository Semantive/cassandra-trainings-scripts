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
	year int,
	month int,
	day int,
	ms_part decimal,
	event_ts timeuuid,
	employee varchar,
	event_data varchar,
	primary key((year, month, day), event_ts)	
) with clustering order by (event_ts asc);

insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2015, 1, 1, minTimeuuid('2015-01-01'), 'jkowalski', 'Error 1'); 
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2015, 1, 2, minTimeuuid('2015-01-02'), 'jkowalski', 'Error 2');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2015, 1, 6, minTimeuuid('2015-01-06'), 'jkowalski', 'Error 22');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2015, 1, 3, minTimeuuid('2015-01-03'), 'jkowalski', 'Error 3');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2015, 1, 4, minTimeuuid('2015-01-04'), 'jkowalski', 'Error 4');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2015, 1, 5, minTimeuuid('2015-01-05'), 'jnowak', 'Error 6');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2015, 1, 5, minTimeuuid('2012-01-05'), 'jnowak', 'Error 61');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2016, 11, 12, now(), 'jnowak', 'Error 62');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2016, 11, 12, now(), 'jnowak', 'Error 7');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2016, 11, 12, now(), 'jkowalski', 'Error 71');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2016, 11, 12, now(), 'knowak', 'Info 8');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2016, 11, 12, now(), 'knowak', 'Info 9');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2016, 11, 12, now(), 'knowak', 'Info 10');
insert into fast_growing_jourlal(year, month, day, event_ts, employee, event_data) values(2015, 1, 5, maxTimeuuid('2012-01-05'), 'jnowak', 'Error 62');

select toTimestamp(event_ts), employee, event_data from fast_growing_jourlal;
select toTimestamp(event_ts), employee, event_data from fast_growing_jourlal where year = 2016 and month = 11 and day = 12;
select toTimestamp(event_ts), employee, event_data from fast_growing_jourlal where year = 2015 and month = 1 and day = 5 order by event_ts desc;

select toTimestamp(event_ts), employee, event_data from fast_growing_jourlal where year = 2015 and month = 1 and day = 5 order by event_ts desc;

 



