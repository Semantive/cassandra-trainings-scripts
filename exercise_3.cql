/**
 * Auction system
 */
create keyspace if not exists exercise_3  
with replication = {
	'class': 'SimpleStrategy',
	'replication_factor': 1
}; 

use exercise_3;

create table if not exists users(
	id uuid,
	nick varchar,
	email varchar,
	account_balance decimal,
	primary key(id)
);

create table if not exists users_by_emails_idx(
	domain varchar,
	username varchar,
	user_id uuid,
	primary key((domain), username)
);

create table if not exists items(
	id uuid,
	name varchar,
	description varchar,
	offers_number decimal,
	expiration_date timestamp,
	last_offer decimal,
	tags set<varchar>,
	offers_users list<varchar>,
	offers_prices list<decimal>,
	primary key (id)
);

create table if not exists items_views(
	id uuid primary key,
	view_count counter
);

create table if not exists transactions(
	user_id uuid,
	time timeuuid,
	seller_id uuid,
	item_id uuid, 
	price decimal,
	primary key((user_id), time)
);

create table if not exists inverse_transactions(
	seller_id uuid,
	time timeuuid,
	user_id uuid,
	item_id uuid, 
	price decimal,
	primary key((seller_id), time)
);

create table if not exists tokens(
	token_value varchar primary key,
	user_id uuid
);

create table if not exists items_by_offers(
	item_name varchar,
	offers_count decimal,
	item_id uuid,
	price decimal,
	primary key((item_name), offers_count, item_id, price)
);

/*create table if not exists items_by_views(
);*/

create table if not exists items_views_histogram(
	item_name varchar,
	time_discriminator timestamp,
	views_count decimal,
	primary key((item_name), time_discriminator)
);