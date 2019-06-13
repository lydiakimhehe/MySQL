create database webdb;
use webdb;
show databases;
show tables;

create table pet(
name varchar(20),
owner varchar(20),
species varchar(20),
sex char(1),
birth date,
death date);

show tables;

insert into pet values ('Fluffy', 'Haroid', 'cat', 'f', '1999-02-04', null);

select * from pet;



load data local infile 'C:/Temp/pet_table.txt' into table pet;


select * from pet where name ='Bowser';

select * from pet where birth >= '1998-01-01';

select * from pet where species = 'dog' and sex ='f';

select * from pet where species = 'snake' or  species ='bird';

select name, birth from pet;

select name, birth from pet order by birth; -- 오름차순 

select name, birth from pet order by birth desc; -- 내림차순 

select name from pet where death is not null; -- 사망한것 

select name from pet where death is null; -- 살아 있는거 

select * from pet where name like 'b%'; -- 이름이 b로 시작하는 데이터 출력

select * from pet where name like'%fy'; -- 이름이  fy 로끝나는 데이터 출력 

select * from pet where name like '%w%'; -- w 포함하고 0 이상으로 나오면 된다. 

select * from pet where name like '_____'; -- 이름이 다섯글자 이상인 것을 찾겠다. 

select * from pet where name regexp '^b'; -- 정규표현식을 적용한 것 -- b 로 시작하는 것 

select * from pet where name regexp 'fy$'; -- 정규 표현식 fy로 끝나는 것 

select count(*) from pet; -- count 사용해서 테이블 전체 데이터 개수를 볼수 있다. 

select * from pet;

update pet set species='dog' where name ='calws'; -- pet 이ㅏ는 테이블을 수정하겠다. 

set sql_safe_updates = 0; -- safe update mode 를 0으로 설정

update pet set species = 'pig' where birth < '1999-01-01';


use sqldb;
select * from usertbl where name='김경호';
select * from usertbl where birthyear >'1970' and height >= 182;
select * from usertbl where birthyear >=1970 and height >= 182;

select * from usertbl where height >= 180 and  height <= 182;

select userid, name from usertbl where height between 180 and 182; -- 180 and 182 사이의 키 값을 가지고 오는데 between 쓰면 된다. 

select * from usertbl;
select name, addr from usertbl where addr='경남' or addr='경북'; 

-- 다른 방식으로도 가능하다 :

select name, addr from usertbl  where addr in('경남','전남','경북'); -- 주소가 여기에 포함되어 있으면 값을 return 한다. 


select name, height from usertbl where name like '김%';
select name, height from usertbl where name regexp '^김';

-- 성인 한글자로 이름이 종신인 사람을 출력하라 
select name, height from usertbl where name like'_종신';

select name, height from usertbl where height >= 177;

select height from usertbl where name='김경호';
select height, name from usertbl where height > (select height from usertbl where name='김경호'); -- 괄호를 찍어야한다. 

-- 주소가 경남인 사람의키보다 큰 사람들 
select height from usertbl where addr='경남';

select height, name from usertbl where height > (select height from usertbl where addr='경남');

select height, name from usertbl where height > all(select height from usertbl where addr='경남'); -- 둘중에 큰거보다 크면 다큰거 
select height, name from usertbl where height > any(select height from usertbl where addr='경남'); --  그냥 any 조건 

-- 경남에 거주하는 사람의 키와 동일한 사람들(키, 이름) 
select height, name from usertbl where height = any(select height from usertbl where addr='경남');

-- 이름과 가입일자를 출력 / 가입일자 기준 오름차순 정령 

select * from usertbl;

select name, mdate from usertbl order by mdate; -- 오름
select name, mdate from usertbl order by mdate desc; -- 내림

-- 이름과 키를 뽑는데 키는 내림차순 이름은 오름 차순 

select name, height from usertbl order by name asc, height desc;


-- 주소가 중복되지 않는 유니크한 데이터 
select distinct  addr from usertbl;
-- distinct 중복된 값 빼고 모든 값 한번씩 뽑는거 unique 한것만 

/*
-- employees db에서 employees table 의 emp_no.
-- hire_date 를 출력하되 hire_date을 오름차순으로 */


