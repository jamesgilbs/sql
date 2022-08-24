/*COMMANDS BASIC*/
----------------------------------------------------------------------------------------------
--Cria um esquema
USE Base
GO
CREATE SCHEMA harm
----------------------------------------------------------------------------------------------
--Apaga tabela
DROP TABLE xxxxx
----------------------------------------------------------------------------------------------
--Apaga conteúdo da tabela, com condicional e não muda estrutura da tabela
DELETE FROM xxxxx
WHERE xxxxx
----------------------------------------------------------------------------------------------
--Apaga conteúdo da tabela e modifica sua estrutura, não pode ter condicional
TRUNCATE TABLE xxxxx
----------------------------------------------------------------------------------------------
--Contagem de registros de toda tabela
SELECT COUNT (*) FROM xxxxx
----------------------------------------------------------------------------------------------
--Converte um campo
CAST(YYYYY AS nvarchar(50))  AS ValorConvertido
----------------------------------------------------------------------------------------------
--Concatenar
CONCAT (Name, Name2) AS Name1
----------------------------------------------------------------------------------------------
CASE
        WHEN YYYYY = '123456' THEN 'Y'
        ELSE 'N'
END AS xxxxx
----------------------------------------------------------------------------------------------
--Update

UPDATE [dbo].[TB_TRAT_FOLHA_MPE] SET ATUACAO = 'EXCLUIR' 
WHERE	ANO_MES = '2022-06'
		AND CPF IN('2769010107', '86521080130', '27668708812', '7143017442', '37157573881', '50301983852', '14142557807')

----------------------------------------------------------------------------------------------
--Condicionais
WERE YYYYY LIKE '%[A-Z]%'
WERE YYYYY LIKE IN ('', '')
WERE YYYYY LIKE NOT IN ('', '')
WERE YYYYY LIKE NOT IN (SELECT DISTINCT xxxxx FROM xxxxx WERE Flag = 1)

SELECT	DISTINCT MaterialDocument,
		DataDeLançamento,
		COUNT(1)
----------------------------------------------------------------------------------------------
--having
FROM [Base].[sapecc].[tb_wp03_mm_material_document]
WHERE FORMAT(DataDeLançamento, 'yyyyMM') = '202201'
GROUP BY MaterialDocument,
		DataDeLançamento
HAVING COUNT(1) > 1
----------------------------------------------------------------------------------------------
--distinct por data
SELECT	MaterialDocument,
		COUNT(DISTINCT DataDeLançamento)
		
FROM [Base].[sapecc].[tb_wp03_mm_material_document]
--WHERE FORMAT(DataDeLançamento, 'yyyyMM') = '202201'
GROUP BY MaterialDocument		
HAVING COUNT(DISTINCT DataDeLançamento) > 1
----------------------------------------------------------------------------------------------
--Condicional LIKE Otimizado
SELECT * 
FROM table1 
WHERE REGEXP_LIKE(lower(item_name), 'samsung|xiaomi|iphone|huawei')
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
                DISTINCT YYYYY,
                COUNT(1)
FROM xxxxx
GROUP BY YYYYY
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
        FROM xxxxx
)
SELECT *
FROM    cte
WHERE   row_num >= 2
ORDER BY 1
----------------------------------------------------------------------------------------------
--Comparar um campo com zeros a esquerda Ex.: 3000 - 0000030000
FROM REPLACE(LTRIM(REPLACE(xxxxx.YYYYY, '0', ' ')), ' ', '0') NOT IN('3000', '2001', '4005')
----------------------------------------------------------------------------------------------
--Common table expression
WITH cte AS (
SELECT
        YYYYY,
        COUNT(1) AS QTY
FROM xxxxx
GROUP BY YYYYY
)
SELECT *,
        SUM(QTY) OVER() AS QTY_GERAL,
        RANK() OVER(ORDER BY QTY DESC) AS RANKING
