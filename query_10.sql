
    SELECT DISTINCT subjects.name AS course_name, teachers.name AS teacher_name, students.name AS student_name 
    FROM subjects
    JOIN grades ON subjects.id = grades.subject_id
    JOIN students ON grades.student_id = students.id
    JOIN teachers ON subjects.teacher_id = teachers.id
    WHERE students.id = '3' AND teachers.id = '2';
    