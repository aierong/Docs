
 

Transact-SQL提供了4个排名函数: RANK(),DENSE_RANK(),ROW_NUMBER(),NTILE()

下面是对这4个函数的解释：
RANK() 
返回结果集的分区内每行的排名。行的排名是相关行之前的排名数加一。
如果两个或多个行与一个排名关联，则每个关联行将得到相同的排名。
例如，如果两位销售员具有相同的SalesYTD值，则他们将并列第一。由于已有两行排名在前，所以具有下一个最大SalesYTD的销售人员将排名第三。
因此，RANK 函数并不总返回连续整数。


DENSE_RANK()
返回结果集分区中行的排名，在排名中没有任何间断。行的排名等于所讨论行之前的所有排名数加一。
如果有两个或多个行受同一个分区中排名的约束，则每个约束行将接收相同的排名。
例如，如果两位顶尖销售员具有相同的 SalesYTD 值，则他们将并列第一。接下来 SalesYTD 最高的销售人员排名第二。该排名等于该行之前的所有行数加一。
因此，DENSE_RANK 函数返回的数字没有间断，并且始终具有连续的排名。 


ROW_NUMBER()
回结果集分区内行的序列号，每个分区的第一行从 1 开始。
ORDER BY 子句可确定在特定分区中为行分配唯一 ROW_NUMBER 的顺序。


NTILE()
将有序分区中的行分发到指定数目的组中。各个组有编号，编号从一开始。对于每一个行，NTILE 将返回此行所属的组的编号。
如果分区的行数不能被 integer_expression 整除，则将导致一个成员有两种大小不同的组。按照 OVER 子句指定的顺序，较大的组排在较小的组前面。
例如，如果总行数是 53，组数是 5，则前三个组每组包含 11 行，其余两个组每组包含 10 行。
另一方面，如果总行数可被组数整除，则行数将在组之间平均分布。
例如，如果总行数为 50，有五个组，则每组将包含 10 行。



--演示例题，建一个table
create table rankorder(
orderid int,
qty int
)
go
--插入数据
insert rankorder values(30,10)
insert rankorder values(10,10)
insert rankorder values(80,10)
insert rankorder values(40,10)
insert rankorder values(30,15)
insert rankorder values(30,20)
insert rankorder values(22,20)
insert rankorder values(21,20)
insert rankorder values(10,30)
insert rankorder values(30,30)
insert rankorder values(40,40)
go
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
--NTILE()是按qty由小到大分成3组逐一排名，并列，排名连续
orderid	qty	rownumber	rank	denserank	NTILE
30	    10	1	        1	    1	        1
10	    10	2	        1	    1	        1
80	    10	3	        1	    1	        1
40	    10	4	        1	    1	        1
30	    15	5	        5	    2	        2
30	    20	6	        6	    3	        2
22	    20	7	        6	    3	        2
21	    20	8	        6	    3	        2
10	    30	9	        9	    4	        3
30	    30	10	        9	    4	        3
40	    40	11	        11	    5	        3

sql 2005实现排名非常方便，但是用sql 2000实现排名就比较麻烦，下面是sql 2000的实现代码:

--RANK在sql 2000中的实现
select orderid,qty,
	(select count(1)+1 from rankorder where qty<r.qty) as [rank]
from rankorder r
ORDER BY qty
go
 
--ROW_NUMBER在sql 2000中的实现
--利用临时表和IDENTITY（函数）
select identity(int,1,1) as [ROW_NUMBER],orderid,qty
into #tem             
from rankorder

select orderid,qty,[ROW_NUMBER]
from #tem

drop table #tem
go

--DENSE_RANK在sql 2000中的实现
select identity(int,1,1) as ids,  qty
into #t
from rankorder
group by qty
order by qty

select r.orderid,r.qty,t.ids as [DENSE_RANK]
from rankorder r join #t  t
on r.qty=t.qty

drop table #t
go

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
以下是我对4个排名函数的类比表格：

                排名连续性   排名并列性
RANK()          不一定连续   有并列
DENSE_RANK()    连续         有并列
ROW_NUMBER()    连续         无并列 
NTILE()         连续         有并列




