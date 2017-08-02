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
INSERT INTO users_by_email (email, user_id) VALUES ('test@semantive.com', uuid()) IF NOT EXISTS;
 
BEGIN BATCH 
	INSERT INTO users (id, name, surname, nick, email, account_balance, active)
		VALUES (20cd62f7-956e-4f33-aecd-29a6cd204b4e, 'John', 'Dee', 'jdee', 'john.dee@semantive.com', 150, false) 
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
	SET name='John', surname='Dee', nick='jdee', email='john.dee@semantive.com', account_balance=0, active=true
	WHERE id = 20cd62f7-956e-4f33-aecd-29a6cd204b4e;
	
	UPDATE users_by_email USING TTL 259200 SET user_id = 20cd62f7-956e-4f33-aecd-29a6cd204b4e
	WHERE email = 'john.dee@semantive.com';

	DELETE FROM tokens where token_value = c0d8f861-9605-490e-b248-76b9d940b536;
APPLY BATCH;

/**
 * Auxiliary user, used as a bidder
 */
INSERT INTO users (id, name, surname, nick, email, account_balance, active)
	VALUES (6ca101bc-388e-46bb-970c-d82fd4d13654, 'Matt', 'Bidder', 'bidder', 'matt.b@bidder.com', 200, true); 



/**
 * ADDING ITEM
 */
 
/**
 * Get the current 'bucket' for the first_letter of adding product. If it's empty, then bucket is 0
 * The table is sorted desc by bucket, then the first row on the partition is the current one. 
 */
SELECT bucket, bucket_counter from bucket_first_letter_of_item where firs_letter = 't' LIMIT 1;
 
/**
 * If the bucket_counter is greater than MAX_BUCKET_SIZE, than increment bucket and 
 * Update bucket_counter for a new bucket value 
 */ 
UPDATE bucket_first_letter_of_item SET bucket_counter = bucket_counter + 1
WHERE firs_letter = 't' and bucket = 0;
 
/**
 * Insert a new item, with bucket_firs_letter_of_name set with value from counter table
 */ 
INSERT INTO items (id, auctioneer_id, name, description, creation_time, expiration_date, tags,  
	firs_letter_of_name, creation_year, creation_month, views, bids, bucket_firs_letter_of_name)
VALUES (26ea7804-31ba-4129-9ade-1a1789566ed5, 20cd62f7-956e-4f33-aecd-29a6cd204b4e, 'tv set', 
	'brand new samsung tv set', minTimeuuid('2017-08-01'), '2017-09-01', {'tv'}, 't', 2017, 8, 0, 0, 0);
 

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
WHERE id = 26ea7804-31ba-4129-9ade-1a1789566ed5 and name = 'tv set' and firs_letter_of_name = 't' 
	and creation_time = minTimeuuid('2017-08-01') and creation_year = 2017 and creation_month = 8
IF last_offer = 0.0;
 
 
/**
 * TRANSACTION REGISTRATION
 */

/**
 * Get the current state of bidder, especially account_balance
 */
select * from users where id = 6ca101bc-388e-46bb-970c-d82fd4d13654;
 
/**
 * 1. Decrease the bidder's account_balance with accepted price. It's executed transactionally.
 * 2. Insert a new transaction.
 * NODE: Decreasing account_ballance is not isolated
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
WHERE id = 26ea7804-31ba-4129-9ade-1a1789566ed5 and name = 'tv set' and firs_letter_of_name = 't' 
	and creation_time = minTimeuuid('2017-08-01') and creation_year = 2017 and creation_month = 8;

UPDATE items_views_histogram SET views = views + 1
WHERE item_name = 'tv set' AND time_discriminator = '2017-08-01';

/**
 * QUERY - Paging items sorted by name
 */

/**
 * Get the first item to start paging 
 */
select creation_time, creation_year, creation_month, id 
from items_by_name 
where firs_letter_of_name = 'a' and bucket_firs_letter_of_name = 0 LIMIT 1;
 
/**
 * Get the last bucket for the first letter of name. 
 * It is used to check when paging should move to the next letter.
 */ 
SELECT bucket FROM bucket_first_letter_of_item WHERE firs_letter = 'a';
 
/**
 * The first query for each first_letter_of_name starts with bucket 0 and no range
 */  
SELECT * FROM items_by_name
WHERE firs_letter_of_name='a' AND bucket_firs_letter_of_name = 0; 

/**
 * 1. The next queries uses the initial bucket until they can fetch the next page. 
 * 2. If there is no data for a given bucket, then the bucket is incremented by 1
 * 3. When bucket_firs_letter_of_name exceeds the latest bucket for the querying letter 
 *    taken from the previous step, then query takes the next letter, initial bucket 0 for it and  
 *    get the latest bucket from bucket_first_letter_of_item table to get a new bucket limit. 
 * 
 * NOTE: Each query requires comparing the name column with the latest one.  
 */
 
SELECT * FROM items_by_name
WHERE firs_letter_of_name='a' AND bucket_firs_letter_of_name = 1 and name > 'tv set';


/**
 * QUERY - Paging items sorted by number of views for a item name
 */
 -- first
 select * from items_by_name_by_views where name = 'tv set'; 
  -- next
 select * from items_by_name_by_views 
 where name = 'tv set' and (views, id) > (0, 26ea7804-31ba-4129-9ade-1a1789566ed5);
 
 
/**
 * QUERY - Paging items sorted by number of bids for a item name
 */
 -- first
 select * from items_by_name_by_bids where name = 'tv set'; 
  -- next
 select * from items_by_name_by_bids 
 where name = 'tv set' and (bids, id) > (0, 26ea7804-31ba-4129-9ade-1a1789566ed5); 
 
 
/**
 * QUERY - searching users by name and surname 
 */
--SELECT * FROM users WHERE name_surname LIKE '%john%';
 
/**
 * QUERY - searching items by name 
 */
--SELECT * FROM items WHERE name LIKE '%set%';
 
 