FROM cte
ORDER BY 2 DESC
----------------------------------------------------------------------------------------------
--TOP
SELECT TOP 100 *
FROM xxxxx
----------------------------------------------------------------------------------------------
--TOP com porcentagem
SELECT TOP 1 PERCENT *
FROM xxxxx
----------------------------------------------------------------------------------------------
--TOP com regra de seleção
SELECT TOP 100 WITH TIES *
FROM xxxxx
WHERE YYYYY > 2
ORDER BY YYYYY
----------------------------------------------------------------------------------------------
--Format Date
FORMAT(XXXXX, 'yyyyMM') = '202201'
----------------------------------------------------------------------------------------------
--Valores distintos de uma coluna específica
SELECT 
        DISTINCT YYYYY
FROM xxxxx
Order by 1
----------------------------------------------------------------------------------------------
--Contagem através do agrupamento
SELECT 
        YYYYY,
        COUNT(1) AS QTY
FROM xxxxx
GROUP BY YYYYY
ORDER BY 2 DESC
----------------------------------------------------------------------------------------------
--Cria primary key em uma tabela
ALTER TABLE xxxxx
ADD CONSTRAINT PK_xxxxx PRIMARY KEY (
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
        C.NAME LIKE '%YYYYY%'
ORDER BY T.name ASC
----------------------------------------------------------------------------------------------
--Procedure
USE [Base]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[xxxxx] AS
DROP TABLE IF EXISTS Base.dbo.ZZZZZ

WITH cte1 AS (
        SELECT *
        FROM    Base.aux.KKKKK
),
cte2 AS (
        SELECT *
        FROM    Base.aux.LLLLL
)

SELECT  
        cte1.*
        cte2.*
        INTO Base.dbo.ZZZZZ

FROM    cte1 AS cte1
        LEFT JOIN cte2 AS cte2 ON 
        cte1.* = cte2.*
WHERE 
        1=1
        AND...
----------------------------------------------------------------------------------------------
DECLARE @ULT_DESPESA FLOAT;
    SET @ULT_DESPESA = (SELECT DESPESA_TECNICO 
	                      FROM (SELECT *,
                               ROW_NUMBER() OVER (PARTITION BY SEGMENTO ORDER BY CAST(SUBSTRING(MES, 1, 4) AS INT) DESC, 
							   CAST(SUBSTRING(MES, 6, 2) AS INT) DESC) AS RANK
                         FROM TB_AUX_CUSTO_UNITARIO_DESPESAS_TEC
                         WHERE SEGMENTO = 'B2B') AS A
						 WHERE A.RANK = 1
                        );
----------------------------------------------------------------------------------------------
-- Replace Patindex
SELECT
                [TEMPO_FILA_CORRIDO]
                ,TRY_CAST((CASE WHEN SUBSTRING([TEMPO_FILA_CORRIDO], 1, 1) = '.' THEN REPLACE([TEMPO_FILA_CORRIDO], '.','0.')
                          WHEN SUBSTRING([TEMPO_FILA_CORRIDO], 1, 2) = '-.' THEN REPLACE([TEMPO_FILA_CORRIDO], '-.','-0.')
                          WHEN SUBSTRING([TEMPO_FILA_CORRIDO], 1, 2) = '0.' THEN REPLACE([TEMPO_FILA_CORRIDO], '0.','0.')
                          ELSE REPLACE([TEMPO_FILA_CORRIDO], PATINDEX ('%.%', [TEMPO_FILA_CORRIDO]) , '') END) AS float) AS [TEMPO_FILA_CORRIDO]
----------------------------------------------------------------------------------------------
-- Sobreposicao horarios
LAG(HORA_INICIO, 1) OVER (PARTITION BY [DATA] ORDER BY HORA_INICIO, HORA_FIM DESC) AS HORA_INICIO_CAL
LEAD(HORA_INICIO, 1) OVER (PARTITION BY [DATA] ORDER BY HORA_INICIO, HORA_FIM DESC) AS HORA_INICIO_CAL

--1ª Solucao
SELECT  PROBLEMA,
        RESPONSAVEL,
        [DATA],
        HORA_INICIO,
        HORA_FIM,
        CASE WHEN	HORA_INICIO = (LAG(HORA_INICIO, 1) OVER (PARTITION BY [DATA] ORDER BY HORA_INICIO, HORA_FIM DESC)) 
			AND		HORA_FIM	= (LAG(HORA_FIM, 1) OVER (PARTITION BY [DATA] ORDER BY HORA_INICIO, HORA_FIM DESC)) 
			THEN 0
			ELSE DATEDIFF(MINUTE, HORA_INICIO, HORA_FIM)
		END AS TEMPO_MIN

FROM [Algar-SLA].[dbo].[TB_TRAT_EXPURGOS_HORAS_SLA_ONLINE]
WHERE [DATA] = '2022-01-4'

--2ª Solucao
WITH rank_ex as (
SELECT  
		ID,
		PROBLEMA,
        RESPONSAVEL,
        [DATA],
        HORA_INICIO,
        HORA_FIM,
        ROW_Number() OVER (PARTITION BY [DATA] ORDER BY HORA_INICIO, HORA_FIM ASC) AS RANK
FROM [Algar-SLA].[dbo].[TB_TRAT_EXPURGOS_HORAS_SLA_ONLINE]
),
calc_temp AS (
SELECT  DISTINCT
		A.ID,
        A.PROBLEMA,
        A.RESPONSAVEL,
        A.[DATA],
        A.HORA_INICIO,
        A.HORA_FIM,
        CASE WHEN A.PROBLEMA = 'TORRE DE CONTROLE' THEN 0
             WHEN a.DATA <> b.DATA THEN DATEDIFF(MINUTE,B.HORA_INICIO, B.HORA_FIM)
             WHEN A.DATA = B.DATA AND A.HORA_INICIO = B.HORA_INICIO AND A.HORA_FIM = B.HORA_FIM THEN 0 -- OK
             WHEN A.DATA = B.DATA AND DATEDIFF(MINUTE, B.HORA_FIM, A.HORA_INICIO) <0 THEN DATEDIFF(MINUTE, B.HORA_FIM, B.HORA_FIM)
             ELSE DATEDIFF(MINUTE, A.HORA_INICIO, A.HORA_FIM) -- OK
             end 
             AS TEMPO_MIN
FROM    rank_ex AS A LEFT JOIN
        rank_ex AS B    ON A.[DATA]    = B.[DATA]
                        AND A.RANK      = B.RANK+1

----------------------------------------------------------------------------------------------
-- Data e Hora
Time			-- hh:mm:ss[.nnnnnnn]
Date			-- YYYY-MM-DD
Smalldatetime	-- YYYY-MM-DD hh:mm:ss
DateTime		-- YYYY-MM-DD hh:mm:ss[.nnn]
datetime2		-- YYYY-MM-DD hh:mm:ss[.nnnnnnn]
Datetimeoffset	-- YYYY-MM-DD hh:mm:ss[.nnnnnnn][+|-]hh:mm

SELECT 'GETDATE()' AS [Function], GETDATE() AS [Value]
SELECT 'GETUTCDATE()' AS [Function], GETUTCDATE() AS [Value]
SELECT 'SYSDATETIME()' AS [Function], SYSDATETIME() AS [Value]
SELECT 'SYSUTCDATETIME()' AS [Function], SYSUTCDATETIME() AS [Value]
SELECT 'SYSDATETIMEOFFSET()' AS [Function], SYSDATETIMEOFFSET() AS [Value]

SELECT DATEADD(YEAR, -1, '2013-04-02T00:00:00');	-- Subtrai um ano da data informada
SELECT DATEADD(YEAR, +1, '2014-04-02T00:00:00');	-- Adiciona um ano à data informada
SELECT DATEADD(Day, 1, '2014-04-29T00:00:00');		-- Adiciona um dia da data
SELECT DATEADD(Month, -1, '2014-04-29T00:00:00');	-- Subtrai um mês da data
SELECT DATEADD(hour , +1, '2014-04-29T00:00:00');	-- Adiciona uma hora à data

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

