WITH cte AS (
        SELECT
                /*Nome colunas*/
                ROW_NUMBER() OVER (
                PARTITION BY
                /*Nome colunas*/
                ORDER BY
                /*Nome colunas*/
                ) row_num
        FROM [TABELA]
)
SELECT *
FROM    cte
WHERE   row_num >= 2
ORDER BY 1