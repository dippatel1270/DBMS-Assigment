-- Q-1 : Create a new database named school_db and a table called students with the following columns: student_id, student_name, age, class, and address.

create table students
(
student_id int not null unique,
student_name varchar(20) not null,
age int not null,
class int not null,
address varchar(50) not null
);

-- Q-2 :  Insert five records into the students table and retrieve all records using the SELECT statement.

insert into students values(101,'Poojan_Patel',16,11,'Ahmedabad'),
(102,'Parth_Vadariya',17,11,'Ahemdabad'),(103,'Dip_patel',12,8,'Valsad'),(104,'Bhavik_Gondaliya',12,8,'Rajkot'),(105,'Sagar_Divaraniya',14,9,'Porbandar'),
(106,'Umang_Hingu',10,5,'Ahmedabad'),(107,'Darshan_patel',10,5,'Himmatnagar');

select * from students;

-- Q-3 : Write SQL queries to retrieve specific columns (student_name and age) from the students table.

select student_name,age from students;

-- Q-4 :  Write SQL queries to retrieve all students whose age is greater than 10.

select * from students where age>10;

-- Q-5 :  Create a table teachers with the following columns: teacher_id (Primary Key),teacher_name (NOT NULL), subject (NOT NULL), and email (UNIQUE).
-- Q-6 :  Implement a FOREIGN KEY constraint to relate the teacher_id from the teachers table with the students table


create table teachers
(
teacher_id int primary key,
teacher_name varchar(25) not null,
subject varchar(10) not null,
email varchar(40) not null unique,
foreign key teacher(teacher_id) references students(student_id)
);


-- Q-11 : Drop the teachers table from the school_db database.

drop table teachers;

-- Q-12 : Drop the students table from the school_db database and verify that the table has been removed.

drop table students;
select * from students;






