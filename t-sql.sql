/*COMMANDS BASIC*/
----------------------------------------------------------------------------------------------
--Cria um esquema
USE Base
GO
CREATE SCHEMA harm
----------------------------------------------------------------------------------------------
--Top
SELECT TOP 100 *
FROM [TABELA]
----------------------------------------------------------------------------------------------
--Top com porcentagem
SELECT TOP 1 PERCENT *
FROM [TABELA]
----------------------------------------------------------------------------------------------
--Top com regra de seleção
SELECT TOP 100 WITH TIES *
FROM [TABELA]
WHERE [CAMPO] > 2
ORDER BY [CAMPO]
----------------------------------------------------------------------------------------------
--Excluir tabela
DROP TABLE [TABELA]
----------------------------------------------------------------------------------------------
--Exclui linhas da tabela, com condicional e não muda estrutura da tabela
DELETE FROM [TABELA]
WHERE [CAMPO] = 'DADOS'
----------------------------------------------------------------------------------------------
--Exclui conteúdo da tabela e modifica sua estrutura, não pode ter condicional
TRUNCATE TABLE [TABELA]
----------------------------------------------------------------------------------------------
--Contagem de registros de toda tabela
SELECT COUNT (*) FROM [TABELA]
-------------
SELECT  DISTINCT         
                MaterialDocument,
                DataDeLançamento,
                COUNT(1)
----------------------------------------------------------------------------------------------
--Converte um campo
CAST([CAMPO] AS nvarchar(50))  AS [NOME CAMPO]
----------------------------------------------------------------------------------------------
--Concatenar
CONCAT ([CAMPO1], [CAMPO2]) AS [NOME CAMPO]
----------------------------------------------------------------------------------------------
--Case
CASE
        WHEN [CAMPO] = 'DADOS' THEN 'Y'
        ELSE 'N'
END AS [NOME CAMPO]
----------------------------------------------------------------------------------------------
--Update
UPDATE [TABELA] SET [CAMPO] = 'EXCLUIR' 
WHERE [CAMPO] = 'DADOS'
----------------------------------------------------------------------------------------------
--Condicionais
WHERE [CAMPO] LIKE '%[A-Z]%'
WHERE [CAMPO] LIKE IN ('DADOS1', 'DADOS2')
WHERE [CAMPO] LIKE NOT IN ('DADOS1', 'DADOS2')
WHERE [CAMPO] LIKE NOT IN (SELECT DISTINCT [CAMPO] FROM [TABLE] WHERE [CAMPO] = 'DADOS')
----------------------------------------------------------------------------------------------
--Having
SELECT *
FROM [TABLE]
WHERE FORMAT([CAMPO DATA], 'yyyyMM') = 'DADOS'
GROUP BY [CAMPO]
HAVING COUNT(1) > 1
----------------------------------------------------------------------------------------------
--Distinct por data
SELECT	[CAMPO1]
	COUNT(DISTINCT [CAMPO DATA])
FROM [TABLE]
WHERE FORMAT([[CAMPO DATA]], 'yyyyMM') = 'DADOS'
GROUP BY [CAMPO1]		
HAVING COUNT(DISTINCT [CAMPO DATA]) > 1
----------------------------------------------------------------------------------------------
--Convert long list of IN clause into a temporary table
SELECT * 
FROM Table1 as t1 JOIN ( 
        SELECT itemid FROM      ( 
                SELECT split('3363134, 5189076, …,', ', ') as bar 
                                ) 
                CROSS JOIN UNNEST(bar) AS t(itemid) 
                        ) AS Table2 as t2 ON t1.itemid = t2.itemid
----------------------------------------------------------------------------------------------
--Conta itens de uma coluna específica
SELECT 
                DISTINCT [CAMPO],
                COUNT(1)
FROM [TABELA]
GROUP BY [CAMPO]
----------------------------------------------------------------------------------------------
--Having
SELECT grupo, SUM(qtd) as total
FROM exemplo
GROUP BY grupo HAVING total >=80
----------------------------------------------------------------------------------------------
--Duplicação de linhas
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
----------------------------------------------------------------------------------------------
--Comparar um campo com zeros a esquerda Ex.: 3000 - 0000030000
FROM REPLACE(LTRIM(REPLACE([CAMPO], '0', ' ')), ' ', '0') NOT IN('3000', '2001', '4005')
----------------------------------------------------------------------------------------------
--Ranking
WITH cte AS (
SELECT
        [CAMPO],
        COUNT(1) AS QTY
FROM [TABELA]
GROUP BY [CAMPO]
)
SELECT *,
        SUM(QTY) OVER() AS QTY_GERAL,
        RANK() OVER(ORDER BY QTY DESC) AS RANKING
