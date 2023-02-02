drop table depts;

create table depts(
  dept_id     NUMBER(10)
        CONSTRAINT nnc_depts_dept_id NOT NULL,
    dept_name   VARCHAR2(10)
        CONSTRAINT nnc_depts_dept_name NOT NULL,
        constraint depts_pk primary key(dept_id)
);
create table stores(
 store_id     NUMBER(10) NOT NULL,
    store_name   VARCHAR2(10), 
    constraint stores_pk primary key (store_id)
    );
create table units( 
  unit_id     NUMBER(10) NOT NULL,
    unit_code   VARCHAR2(10),
    unit_desc   VARCHAR2(30),
    constraint units_pk primary key (unit_id),
    constraint units_uniq unique(unit_code)
    );

create table items(
   item_id int ,
    item_no      VARCHAR2(16) NOT NULL,
    item_name    VARCHAR2(300) NOT NULL,
    unit_id      NUMBER(10) NOT NULL,
    store_id     NUMBER(10) NOT NULL,
    unit_price   NUMBER(10,2), 
    constraint items_pk primary key (item_id),
    constraint items_units_fk foreign key (unit_id) references units(unit_id),
    constraint items_stores_fk foreign key (store_id) references stores(store_id)
);


create table users(    
   user_id     NUMBER(10) NOT NULL,
    user_name   VARCHAR2(30) NOT NULL,
    password    VARCHAR2(10) NOT NULL, 
    constraint users_pk primary key (user_id)
    );


create table issuing(
 issue_id     NUMBER(10) NOT NULL,
    issue_no     NUMBER(6) NOT NULL,
    issue_date   DATE NOT NULL,
    dept_id      NUMBER(10) NOT NULL,
    store_id     NUMBER(10) NOT NULL,
    user_id      NUMBER(10) NOT NULL, 
    constraint issuing_pk primary key (issue_id),
    constraint issuing_users_fk foreign key(user_id) references users(user_id),
    constraint issuing_depts_fk foreign key (dept_id)references depts(dept_id),
    constraint issuing_dtores_fk foreign key (store_id) references stores(store_id)
    );
 CREATE TABLE isuuing_items (
    issue_i_id      NUMBER(10) NOT NULL,
    issue_id        NUMBER(10) NOT NULL,
    issue_serial    NUMBER(2),
    item_id         NUMBER(10) NOT NULL,
    available_qty   NUMBER(10,3),
    issue_qty       NUMBER(10,2), 
    constraint isuuing_items_pk primary key(issue_i_id),
    constraint isuuing_items_issuing_fk foreign key(issue_id) references issuing(issue_id),
    constraint isuuing_items_items_fk foreign key(item_id) references items (item_id)
);
create table vendors(
   vendor_id           NUMBER(10) NOT NULL,
    vendor_name         VARCHAR2(50) NOT NULL,
    vendor_short_name   VARCHAR2(30),
    phone               VARCHAR2(12) unique,
    fax                 VARCHAR2(12) unique,
    local_foreign_ind   CHAR(1) NOT NULL, 
    constraint vendors_pk primary key (vendor_id)
);

create table receiving
(
receiving_id number(10) not null, 
rec_no varchar(6) not null, 
rec_date date not null,
vendor_id number(10) not null, 
dept_id number(10) not null, 
store_id number(10)not null,
user_id number(10)not null,
constraint receiving_pk primary key(receiving_id),
constraint receiving_vendors_fk foreign key (vendor_id) references vendors (vendor_id),
constraint receiving_depts_fk foreign key(dept_id) references depts (dept_id),
constraint receiving_stores_fk foreign key(store_id) references stores (store_id),
constraint receiving_users_fk foreign key(user_id) references users (user_id)
);

create table receiving_items
(
rec_i_id number(10) not null,
rec_id number(10) not null,
rec_qty      NUMBER(10,3) NOT NULL,
rec_serial  NUMBER(2) NOT NULL,
item_id    NUMBER(10) NOT NULL,
unit_price   NUMBER(10,2) NOT NULL,
constraint receiving_items_pk primary key (rec_i_id),
constraint   receiving_items_receiving_fk foreign key (rec_id)references receiving (receiving_id),
constraint  receiving_items_items_fk foreign key(item_id)references items(item_id)
);

CREATE TABLE transactions (
    trans_id     NUMBER(10) NOT NULL,
    trans_type   NUMBER(2),
    trans_no     VARCHAR2(6),
    trans_date   DATE,
    item_id      NUMBER(10) NOT NULL,
    qty_plus     NUMBER(10,3),
    qty_minus    NUMBER(10,3),
    unit_price   NUMBER(10,2),
    constraint transactions_pk primary key(trans_id),
    constraint transactions_items_fk foreign key(item_id)references items(item_id)
);