/* Exercícios Stored Procedures */

/* 1 - Crie a stored procedure 'insere_fornec' que insira um registro
na tabela de fornecedores */
DROP	PROCEDURE insere_fornec
GO
CREATE	PROCEDURE insere_fornec
(
@INP_Empresa	VARCHAR(40),
@INP_Contato	VARCHAR(30),
@INP_Cargo	VARCHAR(30),
@INP_Endereco	VARCHAR(60),
@INP_Cidade	VARCHAR(15),	
@INP_CEP	VARCHAR(10),
@INP_PAIS	VARCHAR(15)
)
WITH 
ENCRYPTION 
AS

	INSERT INTO Fornecedores
	(
		Empresa		,
		Contato		,
		Cargo		,
		Endereco	,
		Cidade		,	
		CEP		,
		Pais	
	)
	VALUES
	(
		@INP_Empresa	,
		@INP_Contato	,
		@INP_Cargo	,	
		@INP_Endereco	,
		@INP_Cidade	,	
		@INP_CEP	,
		@INP_PAIS
	)

EXEC insere_fornec	'TESTE LTDA', '1140028922', 'DESENVOLVEDOR JUNIOR', 'RUA TESTE 123', 'SAO PAULO' ,'13221-403', 'BRAZIL'


/* 2 - Crie a stored procedure 'insere_detalhes' que insira um detalhe
de pedido na tabela DetalhesPed. */

DROP	PROCEDURE insere_detalhes
GO
CREATE	PROCEDURE insere_detalhes
(
@INP_CodProd	INTEGER		,
@INP_Preco	MONEY		,
@INP_Qtde	SMALLINT	,
@INP_Desconto	FLOAT	
)
WITH 
ENCRYPTION 
AS
DECLARE
@V_NEWIDIDENTITY	INTEGER		=	0

	SELECT	@V_NEWIDIDENTITY	=	ISNULL(MAX(NumPed),0) + 1
	FROM	DetalhesPed WITH(NOLOCK)

	INSERT INTO DetalhesPed
	(
		NumPed		,
		CodProd		,
		Preco		,
		Qtde		,
		Desconto	
	)
	VALUES
	(
		@V_NEWIDIDENTITY	,
		@INP_CodProd		,
		@INP_Preco		,
		@INP_Qtde		,
		@INP_Desconto	
	)

	

	EXEC	insere_detalhes  1, 18.00, 2, 0.00
	GO
	SELECT	* FROM DetalhesPed order by NumPed desc

/* 3 - Crie a stored procedure 'aumenta_preco' que dado um código de
produto e um percentual, aumente o valor do mesmo na quantidade do
percentual fornecido. Se nenhum código for informado todos os produtos
serão alterados. Obs. o percentual deve ser informado em forma decimal, por
exemplo 10% deve ser indicado como 0.1 */

DROP	PROCEDURE aumenta_preco
GO
CREATE	PROCEDURE aumenta_preco
(
@INP_CodProd	INTEGER		=	0,
@INP_PERCENT	FLOAT		=	0
)
WITH 
ENCRYPTION 
AS

	IF	@INP_CodProd	=	0
	BEGIN
		UPDATE	Produtos	
		SET	Preco		=	Preco	*	(1 + @INP_PERCENT)
	END
	ELSE
	BEGIN
		UPDATE	Produtos 
		SET	Preco		=	Preco	*	(1 + @INP_PERCENT)
		WHERE	CodProd		=	@INP_CodProd	
	END


	EXEC	aumenta_preco	0, 0.1  
	GO
	SELECT	* FROM Produtos order by CodProd asc



/* 4 - Crie a stored procedure 'diminui_preco' que dado um código de
produto e um percentual, diminua o valor do mesmo na quantidade do
percentual fornecido. Se nenhum código for informado todos os produtos
serão alterados. Obs. o percentual deve ser informado em forma decimal, por
exemplo 10% deve ser indicado como 0.1 */

DROP	PROCEDURE diminui_preco
GO
CREATE	PROCEDURE diminui_preco
(
@INP_CodProd	INTEGER		=	0,
@INP_PERCENT	FLOAT		=	0
)
WITH 
ENCRYPTION 
AS

	IF	@INP_CodProd	=	0
	BEGIN
		UPDATE	Produtos	
		SET	Preco		=	Preco	/	(1 + @INP_PERCENT)
	END
	ELSE
	BEGIN
		UPDATE	Produtos 
		SET	Preco		=	Preco	/	(1 + @INP_PERCENT)
		WHERE	CodProd		=	@INP_CodProd	
	END


	EXEC	diminui_preco	0, 0.1  
	GO
	SELECT	* FROM Produtos order by CodProd asc


