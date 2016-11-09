/** Create keyspace 'songbrowser' */
CREATE KEYSPACE IF NOT EXISTS songbrowser
WITH REPLICATION = {
	'class': 'SimpleStrategy',
	'replication_factor': 2
}; 

/** Show all keyspaces */
DESCRIBE KEYSPACES;
