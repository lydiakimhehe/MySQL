use sqldb;
-- drop procedure if exists userproc;

-- <procedure> --

-- 매개변수a
-- in 입력매개변수이름 데이터타입
-- call 프로시저이름(전달값)
-- out 출력매개변수이름 데이터 타입  
DELIMITER $$ 
CREATE PROCEDURE userProc1(IN userName VARCHAR(10)) 
BEGIN 
  SELECT * FROM userTbl WHERE name = userName;  
END $$ 
DELIMITER ; 

call userproc1('조관우');


drop procedure if exists userpro2;

DELIMITER $$ 
CREATE PROCEDURE userProc2( 
    IN userBirth INT,  
    IN userHeight INT 
) 
BEGIN 
  SELECT * FROM userTbl  
    WHERE birthYear > userBirth AND height > userHeight; 
END $$ 
DELIMITER ; 

 call userproc2(1970,178);
 
 
 drop procedure if exists userproc3;
 
 delimiter $$
 create procedure userproc3(
 in txtvalue char(10),
 out outvalue int)
 begin
	insert into testtbl values(NUll, txtvalue);
    select max(id) into outvalue from testtbl;
end $$
delimiter ;

create table if not exists testtbl( -- procedure를 호출하기 전에 table을 만들어준다. 
id int auto_increment primary key,
txt char(10));

call userproc3('텍스트값', @myvalue);
select concat('현재 입력된 id 값', @myvalue);

select * from testtbl;

-- procedure 안의 in, out의 차이
-- in 값을 안에서 입력해주기 위해서 
-- out return값을 입력해준다. 



drop procedure if exists ifelseproc;

delimiter $$
create procedure ifelseproc(
in username varchar(10))
begin 
	declare byear int; -- 변수 선언
    select birthyear into byear from usertbl
		where name=username; -- usetbl에서 username 인것의 birthyear를 byear 변수에 넣는다.
	if (byear>=1980) then
		select '아직 젊군요';
	else 
		select '나이가 지긋하네요';
	end if;
end $$
delimiter ;

call ifelseproc('조용필');



drop procedure if exists caseproc;
delimiter $$
create procedure caseproc(
in username varchar(10))
begin
	declare byear int;
    declare tti char(8); -- 띠
    select birthyear into byear from usertbl where name=username;
case
	when (byear%12=0) then set tti='원숭이';
    when (byear%12 =1) then set tti='닭';
     WHEN ( bYear%12 = 2) THEN    SET tti = '개'; 
        WHEN ( bYear%12 = 3) THEN    SET tti = '돼지'; 
        WHEN ( bYear%12 = 4) THEN    SET tti = '쥐'; 
        WHEN ( bYear%12 = 5) THEN    SET tti = '소'; 
        WHEN ( bYear%12 = 6) THEN    SET tti = '호랑이'; 
        WHEN ( bYear%12 = 7) THEN    SET tti = '토끼'; 
        WHEN ( bYear%12 = 8) THEN    SET tti = '용'; 
        WHEN ( bYear%12 = 9) THEN    SET tti = '뱀'; 
        WHEN ( bYear%12 = 10) THEN    SET tti = '말'; 
        else set tti='양';
	end case;
    select concat(username, '의띠==>',tti);
end $$
delimiter ;
call caseproc('김범수');



/* procedure 특징 
1. mysql성능 향상 
2. 유지관리 편리 
3. 모듈식 프로그래밍 
4. 보안을 강화  */



-- <stored function> -- 
-- 사용자가 만든 함수

use sqldb;
drop function if exists userfunc;


delimiter $$
create function userfunc(value1 int, value2 int) -- in out등 없이 모두 입력 파라미터
returns int -- 리턴의 데이터 형식
begin 
return value1 +value1; -- 하나의 리터문, 프로시저는 out 파라티머를 사용한다. 바로 return 함수를 이용해준다.
end $$
delimiter ;

select userfunc(100,200); -- function를 불러오기 위해서는 call 이 아닌 select로 바로 실행



use sqldb;
drop function if exists getagefunc;

delimiter //
create function getagefunc(byear int)
returns int
begin
	declare age int;
    set age = year(curdate()) -byear;
    return age;
end //
delimiter ;

select getagefunc(1979);




-- <trigger> --
-- 테이블에서 삽입, 수정, 삭제 등의 작업이 발행할 경우 자동으로 작동되는 객체
-- 데이터의 무결성 확보
-- 트리거가 부착된 테이블에 이벤트가 발생하면 자동으로 부착된 트리거가 발동

/*트리거는 다음과 같은 속성을 갖습니다.

BEFORE or AFTER : 트리거가 실행되는 시기를 지정합니다.

INSTEAD OF : 트리거를 원래 문장 대신 수행합니다.

WHEN : 트리거를 시작하는 조건식을 지정합니다*/


/*1: DELIMITER

2: CREATE TRIGGER (트리거이름)


3: AFTER INSERT ON (테이블이름)

4: FOR EACH ROW -- 행 트리거


5: BEGIN -- 트리거 내용

6: END -- 트리거 끝남

7: DELIMITER*/

drop database testdb; 
CREATE DATABASE IF NOT EXISTS testDB; 
USE testDB; 
CREATE TABLE IF NOT EXISTS testTbl (id INT, txt VARCHAR(10)); 
INSERT INTO testTbl VALUES(1, '이엑스아이디'); 
INSERT INTO testTbl VALUES(2, '애프터스쿨'); 
INSERT INTO testTbl VALUES(3, '에이오에이'); 

select * from testtbl;

drop trigger if exists testtrg;
delimiter //
create trigger testtrg -- 트리거 이름
after delete -- 삭제후에 작동하도록 지정 -> table 에서 delete가 발생하면 
on testtbl -- 트리거를 부착할 테이블 이름
for each row -- 각행마다 적용시킴 
begin
set @msg='가수 그룹이 삭제됨'; -- 트리거 실행시 작동되는  코드들 
end //
delimiter ;

set @msg='';
insert into testtbl values(4,'나인뮤지스');
DELETE FROM testTbl WHERE id = 4; 
select @msg;

-- after trigger - insert, update, delete 등의 작업이 일어났을 때 작동하는 트리거 
-- before trigger - 작업이 일어나기 전에 발생하는 트리거 
 
-- 회원테이블에 update나 insert를 시도하면, 수정 또는 삭제된 데이터를 별도의 테이블에 보관 하고 변경된 
-- 일자와 변경한 사람을 기록한다, 즉 기록을 남겨놓기 위한 것 







