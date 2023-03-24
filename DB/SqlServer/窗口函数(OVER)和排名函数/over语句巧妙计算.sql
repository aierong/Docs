-- ����ֱ��ͳ�ƻ��д�����ʾ:�ڰ����ⲿ���õı��ۺϱ��ʽ��ָ���˶���С�������ۺϵı��ʽ�����ⲿ���ã���ô���ⲿ���þͱ����Ǹñ��ʽ�������õ�Ψһ��һ�С�
SELECT  a.* ,
        testru.checkdateo ,
        testru.mycheckdateo
FROM    dbo.pro_hd AS a
OUTER APPLY
        (
			-- ����ֱ��ͳ�ƻ��д�����ʾ:�ڰ����ⲿ���õı��ۺϱ��ʽ��ָ���˶���С�������ۺϵı��ʽ�����ⲿ���ã���ô���ⲿ���þͱ����Ǹñ��ʽ�������õ�Ψһ��һ�С�
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

-- ����over����������ܹ�����
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


