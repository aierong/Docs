  
--Over�Ӿ��봰�ں������Էǳ�������ۼ�����,�ƶ�ƽ��ֵ,�ƶ��ۼ�,�Լ�ִ����������
--Sql Server2012�汾��֧�ִ˹���(Sql2005,2008����)


--�������Ա�
CREATE TABLE #sales
(
  SalesId INT ,
  SalseYear INT ,
  SalseQty DECIMAL(18 , 2)
)
--�����������
INSERT  INTO #sales
        (
          SalesId ,
          SalseYear ,
          SalseQty
        )
        SELECT  1 ,
                2010 ,
                10
        UNION ALL
        SELECT  2 ,
                2010 ,
                20
        UNION ALL
        SELECT  3 ,
                2010 ,
                60
        UNION ALL
        SELECT  1 ,
                2011 ,
                20
        UNION ALL
        SELECT  2 ,
                2011 ,
                40
        UNION ALL
        SELECT  1 ,
                2012 ,
                3

--�鿴����
SELECT * FROM #sales


SELECT  SalesId ,
        SalseYear ,
        SalseQty ,
		-- ÿ��ҵ��Ա�����ƶ�ƽ��
        AVG(SalseQty) OVER ( PARTITION BY SalesId ORDER BY SalseYear ) AS MovingAvg ,
		-- ÿ��ҵ��Աƽ��
        AVG(SalseQty) OVER ( PARTITION BY SalesId ) AS [Avg] ,
		-- ÿ��ҵ��Ա�����ƶ��ۼ�
        SUM(SalseQty) OVER ( PARTITION BY SalesId ORDER BY SalseYear ) AS MovingTotal ,
		-- ÿ��ҵ��Ա�ۼ�
        SUM(SalseQty) OVER ( PARTITION BY SalesId ) AS Total ,
		-- ÿ��ҵ������
        DENSE_RANK() OVER ( PARTITION BY SalseYear ORDER BY SalseQty DESC ) AS YearRow ,
		-- ��ҵ������(DENSE_RANK���в���)
        DENSE_RANK() OVER ( ORDER BY SalseQty DESC ) AS AllRow
FROM    #sales
ORDER BY SalesId ,
        SalseYear


SalesId	SalseYear	SalseQty	MovingAvg	Avg	        MovingTotal	Total	YearRow	AllRow
1	    2010	    10.00	    10.000000	11.000000	10.00	    33.00	3	    4
1	    2011	    20.00	    15.000000	11.000000	30.00	    33.00	2	    3
1	    2012	    3.00	    11.000000	11.000000	33.00	    33.00	1	    5
2	    2010	    20.00	    20.000000	30.000000	20.00	    60.00	2	    3
2	    2011	    40.00	    30.000000	30.000000	60.00	    60.00	1	    2
3	    2010	    60.00	    60.000000	60.000000	60.00	    60.00	1	    1


--ÿ��������������ļ�¼
SELECT  *
FROM    (
          SELECT  SalesId ,
                  SalseYear ,
                  SalseQty ,
                  DENSE_RANK() OVER ( PARTITION BY SalseYear ORDER BY SalseQty DESC ) AS PaiMing
          FROM    #sales
        ) AS tem
WHERE   PaiMing = 1   --ȡ��������1�ľ�����ߵ�
ORDER BY SalseYear ASC