use employees;
select emp_no, hire_date from employees order by hire_date asc;

select * from employees;

-- 입사시기가 가장 오래된 5명, emp_no, hire_date
select emp_no, hire_date from employees order by hire_date asc limit 5;

select emp_no, hire_date from employees order by hire_date asc limit 10,10; -- 10번째 부터 그다음 10번째를 뽑아라 


-- buytbl 1을 복사ㅐ서 buytbl2 를 만들 예정
use sqldb;
create table buytbl2 (select * from buytbl);
select * from buytbl2;

create table buytbl3 (select userid, prodname from buytbl);
select * from buytbl3;

select * from usertbl;


-- groupby

select userid, sum(amount) from buytbl group by userid; -- userid 기준으로 userid and sum(amount)을 출력 

select userid as 아이디, sum(amount) as 총구매개수  from buytbl group by userid; 

select userid 아이디, avg(amount) 평균개수 from buytbl group by userid;

select * from buytbl;

select userid 아이디 , sum(amount *price) 총구매금액 from buytbl group by userid;

select userid 아이디 , sum(amount *price) 총구매금액 from buytbl group by userid order by 총구매금액; -- as 로 해준 것도 먹힌다. 

select max(height), min(height) from usertbl; -- 최대 최소 키를 출력


-- 키가 최대 최소에 해당하는 키와 이름을 불력하라
select name, height from usertbl where height= (select max(height) from usertbl) or height = (select min(height) from usertbl);

select name, height from usertbl where height in ((select max(height) from usertbl), (select min(height) from usertbl));


select count(*) from usertbl;

select * from usertbl;

select count(*) from usertbl where mobile1 is not null; -- where 조건문은 안에 말고 밖에다 써주자 

select count(*) as 전화번호등록자수 from usertbl where mobile1 is not null;

select count(mobile1) as 전화등록자수 from usertbl; -- null 값 제외하고 계산해준다. 

-- id 별 총금액을 뽑고 
-- id 별 총금액이 1000 이상인 것만 뽑기 
select sum(amount*price) as tm  from buytbl group by userid;

select sum(amount*price) as tm  from buytbl group by userid having tm>1000; 

-- group by 시에는 조건은 where가 안된다.
-- 그래서 group by 일경우에는 having 이라고 해야한다. 

select sum(amount*price) as tm  from buytbl group by userid having tm>1000 order by tm; -- tm을 오름차순으로 


-- table 조작 
-- testtbl1 만들고 id (int), username(char(3)), age(int)

use sqldb;
create table testtbl1(
id int,
username char(3),
age int);


insert into testtbl1 values(1, '홍길동', 25);
insert into testtbl1 (id, username) values(2, '설현'); -- 원래 null 하면 되는데 그거 없이 그냥 비워서 내려면 앞에 column 명 지정 

insert into testtbl1 (username, age, id)  values('초아', 26, 3);

 select * from testtbl1; -- 다 정상적으로 들어간 것을 확인 할 수 있다. 
 
 -- auto_increment 
 
 create table testtbl2(
 id int auto_increment primary key,
 username char(3),
 age int);
 
 insert into testtbl2 values(null, '지민', 25);
 insert into testtbl2 values(null, '유나', 22);
 insert into testtbl2 values(null, '유경', 21);
 
 select * from testtbl2;
 -- id 가 auto_increment 에 의해 자동적으로 순차적으로 들어간다. 
 
 
 
 -- x테이블 대량생상 
 use sqldb;
 create table testtbl5(
 select emp_no, first_name, last_name from employees.employees);
 -- sqldb를 사용하지만, 
 -- employees db 에서 empluyees 테이블을 가지고 와서 만든다. 
 
 create table testtbl4(
 id int,
 fname varchar(50),
 lname varchar(50));
 
 insert into testtbl4 select emp_no, first_name, last_name from employees.employees;
 --  employees db 에서 empluyees 테이블의 내용을 가지고온다. 



-- 데이터 수정 

select * from testtbl4;

select * from testtbl4 where fname='Parto';

update testtbl4 set lname ='없음' where fname='Parto'; -- testtbl4에서 parto 라는 사람의 lname을  없음으로 바꾼다

select * from testtbl4;