FROM cte
ORDER BY 2 DESC
----------------------------------------------------------------------------------------------
--Format Date
FORMAT([CAMPO DATA], 'yyyyMM') = '202201'
----------------------------------------------------------------------------------------------
--Valores distintos de uma coluna específica
SELECT 
        DISTINCT [CAMPO]
FROM [TABELA]
Order by 1
----------------------------------------------------------------------------------------------
--Contagem através do agrupamento
SELECT 
        [CAMPO],
        COUNT(1) AS QTY
FROM [TABELA]
GROUP BY [CAMPO]
ORDER BY 2 DESC
----------------------------------------------------------------------------------------------
--Cria primary key em uma tabela
ALTER TABLE [TABELA]
ADD CONSTRAINT [PK_NOME QUALQUER] PRIMARY KEY (
        YYYYY,
        ZZZZZ,
        KKKKK
)
----------------------------------------------------------------------------------------------
--Busca colunas em todo o banco com nome específico
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
        C.NAME LIKE '%TEXTO%'
ORDER BY T.name ASC
----------------------------------------------------------------------------------------------
--Variável
DECLARE @ULT_DESPESA FLOAT;
    SET @ULT_DESPESA = (SELECT DESPESA
	                      FROM (SELECT *,
                               ROW_NUMBER() OVER (PARTITION BY SEGMENTO ORDER BY CAST(SUBSTRING(MES, 1, 4) AS INT) DESC, 
							   CAST(SUBSTRING(MES, 6, 2) AS INT) DESC) AS RANK
                         FROM   TABELA
                         WHERE  SEGMENTO = 'XXX') AS A
						 WHERE A.RANK = 1
                        );
----------------------------------------------------------------------------------------------
-- Replace Patindex - encontra a posição de um ou mais caracters
SELECT  [CAMPO]
        ,TRY_CAST((CASE WHEN SUBSTRING([CAMPO], 1, 1) = '.' THEN REPLACE([CAMPO], '.','0.')
                        WHEN SUBSTRING([CAMPO], 1, 2) = '-.' THEN REPLACE([CAMPO], '-.','-0.')
                        WHEN SUBSTRING([CAMPO], 1, 2) = '0.' THEN REPLACE([CAMPO], '0.','0.')
                        ELSE REPLACE([CAMPO], PATINDEX('%.%', [CAMPO]), '') END) AS float) AS [CAMPO]
----------------------------------------------------------------------------------------------
-- Sobreposicao horarios
LAG(HORA_INICIO, 1) OVER (PARTITION BY [DATA] ORDER BY HORA_INICIO, HORA_FIM DESC) AS HORA_INICIO_CAL
LEAD(HORA_INICIO, 1) OVER (PARTITION BY [DATA] ORDER BY HORA_INICIO, HORA_FIM DESC) AS HORA_INICIO_CAL
------------------------
--1ª Solucao
SELECT  HORA_INICIO,
        HORA_FIM,
        CASE WHEN       HORA_INICIO = (LAG(HORA_INICIO, 1) OVER (PARTITION BY [DATA] ORDER BY HORA_INICIO, HORA_FIM DESC)) 
	        AND	HORA_FIM    = (LAG(HORA_FIM, 1) OVER (PARTITION BY [DATA] ORDER BY HORA_INICIO, HORA_FIM DESC)) 
			THEN 0
		ELSE DATEDIFF(MINUTE, HORA_INICIO, HORA_FIM)
	END AS [TEMPO_MINUTOS]
        
FROM [TABELA]
WHERE [DATA] = '2022-01-4'
------------------------
--2ª Solucao
WITH rank_ex as (
SELECT  
        HORA_INICIO,
        HORA_FIM,
        ROW_Number() OVER(PARTITION BY [DATA] ORDER BY HORA_INICIO, HORA_FIM ASC) AS RANK
FROM [TABELA]
),

