
create database company;

use company;



CREATE TABLE CUST_INFO

(

	RESIDENCE_ID CHAR(13) PRIMARY KEY NOT NULL,

	FIRST_NM CHAR(10) NOT NULL,
    sex int,

	LAST_NM CHAR(10) NOT NULL,

	ANNL_PERF DECIMAL(15,2)

);



INSERT INTO CUST_INFO VALUES ('8301111999999', 'JIHUN', 0,'KIM', 330.08);

INSERT INTO CUST_INFO VALUES ('7012012888888', 'JINYOUNG',1, 'LEE', 857.61);

INSERT INTO CUST_INFO VALUES ('6705302777666', 'MIJA',1, 'HAN', -76.77);

INSERT INTO CUST_INFO VALUES ('8411011555666', 'YOUNGJUN',0, 'HA', 468.54);

INSERT INTO CUST_INFO VALUES ('7710092666777', 'DAYOUNG',1, 'SUNG', -890);

INSERT INTO CUST_INFO VALUES ('7911022444555', 'HYEJIN',1, 'SEO', 47.44);



select * from cust_info;



/* 

1.남성은 1로 여성은 2로 출력하시어

2. 이메일을 보내기 위해 성과 이름을 결합하시오

3. 고객의 수익을 소수점 첫 째자리에서 반올림하시오. */

select (case when sex=0  then 'm' else 'f' end) as sex from cust_info;
select concat(last_nm, '', first_nm) from cust_info;
select round(annl_perf,-1) from cust_info; -- turncate 랑 비슷함 
select format(annl_perf,0) from cust_info; -- 한단계 전에서 반올림한다. ??

 




create table vendor_info(

id int,

name char(10),

country char(20));





insert into vendor_info values 

(1, 'sue', 'germany'),

(2, 'david', 'switzerland'),

(3, 'sam', 'france'),

(4, 'jihoon', 'brazil'),

(5, 'sunwoo', 'france'),

(6, 'berney', 'italy'),

(7, 'sandy', 'germany'),

(8, 'young', 'korea') ;



/*

1. 이름을 소문자로 변환해서 출력하시오

2. 이름을 대문자로 변환해서 출력하시오

3. 이름의 길이를 name_len라는 별칭으로 출력하시오

4. 이름의 두 번째에서 네 번째 글자를 출력하고 name_str이라는 별칭으로 출력하시오

*/

select * from vendor_info;
select lower(name) from vendor_info;
select upper(name) from vendor_info;
select length(name) as name_len from vendor_info;
select substr(name,2,3) from vendor_info;
select mid(name,2,4) from vendor_info;







create table clerk (

id int,

staff_nm char(5),

def_nm char(10),

gender char(2),

birth_dt date,

emp_flag char(2) );



insert into clerk values 

(135, '이민성', '마케팅부', 'm', '1984-02-11', 'y'),

(142, '김선명', '영업지원부', 'm', '1971-12-08', 'y'),

(121, '신지원', '리스크부', 'f', '1978-05-28','y'),

(334, '고현정', '전략기획부', 'f', '1965-01-12', 'y'),

(144, '이기동', '마케팅분석부', 'm', '1981-03-03', 'y'),

(703, '송지희', '검사부', 'f', '1985-05-14', 'f'),

(732, '연승환', '기업영업지원부', 'm', '1990-01-26', 'y'),

(911, '이명준', '여의도지점', 'm', '1988-06-11', 'n');



/*

1. 직원의 생일을 기준으로 내림차순으로 정렬하시오

2. 직원의 나이를 구하시오

3. 직원의 생일에 1달을 더한 날짜를 구하시오

4. 남성의 평균 나이와 여성의 평균 나이를 구하시오

5. 평균 연령이 가장 낮은 부서는 어디인가 */

select * from clerk;
select * from clerk order by birth_dt desc;
select staff_nm, floor(datediff(now(), birth_dt)/365) as age from clerk order by age; -- ?  2번 문제 인데 값이 안들어감 , floor 내림하는 것 
select staff_nm, (year(now())- year(birth_dt)) as age from clerk order by age;
select staff_nm, birth_dt, adddate(birth_dt, 30) from clerk;
select gender, avg(round(datediff(now(), birth_dt)/365)) as age from clerk order by gender;
select def_nm, avg(round(datediff(now(), birth_dt)/365)) as age from clerk order by def_nm;


select * from cust_info;

/* 

1. 고객이 남성이면 1, 여성이면 2를 출력하시오.

2. 남성의 평균 수익과 여성의 평균 수익을 구하시오

3. 수익이 가장 높은 고객의 이름을 출력하시오

*/




