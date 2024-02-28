# Запит 1: Знайти 5 студентів із найбільшим середнім балом з усіх предметів.
with open('query_1.sql', 'w') as f:
    f.write("""
    SELECT students.name, ROUND(AVG(grades.grade), 2) AS avg_grade
    FROM students
    JOIN grades ON students.id = grades.student_id
    GROUP BY students.id
    ORDER BY avg_grade DESC
    LIMIT 5;
    """)

# Запит 2: Знайти студента із найвищим середнім балом з певного предмета.
with open('query_2.sql', 'w') as f:
    f.write("""
    SELECT students.name, ROUND(AVG(grades.grade), 2) AS avg_grade
    FROM students
    JOIN grades ON students.id = grades.student_id
    WHERE grades.subject_id = 1
    GROUP BY students.id
    ORDER BY avg_grade DESC
    LIMIT 1;
    """)

# Запит 3: Знайти середній бал у групах з певного предмета.
with open('query_3.sql', 'w') as f:
    f.write("""
    SELECT groups.name AS group_name, ROUND(AVG(grade), 2) AS avg_grade
    FROM groups
    JOIN students ON groups.id = students.group_id
    JOIN grades ON students.id = grades.student_id
    JOIN subjects ON grades.subject_id = subjects.id
    WHERE subjects.id = '2'
    GROUP BY groups.name;
        """)

# Запит 4: Знайти середній бал на потоці (по всій таблиці оцінок).
with open('query_4.sql', 'w') as f:
    f.write("""
    SELECT ROUND(AVG(grade), 2) AS avg_grade
    FROM grades;
    """)

# Запит 5: Знайти які курси читає певний викладач.
with open('query_5.sql', 'w') as f:
    f.write("""
    SELECT subjects.name AS course_name, teachers.name AS teacher_name
    FROM subjects
    JOIN teachers ON subjects.teacher_id = teachers.id
    WHERE teachers.id = '2';
    """)

# Запит 6: Знайти список студентів у певній групі.
with open('query_6.sql', 'w') as f:
    f.write("""
    SELECT groups.name AS group_name, students.name AS student_name
    FROM students
    JOIN groups ON students.group_id = groups.id
    WHERE groups.id = '2';
    """)

# Запит 7: Знайти оцінки студентів у окремій групі з певного предмета.
with open('query_7.sql', 'w') as f:
    f.write("""
    SELECT groups.name AS group_, subjects.name AS subject,students.name AS student_name, grades.grade
    FROM students
    JOIN grades ON students.id = grades.student_id
    JOIN subjects ON grades.subject_id = subjects.id
    JOIN groups ON students.group_id = groups.id
    WHERE groups.id = '1' AND subjects.id = '3';
    """)

# Запит 8: Знайти середній бал, який ставить певний викладач зі своїх предметів.
with open('query_8.sql', 'w') as f:
    f.write("""
    SELECT teachers.name AS teacher_name, subjects.name AS subject, ROUND(AVG(grade), 2) AS avg_grade
    FROM grades
    JOIN subjects ON grades.subject_id = subjects.id
    JOIN teachers ON subjects.teacher_id = teachers.id
    WHERE teachers.id = '1';
    """)

# Запит 9: Знайти список курсів, які відвідує студент.
with open('query_9.sql', 'w') as f:
    f.write("""
    SELECT DISTINCT subjects.name AS course_name, students.name AS student_name 
    FROM subjects
    JOIN grades ON subjects.id = grades.subject_id
    JOIN students ON grades.student_id = students.id
    WHERE students.id = '2';
    """)

# Запит 10: Список курсів, які певному студенту читає певний викладач.
with open('query_10.sql', 'w') as f:
    f.write("""
    SELECT DISTINCT subjects.name AS course_name, teachers.name AS teacher_name, students.name AS student_name 
    FROM subjects
    JOIN grades ON subjects.id = grades.subject_id
    JOIN students ON grades.student_id = students.id
    JOIN teachers ON subjects.teacher_id = teachers.id
    WHERE students.id = '3' AND teachers.id = '2';
    """)

# Запит 11: Середній бал, який певний викладач ставить певному студентові.
with open('query_11.sql', 'w') as f:
    f.write("""
    SELECT students.name, ROUND(AVG(grades.grade), 2) AS avg_grade
    FROM students
    JOIN grades ON students.id = grades.student_id
    WHERE grades.subject_id = 1
    GROUP BY students.id
    ORDER BY avg_grade DESC
    LIMIT 1;
    """)

# Запит 12: Оцінки студентів у певній групі з певного предмета на останньому занятті.
with open('query_12.sql', 'w') as f:
    f.write("""
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

    """)