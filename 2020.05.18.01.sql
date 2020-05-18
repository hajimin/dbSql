create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

SELECT *
FROM sales;


SELECT 
     MIN(decode(to_char(dt,'mm'),01, sum(sales)))jan,
     MIN(decode(to_char(dt,'mm'),02, sum(sales)))feb,
     MIN(decode(to_char(dt,'mm'),03, sum(sales),0))mar,
     MIN(decode(to_char(dt,'mm'),04, sum(sales)))apr,
     MIN(decode(to_char(dt,'mm'),05, sum(sales)))may,
     MIN(decode(to_char(dt,'mm'),06, sum(sales)))jun
     FROM sales
group by to_char(dt,'mm');

1. dt안에 있는 월을 따로 뽑아내기 'mm'
SELECT to_char(dt, 'mm')
FROM sales

2. GROUP BY 하기
SELECT to_char(dt, 'mm')
FROM sales
GROUP BY to_char(dt, 'mm')

3. decode 사용
SELECT to_char(dt, 'mm')
     decode(to_char(dt,'mm'),01, 
     decode(to_char(dt,'mm'),02, 
     decode(to_char(dt,'mm'),03, 
     decode(to_char(dt,'mm'),04, 
     decode(to_char(dt,'mm'),05, 
     decode(to_char(dt,'mm'),06 
     FROM sales
group by to_char(dt,'mm');

4. sum 사용
SELECT 
     decode(to_char(dt,'mm'),01, sum(sales)))jan,
     decode(to_char(dt,'mm'),02, sum(sales)))feb,
     decode(to_char(dt,'mm'),03, sum(sales),0))mar,
     decode(to_char(dt,'mm'),04, sum(sales)))apr,
     decode(to_char(dt,'mm'),05, sum(sales)))may,
     decode(to_char(dt,'mm'),06, sum(sales)))jun
     FROM sales
group by to_char(dt,'mm');

4. min 붙이기(null 없애려고)


SELECT 
     MIN(decode(to_char(dt,'mm'),01, sum(sales)))jan,
     MIN(decode(to_char(dt,'mm'),02, sum(sales)))feb,
     MIN(decode(to_char(dt,'mm'),03, sum(sales),0))mar,
     MIN(decode(to_char(dt,'mm'),04, sum(sales)))apr,
     MIN(decode(to_char(dt,'mm'),05, sum(sales)))may,
     MIN(decode(to_char(dt,'mm'),06, sum(sales)))jun
     FROM sales
group by to_char(dt,'mm');



SELECT DECODE(d,1,iw+1,iw),
            MIN(DECODE(d, 1,dt)) sun, MIN(DECODE(d,2,dt)) mon, 
            MIN(DECODE(d,3,dt)) tue, MIN(DECODE(d,4,dt)) wed, 
            MIN(DECODE(d,5,dt)) thu, MIN(DECODE(d,6,dt))fri, 
            MIN(DECODE(d,7,dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
 GROUP BY DECODE(d,1,iw+1,iw) 
 ORDER BY DECODE(d,1,iw+1,iw);
 
 

