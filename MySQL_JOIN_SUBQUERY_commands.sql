#joins user and family_members tables and retrieves info about user first, last name and thename of respective relatives
select user.first_name, user.last_name, family_members.name 
FROM user
INNER JOIN family_members on fk_family_members_ID = family_members_ID;

#joins three tables, user, work_experience and current_workplace_from_to and retrieves info about user name, last name, workplace and beginning date
select user.first_name, user.last_name, work_experience.current_workplace, current_workplace_from_to.beginning_date
FROM user
JOIN work_experience on fk_work_experience_ID = work_experience_ID
JOIN current_workplace_from_to on fk_user_ID = user_ID

#joins three tables, user, post and image and retrieves info about username, publication date and image decsription
select user.first_name, user.last_name, post.publication_date, image.description
FROM user
JOIN post on fk_user_ID = user_ID
JOIN image on fk_post_ID = post_ID 

#joins 4 tables, user, work_Experience, post (only for connection) and image and retrieves information about username, work experience and image description
SELECT user.first_name, user.last_name, work_experience.current_workplace, image.description
FROM user
RIGHT JOIN work_experience on fk_work_experience_ID = work_experience_ID 
RIGHT JOIN post on fk_user_ID = user_ID
RIGHT JOIN image on fk_post_ID = post_ID 

select user.first_name, user.last_name, post.publication_date, comment.comment_text
FROM user
JOIN post on fk_user_ID = user_ID
JOIN comment on fk_post_ID = post_ID

#joins user, post and image table and shows fist, last name, publication date, file name and description
select user.first_name, user.last_name, post.publication_date, image.file_name, image.description
FROM user
JOIN post on fk_user_ID = user_ID
JOIN image on fk_post_ID = post_ID

#joins user, post and image table and shows fist, last name, file name and description
select user.first_name, user.last_name, image.file_name, image.description
FROM user
JOIN post on fk_user_ID = user_ID
JOIN image on fk_post_ID = post_ID

#joins user, post, image and work experience table and shows first, last name, oubication date, file name, description and current workplace
select user.first_name, user.last_name, post.publication_date, image.file_name, image.description, work_experience.current_workplace
FROM user
JOIN post on fk_user_ID = user_ID
JOIN image on fk_post_ID = post_ID
JOIN work_experience on work_experience_ID = fk_work_experience_ID

#EXAMPLES WITH INNER JOIN, LEFT and RIGHT JOIN #user_ID=4 h fk_work_Experience_ID was set to NULL!!!
#joins user and work_experience table and retrieves info about current workplace and shows ONLY users with a current workplace 
select user.first_name, user.last_name, work_experience.current_workplace 
FROM user
INNER JOIN work_experience on fk_work_experience_ID = work_experience_ID;

first_name  last_name  current_workplace
Donatella   Tesei      empty field
Azzurra     Tesei      Tuscia University
John        Harris     JPL


#joins user and work_experience table and retrieves info about current workplace and shows all users, with and w/o current workplace
select user.first_name, user.last_name, work_experience.current_workplace 
FROM user
LEFT JOIN work_experience on fk_work_experience_ID = work_experience_ID;

first_name  last_name  current_workplace
Donatella   Tesei       empty field
Azzurra     Tesei       Tuscia University
John        Harris      JPL
Mark        Reeves      NULL


#joins user and work_experience table and retrieves info about current workplace and shows all current workplaces
select user.first_name, user.last_name, work_experience.current_workplace 
FROM user
RIGHT JOIN work_experience on fk_work_experience_ID = work_experience_ID;

#first_name last_name current_workplace
Donatella   Tesei      empty field
Azzurra     Tesei      Tuscia University
John        Harris     JPL
NULL        NULL       Blu Origin



#select date
SELECT CURRENT_DATE();

#select time
SELECT CURRENT_TIME();

#select timestamp
SELECT CURRENT_TIMESTAMP();

#SQL SUBQUERY w/ WHERE and IN
SELECT last_name, first_name
FROM employees
WHERE office_code IN (SELECT office_code
                     FROM offices
                     WHERE country = 'USA');

#SQL SUBQUERY w/ WHERE and comparing OPERATORS

#which customer has had the greatest amount to pay from our book orders:
SELECT customer_id,
      invoice_number,
      amount
FROM book_orders
WHERE amount = (
SELECT MAX(amount)
FROM book_orders
);

#finds those customers that have spent more than the average amount in our store to send them a gift certificate.
SELECT customer_id,
      invoice_number,
      amount
FROM book_orders
WHERE amount > (
SELECT AVG(amount)
FROM book_orders
);

#finds a list of all customers, who’s have not yet ordered anything
SELECT customer_full_name
FROM customers
WHERE customer_id NOT IN(
SELECT DISTINCT customer_id
FROM orders
);

#finds out if entries do or do not exist in our databases
SELECT price_each /item_price * quantity_ordered /amount_ordered
FROM order_details
WHERE
price_each /item_price * quantity_ordered  /amount_ordered> 10000
GROUP BY
order_id;

#and returns all customers which have made the existing orders
SELECT
customer_name
FROM
customers
WHERE
EXISTS (
SELECT
item_price * amount_ordered
FROM
orderdetails
WHERE
itemPrice * amount_ordered > 10000
GROUP BY
order_id
);

#subquery will return results set as a derived table for the outer query, called either a derived table or materialized subquery.
SELECT
MAX(items),
MIN(items),
FLOOR(AVG(items))   #FLOOR rounds down the results and returns the largest integer value that is smaller than or equal to what is provided 
FROM
(
SELECT
order_id,
COUNT(order_id) AS items
FROM
order_details
GROUP BY
orderUD
) AS line_items;

#correlated subquery = a subquery that uses information from the outer query and therefore depends on the outer query.
SELECT
product_name,
product_price
FROM
products AS p1
WHERE
product_price > (
SELECT
AVG(product_price)
FROM
products
WHERE
brand= p1.brand
);
