# Select all the products that have been purchased in the last month.

SELECT products.name, orders.completed_on FROM line_items
INNER JOIN orders ON orders.id = line_items.order_id
INNER JOIN products ON products.id = line_items.order_id 
WHERE orders.completed_on BETWEEN '2017/08/01' AND '2017/08/31';

# Select the top 10 products in terms of last year's gross sales.
SELECT products.name, line_items.product_id, SUM(line_items.price * line_items.quantity) AS sales FROM line_items
INNER JOIN products ON products.id = line_items.product_id
INNER JOIN orders ON orders.id = line_items.order_id
WHERE orders.completed_on BETWEEN '2016/08/01' AND '2017/08/31'
GROUP BY product_id, products.name
ORDER BY sales DESC
OFFSET 1
LIMIT 10

# Select all the products that weren't purchased during the last month.
SELECT products.name, orders.completed_on FROM line_items
INNER JOIN orders ON orders.id = line_items.order_id
INNER JOIN products ON products.id = line_items.order_id 
WHERE orders.completed_on BETWEEN '2017/08/01' AND '2017/08/31';

SELECT products.name 
FROM products               #Too many Queries here. 
WHERE NOT EXISTS ( SELECT products.name, orders.completed_on FROM line_items
INNER JOIN orders ON orders.id = line_items.order_id
INNER JOIN products ON products.id = line_items.order_id 
WHERE orders.completed_on BETWEEN '2017/08/01' AND '2017/08/31' );

SELECT *
FROM products
WHERE products.id NOT IN ( SELECT product_id FROM line_items
INNER JOIN orders ON orders.id = line_items.order_id
INNER JOIN products ON products.id = line_items.order_id 
WHERE orders.completed_on BETWEEN '2017/08/01' AND '2017/08/31' );

# Select all customers
SELECT * FROM Customers 

Select all customers from France, Germany and UK
SELECT * FROM Customers 
WHERE Country IS 'France', 'Germany', 'UK'

Select all customers not from France, Germany and UK
SELECT * FROM Customers 
WHERE Country IS NOT 'France', 'Germany', 'UK'