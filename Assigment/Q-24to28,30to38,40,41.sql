-- Q-24 : Create two tables: departments and employees. Perform an INNER JOIN to display employees along with their respective departments.

create table department
(
department_id int primary key,
department_name varchar(25) not null
);

create table employees
(
employee_id int not null unique,
employee_name varchar(25) not null,
department_id int not null,
salary int not null,
foreign key employees(department_id) references department(department_id)
);

insert department values (1,'Civil'),
(2,'Mechenical'),
(3,'Electrical'),
(4,'Managment'),
(5,'LOading'),
(6,'labor');

select * from department;

insert employees values(1,'Dip patel',1,55000),
(2,'Pojan patel',2,45000),
(3,'Raj patel',3,35000),
(4,'Bhavik patel',4,45000), 
(5,'Hardik gondalia',5,50000),
(6,'Parth padharia',6,55000);

select * from employees;

select employees.employee_id,employees.employee_name,department.department_id,department.department_name 
from department inner join employees on employees.department_id = department.department_id;

-- Q-25 : Use a LEFT JOIN to show all departments, even those without employees.

select employees.employee_id,employees.employee_name,department.department_id,department.department_name 
from department left join employees on employees.department_id = department.department_id;

-- Q-26: Group employees by department and count the number of employees in each department using GROUP BY.

select department_id,count(*) from employees group by department_id;

-- Q-27 : Use the AVG aggregate function to find the average salary of employees in each department.

select department_id,avg(salary) from employees group by department_id;

-- Q-28 : Write a stored procedure to retrieve all employees from the employees table based on department.

delimiter &&
create procedure display()
select * from employees order by department_id;
end &&

call display();

-- Q-30 : Create a view to show all employees along with their department names.

CREATE VIEW employee_department AS
SELECT 
    employees.employee_id,
    employees.employee_name,
    employees.salary,
    department.department_name
FROM 
    employees
LEFT JOIN 
    department ON employees.department_id = department.department_id;


-- Q-31 : Modify the view to exclude employees whose salaries are below $50,000.

CREATE OR REPLACE VIEW employee_department AS
SELECT 
    employees.employee_id,
    employees.employee_name,
    employees.salary,
    department.department_name
FROM 
    employees
LEFT JOIN 
    department ON employees.department_id = department.department_id
WHERE 
    employees.salary >= 50000;

-- Q-32 : Create a trigger to automatically log changes to the employees table when a new employee is added.
-- Q-33 : Create a trigger to update the last_modified timestamp whenever an employee record is updated.

create table update_employees
(
employee_id int not null unique,
employee_name varchar(25) not null,
department_id int not null,
salary int not null,
action_date timestamp default current_timestamp,
action_type varchar(10)
);

create trigger trg_employee
after insert on employees 
for each raw 
begin 
	insert into update_employees(employee_id,employee_name,department_id,salary,action_type)
    values(new.employee_id,new.employee_name,new.department_id,new,salary)
end;

insert into update_employees(employee_id,employee_name,department_id,salary) values (7,'Varun chavda',3,34000);
insert into update_employees(employee_id,employee_name,department_id,salary) values (8,'Vikas patel',5,40000);

select * from update_employees;


-- Q-34 : Write a PL/SQL block to print the total number of employees from the employees table.

declare
total_employee number;

begin 
select count(*) into total_employee from employees
join department on employees.department_id = department.department_id;
dbms_output.put_line('total number of employees = ' || (total_employee));
end;

-- Q-35 : Create a PL/SQL block that calculates the total sales from an orders table

create table orders
(
order_id int not null unique,
order_name varchar(25) not null,
sales int not null
);

insert into orders values(1,'Tooth past',5);
insert into orders values(2,'Perfume',10);
insert into orders values(3,'soap',8);
insert into orders values(4,'Thooth brush',2);
insert into orders values(5,'Comb',6);
insert into orders values(6,'shampoo',4);

select * from orders;

declare
total_sales number;

begin
select sum(sales) into total_sales
from orders where sales;
dbms_output.put_line('total sales is  = ' || (total_sales));
end;

-- Q-36 : Write a PL/SQL block using an IF-THEN condition to check the department of an employee.


DECLARE
  
  dept_id NUMBER;
  
  emp_name VARCHAR2(25);
  
BEGIN

  DBMS_OUTPUT.PUT_LINE('Enter Employee ID:');

  dept_id := 3; 
  SELECT employee_name, department_id
  INTO emp_name, dept_id
  FROM employees
  WHERE employee_id = dept_id;


  IF dept_id = 1 THEN
    DBMS_OUTPUT.PUT_LINE(emp_name || ' is from the Civil department.');
  ELSIF dept_id = 2 THEN
    DBMS_OUTPUT.PUT_LINE(emp_name || ' is from the Mechanical department.');
  ELSIF dept_id = 3 THEN
    DBMS_OUTPUT.PUT_LINE(emp_name || ' is from the Electrical department.');
  ELSIF dept_id = 4 THEN
    DBMS_OUTPUT.PUT_LINE(emp_name || ' is from the Management department.');
  ELSIF dept_id = 5 THEN
    DBMS_OUTPUT.PUT_LINE(emp_name || ' is from the LOading department.');
  ELSE
    DBMS_OUTPUT.PUT_LINE(emp_name || ' is from the Labor department.');
  END IF;
EXCEPTION

  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Employee with ID ' || dept_id || ' not found.');
END;


-- Q-37 : Use a FOR LOOP to iterate through employee records and display their names.

DECLARE
    emp_name employees.employee_name%type;
BEGIN
    FOR emp_record IN (select employee_name from employees)LOOP
    emp_name:= emp_record.employee_name;
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name);
    END LOOP;
END;


-- Q-38 : Write a PL/SQL block using an explicit cursor to retrieve and display employee details.

DECLARE
    emp_id employees.employee_id%type;
    emp_name employees.employee_name%type;
    dep_id employees.department_id%type;
    sal employees.salary%type;
cursor employee_cursor is 
  select employee_id,employee_name,department_id,salary
  from employees;
begin 
  open employee_cursor ;
  loop
  fetch employee_cursor into emp_id , emp_name , dep_id , sal;
  dbms_output.put_line(emp_id||' | '|| emp_name||' | '|| dep_id||' | '|| sal);
  exit when employee_cursor%notfound;
  end loop;
  close employee_cursor;
end;

-- Q-40 : Perform a transaction where you create a savepoint, insert records, then rollback to the savepoint.
-- Q-41 :  Commit part of a transaction after using a savepoint and then rollback the remaining changes.

update employees set salary = 10000 where employee_id = 2;
savepoint e1;
update employees set salary = 10000 where employee_id = 4;
savepoint e2;
update employees set salary = 10000 where employee_id = 6;
savepoint e3;

select * from employees;

rollback to savepoint e1;

commit;

select * from employees;

