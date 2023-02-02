declare 
v_country_id countries.country_id%type;
v_country_name countries.country_name%type;
begin
v_country_id:='EG';
while v_country_id <>'UK'
loop
select country_id,country_name into v_country_id, v_country_name
from countries
where country_id=v_country_id;
dbms_output.put_line(v_country_id||v_country_name);
--v_country_id:=v_country_id-1;
end loop;
end;
select * from employees 
where job_id='AD_VP';
---------------
declare 
v_number number:=&num;
begin
if mod(v_number,2)=0 then
dbms_output.put_line(v_number ||' is even');
else
dbms_output.put_line(v_number ||' is odd');
end if;
end;
-------------cursors-----------------
declare 
cursor cur_dept is
SELECT department_id,department_name from departments
where department_id=20;
v_department_id departments.department_id% TYPE;
v_department_name departments.department_name% TYPE;
BEGIN
open cur_dept;
loop
FETCH cur_dept into v_department_id,v_department_name;
exit when cur_dept%notfound;
dbms_output.put_line(v_department_id ||'||'|| v_department_name);
end loop;
close cur_dept;
end;
------------------------
declare 
cursor cur_emps is
select * from employees
where employee_id=to_number('&emplastname');
begin
for  rec_emp in cur_emps
loop
dbms_output.put_line(rec_emp.employee_id ||' '|| rec_emp.first_name||' '||rec_emp.salary);
end LOOP;
end;
------------------------

begin 
for record_emp in (select employee_id, first_name, salary from employees where department_id=20)
loop
dbms_output.put_line(record_emp.employee_id ||' '|| record_emp.first_name||' '||record_emp.salary);
end LOOP ; 
END;

------------------------------
declare
v_max_Salary employees.salary% TYPE;
v_dept_number employees.department_id% TYPE:=&departmentuwant;

cursor cur_emp_salary(p_dept_number number) is
select * from employees
where salary=(select max(salary)from employees where department_id=p_dept_number);

v_emp_rec cur_emp_salary%rowtype;
BEGIN
open cur_emp_salary(v_dept_number);
loop
FETCH cur_emp_salary into v_emp_rec;
exit when cur_emp_salary%notfound;
dbms_output.put_line(v_emp_rec.employee_id ||' '|| v_emp_rec.first_name || v_emp_rec.salary);
end loop;
close cur_emp_salary;
end;
-------------------------------------
declare 
cursor c_emp(p_jobid employees.job_id% TYPE,p_salary employees.salary% TYPE)
is select * from employees where job_id=p_jobid and salary>p_salary;
v_jobid employees.job_id% TYPE:='&jobid';
v_salary employees.salary% TYPE:=&ssalary;
begin
for emp_rec in c_emp(v_jobid,v_salary)
loop
dbms_output.put_line(emp_rec.employee_id ||' '|| emp_rec.first_name || emp_rec.salary);
end loop;
end;
-------------------------------------------------------
declare 
cursor cur_dept is
select department_id, department_name from departments
order by department_name;
cursor cur_emp(p_dept_id number)
is select employee_id,first_name, department_id,salary 
from employees 
where department_id= p_dept_id;
BEGIN
for rec_dept in cur_dept
loop
dbms_output.put_line(rec_dept.department_id||rec_dept.department_name);
END LOOP;
for emp_rec in cur_emp(rec_dept.department_id)
loop
dbms_output.put_line(emp_rec.employee_id ||' '|| emp_rec.first_name || emp_rec.salary || emp_rec.department_id||  emp_rec.department_name);
end loop;
end;
---------------------
declare 
type emp_record is record
(emp_id employees.employee_id%type,
fname employees.first_name%type,
lname employees.last_name%type,
deprtmentname departments.department_name% TYPE);
v_emp_rec emp_record;
begin
select e.employee_id,e.first_name,e.last_name,d.department_name INTO v_emp_rec
from employees e join departments d
on(e.department_id= d.department_id)
where e.employee_id=&id;
dbms_output.put_line(v_emp_rec.emp_id ||' '|| v_emp_rec.fname ||'_'|| v_emp_rec.lname||' ' || v_emp_rec.deprtmentname);
end;
--------------------------
create or replace PROCEDURE update_job
(p_jobid in jobs.job_id%type,
p_jobtitle in jobs.job_title% TYPE)
is 
exception_invalid exception;
begin
update jobs
set job_title = p_jobtitle 
where job_id = p_jobid;
if sql%notfound then
raise exception_invalid;
end if;
dbms_output.put_line(p_jobid ||' update successfully');
exception
when exception_invalid then 
dbms_output.put_line('error'|| p_jobid||' is invalid ');
end;
---
select * from employees
where department_id=80;
--
declare 
v_jobid  jobs.job_id%type:='&id';
v_jobtitle  jobs.job_title% TYPE:='&NEW_title';
begin 
update_job(v_jobid,v_jobtitle);
end;
-------------------------------------------
create or replace procedure update_salary
(dept_id employees.department_id%type)
is
begin
case dept_id
when 80 then 
update employees set salary=salary+1000
where department_id=80;
when 50 then
update employees set salary=salary+2000
where department_id=50;
else 
update employees set salary=salary+3000;
end case;
dbms_output.put_line('updated '|| SQL%rowcount);
exception 
when OTHERS then 
dbms_output.put_line('no rows updated');
end;
---
declare 
v_deptid employees.department_id%type:=&deptid;
begin
update_salary(v_deptid);
end;
-----------------------------------------
declare
v_deptid number;
cursor cur_dept is
select department_id,department_name from departments
where department_id < 100;
cursor cur_emp(p_department_id number)
is 
select employee_id,first_name, department_id,salary , hire_date, job_id
from employees 
where department_id= p_department_id
and employee_id < 120;
begin
for rec_dept in cur_dept 
loop 
dbms_output.put_line(rec_dept.department_id || rec_dept.department_name);

