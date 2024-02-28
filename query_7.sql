
    SELECT groups.name AS group_, subjects.name AS subject,students.name AS student_name, grades.grade
    FROM students
    JOIN grades ON students.id = grades.student_id
    JOIN subjects ON grades.subject_id = subjects.id
    JOIN groups ON students.group_id = groups.id
    WHERE groups.id = '1' AND subjects.id = '3';
    