-- Q-8 : Use the CREATE command to create a database university_db.
-- Q-7 : Create a table courses with columns: course_id, course_name, and course_credits. Set the course_id as the primary key.

create table courses
(
course_id int primary key,
course_name varchar(25) not null unique,
course_credits int not null
);

-- Q-9 : Modify the courses table by adding a column course_duration using the ALTER command.

alter table courses add column course_duration varchar(25) not null after course_credits; 

-- Q-10 : Drop the course_credits column from the courses table.

alter table courses drop column course_credits;

-- Q-13 : Lab 1: Insert three records into the courses table using the INSERT command.

insert into courses values(30201,'Computer Engineering','4 Years'),
(30202,'Civil Engineering','4 Years');
insert into courses values(30203,'Automobile Engineering','4 Years');

-- Q-14 : Update the course duration of a specific course using the UPDATE command.

update courses set course_duration = '6 Years' where course_id = 30202;

-- Q-15 : Delete a course with a specific course_id from the courses table using the DELETE command.

delete from courses where course_id = 30203; 

-- Q-16 : Lab 1: Retrieve all courses from the courses table using the SELECT statement.

select course_name from courses;

-- Q-17 : Sort the courses based on course_duration in descending order using ORDER BY.

select * from courses order by course_name desc;

-- Q-18 : Limit the results of the SELECT query to show only the top two courses using LIMIT.

select * from courses limit 2;

-- Q-19 : Create two new users user1 and user2 and grant user1 permission to SELECT from the courses table.

create user user1 identified by 'abc@123';

create user user2 identified by 'def@123';

grant select on courses to user1;

-- Q-20 : Revoke the INSERT permission from user1 and give it to user2.

revoke select on courses from user1;

grant select on courses to user2;

-- Q-21 : Insert a few rows into the courses table and use COMMIT to save the changes.

insert into courses values (30204,'Electric Engineering','4 Years'),
(30205,'IT Engineering','4 Years');

select * from courses;
commit;

-- Q-22 : Insert additional rows, then use ROLLBACK to undo the last insert operation.

insert into courses values (30206,'EC Engineering','4 Years'),
(30207,'Mechenical Engineering','4 Years');

select * from courses;

rollback;

select * from courses;

-- Q-23 : Create a SAVEPOINT before updating the courses table, and use it to roll backspecific changes.

update courses set course_creadits = '4 years' where course_id = 1;
savepoint s1;
update courses set course_creadits = '4 years' where course_id = 2;
savepoint s2;

rollback to savepoint s1;

-- Q-29 : Write a stored procedure that accepts course_id as input and returns the course details.

delimiter &&
create procedure display (in id int)
begin
select * from courses where courses_id;
end &&

-- Q-39 : Create a cursor to retrieve all courses and display them one by one.

DECLARE
    cou_id courses.course_id%type;
    cou_name courses.course_name%type;
cursor cou is select course_id,course_name from courses;
begin 
  open cou ;
  loop
  fetch cou into cou_id , cou_name ;
  dbms_output.put_line(cou_id||' | '|| cou_name);
  exit when cou%notfound;
  end loop;
  close cou;
end;







