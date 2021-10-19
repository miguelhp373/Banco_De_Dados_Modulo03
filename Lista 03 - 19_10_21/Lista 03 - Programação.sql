-- Lista de Exercícios sobre introdução a programação

-- Utilize o banco de dados Empresa3M

/* 1 - Mostre os números ímpares inteiros de 0 a 50 */

DECLARE
	@V_INI_VALUE	INTEGER,
	@V_FIN_VALUE	INTEGER


	SET @V_INI_VALUE	=	0
	SET @V_FIN_VALUE	=	50

	WHILE @V_INI_VALUE <= @V_FIN_VALUE
	BEGIN
		
		IF @V_INI_VALUE % 2 = 1 PRINT(@V_INI_VALUE)

		SET @V_INI_VALUE += 1
	END

	

/* 2 - Dados os números inteiros n1 = 5, n2 = 10 e n3 = 2, mostre-os em ordem decrescente */

DECLARE
	@V_N1		INTEGER,
	@V_N2		INTEGER,
	@V_N3		INTEGER


	SET @V_N1		=	5
	SET @V_N2		=	10
	SET @V_N3		=	2

	IF @V_N1 < @V_N2 AND @V_N3 < @V_N2 
	BEGIN
		PRINT(@V_N2)
		PRINT(@V_N1)
		PRINT(@V_N3)
	END
	




/* 3 - Utilizando a tabela DetalhesPed exiba a quantidade e a porcentagem de desconto para os itens de 
acordo com a tabela abaixo:
	Quantidade < 10, desconto 2%
	Quantidade entre 10 e 20, desconto 5%
	Quantidade entre 20 e 40, desconto 8%
	Quantidade acima de 40, desconto 12%
*/


	SELECT 
		Qtde,
		DESCONT	=	CASE	WHEN Qtde <= 10 THEN '2%'
							WHEN Qtde > 10	AND	Qtde < 20 THEN '5%'
							WHEN Qtde >= 20  AND	Qtde < 40 THEN '8%'
							WHEN Qtde >= 40 THEN '12%'
					END
	FROM DetalhesPed




/* 4 - Para cada cliente mostre nome, país e informe "importação" para países diferentes do Brasil e 
exportação" para clientes do Brasil */

SELECT 
	Nome,
	Pais	=	CASE WHEN Pais = 'BRASIL' THEN 'Importação'
					 WHEN Pais  <> 'BRASIL' THEN 'Exportação'
				END

FROM Clientes



/* 5 - Mostre Nome, País e Usando o CASE mostre o nome dos meses da data de nascimento dos clientes */

SELECT 
	Nome,
	Data_Nascimento	=	CASE	DATEPART(MONTH,DataNasc)	
						WHEN	1	THEN	'JANEIRO'
						WHEN	2	THEN	'FEVEREIRO'
						WHEN	3	THEN	'MARÇO'
						WHEN	4	THEN	'ABRIL'
						WHEN	5	THEN	'MAIO'
						WHEN	6	THEN	'JUNHO'
						WHEN	7	THEN	'JULHO'
						WHEN	8	THEN	'AGOSTO'
						WHEN	9	THEN	'SETEMBRO'
						WHEN	10	THEN	'OUTUBRO'
						WHEN	11	THEN	'NOVEMBRO'
						WHEN	12	THEN	'DEZEMBRO'
				END

FROM Funcionarios