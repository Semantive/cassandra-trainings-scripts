/**
 * Auction system
 */
DROP KEYSPACE IF exists auctions; 
 
create keyspace if not exists auctions  
with replication = {
	'class': 'SimpleStrategy', 'replication_factor': 1
}; 

use auctions;


/**
 * Users' primary store
 */
CREATE TABLE IF NOT EXISTS users(
	id uuid,
	name varchar,
	surname varchar,
	name_surname varchar,
	nick varchar,
	email varchar,
	account_balance decimal,
	active boolean,
	PRIMARY KEY(id)
);

/**
 * Used to check email uniqueness only
 */
CREATE TABLE IF NOT EXISTS users_by_email(
	email varchar,
	user_id uuid,
	PRIMARY KEY(email)
);

/**
 * Unique tokens, generated for user registration.
 * This table could be merged with users.
 */
CREATE TABLE IF NOT EXISTS tokens(
	token_value uuid PRIMARY KEY,
	user_id uuid
);

/**
 * NOTE: there is a problem with updating UDT inside collection, 
 * since it has to be frozen. 
 * This is why items uses two separates list offers: offers_bidders and offers_values   
 */
CREATE TYPE IF NOT EXISTS offer (
	value decimal,
	time timestamp,
	bidder_id uuid
);

CREATE TABLE IF NOT EXISTS items(
	id uuid,
	auctioneer_id uuid,
	name varchar,
	description varchar,
	creation_time timeuuid,
	expiration_date timestamp,
	tags set<varchar>,
	last_offer decimal,
	offers_bidders list<uuid>,
	offers_values list<decimal>,

	--columns for rankings - materialized views	
	name_prefix varchar,
	views bigint,
	bids bigint,
	bucket_creation_date timeuuid,
	PRIMARY KEY(id, name, creation_time)
);

CREATE TABLE IF NOT EXISTS bucket_creation_date ( 
	year int,
	bucket timeuuid,
	bucket_counter counter,
	PRIMARY KEY (year, bucket) 
) WITH CLUSTERING ORDER BY (bucket DESC)
	AND caching = {'rows_per_partition': '1'};


CREATE MATERIALIZED VIEW IF NOT EXISTS items_by_name AS 
	SELECT id, auctioneer_id, name, description, creation_time, expiration_date, tags, 
		last_offer, offers_bidders, offers_values, name_prefix, views, bids
	FROM items
	WHERE id IS NOT NULL 
	AND name IS NOT NULL 
	AND name_prefix IS NOT NULL 
	AND creation_time IS NOT NULL
	PRIMARY KEY (name_prefix, name, creation_time, id);

CREATE MATERIALIZED VIEW IF NOT EXISTS items_by_creation_time AS 
	SELECT id, auctioneer_id, name, description, creation_time, expiration_date, tags, last_offer, 
		offers_bidders, offers_values, views, bids, bucket_creation_date
	FROM items
	WHERE id IS NOT NULL 
	AND name IS NOT NULL 
	AND creation_time IS NOT NULL
	AND bucket_creation_date IS NOT NULL
	PRIMARY KEY (bucket_creation_date, creation_time, name, id)
	WITH CLUSTERING ORDER BY (creation_time DESC)
		AND compaction = {'class': 'org.apache.cassandra.db.compaction.TimeWindowCompactionStrategy', 
			'compaction_window_unit': 'DAYS', 'compaction_window_size': '30'};

-- Updating views in source table causes deletion and insertion in items_by_name_by_views view.
-- It results with multiple tombstones. To reduce its number set gc_grace_seconds for 2 days.
CREATE MATERIALIZED VIEW IF NOT EXISTS items_by_name_by_views AS 
	SELECT id, auctioneer_id, name, description, creation_time, expiration_date, tags, last_offer, 
		offers_bidders, offers_values, views, bids    
	FROM items
	WHERE id IS NOT NULL 
	AND name IS NOT NULL 
	AND creation_time IS NOT NULL
	AND views IS NOT NULL
	PRIMARY KEY (name, views, id, creation_time)
	WITH CLUSTERING ORDER BY (views DESC)
		AND gc_grace_seconds = 172800;

-- Updating bids in source table causes deletion and insertion in items_by_name_by_bids view.
-- It results with multiple tombstones. To reduce its number set gc_grace_seconds for 4 days.
CREATE MATERIALIZED VIEW IF NOT EXISTS items_by_name_by_bids AS 
	SELECT id, auctioneer_id, name, description, creation_time, expiration_date, tags, last_offer,
		 offers_bidders, offers_values, views, bids    
	FROM items
	WHERE id IS NOT NULL 
	AND name IS NOT NULL 
	AND creation_time IS NOT NULL
	AND bids IS NOT NULL
	PRIMARY KEY (name, bids, id, creation_time)
	WITH CLUSTERING ORDER BY (bids DESC)
		AND gc_grace_seconds = 345600;

CREATE TABLE IF NOT EXISTS items_views_histogram(
	item_name varchar,
	time_discriminator timestamp,
	views counter,
	PRIMARY KEY(item_name, time_discriminator)
) WITH compaction = {'class': 'org.apache.cassandra.db.compaction.TimeWindowCompactionStrategy', 
		'compaction_window_unit': 'DAYS', 'compaction_window_size': '30'};


CREATE TABLE IF NOT EXISTS item_views(
	item_id uuid PRIMARY KEY,
	views counter
);

CREATE TABLE IF NOT EXISTS transactions(
	bidder_id uuid,
	auctioneer_id uuid,
	time timeuuid,
	item_id uuid, 
	price decimal,
	PRIMARY KEY(bidder_id, time)
) WITH CLUSTERING ORDER BY (time DESC);


CREATE MATERIALIZED VIEW IF NOT EXISTS inverse_transactions AS 
	SELECT bidder_id, auctioneer_id, time, item_id, price
	FROM transactions
	WHERE bidder_id IS NOT NULL AND auctioneer_id IS NOT NULL AND time IS NOT NULL
	PRIMARY KEY (auctioneer_id, time, bidder_id)
	WITH CLUSTERING ORDER BY (time DESC);


CREATE CUSTOM INDEX IF NOT EXISTS users_by_name_surname ON users (name_surname) USING 'org.apache.cassandra.index.sasi.SASIIndex'
  WITH OPTIONS = { 'mode': 'CONTAINS' };

CREATE CUSTOM INDEX IF NOT EXISTS items_by_name ON items (name) USING 'org.apache.cassandra.index.sasi.SASIIndex'
  WITH OPTIONS = { 'mode': 'CONTAINS' };