calc_temp AS (
SELECT  DISTINCT
	A.HORA_INICIO,
        A.HORA_FIM,
        CASE WHEN A.[DATA] <> B.[DATA] THEN DATEDIFF(MINUTE,B.HORA_INICIO, B.HORA_FIM)
             WHEN A.[DATA] =  B.[DATA] AND A.HORA_INICIO = B.HORA_INICIO AND A.HORA_FIM = B.HORA_FIM THEN 0
             WHEN A.[DATA] =  B.[DATA] AND DATEDIFF(MINUTE, B.HORA_FIM, A.HORA_INICIO) < 0 THEN DATEDIFF(MINUTE, B.HORA_FIM, B.HORA_FIM)
             ELSE DATEDIFF(MINUTE, A.HORA_INICIO, A.HORA_FIM)
        END AS [TEMPO_MINUTOS]

FROM    rank_ex AS A LEFT JOIN
        rank_ex AS B    ON  A.[DATA]    = B.[DATA]
                        AND A.[RANK]    = B.[RANK] + 1
----------------------------------------------------------------------------------------------
--Procedure sem limite de data
USE [DATABASE]
GO

CREATE PROCEDURE [NOME PROCEDURE] AS --Create ou Alter
DROP TABLE IF EXISTS [TABELA NOVA];

WITH cte1 AS (
        SELECT *
        FROM [TABELA1]
),
cte2 AS (
        SELECT *
        FROM [TABELA2]
)

SELECT  
        cte1.*
        cte2.*

INTO [TABELA NOVA]

FROM    cte1 AS cte1
        LEFT JOIN cte2 AS cte2 ON
        cte1.[CAMPO] = cte2.[CAMPO]
WHERE   1=1
        AND...
----------------------------------------------------------------------------------------------
--Procedure com limite de truncagem por data (Obs.: Somente é deletado dados que
--      existem na staging com mesma data.

USE [DATABASE]
GO

ALTER PROCEDURE [NOME PROCEDURE] --Create ou Alter
AS

DECLARE @DT_MAX DATE,
        @DT_MIN DATE;
SET @DT_MAX = (SELECT MAX(CASE WHEN [DATA_REFERENCIA] LIKE '%/%' THEN CONVERT(DATE, [DATA_REFERENCIA], 103)
                                ELSE CONVERT(DATE, [DATA_REFERENCIA], 102) END) FROM [TABELA STAGING])
SET @DT_MIN = (SELECT MIN(CASE WHEN [DATA_REFERENCIA] LIKE '%/%' THEN CONVERT(DATE, [DATA_REFERENCIA], 103)
                                ELSE CONVERT(DATE, [DATA_REFERENCIA], 102) END) FROM [TABELA STAGING])

DELETE [TABELA NOVA]
WHERE CAST([DATA_REFERENCIA] AS DATE) BETWEEN @DT_MIN AND @DT_MAX

INSERT INTO [TABELA NOVA]

SELECT 
        [TODOS CAMPOS]
--INTO [TABELA NOVA] --Caso seja necessário ignorar a data do delete
FROM    [TABELA STAGING]
----------------------------------------------------------------------------------------------
-- Data e Hora
Time            -- hh:mm:ss[.nnnnnnn]
Date            -- YYYY-MM-DD
Smalldatetime   -- YYYY-MM-DD hh:mm:ss
DateTime        -- YYYY-MM-DD hh:mm:ss[.nnn]
datetime2       -- YYYY-MM-DD hh:mm:ss[.nnnnnnn]
Datetimeoffset  -- YYYY-MM-DD hh:mm:ss[.nnnnnnn][+|-]hh:mm

SELECT 'GETDATE()' AS [Function], GETDATE() AS [Value]
SELECT 'GETUTCDATE()' AS [Function], GETUTCDATE() AS [Value]
SELECT 'SYSDATETIME()' AS [Function], SYSDATETIME() AS [Value]
SELECT 'SYSUTCDATETIME()' AS [Function], SYSUTCDATETIME() AS [Value]
SELECT 'SYSDATETIMEOFFSET()' AS [Function], SYSDATETIMEOFFSET() AS [Value]

SELECT DATEADD(YEAR, -1, '2013-04-02T00:00:00');  -- Subtrai um ano da data informada
SELECT DATEADD(YEAR, +1, '2014-04-02T00:00:00');  -- Adiciona um ano à data informada
SELECT DATEADD(Day, 1, '2014-04-29T00:00:00');    -- Adiciona um dia da data
SELECT DATEADD(Month, -1, '2014-04-29T00:00:00'); -- Subtrai um mês da data
SELECT DATEADD(hour , +1, '2014-04-29T00:00:00'); -- Adiciona uma hora à data

SELECT DATEDIFF(year, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(quarter, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(month, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(dayofyear, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(day, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(week, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(hour, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(minute, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(second, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT DATEDIFF(millisecond, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');

SET LANGUAGE Portuguese
SELECT DATENAME(year , '2005-12-31');