/* 5 - Crie a stored procedure 'exclui_produto' que dado um código de
produto exclua o mesmo */

DROP	PROCEDURE exclui_produto
GO
CREATE	PROCEDURE exclui_produto
(
@INP_CodProd	INTEGER		=	0
)
WITH 
ENCRYPTION 
AS

	IF	@INP_CodProd	>	0
	BEGIN
		DELETE	
		FROM	Produtos	
		WHERE	CodProd		=	@INP_CodProd
	END
	ELSE	PRINT('Operação Cancelada Ao Tentar Apagar')



		


	EXEC	exclui_produto	0
	GO
	SELECT	* FROM Produtos order by CodProd asc
	


/* 6 - Crie a stored procedure 'altera_produto' que dado um código de
produto e uma descrição, altere a descrição desse produto */

DROP	PROCEDURE altera_produto
GO
CREATE	PROCEDURE altera_produto
(
@INP_CodProd		INTEGER		=	0,
@INP_PROD_DESCRI	VARCHAR(40)
)
WITH 
ENCRYPTION 
AS

	IF	@INP_CodProd	>	0
	BEGIN
		UPDATE	Produtos
		SET	Descr		=	@INP_PROD_DESCRI		
		WHERE	CodProd		=	@INP_CodProd
	END
	ELSE	PRINT('Operação Cancelada Ao Tentar ALTERAR PRODUTO')



		


	EXEC	altera_produto	2, 'FERRAMENTA'
	GO
	SELECT	* FROM Produtos order by CodProd asc


/* 7 - Crie a stored procedure 'exclui_pedido' que dado um número de
pedido exclua o mesmo e seu detalhe */

DROP	PROCEDURE exclui_pedido
GO
CREATE	PROCEDURE exclui_pedido
(
@INP_CodPED	INTEGER		=	0
)
WITH 
ENCRYPTION 
AS

	IF	@INP_CodPED	>	0
	BEGIN
		DELETE	
		FROM	Pedidos	
		WHERE	NumPed		=	@INP_CodPED

		DELETE	
		FROM	DetalhesPed	
		WHERE	NumPed		=	@INP_CodPED
	END
	ELSE	PRINT('Operação Cancelada Ao Tentar Apagar PEDIDO')



		


	EXEC	exclui_pedido	0
	GO
	SELECT	* FROM Produtos order by CodProd asc

/* 8 - Crie a stored procedute 'funcionarios_cargo' que dado um cargo
retorne todos os funcionários que tenham esse cargo */


DROP	PROCEDURE funcionarios_cargo
GO
CREATE	PROCEDURE funcionarios_cargo
(
@INP_SEARCH_CARGO	VARCHAR(255)
)
WITH 
ENCRYPTION 
AS

	IF	@INP_SEARCH_CARGO	IS NOT NULL
	BEGIN
		SELECT	* 
		FROM	Funcionarios
		WHERE	CARGO	LIKE	'%'+ @INP_SEARCH_CARGO +'%'
	END
	ELSE	PRINT('Operação Cancelada Ao Tentar BUSCAR FUNCIONARIOS')

	
	EXEC	funcionarios_cargo	'Representante de Vendas'

/* 9 - Crie a stored procedure 'aumenta_salario' que dado um código de
funcionário e um percentual, aumente o valor do salário do funcionário 
na quantidade do percentual fornecido. 
Se nenhum código for informado todos os salários serão alterados. */

DROP	PROCEDURE aumenta_salario
GO
CREATE	PROCEDURE aumenta_salario
(
@INP_Codfunc	INTEGER		=	0,
@INP_PERCENT	FLOAT		=	0
)
WITH 
ENCRYPTION 
AS
		UPDATE	Funcionarios	
		SET	Salario		=	Salario	*	(1 + @INP_PERCENT)
		WHERE	CodFun		=	@INP_Codfunc


	EXEC	aumenta_salario	1, 0.1  
	GO
	SELECT	* FROM Funcionarios order by CodFun asc

/* 10 - Crie a stored procedure 'clientes_cidade' que dada uma cidade
retorne todos os clientes desta cidade */

DROP	PROCEDURE clientes_cidade
GO
CREATE	PROCEDURE clientes_cidade
(
@INP_SEARCH_CIDADE	VARCHAR(255)
)
WITH 
ENCRYPTION 
AS

	IF	@INP_SEARCH_CIDADE	IS NOT NULL
	BEGIN
		SELECT	* 
		FROM	Clientes
		WHERE	Cidade	LIKE	'%'+ @INP_SEARCH_CIDADE +'%'
	END
	ELSE	PRINT('Operação Cancelada Ao Tentar BUSCAR CLIENTES')

	EXEC	clientes_cidade 'Berlin'

	