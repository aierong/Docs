
 

Transact-SQL�ṩ��4����������: RANK(),DENSE_RANK(),ROW_NUMBER(),NTILE()

�����Ƕ���4�������Ľ��ͣ�
RANK() 
���ؽ�����ķ�����ÿ�е��������е������������֮ǰ����������һ��
���������������һ��������������ÿ�������н��õ���ͬ��������
���磬�����λ����Ա������ͬ��SalesYTDֵ�������ǽ����е�һ��������������������ǰ�����Ծ�����һ�����SalesYTD��������Ա������������
��ˣ�RANK ���������ܷ�������������


DENSE_RANK()
���ؽ�����������е���������������û���κμ�ϡ��е�����������������֮ǰ��������������һ��
�����������������ͬһ��������������Լ������ÿ��Լ���н�������ͬ��������
���磬�����λ��������Ա������ͬ�� SalesYTD ֵ�������ǽ����е�һ�������� SalesYTD ��ߵ�������Ա�����ڶ������������ڸ���֮ǰ������������һ��
��ˣ�DENSE_RANK �������ص�����û�м�ϣ�����ʼ�վ��������������� 


ROW_NUMBER()
�ؽ�����������е����кţ�ÿ�������ĵ�һ�д� 1 ��ʼ��
ORDER BY �Ӿ��ȷ�����ض�������Ϊ�з���Ψһ ROW_NUMBER ��˳��


NTILE()
����������е��зַ���ָ����Ŀ�����С��������б�ţ���Ŵ�һ��ʼ������ÿһ���У�NTILE �����ش�����������ı�š�
����������������ܱ� integer_expression �������򽫵���һ����Ա�����ִ�С��ͬ���顣���� OVER �Ӿ�ָ����˳�򣬽ϴ�������ڽ�С����ǰ�档
���磬����������� 53�������� 5����ǰ������ÿ����� 11 �У�����������ÿ����� 10 �С�
��һ���棬����������ɱ�����������������������֮��ƽ���ֲ���
���磬���������Ϊ 50��������飬��ÿ�齫���� 10 �С�



--��ʾ���⣬��һ��table
create table rankorder(
orderid int,
qty int
)
go
--��������
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
--��ѯ����������
SELECT orderid,qty,
  ROW_NUMBER() OVER(ORDER BY qty) AS rownumber,
  RANK()       OVER(ORDER BY qty) AS [rank],
  DENSE_RANK() OVER(ORDER BY qty) AS denserank ,
  NTILE(3) OVER(ORDER BY qty) AS [NTILE]
FROM rankorder
ORDER BY qty

--���
--ROW_NUMBER()�ǰ�qty��С������һ�����������У���������
--RANK()�ǰ�qty��С������һ���������У�����������
--DENSE_RANK()�ǰ�qty��С������һ���������У���������
--NTILE()�ǰ�qty��С����ֳ�3����һ���������У���������
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

sql 2005ʵ�������ǳ����㣬������sql 2000ʵ�������ͱȽ��鷳��������sql 2000��ʵ�ִ���:

--RANK��sql 2000�е�ʵ��
select orderid,qty,
	(select count(1)+1 from rankorder where qty<r.qty) as [rank]
from rankorder r
ORDER BY qty
go
 
--ROW_NUMBER��sql 2000�е�ʵ��
--������ʱ���IDENTITY��������
select identity(int,1,1) as [ROW_NUMBER],orderid,qty
into #tem             
from rankorder

select orderid,qty,[ROW_NUMBER]
from #tem

drop table #tem
go

--DENSE_RANK��sql 2000�е�ʵ��
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

�����������봰�ں���OVER()���һ��ʹ�õġ�
�������OVER�Ӿ�Ĳ���PARTITION BY,�Ϳ��Խ��������Ϊ���������������������ÿ�������ڽ�������.

--����
SELECT orderid,qty,
DENSE_RANK() OVER(ORDER BY qty) AS a ,
DENSE_RANK() OVER(PARTITION BY orderid ORDER BY qty) AS b 	
FROM rankorder
ORDER BY qty

--˵����
--a������ȫ����¼�Ͻ��е�����
--b���ǰ�orderid�еļ�¼�ֳ���10,21,22,30,40,80��6����������ÿ�����Ͻ��е�������
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

���ǿ��������������Ժܼ��ĵõ��������͵�����
�������Ҷ�4��������������ȱ��

                ����������   ����������
RANK()          ��һ������   �в���
DENSE_RANK()    ����         �в���
ROW_NUMBER()    ����         �޲��� 
NTILE()         ����         �в���




