#### 1.利用FOR JSON PATH或者FOR JSON AUTO格式化输出



FOR JSON PATH是代码控制输出,比FOR JSON AUTO灵活(推荐:FOR JSON PATH)

```sql
SELECT      TOP 8
            productno ,
            pono ,
            id ,
            custno AS 'customer.custno' ,
            salescode AS 'customer.salescode',

			inputdate AS 'CZ.add.date',
			userid AS 'CZ.add.userid',
			modifydate AS 'CZ.update.date',
			ISNULL( modifyid,'') AS 'CZ.update.userid',
			confirmdate AS 'CZ.confirm.date',
			confirmid AS 'CZ.confirm.userid'

FROM        dbo.pro_hd
ORDER BY    inputdate DESC
FOR JSON PATH
```



下面的输出json,如果字段是null,不会在json中显示(例如:confirmdate和modifydate)

```json
[
  {
    "productno":"EJ2110220001",
    "pono":"ES21103565",
    "id":1316760,
    "customer":{
      "custno":"A4011",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-22T12:05:00.007",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-22T17:26:07.190",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-22T17:26:07.687",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110210002",
    "pono":"ES21103562",
    "id":1316759,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-21T16:01:06.920",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-22T11:11:17.643",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-22T11:11:18.123",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110210001",
    "pono":"ES21103562-del",
    "id":1316756,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-21T15:06:44.043",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-21T16:58:01.753",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-21T16:57:57.833",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110200004",
    "pono":"ES21103562-del",
    "id":1316748,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-20T17:38:52.150",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-21T14:40:24.970",
        "userid":"82169"
      },
      "confirm":{
        "userid":""
      }
    }
  },
  {
    "productno":"EJ2110200003",
    "pono":"ES21103562-del",
    "id":1316747,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-20T17:33:59.897",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-20T17:38:01.987",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-21T09:01:50.350",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110200002",
    "pono":"ES21103562-del",
    "id":1316743,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-20T15:31:25.317",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-20T17:22:23.217",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-21T09:01:49.133",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110200001",
    "pono":"ES21103562-del",
    "id":1316742,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-20T15:16:45.093",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-20T15:26:30.710",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-21T09:01:46.480",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110190001",
    "pono":"ES21103560",
    "id":1316732,
    "customer":{
      "custno":"A4766",
      "salescode":"34903"
    },
    "CZ":{
      "add":{
        "date":"2021-10-19T09:45:20.530",
        "userid":"117447"
      },
      "update":{
        "userid":""
      }
    }
  }
]

```





#### 2.INCLUDE_NULL_VALUES选项显示所有属性

```sql
SELECT      TOP 8
            productno ,
            pono ,
            id ,
            custno AS 'customer.custno' ,
            salescode AS 'customer.salescode' ,
            inputdate AS 'CZ.add.date' ,
            userid AS 'CZ.add.userid' ,
            modifydate AS 'CZ.update.date' ,
            ISNULL ( modifyid, '' ) AS 'CZ.update.userid' ,
            confirmdate AS 'CZ.confirm.date' ,
            confirmid AS 'CZ.confirm.userid'
FROM        dbo.pro_hd
ORDER BY    inputdate DESC
-- 指定 INCLUDE_NULL_VALUES ,可以显示所有的属性包括null的
-- 没有指定 INCLUDE_NULL_VALUES 选项，则 JSON 输出不会包括查询结果中 NULL 值所对应的属性。
FOR JSON PATH, INCLUDE_NULL_VALUES
```



下面结果所有属性都会显示出来

```json
[
  {
    "productno":"EJ2110220001",
    "pono":"ES21103565",
    "id":1316760,
    "customer":{
      "custno":"A4011",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-22T12:05:00.007",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-22T17:26:07.190",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-22T17:26:07.687",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110210002",
    "pono":"ES21103562",
    "id":1316759,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-21T16:01:06.920",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-22T11:11:17.643",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-22T11:11:18.123",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110210001",
    "pono":"ES21103562-del",
    "id":1316756,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-21T15:06:44.043",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-21T16:58:01.753",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-21T16:57:57.833",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110200004",
    "pono":"ES21103562-del",
    "id":1316748,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-20T17:38:52.150",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-21T14:40:24.970",
        "userid":"82169"
      },
      "confirm":{
        "date":null,
        "userid":""
      }
    }
  },
  {
    "productno":"EJ2110200003",
    "pono":"ES21103562-del",
    "id":1316747,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-20T17:33:59.897",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-20T17:38:01.987",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-21T09:01:50.350",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110200002",
    "pono":"ES21103562-del",
    "id":1316743,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-20T15:31:25.317",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-20T17:22:23.217",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-21T09:01:49.133",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110200001",
    "pono":"ES21103562-del",
    "id":1316742,
    "customer":{
      "custno":"B295",
      "salescode":"82169"
    },
    "CZ":{
      "add":{
        "date":"2021-10-20T15:16:45.093",
        "userid":"82169"
      },
      "update":{
        "date":"2021-10-20T15:26:30.710",
        "userid":"82169"
      },
      "confirm":{
        "date":"2021-10-21T09:01:46.480",
        "userid":"82169"
      }
    }
  },
  {
    "productno":"EJ2110190001",
    "pono":"ES21103560",
    "id":1316732,
    "customer":{
      "custno":"A4766",
      "salescode":"34903"
    },
    "CZ":{
      "add":{
        "date":"2021-10-19T09:45:20.530",
        "userid":"117447"
      },
      "update":{
        "date":null,
        "userid":""
      },
      "confirm":{
        "date":null,
        "userid":null
      }
    }
  }
]

```





