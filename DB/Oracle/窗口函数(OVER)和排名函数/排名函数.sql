oracle�ṩ��3����������: RANK(),DENSE_RANK(),row_number() 

�����Ƕ���3�������Ľ��ͣ�
ROW_NUMBER()
�ؽ�����������е����кţ�ÿ�������ĵ�һ�д�1��ʼ��
��û���ظ�ֵ������(��ʹ������¼���Ҳ�ǲ��ظ���)��������������ʵ�ַ�ҳ 

RANK() 
����Ծ���������ڶ����������ǵ�������

DENSE_RANK()
���������������ڶ�����Ȼ���ŵ�����    

  




--��ʾ���⣬��һ��table
create table rankorder(
orderid int,
qty int
)
 
--��������
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
�������Ҷ�3��������������ȱ��

                ����������   ����������
RANK()          ��һ������   �в���
DENSE_RANK()    ����         �в���
ROW_NUMBER()    ����         �޲��� 
 

