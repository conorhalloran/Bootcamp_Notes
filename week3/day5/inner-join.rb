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

List all the students enrolled in the course "up-sized hybrid project"
SELECT students.* FROM students
INNER JOIN enrolments ON enrolments.student_id = students.id
INNER JOIN courses ON enrolments.course_id = courses.id
WHERE courses.title = 'Up-sized hybrid project';

Select all students who do not have projects 

SELECT *
FROM students
LEFT JOIN projects ON projects.student_id = students.id
WHERE title IS NULL;

--------------------------------

SELECT students.*, COUNT(projects.created_at) as total FROM students
INNER JOIN projects
ON projects.student_id = students.id
WHERE total = 0
GROUP BY students.id

List the average score for each course 
SELECT course_id, ROUND(AVG(score)), courses.title
FROM enrolments
INNER JOIN courses ON courses.id = enrolments.course_id
GROUP BY course_id, courses.title;

SELECT courses.id, courses.title, ROUND( AVG(score) )
FROM courses
INNER JOIN enrolments ON courses.id = enrolments.course_id
GROUP BY courses.id
LIMIT 10;
