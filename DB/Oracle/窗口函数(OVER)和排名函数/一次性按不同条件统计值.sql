例题：

--建立订单表
create table SalesOrder(
OrderID int,            --订单id
OrderQty number(18,2)  --数量
)
go

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


