use auctions;

/**
 * USER REGISTRATION 
 * 
 * It lock an email and create inactive, volatile, inactive user.
 * It will be deleted with all related data, if it does not confirm the account in 3 days.  
 * 
 * 1. verify if email is available, and just register it if it's unique and continue procedure
 * 2. insert a new user with reserved email with expiration time equals 3 days 
 * 3. generate a registration token with expiration time equals 3 days, it is used to confirm the email
 * 4. update the entry for user registration and release it (remove) after 3 days
 * 5. make user permanent on email confirmation  
 */
 
/**
 * verify if email is available, and just register it if it's unique and continue procedure
 */
INSERT INTO users_by_email (email, user_id) 
VALUES ('john.dee@semantive.com', 20cd62f7-956e-4f33-aecd-29a6cd204b4e) IF NOT EXISTS;
 
BEGIN BATCH 
	INSERT INTO users (id, name, surname, name_surname, nick, email, account_balance, active)
		VALUES (20cd62f7-956e-4f33-aecd-29a6cd204b4e, 'John', 'Dee', 'John Dee', 'jdee', 
			'john.dee@semantive.com', 200, false) 
		USING TTL 259200;
	
	INSERT INTO tokens (token_value, user_id) 
		VALUES(c0d8f861-9605-490e-b248-76b9d940b536, 20cd62f7-956e-4f33-aecd-29a6cd204b4e)
		USING TTL 259200;
	
	UPDATE users_by_email USING TTL 259200 SET user_id = 20cd62f7-956e-4f33-aecd-29a6cd204b4e
	WHERE email = 'john.dee@semantive.com';
APPLY BATCH;

/**
 * Confirm registration
 * 1. Make the user and the email permanent
 * 2. Remove the used token
 */
BEGIN BATCH 
	UPDATE users USING TTL 0
	SET name='John', surname='Dee', name_surname = 'John Dee', nick='jdee', email='john.dee@semantive.com', account_balance=0, active=true
	WHERE id = 20cd62f7-956e-4f33-aecd-29a6cd204b4e;
	
	UPDATE users_by_email USING TTL 259200 SET user_id = 20cd62f7-956e-4f33-aecd-29a6cd204b4e
	WHERE email = 'john.dee@semantive.com';

	DELETE FROM tokens where token_value = c0d8f861-9605-490e-b248-76b9d940b536;
APPLY BATCH;

/**
 * Auxiliary user, used as a bidder
 */
INSERT INTO users (id, name, surname, name_surname, nick, email, account_balance, active)
	VALUES (6ca101bc-388e-46bb-970c-d82fd4d13654, 'Matt', 'Bidder', 'Matt Bidder', 
		'bidder', 'matt.b@bidder.com', 200, true); 



/**
 * ADDING ITEM
 */
 
/**
 * Get the current 'bucket' for the first_letter of adding product. If it's empty, then bucket is 0
 * The table is sorted descending by bucket, then the first row on the partition is the current one. 
 */
SELECT bucket, bucket_counter from bucket_creation_date where year = 2017 LIMIT 1;
 
/**
 * 1. If the bucket_counter is greater than MAX_BUCKET_SIZE, than increment bucket. 
 * 2. Increment bucket_counter for the current bucket value. 
 */ 
UPDATE bucket_creation_date SET bucket_counter = bucket_counter + 1
WHERE year = 2017 and bucket = minTimeuuid('2017-08-01');
 
/**
 * Insert a new item, with bucket_creation_date set with value from the bucket table
 */ 
INSERT INTO items (id, auctioneer_id, name, description, creation_time, expiration_date, 
	last_offer, tags, name_prefix, views, bids, bucket_creation_date)
VALUES (26ea7804-31ba-4129-9ade-1a1789566ed5, 20cd62f7-956e-4f33-aecd-29a6cd204b4e, 'tv set', 
	'brand new samsung tv set', minTimeuuid('2017-08-01'), '2017-09-01', 
	0.0, {'tv'}, 'tv', 0, 0, minTimeuuid('2017-08-01'));
 

/**
 * ADDING OFFER
 */
 
/**
 * Get offers' columns, including last_offer  
 */ 
SELECT offers_bidders, offers_values, bids, last_offer FROM items 
where id = 26ea7804-31ba-4129-9ade-1a1789566ed5;

/**
 * Client application should check if the new offer is greater than the last_offer, then update
 * the item conditionally to make sure no one will add the offer simultaneously, since it will be
 * executed in isolation. 
 * If there was already an offer, then the condition is added and it uses the previous offer.
 * Number of bids is computed by application - it's just the length of offers list.
 */
UPDATE items SET offers_bidders = [6ca101bc-388e-46bb-970c-d82fd4d13654],
	offers_values =  [80.0], last_offer = 80.0, bids = 1 
WHERE id = 26ea7804-31ba-4129-9ade-1a1789566ed5 and name = 'tv set' 
	and creation_time = minTimeuuid('2017-08-01') 
