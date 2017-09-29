Relational Databases: 
- SQL - Structured Query Language
- MariaDB (MySQL)
- Postgres (Or most used in this course)
- MSSQL
- Oracle

Data must be stored in an table format. (Excel File format)
Every Row is a collection of data. 

Non-Relational Databases: nosql

Relational Data

Commands:
brew install
brew update
brew install postgresql
brew services start postgresql
brew services restart postgresql
ps aux
ps aux | grep postgres

Links:
# https://www.postgresql.org

Convention:
- Use single quotes when refering to a string
- Use all Caps when refering to keywords. 

CRUD: Create Read Update Delete
Create: 
INSERT INTO student
    (first_name, last_name, email, phone_number)
    VALUES
    ('Conor', 'Halloran', 'conorhalloran@gmail.com', '555-555-5555')

Read:
    SELECT * FROM <table_name>
    SELECT id, first_name, last_name, FROM <table_name>;
    SELECT * FROM <table_name> WHERE id = 1;
    SELECT * FROM students WHERE id = 10;

Exercise:
Select all students whoes ages are more than 40:
    SELECT * FROM students WHERE age > 40
Select all students who have registered in last 20 days:
    SELECT * FROM students WHERE registration_date BETWEEN '2017-09-08' AND CURRENT_DATE
    SELECT * FROM students WHERE registration_date >= CURRENT_DATE - 20
Select all students whose ages are more than 40 or less than 20:
    SELECT * FROM students WHERE age < 20 OR age > 40

1.) Three Value Logic: True, False or Not. Is NULL or Not NULL.
    SELECT * FROM students WHERE registration_date IS NULL 

Seclet all student whose age is NULL or less than 20:
    SELECT * FROM students WHERE age IS NULL OR age < 20

'abc%' = anything that has 'abc' followed by whatever. 
    SELECT * FROM students WHERE last_name LIKE 'R%'
    SELECT * FROM students WHERE last_name ILIKE '%R%' #all last names that have R in them. ILIKE makes it class insensitive

Select all students whoes first names or last names contain 'nn'
    SELECT * FROM students WHERE last_name LIKE '%nn%' OR first_name LIKE '%nn%'

Select all students whoes ares are between 20 and 40
    SELECT * FROM students WHERE AGE BETWEEN 20 AND 40 

Select all students that registered between 20 days ago and 25 days ago
    SELECT * FROM students WHERE registration_date BETWEEN CURRENT_DATE - 25 AND CURRENT_DATE - 20 

2.) ORDER BY (ASC / DESC)
    SELECT * FROM students 
    WHERE registration_date BETWEEN (CURRENT_DATE - 25) AND (CURRENT_DATE - 20) 
    ORDER BY age DESC, first_name ASC; 

3.) LIMIT <value> - Will limit the results by a specified <value>. Must put limit at the end of query.
    SELECT * FROM students 
    WHERE registration_date BETWEEN (CURRENT_DATE - 25) AND (CURRENT_DATE - 20) 
    ORDER BY age DESC, first_name ASC;
    LIMIT 10 

Select the first 10 students whose first name start with 'ke' (case insensitive)
    SELECT * FROM students 
    WHERE first_name ILIKE 'ke%'
    LIMIT 10;

4.) OFFSET <value> - will skip the first <value> in the records
    SELECT * FROM students 
    ORDER BY age
    LIMIT 10
    OFFSET 10;

Select the second set of 20 students whoes ages are more than 25
    SELECT * FROM students 
    WHERE age > 25
    ORDER BY age
    LIMIT 20
    OFFSET 20;

Aggregate Functions: 
1.) COUNT
    example: get a limited number of students in the database.
    SELECT COUNT(*) FROM students
Get the number of students who are more than 25 years of age
    SELECT COUNT(*) FROM students
    WHERE age > 25;

2.) AS 
    SELECT COUNT(*) AS student_count FROM students
    WHERE age > 25;

3.) SUM
SELECT SUM(age) FROM students;

4.) AVG: average
SELECT AVG(age) FROM students;
Find the average ages of students who registered after January 1st 2017. 
    SELECT AVG(age) FROM students 
    WHERE registration_date BETWEEN '01-01-2017' AND CURRENT_DATE

5.) ROUND
    - FLOOR
    - CEIL
    SELECT ROUND( AVG(age) ) FROM students 
    WHERE registration_date BETWEEN '01-01-2017' AND CURRENT_DATE

6.) MAX MIN
    SELECT MAX(age) FROM students
    SELECT MIN(age) FROM students

7.) GROUP BY
Find the number of occurrences of first names in the database. 
    SELECT first_name, COUNT(first_name) AS occurances FROM students 
    GROUP BY first_name
    ORDER BY occurances DESC;
Find the average age of studends grouped by their last name
    SELECT age, COUNT(age) AS average_age FROM students 
    GROUP BY age
    ORDER BY average_age DESC;

UPDATE:
UPDATE students
SET email='you@me.com', age = '35'
WHERE ID = 265;

SELECT * FROM students WHERE ID=265

DELETE:
SELECT FROM students WHERE id=332
DELETE FROM students WHERE id=332

