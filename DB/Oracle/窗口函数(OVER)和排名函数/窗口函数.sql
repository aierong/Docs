���ں���(OVER)

1.��飺 
���ں���������Ѹ�ٲ鿴��ͬ����ľۺϣ�ͨ�������Էǳ�������ۼ��������ƶ�ƽ��ֵ���Լ�ִ���������㡣
���ں������ܷǳ�ǿ��ʹ������Ҳʮ�����ס�����ʹ��������������õ�����ͳ��ֵ��
�������û�ָ����һ���С� ������������Ӵ��������Ľ�����и��е�ֵ��

2.���÷�Χ��
�������������;ۺϿ�������.
Ҳ����˵���ں����ǽ�����������������߾ۺϿ�������һ��ʹ��
OVER�Ӿ�ǰ��������������������ǾۺϺ���


3.���⣺

--����������
create table SalesOrder(
OrderID int,            --����id
OrderQty number(18,2)  --����
)
 

--��������
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

--��ѯ�����½��
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
sum(OrderQty) over() as  "����",
round(OrderQty/sum(OrderQty) over() ,4)  as "ÿ����ռ����",
sum(OrderQty) over(PARTITION BY OrderID)  as "�������",
round(OrderQty/sum(OrderQty) over(PARTITION BY OrderID) ,4) as "ÿ���ڸ�����ռ����"
from SalesOrder
order by OrderID

  
 

������ʾ�Ķ��Ǵ��ں�����ۺϿ���������ʹ�ã������������������뿴��������:

--��������������ʹ��
select OrderID,OrderQty,
rank() over(PARTITION BY orderid order by OrderQty ) as "��������",
rank() over(order by OrderQty ) as "����"
from SalesOrder
order by orderid asc

--��ѯ�����½��
OrderID	OrderQty    ��������	����
1	    1	        1	1
1	    2	        2	4
1	    3	        3	5
2	    1.1	        1	2
2	    6	        2	6
3	    1.1	        1	2
3	    7	        2	7
3	    8	        3	8


������������������ϸʹ���뿴��һƪ�ܽ�


