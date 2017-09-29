Using the SQL Lab tool: https://sql-lab.herokuapp.com/

For the products table:

# Select the product whose stock has the most value (use sale price)
SELECT name, price, sale_price, remaining_quantity, 
SUM(sale_price * remaining_quantity) 
AS value FROM products
GROUP BY name, price, sale_price, remaining_quantity
ORDER BY value DESC
LIMIT 1

-------------------
SELECT * FROM products
ORDER BY (sale_price * remaining_quantity) DESC
LIMIT 1

# Select the most expensive product whose price is between 25 and 50 with remaining quantity
SELECT * FROM products
WHERE remaining_quantity > 0 AND price BETWEEN 25 AND 50
ORDER BY price DESC
LIMIT 1 
# Select all products on sale with remaining quantity ordered by their price and then their name
SELECT * FROM products
WHERE price > sale_price AND remaining_quantity > 0
ORDER BY price DESC, name ASC
# Select the second set 20 results based on the previous query
SELECT * FROM products
WHERE price > sale_price AND remaining_quantity > 0
ORDER BY price DESC, name ASC
LIMIT 20
OFFSET 20
# Find the average price of all products
SELECT ROUND( AVG(price) ) AS value FROM products
# Find the average price of all products that are on sale
SELECT ROUND( AVG(sale_price) ) AS value FROM products
WHERE price > sale_price
# Find the average price of all products that are on sale with remaining quantity
SELECT ROUND( AVG(sale_price) ) AS value FROM products
WHERE price > sale_price AND remaining_quantity > 0
# Update all the products whose name contains `paper` (case insensitive) to have a remaining quantity of 0
SELECT * FROM products
WHERE name ILIKE '%paper%'
-----------------------------
UPDATE products
SET remaining_quantity = 0
WHERE name ILIKE '%paper%'
# Is it possible to revert the query in question 8?
No
# Update all the products whose name contains `paper` or `steel` to have a remaining quantity of a random number between 5 and 25
SELECT * FROM products
WHERE name ILIKE '%paper%' OR name ILIKE '%steel%'
-------------------------------------------------
UPDATE products
SET remaining_quantity = (random()*(25-5)+5)
WHERE name ILIKE '%paper%' OR name ILIKE '%steel%'
# Select the second set of 10 cheapest products with remaining quantity
SELECT * FROM products 
WHERE price > sale_price AND remaining_quantity > 0
ORDER BY sale_price ASC
LIMIT 10
OFFSET 10;
# Build a query that groups the products by their sale price and show the number of products in that price and the sum of remaining quantity. Label the count `product_count`
SELECT sale_price, name, 
SUM(sale_price * remaining_quantity) 
AS value FROM products
GROUP BY sale_price, name
ORDER BY sale_price DESC, value DESC

# [stretch] Update the most expensive product to have double its quantity in a single query
# UPDATE products
# SET remaining_quantity = 10
# WHERE price > 0;

UPDATE products
SET remaining_quantity = remaining_quantity*2
WHERE price = (SELECT MAX(price) FROM products);
-------------------------------------------------
SELECT * FROM products WHERE price = (SELECT MAX(price) FROM products) ORDER BY price LIMIT 1;