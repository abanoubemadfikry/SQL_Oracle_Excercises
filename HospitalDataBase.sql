use hospital;
go 
create table Patient(
national_id varchar primary key  ,
first_name nvarchar(30) not null,
last_name nvarchar(40) not null,
[Address] nvarchar (70) not null,
age int not null,
phone nvarchar(20) unique,
gender nvarchar(7) not null check(gender='male' or gender='female'),
date_admitted date ,
insurance varchar(100)
);
create table [Doctor](
doctor_id int  primary key,
[name] varchar(30) not null,
specialization varchar(50) not null,
shift_time varchar ,
);

create table [Nurses(staff)](
staff_id int primary key,
[name] varchar(30) not null,
specialization varchar(50) not null,
shift_time varchar
);

create table Patient_record(
patient_id varchar not null,
taken_drugs varchar(100),
operation_name varchar(50) not null,
doctor_id int,
nurse_id int,
entry_time time ,
exiting_time time,
assistant_doctor varchar(30),
anesthetist varchar(50),
x_rays image,
test_results varchar(300),
constraint patient_patientrecord_fk foreign key(patient_id) references Patient(national_id),
constraint patientrecord_doctor_fk foreign key (doctor_id) references Doctor(doctor_id),
constraint patientrecord_nurses_fk foreign key (nurse_id) references [Nurses(staff)](staff_id)
);
create table Pharmacy(
nurse_id int,
drug_name varchar(50) not null,
drug_quantity int,
drug_recipient varchar(50),
recipient_date date,
constraint pharmacy_staff_fk foreign key (nurse_id) references [Nurses(staff)](staff_id)
);

create table Material_Room(
nurse_id int not null,
material_name varchar(100) ,
material_quantity int ,
constraint materialroom_staff_fk foreign key (nurse_id) references [Nurses(staff)](staff_id)
);
create table Operation_room(
[name] varchar(30) primary key,
medical_devices varchar(100) not null,
[is_available?] varchar(10) not null,
patient_id varchar not null,
doctor_id int not null,
nurse_id int not null,
constraint patient_operationroom_fk foreign key(patient_id) references Patient(national_id),
constraint doctor_operationroom_fk foreign key (doctor_id) references Doctor(doctor_id),
constraint nurses_operationroom_fk foreign key (nurse_id) references [Nurses(staff)](staff_id)
);
insert into patient
values(12132873,'ahmed','hassan','beba/beni_suef',19,'0124384473','male','2017-12-30','have insurance');

insert into Patient(
national_id,
first_name ,
last_name ,
[Address] ,
age ,
phone ,
gender,
date_admitted ,
insurance )
values (1328432,'lionel','messi','argentin',30,'012973864','male','12-5-2014','dont have insurance');

insert into Patient
values(542998256216176,'samira'	,'saeed','minya',43	,'0128478443','female','12-20-2020','have insurance');

insert into Patient
values(80961234586453,'mohsen'	,'tawfik','ihnasya',50,'015873862','male','9-7-2022','have no insurance');

select * from Patient;

insert into Doctor
values(1,'maged samir','surgery','sunday and wedensday');


insert into Doctor(doctor_id,name,specialization,shift_time)
values(2,'tamer salah','brain surgery','on demand, if they needed him in emergency operations');

insert into Doctor(doctor_id,name,specialization,shift_time)
values(3,'magdy samir','cardiac surgery','on demand, if they needed him in emergency operations');

select * from doctor;

insert into [Nurses(staff)]
values(1,'mamdouh ali','responsible for pharmacy','monday and friday in the night shift');

insert into [Nurses(staff)]
values(2,'hossam tawfik','responsible for material room','tuseday and wednesday in the night shift');

insert into [Nurses(staff)]
values(3,'omima ali','responsible for operation room','all days in morning shift');

insert into [Nurses(staff)]
values(4,'yasmin adel','responsible for surgical operation room','all days in nightshift');

select * from [Nurses(staff)];

insert into Patient_record
values (12132873,'panadol , coldfree, netlook','plastic surgery',1,3,'12:30','2:15',
'dr/youssef salama','dr/momen yasser','image for x_rays','test result written here');
select * from Patient_record;
insert into Patient_record
values (542998256216176,'panadol , coldfree, panadolextra','brain and nerv surgeory',2,2,'19:30','21:15',
'dr/ramy nageb','dr/momen yasser','image for x_rays','test result written here');

select pat.national_id,pat.first_name,pat.last_name,patrec.taken_drugs,doc.name "doctor name",doc.specialization
from patient as pat join Patient_record patrec
on(pat.national_id=patrec.patient_id) join Doctor doc
on (patrec.doctor_id=doc.doctor_id);

insert into Pharmacy
values(1,'panadol extra',2,'nurse amal maher','4-9-2021');

insert into Pharmacy
values(1,'cold free',4,'nurse mamdouh ali','9-16-2021');

insert into Pharmacy
values(1,'net look',3,'nurse mamdouh ali','9-24-2021');

select * from pharmacy;


insert into Material_Room
values(2,'cotton',12);

insert into Material_Room
values(2,'gauze',9);

insert into Material_Room
values(2,'saline',15);

select * from Material_Room;

insert into Operation_room
values('surgery','Tables - Surgical
Patient Monitors
Patient Monitors
Endoscopy Equipment
Endoscopy Equipment','yes',542998256216176,1,3);

insert into Operation_room
values('plastic surgery','Tables - Surgical
Patient Monitors
Endoscopy Equipment','yes',1328432,1,3);

insert into Operation_room
values('cardiac surgery','Tables - Surgical
Patient Monitors
Endoscopy Equipment Surgical Microscopes Defibrillators','no',80961234586453,3,4);


select * from Operation_room;

select pat.national_id,CONCAT(pat.first_name,pat.last_name)"full name",pat.phone,doc.name "doctor name",doc.specialization
from Patient pat join Patient_record patrec
on(pat.national_id=patrec.patient_id) join  Doctor doc
on(patrec.doctor_id=doc.doctor_id)
;


select pat.national_id,CONCAT( pat.first_name,pat.last_name) "full name", doc.name "doctor supervisor",
op.name "operation name", nur.name "supervisor nurse" ,patrec.taken_drugs "taken drugs",patrec.operation_name 
from patient pat join Doctor doc 
on (pat.national_id=doc.patient_national_id)
join Operation_room op on
(pat.national_id=op.patient_id) join [Nurses(staff)] nur
on(nur.staff_id=op.nurse_id) join  Patient_record patrec
on(patrec.patient_id=pat.national_id)
where national_id=542998256216176;


select pat.national_id,pat.first_name,op.name,doc.name,nur.name,patrec.taken_drugs,patrec.entry_time,patrec.test_results
from Operation_room op join Patient pat
on(pat.national_id=op.patient_id) join [Nurses(staff)] nur
on(op.nurse_id=nur.staff_id) join Doctor doc
on(doc.doctor_id=op.doctor_id) join Patient_record patrec
on(patrec.patient_id=pat.national_id);


