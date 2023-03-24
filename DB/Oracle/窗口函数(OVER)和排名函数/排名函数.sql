oracle提供了3个排名函数: RANK(),DENSE_RANK(),row_number() 

下面是对这3个函数的解释：
ROW_NUMBER()
回结果集分区内行的序列号，每个分区的第一行从1开始。
是没有重复值的排序(即使两条记录相等也是不重复的)，可以利用它来实现分页 

RANK() 
是跳跃排序，两个第二名下来就是第四名。

DENSE_RANK()
是连续排序，两个第二名仍然跟着第三名    

  




--演示例题，建一个table
create table rankorder(
orderid int,
qty int
)
 
--插入数据
insert into rankorder values(30,10)
insert into rankorder values(10,10)
insert into rankorder values(80,10)
insert into rankorder values(40,10)
insert into rankorder values(30,15)
insert into rankorder values(30,20)
insert into rankorder values(22,20)
insert into rankorder values(21,20)
insert into rankorder values(10,30)
insert into rankorder values(30,30)
insert into rankorder values(40,40)
 
--查询出各类排名
SELECT orderid,qty,
  ROW_NUMBER() OVER(ORDER BY qty) AS rownumber,
  RANK()       OVER(ORDER BY qty) AS [rank],
  DENSE_RANK() OVER(ORDER BY qty) AS denserank ,
  NTILE(3) OVER(ORDER BY qty) AS [NTILE]
FROM rankorder
ORDER BY qty

--结果
--ROW_NUMBER()是按qty由小到大逐一排名，不并列，排名连续
--RANK()是按qty由小到大逐一排名，并列，排名不连续
--DENSE_RANK()是按qty由小到大逐一排名，并列，排名连续
orderid	qty	rownumber	rank	denserank	 
30	    10	1	        1	    1	        
10	    10	2	        1	    1	        
80	    10	3	        1	    1	        
40	    10	4	        1	    1	        
30	    15	5	        5	    2	        
30	    20	6	        6	    3	        
22	    20	7	        6	    3	        
21	    20	8	        6	    3	        
10	    30	9	        9	    4	        
30	    30	10	        9	    4	        
40	    40	11	        11	    5	        

 

排名函数是与窗口函数OVER()配合一起使用的。
如果借助OVER子句的参数PARTITION BY,就可以将结果集分为多个分区。排名函数将在每个分区内进行排名.

--例题
SELECT orderid,qty,
DENSE_RANK() OVER(ORDER BY qty) AS a ,
DENSE_RANK() OVER(PARTITION BY orderid ORDER BY qty) AS b 	
FROM rankorder
ORDER BY qty

--说明：
--a列是在全部记录上进行的排名
--b列是把orderid中的记录分成了10,21,22,30,40,80这6个区，再在每个区上进行的排名。
orderid	qty	a	b
10	    10	1	1
30	    10	1	1
40	    10	1	1
80	    10	1	1
30	    15	2	2
30	    20	3	3
21	    20	3	1
22	    20	3	1
10	    30	4	2
30	    30	4	4
40	    40	5	2

我们看到排名函数可以很简便的得到各种类型的排名
以下是我对3个排名函数的类比表格：

                排名连续性   排名并列性
RANK()          不一定连续   有并列
DENSE_RANK()    连续         有并列
ROW_NUMBER()    连续         无并列 
 

