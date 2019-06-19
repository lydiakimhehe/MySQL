use sqldb;
CREATE TABLE CARD_TRAN_201311
(
	CMF CHAR(4) PRIMARY KEY NOT NULL,
	PARTY_NM CHAR(10) NOT NULL,
	SEG CHAR(10) NOT NULL,
	PIF_AMT DECIMAL(15,0),
	INST_AMT DECIMAL(15,0),
	OVRS_AMT DECIMAL(15,0),
	CASH_AMT DECIMAL(15,0)
);

INSERT INTO CARD_TRAN_201311 VALUES ('2356', '김아름', 'PB', 1234041, null , 1301710,null );
INSERT INTO CARD_TRAN_201311 VALUES ('4570', '이선우', 'MASS', null, null , 524560,null );
INSERT INTO CARD_TRAN_201311 VALUES ('4563', '홍지은', 'MASS', 213570, null,null , 3700000);
INSERT INTO CARD_TRAN_201311 VALUES ('3266', '윤일상', 'MASS', 89641, null, null,null );
INSERT INTO CARD_TRAN_201311 VALUES ('8904', '이동건', 'PB', 1278960, 500000, null, null);
INSERT INTO CARD_TRAN_201311 VALUES ('4678', '최혜연', 'MASS', 4567780,null , null, null);
INSERT INTO CARD_TRAN_201311 VALUES ('1746', '임하영', 'PB', 7836100, 3213400,null ,null );
INSERT INTO CARD_TRAN_201311 VALUES ('3120', '김지철', 'PB',null ,null ,null ,null );
INSERT INTO CARD_TRAN_201311 VALUES ('8974', '강성범', 'MASS', 655456,null ,null ,null );
INSERT INTO CARD_TRAN_201311 VALUES ('3255', '김지연', 'MASS', 213,null ,null ,null );
INSERT INTO CARD_TRAN_201311 VALUES ('8977', '김지현', 'PB', 1300,null , 54000, 100000);


/* cmf - 고객번호, party_nm - 이름, seg - 고객등급, pif_amt - 일시불, inst_amt - 할부사용금액,
ovrs_amt - 해외사용금액, cash_amt - 현금서비스
*/

-- coalesce함수 사용
select coalesce(ovrs_amt, 0) from card_tran_201311 where PARTY_NM = '임하영';

-- 1. cmf, 이름, 총 사용금액을 총 사용금액 기준 내림차순으로 출력하시오
select cmf, party_nm, (coalesce(pif_amt, 0)+coalesce(inst_amt, 0)+coalesce(ovrs_amt, 0)+ coalesce(cash_amt, 0)) as 총사용금액  from CARD_TRAN_201311 order by 총사용금액 desc;

-- 2. 신규 무이자 할부 카드의 홍보대상 고객을 추출하시오
select party_nm from card_tran_201311 where INST_AMT is not null;

-- 3. pb고객을 대상으로 일시불사용금액의 1%를 캐시백해주는 캠페인을 진행하면 누가 얼마의 금액을 받을 것인가
select PARTY_NM, PIF_AMT*0.01 as cash_bag from card_tran_201311 where seg= 'pb' order by cash_bag desc; 


-- 4. 고객 등급별 총사용 금액을 추출하고 총사용금액 기준 내림차순 정렬
select sum((coalesce(pif_amt, 0)+coalesce(inst_amt, 0)+coalesce(ovrs_amt, 0)+coalesce(cash_amt, 0))) as 총사용금액, seg from card_tran_201311 group by seg order by 총사용금액 desc;

-- 고객들로 나누었기 때문에 다시 sum 을 해서 더해줘야한다. 

-- 5. 사용금액이 가장 많은 서비스는
select sum(pif_amt), sum(inst_amt), sum(ovrs_amt), sum(cash_amt) from card_tran_201311;

-- 6. 사용횟수가 가장 많은 서비스는
select count(pif_amt), count(inst_amt), count(ovrs_amt), count(cash_amt) from card_tran_201311;

-- 7. pb 고객이 가장 많이 사용한 서비스는
select sum(pif_amt), sum(inst_amt), sum(ovrs_amt), sum(cash_amt) from card_tran_201311 where seg='pb';




