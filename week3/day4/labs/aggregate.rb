Using SQL Lab tool: https://sql-lab.herokuapp.com/

From the students table:
# Find the number of students named 'Milton'.
SELECT COUNT(*) FROM students
WHERE first_name = 'Milton'
# List the `first_name`s that occur more than once in students, with the number occurrences of that name.
SELECT first_name, COUNT(first_name) AS occurances FROM students
GROUP BY first_name
HAVING COUNT(first_name) > 1
ORDER BY occurances DESC
# Refine the above query to list the 20 most common first_names among students, in order first of how common they are, and alphabetically when names have the same count.
SELECT first_name, COUNT(first_name) AS occurances FROM students
GROUP BY first_name
ORDER BY occurances DESC, first_name ASC
LIMIT 20

From the products table:
# Find the most expensive product.
SELECT * FROM products
ORDER BY price DESC
LIMIT 1
# Find the cheapest product that is on sale.
SELECT * FROM products
WHERE sale_price < price
ORDER BY sale_price ASC
LIMIT 1
# Find the total value of all inventory in stock (use sale price).
SELECT ROUND (SUM(sale_price * remaining_quantity)) AS value FROM products