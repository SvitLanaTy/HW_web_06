
    SELECT groups.name AS group_name, ROUND(AVG(grade), 2) AS avg_grade
    FROM groups
    JOIN students ON groups.id = students.group_id
    JOIN grades ON students.id = grades.student_id
    JOIN subjects ON grades.subject_id = subjects.id
    WHERE subjects.id = '2'
    GROUP BY groups.name;
        