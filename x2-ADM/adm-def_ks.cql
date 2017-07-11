CREATE KEYSPACE IF NOT EXISTS def_ks 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3 };

CREATE TABLE IF NOT EXISTS def_ks.datatable ( 
	left_id text, 
	right_id text, 
	chosen text, 
	PRIMARY KEY ((left_id, right_id))
) 
WITH dclocal_read_repair_chance = 0.0 
AND read_repair_chance = 0.0 
AND comment = 'https://archive.ics.uci.edu/ml/datasets/YouTube+Comedy+Slam+Preference+Data' ;

--COPY def_ks.datatable FROM '.../path/to/comedy_comparisons.csv' WITH DELIMITER = ',' AND HEADER = false;
