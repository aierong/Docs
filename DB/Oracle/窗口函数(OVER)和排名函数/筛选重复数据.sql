
--先建立一个测试表
CREATE TABLE sales
(
  SalesId INT ,
  SalseName VARCHAR2(100) ,
  dates VARCHAR2(100)
)


--插入数据
INSERT  INTO sales
        (
          SalesId ,
          SalseName ,
          dates
        )
SELECT  1 ,
        'test1' ,
        '2015-01-01' from dual
UNION ALL
SELECT  1 ,
        'test1' ,
        '2015-01-05' from dual
UNION ALL
SELECT  2 ,
        'test2' ,
        '2015-01-01' from dual
UNION ALL
SELECT  3 ,
        'test3' ,
        '2015-01-01' from dual
UNION ALL
SELECT  4 ,
        'test4' ,
        '2015-01-01' from dual
UNION ALL
SELECT  4 ,
        'test4' ,
        '2015-01-03' from dual
UNION ALL
SELECT  5 ,
        'test5' ,
        '2015-01-13' from dual
        UNION ALL
SELECT  5 ,
        'test5' ,
        '2015-01-01' from dual;

commit;
 
 
 

--查看一下数据        
SELECT  *
FROM    sales;
/* 结果:
SalesId  SalseName     dates 
1        'test1'       '2015-01-01'
1        'test1'       '2015-01-02'
2        'test2'       '2015-01-01'
3        'test3'       '2015-01-01'
4        'test4'       '2015-01-01'
4        'test4'       '2015-01-03'
5        'test5'       '2015-01-13'
5        'test5'       '2015-01-01'
*/

--利用排名函数找出重复数据
SELECT  *
FROM    (
          SELECT    SalesId ,
                    SalseName ,
                    dates ,
                    ROW_NUMBER() OVER ( PARTITION BY SalesId ORDER BY dates ) AS PaiMing
          FROM      sales
        )  tem
WHERE   tem.PaiMing > 1;

/* 结果:
SalesId	SalseName	dates		PaiMing
1	    test1		2015-01-05	2
4	    test4		2015-01-03	2
5	    test5		2015-01-13	2
*/

--利用GROUP BY找出重复数据
SELECT  SalesId ,
        MAX(dates) AS dates
FROM    sales
GROUP BY SalesId
HAVING  COUNT(SalesId) > 1;

/* 结果:
SalesId	dates
1		2015-01-05
4		2015-01-03
5		2015-01-13
*/


