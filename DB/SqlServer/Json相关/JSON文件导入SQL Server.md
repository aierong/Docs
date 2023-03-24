#### 0.注意

OPENROWSET这个导入文件,必须在sql server本机运行才有效



#### 1.JSON 文档导入单个列

```sql
SELECT BulkColumn
 FROM OPENROWSET (BULK 'C:\JSON\Books\book.json', SINGLE_CLOB) as j;
```

```sql
SELECT BulkColumn
 FROM OPENROWSET (BULK 'd:\userinfo.json', SINGLE_CLOB) as j;
```



#### 2.JSON文档导入变量

```sql
DECLARE @json NVARCHAR(max)=''

SELECT @json = BulkColumn
FROM OPENROWSET (BULK 'd:\userinfo.json', SINGLE_CLOB) as j

SELECT @json
```



#### 3.JSON文档导入临时表

```sql
SELECT BulkColumn
INTO #temp 
FROM OPENROWSET (BULK 'd:\userinfo.json', SINGLE_CLOB) as j

SELECT * FROM #temp
```



#### 4.参考

https://docs.microsoft.com/zh-cn/sql/relational-databases/json/import-json-documents-into-sql-server?view=sql-server-ver15

