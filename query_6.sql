
    SELECT groups.name AS group_name, students.name AS student_name
    FROM students
    JOIN groups ON students.group_id = groups.id
    WHERE groups.id = '2';
    