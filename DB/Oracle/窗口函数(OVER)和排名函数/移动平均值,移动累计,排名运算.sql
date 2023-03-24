Over子句与窗口函数可以非常方便地累计总数,移动平均值,移动累计,以及执行其它计算



--创建测试表
CREATE TABLE sales
(
  SalesId INT ,
  SalseYear INT ,
  SalseQty number(18 , 2)
)

--插入测试数据
INSERT  INTO sales
        (
          SalesId ,
          SalseYear ,
          SalseQty
        )
        SELECT  1 ,
                2010 ,
                10 from dual
        UNION ALL
        SELECT  2 ,
                2010 ,
                20  from dual
        UNION ALL
        SELECT  3 ,
                2010 ,
                60  from dual
        UNION ALL
        SELECT  1 ,
                2011 ,
                20  from dual
        UNION ALL
        SELECT  2 ,
                2011 ,
                40  from dual
        UNION ALL
        SELECT  1 ,
                2012 ,
                3  from dual;
				
        commit;

--查看数据
SELECT * FROM sales


SELECT  SalesId ,
        SalseYear ,
        SalseQty ,
		-- 每个业务员按年移动平均
        AVG(SalseQty) OVER ( PARTITION BY SalesId ORDER BY SalseYear ) AS MovingAvg ,
		-- 每个业务员平均
        AVG(SalseQty) OVER ( PARTITION BY SalesId ) AS Avg ,
		-- 每个业务员按年移动累计
        SUM(SalseQty) OVER ( PARTITION BY SalesId ORDER BY SalseYear ) AS MovingTotal ,
		-- 每个业务员累计
        SUM(SalseQty) OVER ( PARTITION BY SalesId ) AS Total ,
		-- 每年业绩排名
        DENSE_RANK() OVER ( PARTITION BY SalseYear ORDER BY SalseQty DESC ) AS YearRow ,
		-- 总业绩排名(DENSE_RANK会有并列)
        DENSE_RANK() OVER ( ORDER BY SalseQty DESC ) AS AllRow
FROM    sales
ORDER BY SalesId ,
        SalseYear


SalesId	SalseYear	SalseQty	MovingAvg	Avg	        MovingTotal	Total	YearRow	AllRow
1	    2010	    10.00	    10.000000	11.000000	10.00	    33.00	3	    4
1	    2011	    20.00	    15.000000	11.000000	30.00	    33.00	2	    3
1	    2012	    3.00	    11.000000	11.000000	33.00	    33.00	1	    5
2	    2010	    20.00	    20.000000	30.000000	20.00	    60.00	2	    3
2	    2011	    40.00	    30.000000	30.000000	60.00	    60.00	1	    2
3	    2010	    60.00	    60.000000	60.000000	60.00	    60.00	1	    1


--每年最高销售数量的记录
SELECT  *
FROM    (
          SELECT  SalesId ,
                  SalseYear ,
                  SalseQty ,
                  DENSE_RANK() OVER ( PARTITION BY SalseYear ORDER BY SalseQty DESC ) AS PaiMing
          FROM    sales
        )  tem
WHERE   PaiMing = 1   --取出排名第1的就是最高的
ORDER BY SalseYear ASC   


