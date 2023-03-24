

���⣺

--����������
create table SalesOrder(
OrderID int,            --����id
OrderQty decimal(18,2)  --����
)
go

--��������
insert into SalesOrder
select 1,2.0
union all
select 1,1.0
union all
select 1,3.0
union all
select 2,6.0
union all
select 2,1.1
union all
select 3,8.0
union all
select 3,1.1
union all
select 3,7.0
go

--��ѯ�����½��
select * from SalesOrder
go

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

��Ҫ����ʾ����������ÿ����ռ�����������������ÿ���ڸ�����ռ������Ҫ���ʽ���£�

OrderID	OrderQty	����	ÿ������	    �������	ÿ���ڸ������
1	    2.00	    29.20	0.0685	        6.00	    0.3333
1	    1.00	    29.20	0.0342	        6.00	    0.1667
1	    3.00	    29.20	0.1027	        6.00	    0.5000
2	    6.00	    29.20	0.2055	        7.10	    0.8451
2	    1.10	    29.20	0.0377	        7.10	    0.1549
3	    8.00	    29.20	0.2740	        16.10	    0.4969
3	    1.10	    29.20	0.0377	        16.10	    0.0683
3	    7.00	    29.20	0.2397	        16.10	    0.4348

--���ô��ں����;ۺϿ�������,���Ժܿ�ʵ������Ҫ��
select OrderID,OrderQty,
sum(OrderQty) over() as [����],
convert(decimal(18,4), OrderQty/sum(OrderQty) over() ) as [ÿ����ռ����],
sum(OrderQty) over(PARTITION BY OrderID)  as [�������],
convert(decimal(18,4),OrderQty/sum(OrderQty) over(PARTITION BY OrderID)) as [ÿ���ڸ�����ռ����]
from SalesOrder
order by OrderID

