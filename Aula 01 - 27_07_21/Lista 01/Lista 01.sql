
/* Exercícios Consultas com mais de uma tabela */

/* 01) Mostrar todos os clientes que fizeram pedidos em 1996 */

SELECT Clientes.Nome
FROM Clientes,
Pedidos 
WHERE YEAR(Pedidos.DataPed) = '1996' AND
Pedidos.CodCli = Clientes.CodCli


/* 02) Mostrar todos os funcionários que fizeram pedidos para o cliente 'Around the horn' */

SELECT Funcionario = Funcionarios.Nome + ' ' + Funcionarios.Sobrenome
FROM Funcionarios,
Clientes,
Pedidos

WHERE  Clientes.NOME = 'Around the horn' AND 
	   Funcionarios.CodFun = Pedidos.CodFun 
	   

/* 03) Mostre todos os pedidos feitos pelo cliente 'Comércio Mineiro'. */

SELECT Pedidos.NumPed,
	   Pedidos.CodCli,
	   Pedidos.CodFun,
	   Pedidos.DataPed,
	   Pedidos.DataEntrega,
	   Pedidos.Frete 
FROM Pedidos,
Clientes
WHERE Pedidos.CodCli =  Clientes.CodCli AND
	  Clientes.Nome  =  'Comércio Mineiro'



/* 04) Mostrar todos os dados dos Funcionários que participaram dos pedidos de setembro de 1996. */

SELECT DISTINCT Funcionarios.CodFun, 
	   Funcionario = Funcionarios.Nome + ' ' + Funcionarios.Sobrenome ,
	   Funcionarios.Cargo,
	   Funcionarios.DataNasc,
	   Funcionarios.Endereco,
	   Funcionarios.Cidade,
	   Funcionarios.CEP,
	   Funcionarios.Pais,
	   Funcionarios.Fone,
	   Funcionarios.Salario
FROM Funcionarios,
Pedidos
WHERE YEAR(Pedidos.DataPed) = '1996' AND 
	  MONTH(Pedidos.DataPed) = '09'  
	


/* 05) Mostrar a todos os dados dos produtos e suas categorias de todos os produtos da categoria 'laticínios' */

SELECT Produtos.CodProd,
	   Produtos.Descr,
	   Produtos.CodFor,
	   Produtos.Preco,
	   Produtos.Unidades,
	   Produtos.Descontinuado
FROM Produtos,
	 Categorias
WHERE Produtos.CodCategoria = Categorias.CodCategoria AND
	  Categorias.Descr = 'laticínios'


/* 06) Mostrar todos os dados dos produtos e o número do pedido em que eles fizeram parte na data '1996-07-08' */

SELECT Pedidos.NumPed,
	   Produtos.CodProd,
	   Produtos.Descr,
	   Produtos.CodFor,
	   Produtos.Preco,
	   Produtos.Unidades,
	   Produtos.Descontinuado
FROM Produtos,
	 Pedidos,
	 DetalhesPed
WHERE DetalhesPed.NumPed = Pedidos.NumPed AND 
      Produtos.CodProd = DetalhesPed.CodProd AND
	  Pedidos.DataPed = '1996-07-08'


/* 07) Mostre o nome de todos os funcionários e o número dos pedidos que eles fizeram em '1997-05-01'. */

SELECT Funcionario =  Funcionarios.Nome + ' ' + Funcionarios.Sobrenome,
	   Pedidos.NumPed
FROM Funcionarios,
Pedidos
WHERE Pedidos.DataPed = '1997-05-01' AND
	  Pedidos.CodFun = Funcionarios.CodFun


/*08) Mostre o número dos pedidos feitos em maio de 1997 e o nome de todos os clientes.*/

SELECT Clientes.Nome,
	   Pedidos.NumPed
FROM Clientes,
Pedidos
WHERE Clientes.CodCli = Pedidos.CodCli AND 
	  YEAR(Pedidos.DataPed) = '1997' AND 
	  MONTH(Pedidos.DataPed) = '05'	

