CREATE DATABASE school;
USE school;
CREATE TABLE students(id INT PRIMARY KEY, name VARCHAR(50), age INT, grade CHAR(1));
INSERT INTO students(id, name, age, grade) VALUES
(1, 'TOM', 18, 'A'),
(2, 'SOM', 19, 'C'),
(3, 'moon', 20, 'B'),
(4, 'van', 23, 'A'),
(5, 'can', 18, 'A');
SELECT *FROM students;
SELECT*FROM students WHERE age =18;
UPDATE students SET grade ='b' WHERE id=3;
SELECT*FROM students WHERE id=3;
DELETE FROM students WHERE id=5;
SELECT*FROM students;
ALTER TABLE students ADD COLUMN email VARCHAR(100);
UPDATE students SET email='tom@example.com' WHERE ID=1;
UPDATE students SET email='som@example.com' WHERE ID=2;
UPDATE students SET email='moon@example.com' WHERE ID=3;
UPDATE students SET email='van@example.com' WHERE ID=4;
UPDATE students SET email='can@example.com' WHERE ID=5;
SELECT*FROM students;

CREATE TABLE courses(course_id INT PRIMARY KEY, course_name VARCHAR(100), student_id INT, FOREIGN KEY (student_id) REFERENCES students(id));
INSERT INTO courses(course_id, course_name, student_id) VALUES(101, 'maths',1),(102, 'phy',2),(103, 'chem',3),(104, 'bio',4),(105, 'comp sci',1);
SELECT students.name, courses.course_name FROM students INNER JOIN courses ON student_id= courses.student_id;
SELECT students.name, courses.course_name FROM students LEFT JOIN courses ON student_id= courses.student_id;
SELECT students.name, COUNT(courses.course_id) AS num_courses FROM students LEFT JOIN courses ON student_id=courses.student_id GROUP BY students.name;
SELECT AVG(age) AS average_age FROM students;
SELECT students.name, COUNT(courses.course_id) AS num_courses FROM students LEFT JOIN courses ON students.id = courses.student_id GROUP BY students.name HAVING COUNT(courses.course_id) > 1;
SELECT name FROM students WHERE id IN(SELECT student_id FROM courses WHERE course_name='maths');
ALTER TABLE courses ADD CONSTRAINT unique_course_name UNIQUE(course_name);
ALTER TABLE courses MODIFY course_name VARCHAR(100) NOT NULL;
ALTER TABLE students ADD CONSTRAINT age_check CHECK(age>0);
SELECT name AS student_or_course FROM students UNION SELECT course_name FROM courses; 

//INTERSECT OPERATOR DOES NOT SUPPORT IN MySQL
/*SELECT name FROM students WHERE id IN (SELECT student_id FROM courses WHERE course_name = 'Maths') INTERSECT SELECT name FROM students WHERE id IN (SELECT student_id FROM courses WHERE course_name = 'Computer Science');*/                    
//INNER JOIN
SELECT s.name FROM students s INNER JOIN courses c1 ON s.id = c1.student_id AND c1.course_name = 'Mathematics' INNER JOIN courses c2 ON s.id = c2.student_id AND c2.course_name = 'Computer Science';                                             
// EXISTS
SELECT s.name FROM students s WHERE EXISTS (SELECT 1 FROM courses c1 WHERE c1.student_id = s.id AND c1.course_name = 'Mathematics') AND EXISTS ( SELECT 1 FROM courses c2 WHERE c2.student_id = s.id AND c2.course_name = 'Computer Science');    


// EXCEPT OPERATOR DOES NOT SUPPORT IN My SQL
/*SELECT name FROM students EXCEPT SELECT students.name FROM students INNER JOIN courses ON students.id = courses.student_id;*/    
// NOT IN
SELECT name FROM students WHERE id NOT IN ( SELECT student_id FROM courses);                             
// LEFT JOIN and NULL
SELECT s.name FROM students s LEFT JOIN courses c ON s.id = c.student_id WHERE c.course_id IS NULL;      
// NOT EXIST
SELECT s.name FROM students s WHERE NOT EXISTS ( SELECT 1 FROM courses c WHERE c.student_id = s.id);     