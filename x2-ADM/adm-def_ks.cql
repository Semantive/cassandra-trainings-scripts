/**
 * 1. Create cluster with 2 nodes
 */
-- ccm create c311_2 -v 3.11.1 -n 2 -s


/**
 * 2. Create keyspace with RF = 2
 */
-- ccm node1 cqlsh
  
CREATE KEYSPACE IF NOT EXISTS def_ks 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 2 };

/**
 * 3. Create table destination table. Turn off random read repairs 
 */
CREATE TABLE IF NOT EXISTS def_ks.datatable ( 
	left_id text, 
	right_id text, 
	chosen text, 
	PRIMARY KEY ((left_id, right_id))
) 
WITH dclocal_read_repair_chance = 0.0 
AND read_repair_chance = 0.0 
AND comment = 'https://archive.ics.uci.edu/ml/datasets/YouTube+Comedy+Slam+Preference+Data' ;

/**
 * 4. Turn off node2
 */
-- ccm node2 stop
-- ccm node1 nodetool status

/**
 * 5. Disable handoff on node1
 */
-- ccm node1 nodetool disablehandoff
-- ccm node1 nodetool statushandoff

/**
 * 6. Load data with cqlsh
 */
-- ccm node1 cqlsh
-- COPY def_ks.datatable FROM '/home/cassandra/Workspace/comedy_comparisons/comedy_comparisons.test' WITH DELIMITER = ',' AND HEADER = false;
-- select * from def_ks.datatable;

/**
 * 7. Turn on node2 and check data in def_ks.datatable
 */
-- ccm node2 start
-- ccm node2 cqlsh
-- select * from def_ks.datatable;

/**
 * 8. Compare tablestats on node1 and node2
 */
-- ccm node1 nodetool tablestats "def_ks.datatable -H"
-- ccm node2 nodetool tablestats "def_ks.datatable -H"

/**
 * 9. Increase the consistency level on node2, select data and compare tablestats again; 
 */
 -- ccm node2 cqlsh
 -- consistency all;
 -- select * from def_ks.datatable;
 
 /**
  * 10. Repair cluster and compare tablestats again;
  */
-- ccm node1 nodetool repair
-- ccm node1 nodetool tablestats "def_ks.datatable -H"
-- ccm node2 nodetool tablestats "def_ks.datatable -H"
