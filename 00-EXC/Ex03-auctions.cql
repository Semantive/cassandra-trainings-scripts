/**
 * Auction system
 */
create keyspace if not exists auctions  
with replication = {
	'class': 'SimpleStrategy', 'replication_factor': 1
}; 

use auctions;

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
 * used to check email uniqueness only
 */
CREATE TABLE IF NOT EXISTS users_by_email(
	email varchar,
	user_id uuid,
	PRIMARY KEY(email)
);

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
	firs_letter_of_name varchar,
	creation_year int,
	creation_month int,

	views bigint,
	bids bigint,
	bucket_firs_letter_of_name bigint,
	PRIMARY KEY(id, name, firs_letter_of_name, creation_time, creation_year, creation_month)
);

CREATE TABLE IF NOT EXISTS bucket_first_letter_of_item ( 
	firs_letter varchar, 
	bucket bigint,
	bucket_counter counter,
	PRIMARY KEY (firs_letter, bucket) 
) WITH CLUSTERING ORDER BY (bucket DESC);

CREATE MATERIALIZED VIEW IF NOT EXISTS items_by_name AS 
	SELECT id, auctioneer_id, name, description, creation_time, expiration_date, tags, last_offer, offers_bidders,
		offers_values, firs_letter_of_name, creation_year, creation_month, views, bids, bucket_firs_letter_of_name    
	FROM items
	WHERE id IS NOT NULL 
	AND name IS NOT NULL 
	AND firs_letter_of_name IS NOT NULL 
	AND creation_time IS NOT NULL
	AND creation_year IS NOT NULL
	AND creation_month IS NOT NULL
	AND bucket_firs_letter_of_name IS NOT NULL
	PRIMARY KEY ((firs_letter_of_name, bucket_firs_letter_of_name), name, creation_time, creation_year, creation_month, id);

CREATE MATERIALIZED VIEW IF NOT EXISTS items_by_creation_time AS 
	SELECT id, auctioneer_id, name, description, creation_time, expiration_date, tags, last_offer, 
		offers_bidders, offers_values, firs_letter_of_name, creation_year, creation_month, views, bids
	FROM items
	WHERE id IS NOT NULL 
	AND name IS NOT NULL 
	AND firs_letter_of_name IS NOT NULL 
	AND creation_time IS NOT NULL
	AND creation_year IS NOT NULL
	AND creation_month IS NOT NULL
	PRIMARY KEY ((creation_year, creation_month), creation_time, name, firs_letter_of_name, id)
	WITH CLUSTERING ORDER BY (creation_time DESC);

CREATE MATERIALIZED VIEW IF NOT EXISTS items_by_name_by_views AS 
	SELECT id, auctioneer_id, name, description, creation_time, expiration_date, tags, last_offer, 
		offers_bidders, offers_values, firs_letter_of_name, creation_year, creation_month, views, bids    
	FROM items
	WHERE id IS NOT NULL 
	AND name IS NOT NULL 
	AND firs_letter_of_name IS NOT NULL 
	AND creation_time IS NOT NULL
	AND creation_year IS NOT NULL
	AND creation_month IS NOT NULL
	AND views IS NOT NULL
	PRIMARY KEY (name, views, id, creation_time, creation_year, creation_month, firs_letter_of_name)
	WITH CLUSTERING ORDER BY (views DESC);

CREATE MATERIALIZED VIEW IF NOT EXISTS items_by_name_by_bids AS 
	SELECT id, auctioneer_id, name, description, creation_time, expiration_date, tags, last_offer,
		 offers_bidders, offers_values, firs_letter_of_name, creation_year, creation_month, views, bids    
	FROM items
	WHERE id IS NOT NULL 
	AND name IS NOT NULL 
	AND firs_letter_of_name IS NOT NULL 
	AND creation_time IS NOT NULL
	AND creation_year IS NOT NULL
	AND creation_month IS NOT NULL
	AND bids IS NOT NULL
	PRIMARY KEY (name, bids, id, creation_time, creation_year, creation_month, firs_letter_of_name)
	WITH CLUSTERING ORDER BY (bids DESC);

CREATE TABLE IF NOT EXISTS items_views_histogram(
	item_name varchar,
	time_discriminator timestamp,
	views counter,
	PRIMARY KEY(item_name, time_discriminator)
);

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


CREATE TABLE IF NOT EXISTS tokens(
	token_value uuid PRIMARY KEY,
	user_id uuid
);

CREATE CUSTOM INDEX IF NOT EXISTS users_by_name_surname ON users (name_surname) USING 'org.apache.cassandra.index.sasi.SASIIndex'
  WITH OPTIONS = { 'mode': 'CONTAINS' };

CREATE CUSTOM INDEX IF NOT EXISTS items_by_name ON items (name) USING 'org.apache.cassandra.index.sasi.SASIIndex'
  WITH OPTIONS = { 'mode': 'CONTAINS' };




