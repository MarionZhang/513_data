USE newDB;

CREATE TABLE IF NOT EXISTS wireless_table(
	event_id VARCHAR(50),
    user_log_acct VARCHAR(50),
    dt TIMESTAMP    
);

INSERT INTO wireless_table(event_id,user_log_acct,dt)
VALUES('JDbeans_SignIn', 'id_34562871', '2022-06-01 12:30:06'),
	  ('SearchList_Ad',	'id_34566172', '2022-07-02 11:38:07'),
      ('JDbeans_SignIn', 'id_34812873',	'2022-06-01 10:41:06'),
      ('JDbeans_SignIn', 'id_34812873',	'2022-06-02 10:41:06'),
	  ('JDbeans_SignIn', 'id_34812873',	'2022-06-03 10:41:06'),
      ('JDbeans_SignIn', 'id_34812873',	'2022-06-04 10:41:06'),
      ('JDbeans_SignIn', 'id_34812873',	'2022-06-05 10:41:06'),
      ('JDbeans_SignIn', 'id_34812873',	'2022-06-06 10:41:06'),
      ('JDbeans_SignIn', 'id_34812873',	'2022-06-07 10:41:06'),
	  ('JDbeans_SignIn', 'id_345672874', '2022-06-04 16:30:06'),
	  ('Home_Main_Product','id_34562475', '2022-09-05 12:12:09'),
	  ('JDbeans_SignIn', 'id_33962876',	'2022-07-10 22:10:07'),
	  ('Product_Detail_Coupon',	'id_34562877',	'2022-05-30 20:08:05'),
	  ('JDbeans_SignIn','id_34562878','2022-06-22 19:36:06');
      
           
WITH checkins AS (
  SELECT 
    user_log_acct AS user_id, 
    DATE(dt) AS checkin_date   /*convert TIMESTAMP to DATE*/
  FROM 
    wireless_table
  WHERE 
    event_id = 'JDbeans_SignIn'   /*focus on the event of signIn*/
),
consecutive_checkins AS (
  SELECT 
    user_id, 
    checkin_date,
    /*Assign numbers in order to the checkin_date within each group of user_id,
    convert to negative numbers and combined with the date units
    and we will get a negative date interval.
    Finally add the negative date interval mentioned above to the checkin_date*/
    DATE_ADD(checkin_date, INTERVAL - ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY checkin_date) DAY) AS group_id
  FROM 
    checkins
),
consecutive_days AS (
  SELECT 
    user_id,
    COUNT(DISTINCT checkin_date) AS days
  FROM 
    consecutive_checkins
  GROUP BY 
    user_id, group_id
  HAVING 
    days >= 7
)
SELECT 
  COUNT(DISTINCT user_id) AS user_count
FROM 
  consecutive_days
