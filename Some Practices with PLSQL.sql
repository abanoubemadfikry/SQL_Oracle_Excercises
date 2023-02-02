
create or replace procedure_name
is 


drop function get_mile_to_km;
drop procedure greet;

 create or replace function find_salary
  (  p_emp_id          job_history.employee_id%type
   , p_start_date      job_history.start_date%type
   , p_end_date        job_history.end_date%type
   , p_job_id          job_history.job_id%type
   )
IS
BEGIN
  INSERT INTO job_history (employee_id, start_date, end_date,
                           job_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id);
END add_job_history;
execute add_job_history(110,'1-nov-2011','7-feb-2018','FI_ACCOUNT');

select * from employees;

CREATE PROCEDURE procedure_name(parameters_name in/out parameter_dataType)
IS 
Begin
procedure_body 
exception(optional)
END;
---------------------------------------------------------------------------------------------------------------------------
create or replace procedure query_employees
(
p_empid in employees.employee_id%type,
p_fname out employees.first_name%type,
p_salary out employees.salary%type,
p_deptname out departments.department_name%type,--department table(department_id is fk)
p_jobid out employees.job_id%type,
p_countryname out countries.country_name%type,--countries table will linked with locations with country_id
p_city out locations.city%type
)
is 
begin
select first_name,salary,department_name,job_id,country_name,city 
into p_fname,p_salary,p_deptname,p_jobid,p_countryname,p_city
from employees emp join departments dept 
on(emp.department_id=dept.department_id) join locations loc
on(loc.location_id=dept.location_id) join countries cont
on(loc.country_id=cont.country_id)
where employee_id=p_empid;

exception
when others then
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
end;
-----------------------------------------------------
declare
v_firstname employees.first_name%type;
v_sal employees.salary%type;
v_deptname departments.department_name%TYPE;
v_job_id employees.job_id%type;
v_countryname countries.country_name%type;
v_city locations.city%type;
begin
query_employees(&id,v_firstname,v_sal,v_deptname,v_job_id,v_countryname,v_city);
dbms_output.put_line(v_firstname);
dbms_output.put_line(v_sal);
dbms_output.put_line(v_deptname);
dbms_output.put_line(v_job_id);
dbms_output.put_line(v_countryname||'--'||v_city);

exception
when others then
dbms_output.put_line('error');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);

end;
------------------------------------


select * from employees
where employee_id=120;







create or replace function find_salary
(p_empid number)

return number

is 
v_sal number;
begin
select salary into v_sal
from employees
where employee_id=p_empid;

return v_sal;

exception 
when others then
dbms_output.put_line('error,,,no employee found');
return -1;
end;

--methods to invoke function
--1
declare
v_salary employees.salary%type;
begin 
v_salary :=find_salary(105);
dbms_output.put_line(v_salary);
end;
--
--method (2)
begin 
dbms_output.put_line(find_salary(103));
end;
--
execute dbms_output.put_line(find_salary(100));
--method (3)
variable bindvar_salary number;
execute :bindvar_salary:=find_salary(106);
print bindvar_salary;
--method (4)
select find_salary(124) from dual;
--
select employee_id,first_name ,find_salary(employee_id)
from employees
where department_id=50;












