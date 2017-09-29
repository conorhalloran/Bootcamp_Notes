Select all the first names from the students table with the number of times that the name occured orded by the number of occurences

SELECT first_name, COUNT(first_name) AS occurences FROM students
GROUP BY first_name
ORDER BY occurences;

One to Many

Primary Key = id column
Foreign Key = lives in foreign table

INNER JOIN:  
Select all the students that have projects and projects created by each student in one query. 
    - can also just write JOIN

SELECT * FROM students
INNER JOIN projects ON projects.student_id = student.id

Find the number of projects created by each student if they have created a project:

SELECT students.*, COUNT(projects.created_at) as total FROM students
INNER JOIN projects
ON projects.student_id = students.id
GROUP BY students.id
ORDER BY total DESC;