IF last_offer = 0.0;
 
 
/**
 * TRANSACTION REGISTRATION
 */

/**
 * Get the current state of bidder, especially account_balance
 */
select * from users where id = 6ca101bc-388e-46bb-970c-d82fd4d13654;
 
/**
 * Version1: Transactions per table, no atomicity over multiple tables
 * 1. Decrease the bidder's account_balance with accepted price, transactional
 * 2. Insert a new transaction, transactional
 */
UPDATE users SET account_balance = 120.0 
WHERE id = 6ca101bc-388e-46bb-970c-d82fd4d13654 IF account_balance = 200.0;
	
INSERT INTO transactions (bidder_id, auctioneer_id, time, item_id, price)
VALUES (6ca101bc-388e-46bb-970c-d82fd4d13654, 20cd62f7-956e-4f33-aecd-29a6cd204b4e, now(), 
	26ea7804-31ba-4129-9ade-1a1789566ed5, 80.0) IF NOT EXISTS;
 
 
/**
 * Version2: Non transactional, atomic update of user account and transactions
 * 1. Decrease the bidder's account_balance with accepted price. 
 * 2. Insert a new transaction.
 * NOTE: Decreasing account_ballance is not isolated
 */
BEGIN BATCH 
	UPDATE users SET account_balance = 120.0 
	WHERE id = 6ca101bc-388e-46bb-970c-d82fd4d13654; 
	
	INSERT INTO transactions (bidder_id, auctioneer_id, time, item_id, price)
	VALUES (6ca101bc-388e-46bb-970c-d82fd4d13654, 20cd62f7-956e-4f33-aecd-29a6cd204b4e, now(), 
		26ea7804-31ba-4129-9ade-1a1789566ed5, 80.0);
APPLY BATCH;


/**
 * UPDATE ITEM VIEWS
 */ 

/**
 * Increment views counter for the given item. It should be done every time a user enters the page.
 */ 
UPDATE item_views SET views = views + 1
WHERE item_id = 26ea7804-31ba-4129-9ade-1a1789566ed5;

/**
 * Ranking update should be executed periodically, for example every 10 views, to reduce
 * overhead on frequent materialized views updates.
 * 
 * 1. Get the current number of views
 * 2. Update the item with a new views number
 * 3. Update histogram
 */
SELECT views FROM item_views WHERE item_id = 26ea7804-31ba-4129-9ade-1a1789566ed5;

UPDATE items SET views = 10 
WHERE id = 26ea7804-31ba-4129-9ade-1a1789566ed5 
	and name = 'tv set' 
	and creation_time = minTimeuuid('2017-08-01');

UPDATE items_views_histogram SET views = views + 1
WHERE item_name = 'tv set' AND time_discriminator = '2017-08-01';

/**
 * QUERY - Paging items sorted by name
 */

/**
 * The naive solutions uses first latter of name as name prefix - the partition key 
 */
--first
select * from items_by_name where name_prefix = 'a' LIMIT 1;

--next
select * from items_by_name where name_prefix = 'a' 
and name > 'the last name returned by the previous query' LIMIT 1;

/**
 * QUERY - Paging items sorted by time
 */

/**
 * Get the first page of 50 items
 */
select * from items_by_creation_time LIMIT 50;
 
/**
 * Get the last bucket which is greater or equal the last returned item's creation time.
 * It is used to select the next page. If bucket_counter < page size, than we know the another
 * bucket will be needed.
 */ 
SELECT bucket, bucket_counter FROM bucket_creation_date 
WHERE year = 2017 and bucket >= minTimeuuid('2017-10-01')
LIMIT 1;
 
/**
 * 1. The next queries uses the retrieved bucket until they can fetch the next page. 
 * 2. If there is no data for a given bucket, then selecting items from the time rank query the next bucket
 */
SELECT * FROM items_by_creation_time
WHERE bucket_creation_date = minTimeuuid('2017-10-01') 
	AND creation_time > minTimeuuid('2017-10-01')
LIMIT 50;


/**
 * QUERY - Paging items sorted by number of views for a item name
 */
 -- first
 select * from items_by_name_by_views where name = 'tv set' LIMIT 50; 
  -- next
 select * from items_by_name_by_views 
 where name = 'tv set' and (views, id) > (0, 26ea7804-31ba-4129-9ade-1a1789566ed5) LIMIT 50;
 
 
/**
 * QUERY - Paging items sorted by number of bids for a item name
 */
 -- first
 select * from items_by_name_by_bids where name = 'tv set' LIMIT 50; 
  -- next
 select * from items_by_name_by_bids 
 where name = 'tv set' and (bids, id) > (0, 26ea7804-31ba-4129-9ade-1a1789566ed5) LIMIT 50; 
 
 
/**
 * QUERY - searching users by name and surname 
 */
--SELECT * FROM users WHERE name_surname LIKE '%john%';
 
/**
 * QUERY - searching items by name 
 */
--SELECT * FROM items WHERE name LIKE '%set%';
 
 