#### 1.数据库中存储json字符串

建议使用:nvarchar(max)  varchar(max)



#### 2.ISJSON 函数验证JSON文本

```sql
SELECT  * ,
        ISJSON ( doc ) isjson
FROM    ##Families
--如果字符串包含有效JSON，则返回1；否则，返回0。 如果 expression 为 NULL，则返回NULL。
--ISJSON返回1,就是json
WHERE   ISJSON ( doc ) > 0
```



#### 3.JSON_VALUE函数从JSON文本中提取值

```sql
SELECT      JSON_VALUE ( f.doc, '$.id' ) AS Name ,
            JSON_VALUE ( f.doc, '$.address.city' ) AS City ,
            JSON_VALUE ( f.doc, '$.address.county' ) AS County ,
			--children是数组 children[0].familyName是第1个儿子的familyName
            JSON_VALUE ( f.doc, '$.children[0].familyName' ) familyName0 ,
            JSON_VALUE ( f.doc, '$.children[1].familyName' ) familyName1
FROM        ##Families f
WHERE       JSON_VALUE ( f.doc, '$.id' ) = N'WakefieldFamily'
ORDER BY    JSON_VALUE ( f.doc, '$.address.city' ) DESC ,
            JSON_VALUE ( f.doc, '$.address.state' ) ASC
```



#### 4.JSON_QUERY函数从JSON文本中提取对象或数组

```sql
-- JSON_QUERY返回的是字符串(对象类型json字符串或者数组类型json字符串)
SELECT  JSON_QUERY ( f.doc, '$.address' ) AS Address ,
        --$.parents 返回一个数组形式json字符串
        JSON_QUERY ( f.doc, '$.parents' ) AS Parents ,
        JSON_QUERY ( f.doc, '$.parents[0]' ) AS Parent0
FROM    ##Families f
WHERE   JSON_VALUE ( f.doc, '$.id' ) = N'WakefieldFamily'
```



对比:JSON_VALUE和JSON_QUERY之间的主要区别在于JSON_VALUE返回标量值,而 JSON_QUERY返回数组或对象.



#### 5.分析嵌套式JSON集合

```sql
-- 注意:OPENJSON函数仅在兼容级别130之上可用。 如果数据库兼容级别低于130，SQL Server将无法找到并运行OPENJSON函数

SELECT  JSON_VALUE ( f.doc, '$.id' ) AS Name ,
        JSON_VALUE ( f.doc, '$.address.city' ) AS City ,
        c.givenName ,
        c.grade
FROM    ##Families f
CROSS APPLY
        OPENJSON ( f.doc, '$.children' )
            WITH (
                     grade INT ,
                     givenName NVARCHAR ( 100 )
                 ) c
```





6.参考

https://docs.microsoft.com/zh-cn/sql/relational-databases/json/validate-query-and-change-json-data-with-built-in-functions-sql-server?view=sql-server-ver15

https://docs.microsoft.com/zh-cn/sql/t-sql/functions/json-query-transact-sql?view=sql-server-ver15

https://docs.microsoft.com/zh-cn/sql/relational-databases/json/json-path-expressions-sql-server?view=sql-server-ver15





