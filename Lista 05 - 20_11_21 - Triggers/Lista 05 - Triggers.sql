/* ********************  Triggers  ******************************************* */

/*01) Crie um gatilho que exiba uma mensagem toda vez que um fornecedor for inserido*/

INSERT INTO FORNECEDORES(Empresa,Contato, CARGO, Endereco, Cidade, CEP, Pais) VALUES('BR ENTREGAS', '1140028922','MOTORISTA','RUA SEM NOME', 'SÃO PAULO','13220123','BRASIL')

CREATE TRIGGER GERA_MENSAGEM_CADASTRO_FORNECEDOR
ON FORNECEDORES
AFTER INSERT
AS
BEGIN
	PRINT('FUNCIONÁRIO CRIADO COM SUCESSO!')

END
GO

/*02) Crie um gatilho que exiba uma mensagem toda vez que um produto for excluído*/

DELETE FROM Produtos WHERE CodProd = 2

CREATE TRIGGER GERA_MENSAGEM_PRODUTO_APAGADO
ON PRODUTOS
AFTER DELETE
AS
BEGIN
	PRINT('PRODUTO APAGADO COM SUCESSO!')

END
GO

/*03) Acrescente na tabela pedidos o campo dias_prazo do tipo inteiro */

ALTER TABLE PEDIDOS ADD DIAS_PRAZO INTEGER

/*04) Crie um gatilho que ao inserir um pedido calcule o campo dias_prazo, ou seja a 
diferença em dias da data do pedido para a data de entrega na tabela pedidos*/

INSERT INTO Pedidos (NumPed, CodCli, CodFun, DataPed, DataEntrega, Frete) VALUES (11078,'ALFKI',2,GETDATE(),GETDATE()+10, 22.99)
GO
SELECT * 
FROM Pedidos
ORDER BY NumPed DESC


CREATE TRIGGER CALCULA_DIAS_PRAZO
ON PEDIDOS
FOR INSERT
AS
BEGIN
	DECLARE 
		@V_COD_PED	INTEGER,
		@V_DATA_PRAZO	INTEGER,
		@V_DATA_PEDIDO	DATETIME,
		@V_DATA_ENTREGA	DATETIME

		SELECT @V_DATA_PEDIDO = DataPed, @V_DATA_ENTREGA = DataEntrega, @V_COD_PED = NumPed FROM inserted


		SELECT @V_DATA_PRAZO = DATEDIFF ( DAY , @V_DATA_PEDIDO , @V_DATA_ENTREGA ) 

		UPDATE PEDIDOS SET DIAS_PRAZO = @V_DATA_PRAZO WHERE NumPed = @V_COD_PED

END
GO

/*05) Acrescente na tabela detalhesped o campo valor_item do tipo moeda */

ALTER TABLE detalhesped ADD valor_item MONEY

/*06) Crie um gatilho que ao inserir um item na tabela detalhesped calcule o campo 
valor_item, ou seja (preco*qtde)-desconto */

INSERT INTO detalhesped (NumPed, CodProd, Preco, Qtde, Desconto) VALUES (10868,53,32.80,3,10.99)
GO
SELECT * 
FROM detalhesped
ORDER BY NumPed DESC


CREATE TRIGGER CALCULA_VALOR_ITEM
ON detalhesped
FOR INSERT
AS
BEGIN
	DECLARE 
		@V_COD_ITEM	INTEGER	,
		@V_PRECO	FLOAT	,
		@V_QUANTIDADE	INTEGER	,
		@V_DESCONTO	FLOAT	,
		@VALOR_FINAL	FLOAT	

		SELECT	@V_COD_ITEM	= NumPed	,	 
			@V_PRECO	= Preco		, 
			@V_DESCONTO	= Desconto	,
			@V_QUANTIDADE	= Qtde
		FROM	inserted


		SELECT @VALOR_FINAL = (@V_PRECO * @V_QUANTIDADE)-@V_DESCONTO

		UPDATE detalhesped SET valor_item = @VALOR_FINAL WHERE NumPed = @V_COD_ITEM

END
GO

/*07) Crie um gatilho que exiba uma mensagem toda vez que um produto for alterado*/

UPDATE PRODUTOS SET  Descr = 'Aniseed SyrupDS' WHERE CodProd =  3
GO
SELECT * FROM PRODUTOS

CREATE TRIGGER GERA_MENSAGEM_PRODUTO_ALTERADO
ON PRODUTOS
FOR UPDATE
AS
BEGIN
	PRINT('PRODUTO ALTERADO COM SUCESSO!')

END
GO
