Using the SQL Lab tool: https://sql-lab.herokuapp.com/

From the students table:

# Select the first 10 students whose ages are between 35 and 45.
    SELECT * FROM students 
    WHERE age BETWEEN 35 AND 45 
    LIMIT 10
# Select the third set of 10 students whose ages are more than 25 and whose first names contain `th`. The students must be 
# ordered by their id then first name in a descending order.
SELECT * FROM students 
WHERE first_name LIKE '%th%' AND age > 25
ORDER BY id DESC, first_name
LIMIT 10
OFFSET 20
# Select the 10 oldest students (You should ignore students with an age that is `NULL`).
SELECT * FROM students 
WHERE age > 1
ORDER BY age DESC
LIMIT 10
# Select all students with age 45 whose last names contain the letter n.
SELECT * FROM students 
WHERE age = 45 AND last_name ILIKE '%n%'
# From the products table:

# Select all the products that are on sale.
SELECT * FROM products
WHERE sale_price < price
# Select all the products that are on sale and have remaining items in stock ordered by the sale price in ascending order.
SELECT * FROM products
WHERE sale_price < price AND remaining_quantity > 0
ORDER BY sale_price DESC
# Select all the products priced between 25 and 50 (regular price) and that are on sale.
SELECT * FROM products
WHERE sale_price < price AND price BETWEEN 25 AND 50
ORDER BY price DESC