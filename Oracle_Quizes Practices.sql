Declare 
v_myage number ;
v_firstname employees.first_name% TYPE;
v_id employees.employee_id% TYPE:=&empid ;
v_salary employees.salary% TYPE;
BEGIN
SELECT first_name, salary into v_firstname,v_salary from employees
where employee_id=v_id;
v_myage :=&age;
if v_myage between  10 and 29 then
dbms_output.put_line('ur age is '|| v_myage||'greater than 10 and less than 30 and ur name is '||v_firstname ||' salary is '|| v_salary);
elsif v_myage between 31 and 59 then 
dbms_output.put_line('ur age is'|| v_myage ||' greater than 30 and less than 60 and ur name is '|| v_firstname ||'salary is'|| v_salary);
else 
dbms_output.put_line('ur age greater than  and less than ');
end if;
end;
---------------------Case statement--------------------
declare 
v_num number :=&numberrr;
v_txt VARCHAR(20);
BEGIN
case v_num
WHEN 10 THEN v_txt:= 'number entered is 10';
when 20 then v_txt:= 'number entered is 20';
when 30 then v_txt:= 'number entered is 30';
else dbms_output.put_line('number entered is others');
end CASE;
dbms_output.put_line(v_txt);
end;
-----------case expression----------------
declare 
v_grade CHAR(1):='&gr';
v_appraisal varchar2(40);
begin 
v_grade:=upper(v_grade);
v_appraisal :=
case v_grade
when 'A' then 'Excellent'
when 'B' then 'Very Good'
when 'C' then 'Good'
when 'D' then 'pass'
else 'Fail'
End;
dbms_output.put_line('Grade is :'||v_grade||' ---- Appraisal is :'||v_appraisal);
End;
-----------------------
declare 
v_outval varchar2(30);
v_innerval number :=20;
BEGIN
v_outval:=
case v_innerval
when 1 then 'Low'
when v_innerval THEN 'same value'
when 20 then 'middle value'
else 'other value'
end;
dbms_output.put_line(v_outval);
end;
---------------loops-------------------
declare 
v_counter NUMBER:=&c;
BEGIN
      loop 
      dbms_output.put_line('iteration number '||v_counter);   
      v_counter:=v_counter +1;
      Exit when v_counter>10;
      END LOOP ;
end;
----
select * from locations;
DECLARE 
v_loc_id locations.location_id%TYPE;
v_counter number :=1;
BEGIN
select max(Location_id)into v_loc_id from locations
where location_id= 2;
while v_counter<=3
loop 
insert into locations(location_id,city, country_id)
values((v_loc_id + v_counter),'Montreal','DE');
v_counter:=v_counter+1;
END loop;
end;
---------for loop---------
begin 
for i in 1..4  loop
  for j in reverse 1..8 loop
dbms_output.put_line('outer loop is '||i||' --- inner loop :'||j);
end loop;
dbms_output.put_line('-------------the '||i||'iteration number------------------');
end loop;
end;
----------
declare 
v_outer number:=0;
v_inner number:=1;
BEGIN
  <<outer_loop>>
    loop  
    v_outer := v_outer+1;
    exit when v_outer > 3;
        <<inner_loop>>
            loop
            dbms_output.put_line('outer loop is: '|| v_outer||'inner loop is :'||v_inner);
            v_inner:=v_inner+1;
            exit when v_inner > 8;
            end loop inner_loop;
   end loop outer_loop;
end;
------------
DECLARE
v_grade CHAR(1) := NULL;
v_result VARCHAR2(10);
BEGIN
CASE
WHEN v_grade IN ('A', 'B') THEN v_result := 'Very Good';
WHEN v_grade IN ('E','F') THEN v_result := 'Poor';
ELSE v_result := 'In Between';
END CASE;
DBMS_OUTPUT.PUT_LINE(v_result);
END;
-----------------------
DECLARE
    v_age NUMBER:= 18;
    v_answer VARCHAR2(10);
BEGIN
    v_answer :=
       CASE
          WHEN v_age < 25 THEN 'Young'
          WHEN v_age = 18 THEN 'Exactly 18'
          ELSE 'Older'
END;
dbms_output.put_line(v_answer);
end;
--------------
BEGIN
FOR i IN 1..5 LOOP
FOR j IN 1..8 LOOP
EXIT WHEN j = 7;
DBMS_OUTPUT.PUT_LINE(i || j);
END LOOP;
END LOOP;
END;
------------------
declare
i number := 2;
BEGIN
WHILE i < 3 LOOP
  i := 4;
  DBMS_OUTPUT.PUT_LINE('The counter is: ' || i);
END LOOP;
end;
---------------------------------
DECLARE
   v_bool1 BOOLEAN := TRUE;
   v_bool2 BOOLEAN;
   v_char VARCHAR(4) := 'up';
BEGIN
   IF (v_bool1 AND v_bool2) THEN
     v_char:='down';
   ELSE v_char:='left';
   END IF;
   
   DBMS_OUTPUT.PUT_LINE(v_char);
   
END;
---------------------
DECLARE
    v_salary NUMBER(6);
    v_constant NUMBER(6) := 15000;
    v_result VARCHAR(6) := 'MIDDLE';
BEGIN
 DBMS_OUTPUT.PUT_LINE(v_salary);
    IF v_salary = v_constant THEN
        v_result := 'HIGH';
    ELSE
        v_result := 'LOW';
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
-------------
DECLARE
  x BOOLEAN := FALSE;
  y BOOLEAN := FALSE;
  z BOOLEAN ;
  v_result VARCHAR2(30);
BEGIN
  z := (x OR NOT y);
  v_result:=
  case 
  when z=false then 'false'
  when z=true then 'true'  
    end;
     DBMS_OUTPUT.PUT_LINE(v_result);
END;
-------------------
DECLARE
    a VARCHAR2(6) := NULL;
    b VARCHAR2(6) := NULL;
BEGIN
    IF a = b THEN
       DBMS_OUTPUT.PUT_LINE('EQUAL');
    ELSIF a != b THEN
       DBMS_OUTPUT.PUT_LINE('UNEQUAL');
    ELSE
       DBMS_OUTPUT.PUT_LINE('OTHER');
    END IF;
END;
------
BEGIN
 FOR i IN 1..5 LOOP
   FOR j IN 1..8 LOOP
    DBMS_OUTPUT.PUT_LINE(i || ',' || j);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(i);
 END LOOP;
END;
---------------------
  << outer >>
DECLARE
   v_myvar VARCHAR2(10) := 'Hello' ;
BEGIN
     << inner >>
   DECLARE
     v_myvar VARCHAR2(10) := 'World';
     BEGIN
     v_myvar := v_myvar || ' ' || outer.v_myvar;
   END;
   DBMS_OUTPUT.PUT_LINE(inner.v_myvar);
END;
--------------------------------------
DECLARE
   v_age1 NUMBER(3);
   v_age2 NUMBER(3);
   v_message VARCHAR2(20);
BEGIN
   CASE
     WHEN v_age1 = v_age2 THEN v_message := 'Equal';
     WHEN v_age1 <> v_age2 THEN v_message := 'Unequal';
     ELSE v_message := 'Undefined';
   END CASE;
   DBMS_OUTPUT.PUT_LINE(v_message);
END;

----------
declare
begin
<<outer_loop>>
for i in 1..12
loop
<<inner_loop>>
for j in 1..12
loop
dbms_output.put_line(i||'*'||j||'= '||i*j);
end loop;
dbms_output.put_line('---------------------------------------');
end loop;
end;
-----------

