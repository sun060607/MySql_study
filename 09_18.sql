show databases;
create database study_DB default character set UTF8;
use study_db;
/*---------------------09_18-----------------------*/
create view Vbook
as select *
from book
where bookname like '%축구%';
select * from Vbook;
create view vw_Customer
as select *
from customer
where address like '%대한민국%';
select * from vw_Customer;

create view vw_orders(orderid, bookname,saleprice,name)
as select Orders.orderid, book.bookname, orders.saleprice, Customer.name
from customer, Orders,book
where customer.custid = Orders.custid and book.bookid = Orders.bookid;

select * from vw_orders where name = '김연아';

create or replace view vw_Customer
as select *
from customer
where address like '%영국%';
select * from vw_Customer;

drop view vw_Customer;
select * from vw_Customer;

create view highorders(bookid,bookname, name, publisher,price)
as select book.bookid,book.bookname,customer.name,book.publisher,book.price
from book, customer,orders
where customer.custid = Orders.custid and book.bookid = Orders.bookid;
select * from highorders where price >= 20000;

create index ix_book on book (bookname);
create index ix_book2 on book (publisher,price);
DESC book;
show index from book;
/*----------------------저번시간---------------------*/
create table mybook(
	bookid int(10),
    price int(100),
    primary key(bookid)
);

insert into mybook values(1,10000);
insert into mybook values(2,20000);
insert into mybook values(3,null);

select sum(price),avg(price),count(*),count(price) from mybook;
select sum(price),avg(price),count(*) from mybook where bookid >=4;

select * from mybook where price IS NULL;
select * from mybook where price = '';

CREATE TABLE Book (
  bookid      INTEGER PRIMARY KEY,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       INTEGER 
);

CREATE TABLE  Customer (
  custid      INTEGER PRIMARY KEY,  
  name        VARCHAR(40),
  address     VARCHAR(50),
  phone       VARCHAR(20)
);

CREATE TABLE Orders (
  orderid INTEGER PRIMARY KEY,
  custid  INTEGER ,
  bookid  INTEGER ,
  saleprice INTEGER ,
  orderdate DATE,
  FOREIGN KEY (custid) REFERENCES Customer(custid),
  FOREIGN KEY (bookid) REFERENCES Book(bookid)
);

select * from book;
select * from Customer;
select * from Orders;

select name'이름', IFNULL(phone, '연락처없음')'전화번호' from Customer;
set @seq:=0;
select (@seq:=@seq+1)'순번',custid,name,phone
from Customer
where @seq < 2;
set @RNUM:=0;
select *,@RNUM:=@RNUM+1 as ROWNUM
from book,(select @RNUM:=1)R
where RNUM<=5
order by price;

INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

INSERT INTO Orders VALUES (1, 1, 1, 6000, STR_TO_DATE('2014-07-01','%Y-%m-%d')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, STR_TO_DATE('2014-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, STR_TO_DATE('2014-07-03','%Y-%m-%d')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, STR_TO_DATE('2014-07-04','%Y-%m-%d')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, STR_TO_DATE('2014-07-05','%Y-%m-%d'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, STR_TO_DATE('2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, STR_TO_DATE( '2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, STR_TO_DATE('2014-07-08','%Y-%m-%d')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, STR_TO_DATE('2014-07-09','%Y-%m-%d')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, STR_TO_DATE('2014-07-10','%Y-%m-%d'));

select custid, (select name from customer cs where cs.custid = od.custid), sum(saleprice)
from orders od
group by custid;

select (select name from customer cs where cs.custid = od.custid)'name',sum(saleprice)'total'
from orders od
group by od.custid;