#### 3.ROOT选项(将根节点添加到JSON输出中)

```sql
SELECT      TOP 1
            productno ,
            pono ,
            id ,
            custno AS 'customer.custno' ,
            salescode AS 'customer.salescode' ,
            inputdate AS 'CZ.add.date' ,
            userid AS 'CZ.add.userid' ,
            modifydate AS 'CZ.update.date' ,
            ISNULL ( modifyid, '' ) AS 'CZ.update.userid' ,
            confirmdate AS 'CZ.confirm.date' ,
            confirmid AS 'CZ.confirm.userid'
FROM        dbo.pro_hd
ORDER BY    inputdate DESC
--指定 INCLUDE_NULL_VALUES ,可以显示所有的属性包括null的
--没有指定 INCLUDE_NULL_VALUES 选项，则 JSON 输出不会包括查询结果中 NULL 值所对应的属性。
FOR JSON PATH, INCLUDE_NULL_VALUES, ROOT('mydata')
```



json输出中会增加一个根节点

```json
{
  "mydata":[
    {
      "productno":"EJ2110220001",
      "pono":"ES21103565",
      "id":1316760,
      "customer":{
        "custno":"A4011",
        "salescode":"82169"
      },
      "CZ":{
        "add":{
          "date":"2021-10-22T12:05:00.007",
          "userid":"82169"
        },
        "update":{
          "date":"2021-10-22T17:26:07.190",
          "userid":"82169"
        },
        "confirm":{
          "date":"2021-10-22T17:26:07.687",
          "userid":"82169"
        }
      }
    }]
}
```



#### 4.WITHOUT_ARRAY_WRAPPER(删除默认在JSON输出的方括号) 

```sql
SELECT      TOP 1
            productno ,
            pono ,
            id ,
            custno AS 'customer.custno' ,
            salescode AS 'customer.salescode' ,
            inputdate AS 'CZ.add.date' ,
            userid AS 'CZ.add.userid' ,
            modifydate AS 'CZ.update.date' ,
            ISNULL ( modifyid, '' ) AS 'CZ.update.userid' ,
            confirmdate AS 'CZ.confirm.date' ,
            confirmid AS 'CZ.confirm.userid'
FROM        dbo.pro_hd
ORDER BY    inputdate DESC
--指定 INCLUDE_NULL_VALUES ,可以显示所有的属性包括null的
--没有指定 INCLUDE_NULL_VALUES 选项，则 JSON 输出不会包括查询结果中 NULL 值所对应的属性。
FOR JSON PATH, INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER 
```



```json
{
  "productno":"EJ2110220001",
  "pono":"ES21103565",
  "id":1316760,
  "customer":{
    "custno":"A4011",
    "salescode":"82169"
  },
  "CZ":{
    "add":{
      "date":"2021-10-22T12:05:00.007",
      "userid":"82169"
    },
    "update":{
      "date":"2021-10-22T17:26:07.190",
      "userid":"82169"
    },
    "confirm":{
      "date":"2021-10-22T17:26:07.687",
      "userid":"82169"
    }
  }
}
```



#### 5.输出json结果到变量

> demo1:从表中查询输出

```sql
-- 定义变量
DECLARE @str NVARCHAR(MAX) = ''

-- 输出json结果到变量
SELECT  @str = (
                   SELECT   TOP 3
                            productno ,
                            pono ,
                            id ,
                            custno AS 'customer.custno' ,
                            salescode AS 'customer.salescode' ,
                            inputdate AS 'CZ.add.date' ,
                            userid AS 'CZ.add.userid' ,
                            modifydate AS 'CZ.update.date' ,
                            ISNULL ( modifyid, '' ) AS 'CZ.update.userid' ,
                            confirmdate AS 'CZ.confirm.date' ,
                            confirmid AS 'CZ.confirm.userid'
                   FROM     dbo.pro_hd
                   ORDER BY inputdate DESC
                   FOR JSON PATH, INCLUDE_NULL_VALUES
               )

SELECT  @str
```



> demo2: 自己构造数据输出

```sql
-- 定义变量
DECLARE @str NVARCHAR(MAX) = '';

SELECT @str =
(
    SELECT 1 ids,
           '2021-01-01' dates,
           't89-21' AS takeid
    FOR JSON PATH, INCLUDE_NULL_VALUES, WITHOUT_ARRAY_WRAPPER
);

SELECT @str;
```





#### 6.用户定义函数中输出json

```sql
CREATE FUNCTION GetSalesOrderDetails(@salesOrderId int)  
RETURNS NVARCHAR(MAX)  
AS  
BEGIN  
   RETURN (SELECT UnitPrice, OrderQty  
           FROM Sales.SalesOrderDetail  
           WHERE SalesOrderID = @salesOrderId  
           FOR JSON AUTO)  
END
```

调用函数

```sql
DECLARE @x NVARCHAR(MAX) = dbo.GetSalesOrderDetails(43659)

PRINT dbo.GetSalesOrderDetails(43659)

SELECT TOP 10
  H.*, dbo.GetSalesOrderDetails(H.SalesOrderId) AS Details
FROM Sales.SalesOrderHeader H
```





#### 7.转义特殊字符和控制字符

参考:

https://docs.microsoft.com/zh-cn/sql/relational-databases/json/how-for-json-escapes-special-characters-and-control-characters-sql-server?view=sql-server-ver15 





#### 8.参考

https://docs.microsoft.com/zh-cn/sql/relational-databases/json/format-query-results-as-json-with-for-json-sql-server?view=sql-server-ver15

