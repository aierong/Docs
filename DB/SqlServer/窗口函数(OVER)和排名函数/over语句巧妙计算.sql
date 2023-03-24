-- 这样直接统计会有错误提示:在包含外部引用的被聚合表达式中指定了多个列。如果被聚合的表达式包含外部引用，那么该外部引用就必须是该表达式中所引用的唯一的一列。
SELECT  a.* ,
        testru.checkdateo ,
        testru.mycheckdateo
FROM    dbo.pro_hd AS a
OUTER APPLY
        (
			-- 这样直接统计会有错误提示:在包含外部引用的被聚合表达式中指定了多个列。如果被聚合的表达式包含外部引用，那么该外部引用就必须是该表达式中所引用的唯一的一列。
            SELECT  TOP 1
                    MIN ( hd.checkdate ) AS checkdateo ,
                    MIN (   CASE WHEN hd.checkdate >= a.inputdate THEN hd.checkdate
                                ELSE NULL
                            END
                        ) AS mycheckdateo
            FROM    Stproducestock_new AS hd
            WHERE   hd.companyid = @companyid
                    AND hd.checkdate IS NOT NULL
                    AND hd.productno = a.productno
        ) AS testru

-- 借助over语句可以巧妙避过错误
SELECT  a.* ,
        testru.checkdateo ,
        testru.mycheckdateo
FROM    dbo.pro_hd AS a
OUTER APPLY
        (
            SELECT  TOP 1
                    MIN ( hd.checkdate ) over() AS checkdateo ,
                    MIN (   CASE WHEN hd.checkdate >= a.inputdate THEN hd.checkdate
                                ELSE NULL
                            END
                         ) over() AS mycheckdateo
            FROM    Stproducestock_new AS hd
            WHERE   hd.companyid = @companyid
                    AND hd.checkdate IS NOT NULL
                    AND hd.productno = a.productno
        ) AS testru


