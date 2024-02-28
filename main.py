import logging
import sqlite3
from sqlite3 import Error
from faker import Faker
import random

# Ініціалізуємо Faker
fake = Faker()

database = './students_db.sqlite'

# Підключаємось до бази даних
conn = sqlite3.connect(database)
cursor = conn.cursor()

# Створюємо таблиці
try:
    cursor.execute('''
    DROP TABLE IF EXISTS students;
    ''')
    cursor.execute('''
    CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT ,
        name VARCHAR(100) NOT NULL,
        group_id INTEGER,
        FOREIGN KEY (group_id) REFERENCES groups(id)
            ON DELETE SET NULL
            ON UPDATE CASCADE
    )
    ''')

    cursor.execute('''
    DROP TABLE IF EXISTS groups;
    ''')
    cursor.execute('''
    CREATE TABLE groups (
        id INTEGER PRIMARY KEY,
        name VARCHAR(50) UNIQUE NOT NULL
    )
    ''')

    cursor.execute('''
    DROP TABLE IF EXISTS teachers;
    ''')
    cursor.execute('''
    CREATE TABLE teachers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) NOT NULL
    )
    ''')

    cursor.execute('''
    DROP TABLE IF EXISTS subjects;
    ''')
    cursor.execute('''
    CREATE TABLE subjects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(100) UNIQUE NOT NULL,
        teacher_id INTEGER,
        FOREIGN KEY (teacher_id) REFERENCES teachers(id)
            ON DELETE SET NULL
            ON UPDATE CASCADE    
    )
    ''')

    cursor.execute('''
    DROP TABLE IF EXISTS grades;
    ''')
    cursor.execute('''
    CREATE TABLE grades (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER,
        subject_id INTEGER,
        grade INTEGER CHECK (grade >= 0 AND grade <= 100),
        grade_date DATE NOT NULL,
        FOREIGN KEY (student_id) REFERENCES students(id)
            ON DELETE CASCADE,
        FOREIGN KEY (subject_id) REFERENCES subjects(id)
            ON DELETE CASCADE
    )
    ''')

    # Заповнюємо таблиці випадковими даними
    # Додамо 3 групи
    for group_name in ['Group A', 'Group B', 'Group C']:
        cursor.execute("INSERT INTO groups (name) VALUES (?)", (group_name,))

    # Отримуємо ідентифікатори доданих груп
    group_ids = cursor.execute("SELECT id FROM groups").fetchall()

    # Додаємо 30 студентів з випадковою групою
    for _ in range(30):
        student_name = fake.name()
        group_id = random.choice(group_ids)[0]  # вибираємо випадковий ідентифікатор групи
        cursor.execute("INSERT INTO students (name, group_id) VALUES (?, ?)", (student_name, group_id))   

    # Додамо 3 викладачів
    for _ in range(3):
        cursor.execute("INSERT INTO teachers (name) VALUES (?)", (fake.name(),))

    # Додаємо 5-8 предметів і призначаємо викладачів
    subjects_data = [
        ('Mathematics', 1),
        ('Physics', 2),
        ('Chemistry', 3),
        ('Biology', 1),
        ('History', 2),
        ('Literature', 3),
        ('Computer Science', 1),
        ('Art', 2)
    ]
    for subject in subjects_data:
        cursor.execute("INSERT INTO subjects (name, teacher_id) VALUES (?, ?)", subject)

    # Додаємо випадкові оцінки для кожного студента по всіх предметах
    students = cursor.execute("SELECT id FROM students").fetchall()
    subjects = cursor.execute("SELECT id FROM subjects").fetchall()

    for student_id in students:
        for subject_id in subjects:
            for _ in range(random.randint(3, 5)):  # додаємо випадкову кількість оцінок від 3 до 5
                grade = random.randint(1, 100)
                grade_date = fake.date_between(start_date='-1y', end_date='today')  # оцінка за останній рік
                cursor.execute("INSERT INTO grades (student_id, subject_id, grade, grade_date) VALUES (?, ?, ?, ?)",
                               (student_id[0], subject_id[0], grade, grade_date))

    # Зберігаємо зміни та закриваємо підключення
    conn.commit()
except Error as e:
    logging.error(e)
    conn.rollback()
finally:
    cursor.close()
    conn.close()
