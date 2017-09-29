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

List all the courses with the numbers of students enrolled in them, in descending order of popularity. 
SELECT course_id, courses.title, COUNT(student_id) AS popularity 
FROM enrolments
INNER JOIN courses ON courses.id = enrolments.course_id
GROUP BY course_id, courses.title 
ORDER BY popularity DESC
LIMIT 10

# course_id = column in current table
# courses.id = column from a joined table.