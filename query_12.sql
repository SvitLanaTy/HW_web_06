
    SELECT groups.name AS group_, grades.grade_date AS _date,subjects.name AS course_name, students.name AS student_name, grades.grade
FROM students
JOIN grades ON students.id = grades.student_id
JOIN subjects ON grades.subject_id = subjects.id
JOIN groups ON students.group_id = groups.id
WHERE groups.id = '2' 
  AND subjects.id = '2'
  AND grades.grade_date = (
      SELECT MAX(grade_date)
      FROM grades
      JOIN subjects ON grades.subject_id = subjects.id
      JOIN groups ON students.group_id = groups.id
      WHERE groups.id = '2' 
        AND subjects.id = '2'
  );

    