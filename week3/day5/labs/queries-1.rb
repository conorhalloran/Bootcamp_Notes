Write the following SQL Queries:

# Find the average line_item total price (meaning quantity * price) for each order that were completed in January 2016 month.
SELECT order_id, AVG(quantity * price) FROM line_items 
INNER JOIN orders ON orders.id = line_items.order_id
WHERE orders.completed_on BETWEEN '2016/01/01' AND '2016/01/31'
GROUP BY order_id
LIMIT 10;



# Select product titles, product prices and the lowest price they were sold at during the last month.
SELECT products.name, products.price, MIN(line_items.price) FROM line_items
INNER JOIN products ON products.id = line_items.product_id
INNER JOIN orders ON orders.id = line_items.order_id
WHERE orders.completed_on BETWEEN '2017/08/01' AND '2017/08/31'
GROUP BY products.id, products.name, products.price
LIMIT 10;

# [Note] the total price in the line_items table is price per unit and not total price.

SELECT * FROM products 
ORDER BY id DESC

# Calculate how many items in stock we've ever had for products (remaining or sold) in the database.
SELECT name, SUM(remaining_quantity)
AS stock FROM products
GROUP BY name,
ORDER BY name DESC, stock DESC

----------------------------------------

SELECT products.name, products.remaining_quantity, line_items.quantity, 
SUM(products.remaining_quantity + line_items.quantity) AS item_total
FROM line_items
INNER JOIN products ON products.id = line_items.product_id

-----------------------------------------

SELECT SUM(products.remaining_quantity + line_items.quantity) AS item_total
FROM line_items
INNER JOIN products ON products.id = line_items.product_id

SELECT SUM(remaining_quantity) + SUM(quantity) AS total
FROM products
INNER JOIN line_items ON products.id = line_items.product_id;


# Find the average order total price for all the orders in the system
SELECT AVG(sum) 
FROM 
(SELECT line_items.order_id, SUM(line_items.price * line_items.quantity) AS sum FROM line_items
GROUP BY order_id) AS sums

------------------------

SELECT line_items.order_id, SUM(line_items.price * line_items.quantity) AS sum FROM line_items
GROUP BY order_id

-------------------------

SELECT AVG(sum)
FROM AS sums

--------------------
SELECT line_items.order_id, SUM(line_items.price * line_items.quantity) AS sum FROM line_items
GROUP BY order_id

-------------------------

SELECT AVG(sum)
FROM (SELECT line_items.order_id, SUM(line_items.price * line_items.quantity) AS sum FROM line_items
GROUP BY order_id) AS sums

# [Note] the price in the line_items table is price per unit and not total price.