for rec_emp in cur_emp(rec_dept.department_id)
loop
dbms_output.put_line(rec_emp.employee_id || ' -- '|| rec_emp.first_name || ' -- '|| rec_emp.department_id || ' -- '|| rec_emp.salary ||  ' -- '||rec_emp.hire_date ||' --'|| rec_emp.job_id);
end loop;
dbms_output.put_line('-------------------------------------------------------');
end loop;
end;
-------------------------------------
create or replace procedure greet
(v_name VARCHAR2)
is
today_date date default sysdate;
tomorrow today_date%TYPE;
begin
tomorrow:=today_date+1;
dbms_output.put_line('hello ' ||v_name );
dbms_output.put_line('today is :'||today_date);
dbms_output.put_line('tommorrow is :'||tomorrow);
end;
---
declare 
va_name VARCHAR2(30):='&NAME';
begin
greet(va_name);
end;
----------------------------------------------
declare 
v_country_id countries.country_id% TYPE:='CA';
v_record_countries countries%rowtype;
begin
select * into v_record_countries from countries
where country_id= upper(v_country_id);
dbms_output.put_line('Country id:'|| v_record_countries.country_id ||' country Name :'|| v_record_countries.country_name ||' Region :'|| v_record_countries.region_id);
exception 
when others then 
dbms_output.put_line('no rows foundd');
end;
-------------------------------------
declare 
v_deptno departments.department_id% TYPE:=&enter_department_id;
cursor c_emp_cursor is
select e.employee_id,e.last_name,e.salary,e.manager_id,m.first_name from employees e JOIN employees m
on(e.manager_id=m.employee_id)
where e.department_id=v_deptno;
begin
for v_emp_record in c_emp_cursor
loop
if (v_emp_record.salary < 5000 AND (v_emp_record.manager_id =101 or v_emp_record.manager_id=124)) then
dbms_output.put_line(v_emp_record.last_name || ' Due for a raise.'||v_emp_record.salary);
else
dbms_output.put_line(v_emp_record.last_name || ' Not Due for a raise. his salary is '
||v_emp_record.salary ||'and his manager id is '||v_emp_record.manager_id ||'hismanager name is'||v_emp_record.first_name);
end if;
end loop;
end;
-----
select distinct(manager_id) FROM employees;
select * from employees
where department_id=10;