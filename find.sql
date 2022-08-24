USE Base
Go
SELECT
        T.name AS Tabela,
        C.name AS Coluna
FROM
        sys.sysobjects AS T (NOLOCK)
                /* T.XTYPE
                PK = PRIMARY KEY constraint (type is K)
                F = FOREIGN KEY constraint
                UQ = UNIQUE constraint (type is K)
                U = User table
                P = Stored procedure*/
        INNER JOIN sys.all_columns AS C (NOLOCK) ON T.id = C.object_id AND T.XTYPE = 'U'
WHERE
        C.NAME LIKE '%DocVoucher%'
ORDER BY T.name ASC