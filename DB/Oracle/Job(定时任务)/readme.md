#### 说明

job就是定时执行某些sql



#### 创建

```sql
declare
  job number;
BEGIN
  DBMS_JOB.SUBMIT(  
        JOB => job,  /*自动生成JOB_ID*/  
        WHAT => 'pr_test_ccc;',  /*需要执行的存储过程名称或SQL语句*/  
        NEXT_DATE => sysdate+3/(24*60*60),  /*初次执行时间-下一个3秒*/  
        INTERVAL => 'trunc(sysdate,''mi'')+1/(24*60)' /*每隔1分钟执行一次*/
      );  
  commit;
end;



declare
  job number;
BEGIN
  DBMS_JOB.SUBMIT(  
        JOB => job,  /*自动生成JOB_ID*/  
        WHAT => 'pr_test_EEE;',  /*需要执行的存储过程名称或SQL语句*/  
        NEXT_DATE => sysdate+3/(24*60*60),  /*初次执行时间-下一个3秒*/  
        INTERVAL => 'sysdate+1/(24*60)' /*每隔1分钟执行一次*/
      );  
  commit;
end;



declare
  job number;
BEGIN
  DBMS_JOB.SUBMIT(  
        JOB => job,  /*自动生成JOB_ID*/  
        WHAT => 'pr_test_d;',  /*需要执行的存储过程名称或SQL语句*/  
        NEXT_DATE => sysdate+3/(24*60*60),  /*初次执行时间-下一个3秒*/  
        INTERVAL => 'sysdate+5/86400' /*每隔5秒一次*/
      );  
  commit;
end;
```



#### 查看Job信息

```sql
select job, what, next_date, next_sec,failures, broken, what, interval 
from user_jobs;
```



#### 参考

https://www.cnblogs.com/zhm1985/articles/13900729.html

https://www.cnblogs.com/bill89/p/11044928.html





