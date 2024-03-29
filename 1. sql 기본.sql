SELECT * FROM shopdb.membertbl;

use employees;
-- 주석처리하는 문자는 = -- 
-- 지금 부터 이 데이터베이스를 사용하겠다.
show tables; -- 데이터 베이스에 있는 테이블을 다 보여준다.
select * from dept_manager; -- * = 모든 컬럼을 다 불러온다. 
-- 코드를 칠때 정상적으로 돌아가면 밑에 초록색, 아니면 빨강색

use shopdb;
show tables;
select * from membertbl;
select membername, memberaddress from membertbl;
-- membertbl 테이블에서 membername, memberaddress열 만을 가지고 온다. 

use shopdb;
select * from membertbl;
select * from membertbl where membername='지훈이';
-- 이런식으로 membername 값이 지훈이 인 것을 뽑아 낼 수 있다. 

show databases;-- 모든 데이터 베이스를 다 보여달라 

-- ---------------------------------------------------------
use shopdb;
show tables;
select * from membertbl;
create table test( id int);-- 이 데이터 베이스에 테이블을 만들건데, id 라는 컬럼에, int 속성이야 테이블 이름은 test
show tables;

create table test1(id int, address char);
show tables;

select*from test1;

insert into test values(1); -- test의 테이블에 1 이라는 값을 넣는다. 
select * from test;

insert into test (id) values(1); -- id 칼럼에다가 1을 넣는다. 

insert test1 (id, address) values(3, 's'); -- test1 의 id address 칼럼에 3, s라는 값을 넣는다. 
select * from test1;

use employees;
select * from shopdb.membertbl; -- 다른 데이터 베이스여도  DB.테이블 이름을 넣어주면 불러올 수 있다. 
show tables;

select * from titles;

select first_name, last_name from employees -- employees 테이블에서 first_name, last_name을 가지고 온다.

show databases;
use employees;
show table status; -- 사용하고 있는 데이터 베이스 안에서 테이블 상태를 보여준다. 

describe employees; -- describe 테이블 이름을 넣으면 테이블 구조를 보여준다.
select first_name, gender from employees;
select first_name as 이름, gender 성별 from employees;  -- 이름을 성별로 칼럼이름을 지정해서 가지고 온다.as

drop databases if exists sqldb; -- 데이터 베이스를 없애라 이미 있다라는 조건을 지정을 해 주 었다. 
create database sqldb;
show databases;

use sqldb;
create table usertbl -- 테이블을 만드는데, 괄호 안에가 컬럼, 컬럼 특성을 구성
(userid char(8) not null primary key,
name varchar(10) not null,
birthyear int not null,
 addr char(2) not null,
 mobile1 char(3),
 mobile2 char(8),
 height smallint, -- 자리수를 적게 잡아 먹는 숫자
 mdate date);

 show tables;
 
select * from sqldb.usertbl; --  만들어 진 것을 확인 할 수 있다. 

create table buytbl (
 num int auto_increment not null primary key,
 userid char(8) not null,
 prodname char(6) not null,
 groupname char(4),
 price int not null,
 amount smallint not null,
 foreign key (userid) references usertbl(userid)); -- usertbl 의 userid 를 떼왔다. 

-- auto_increment = 값이 안들어오면 자동으로 넘버링이 되는 기능, 만약 앞에 값이 11인데 다음 값이 안들어오면 자동으로 12로 들어간다
-- primary key = 중복값, null  값이 없는 컬럼 

show tables;

insert into usertbl values ('LSG',  '이승기',  1987,  '서울',  '011',  '1111111',  182,  '2008-8-8');
insert into usertbl values ('KBS',  '김범수',  1979,  '경남',  '011',  '2222222',  173,  '2012-4-4');
insert into usertbl values ('KKH',  '김경호',  1971,  '전남',  '019',  '3333333',  177,  '2007-7-7');
insert into usertbl values ('JYP',  '조용필',  1950,  '경기',  '011',  '4444444',  166,  '2009-4-4');
insert into usertbl values ('SSK',  '성시경',  1979,  '서울',  null,  null,  186,  '2013-12-12');
insert into usertbl values ('LJB',  '임재범',  1963,  '서울',  '016',  '6666666',  182,  '2009-9-9');
insert into usertbl values ('YJS',  '윤종신',  1969,  '경남',  null,  null,  170,  '2005-5-5');
insert into usertbl values ('EJW',  '은지원',  1972,  '경북',  '011',  '8888888',  174,  '2014-3-3');
insert into usertbl values ('JKW',  '조관우',  1965,  '경기',  '018',  '9999999',  172,  '2010-10-10');
insert into usertbl values ('BBK',  '바비킴',  1973,  '서울',  '010',  '0000000',  176,  '2013-5-5');

-- 여기서는 values 앞에 컬럼명을 주지 않았는데 이유는 컬럼명을 안주면 값이 순서대로 들어간다. 

insert into buytbl values (null, 'KBS', '운동화', null, 30, 2);
insert into buytbl values (null, 'KBS', '노트북', '전자', 1000, 1);
insert into buytbl values (null, 'JYP', '모니터', '전자', 200, 1);
insert into buytbl values (null, 'BBK', '모니터', '전자', 200, 5);
insert into buytbl values (null, 'KBS', '청바지', '의류', 50, 3);
insert into buytbl values (null, 'BBK', '메모리', '전자', 80, 10);
insert into buytbl values (null, 'SSK', '책', '서적', 15, 5);
insert into buytbl values (null, 'EJW', '책', '서적', 15, 2);
insert into buytbl values (null, 'EJW', '청바지', '의류', 30, 2);
insert into buytbl values (null, 'BBK', '운동화', null, 30, 2);
insert into buytbl values (null, 'EJW', '책', '서적', 15, 1);
insert into buytbl values (null, 'BBK', '운동화', null, 30, 2);

select * from buytbl