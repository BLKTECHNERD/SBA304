-- A. List each department and the number of courses offered by that department.
SELECT D.name AS "Department Name", COUNT(C.id) AS "# Courses"
FROM department D
LEFT JOIN course C ON D.id = C.deptId
GROUP BY D.name
ORDER BY "# Courses" ASC;

-- B. List the name of each course and the number of students in that course.
SELECT CO.name AS "Course Name", COUNT(SC.studentId) AS "# Students"
FROM course CO
LEFT JOIN studentCourse SC ON CO.id = SC.courseId
GROUP BY CO.name
ORDER BY "# Students" DESC, "Course Name" ASC;

-- C-1. List the names of all courses where the number(#) of assigned faculty is zero.
SELECT CO.name AS "Course Name"
FROM course CO
LEFT JOIN facultyCourse FC ON CO.id = FC.courseId
GROUP BY CO.name
HAVING COUNT(FC.facultyId) = 0
ORDER BY "Course Name" ASC;

-- C-2. List course names and # of students for courses with no assigned faculty.
SELECT CO.name AS "Course Name", COUNT(SC.studentId) AS "# Students"
FROM course CO
LEFT JOIN facultyCourse FC ON CO.id = FC.courseId
LEFT JOIN studentCourse SC ON CO.id = SC.courseId
GROUP BY CO.name
HAVING COUNT(FC.facultyId) = 0
ORDER BY "# Students" DESC, "Course Name" ASC;

-- D. List the total # of students enrolled in classes during each school year.
SELECT COUNT(DISTINCT SC.studentId) AS "Students", YEAR(SC.startDate) AS "Year"
FROM studentCourse SC
GROUP BY YEAR(SC.startDate);

-- E. List Start Date and # of Students enrolled in August of each year.
SELECT YEAR(SC.startDate) AS "Year", COUNT(SC.studentId) AS "# Students"
FROM studentCourse SC
WHERE MONTH(SC.startDate) = 8
GROUP BY YEAR(SC.startDate)
ORDER BY "Year";

-- F. List students’ “First Name,” “Last Name,” and Number of Courses in major department.
SELECT S.firstname AS "First Name", S.lastname AS "Last Name", 
       COUNT(C.id) AS "Number of Courses"
FROM student S
LEFT JOIN studentCourse SC ON S.id = SC.studentId
LEFT JOIN course C ON SC.courseId = C.id
LEFT JOIN department D ON S.majorId = D.id
WHERE D.id = C.deptId
GROUP BY S.id, S.firstname, S.lastname
HAVING COUNT(C.id) >= 2 AND COUNT(C.id) <= 4
ORDER BY "Number of Courses" ASC, S.lastname ASC;

-- G. List First Name, Last Name, and Average Progress of students with progress < 50%.
SELECT S.firstname AS "First Name", S.lastname AS "Last Name",
       ROUND(AVG(SC.progress), 1) AS "Average Progress"
FROM student S
LEFT JOIN studentCourse SC ON S.id = SC.studentId
GROUP BY S.id, S.firstname, S.lastname
HAVING AVG(SC.progress) < 50
ORDER BY "Average Progress" DESC;

-- Execute Queries Individually:
-- You can execute each SELECT query individually by highlighting the specific query and running it.
-- This way, you'll be able to see the results of each query in the results grid.

