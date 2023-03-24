窗口函数(OVER)

1.简介： 
窗口函数帮助你迅速查看不同级别的聚合，通过它可以非常方便地累计总数、移动平均值、以及执行其它计算。
窗口函数功能非常强大，使用起来也十分容易。可以使用这个技巧立即得到大量统计值。
窗口是用户指定的一组行。 开窗函数计算从窗口派生的结果集中各行的值。

2.适用范围：
排名开窗函数和聚合开窗函数.
也就是说窗口函数是结合排名开窗函数或者聚合开窗函数一起使用
OVER子句前面必须是排名函数或者是聚合函数


3.例题：

--建立订单表
create table SalesOrder(
OrderID int,            --订单id
OrderQty number(18,2)  --数量
)
 

--插入数据
insert into SalesOrder
select 1,2.0 from dual
union all
select 1,1.0 from dual
union all
select 1,3.0 from dual
union all
select 2,6.0 from dual
union all
select 2,1.1 from dual
union all
select 3,8.0 from dual
union all
select 3,1.1 from dual
union all
select 3,7.0 from dual;
commit;

--查询得如下结果
select * from SalesOrder
 

OrderID     OrderQty
----------- ------------
1           2.00
1           1.00
1           3.00
2           6.00
2           1.10
3           8.00
3           1.10
3           7.00

现要求显示汇总总数，每当所占比例，分组汇总数，每单在各组所占比例，要求格式如下：

OrderID	OrderQty	汇总	每单比例	    分组汇总	每单在各组比例
1	    2.00	    29.20	0.0685	        6.00	    0.3333
1	    1.00	    29.20	0.0342	        6.00	    0.1667
1	    3.00	    29.20	0.1027	        6.00	    0.5000
2	    6.00	    29.20	0.2055	        7.10	    0.8451
2	    1.10	    29.20	0.0377	        7.10	    0.1549
3	    8.00	    29.20	0.2740	        16.10	    0.4969
3	    1.10	    29.20	0.0377	        16.10	    0.0683
3	    7.00	    29.20	0.2397	        16.10	    0.4348

--利用窗口函数和聚合开窗函数,可以很快实现上述要求
select OrderID,OrderQty,
sum(OrderQty) over() as  "汇总",
round(OrderQty/sum(OrderQty) over() ,4)  as "每单所占比例",
sum(OrderQty) over(PARTITION BY OrderID)  as "分组汇总",
round(OrderQty/sum(OrderQty) over(PARTITION BY OrderID) ,4) as "每单在各组所占比例"
from SalesOrder
order by OrderID

  
 

上面演示的都是窗口函数与聚合开窗函数的使用，它与排名开窗函数请看下面例题:

--与排名开窗函数使用
select OrderID,OrderQty,
rank() over(PARTITION BY orderid order by OrderQty ) as "分组排名",
rank() over(order by OrderQty ) as "排名"
from SalesOrder
order by orderid asc

--查询得如下结果
OrderID	OrderQty    分组排名	排名
1	    1	        1	1
1	    2	        2	4
1	    3	        3	5
2	    1.1	        1	2
2	    6	        2	6
3	    1.1	        1	2
3	    7	        2	7
3	    8	        3	8


与排名开窗函数的详细使用请看另一篇总结


