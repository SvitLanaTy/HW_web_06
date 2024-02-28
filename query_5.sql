
    SELECT subjects.name AS course_name, teachers.name AS teacher_name
    FROM subjects
    JOIN teachers ON subjects.teacher_id = teachers.id
    WHERE teachers.id = '2';
    