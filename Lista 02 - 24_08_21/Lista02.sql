
/* 01) Mostrar todos os clientes que fizeram pedidos em março de 1997 */

SELECT Clientes.*
FROM Clientes INNER JOIN Pedidos on Clientes.CodCli = Pedidos.CodCli and MONTH(Pedidos.dataped) = 3 and YEAR(Pedidos.dataped) = 1997

/* 02) Mostrar todos os funcionários que fizeram pedidos para o cliente 'Around the horn' */

SELECT Funcionarios.*
FROM Funcionarios 	   INNER JOIN Pedidos  on Funcionarios.CodFun = Pedidos.CodFun
					   INNER JOIN Clientes on Pedidos.CodCli = Clientes.CodCli and Clientes.Nome = 'Around the horn'

/* 03) Mostre todos os pedidos feitos pelo cliente 'Comércio Mineiro'. */

SELECT Pedidos.*, Clientes.Nome
FROM Pedidos INNER JOIN Clientes on Pedidos.CodCli = Clientes.CodCli and Clientes.Nome = 'Comércio Mineiro'

/* 04) Mostrar todos os dados dos Funcionários que participaram dos pedidos de setembro de 1996. */

SELECT Funcionarios.*
FROM Funcionarios INNER JOIN Pedidos on Funcionarios.CodFun = Pedidos.CodFun and MONTH(Pedidos.DataPed) = 7 and YEAR(Pedidos.DataPed) = 1996

/* 05) Mostrar a todos os dados dos produtos e suas categorias de todos os produtos da categoria 'laticínios' */

SELECT Pedidos.*, Categorias.Descr
FROM Produtos INNER JOIN Categorias on Pedidos.CodCategoria = Categorias.CodCategoria and Categorias.Descr = 'laticínios'

/* 06) Mostrar todos os dados dos produtos e o número do pedido em que eles fizeram parte na data '1996-07-08' */

SELECT Produtos.*, ped.NumPed
FROM   Produtos		  INNER JOIN DetalhesPed on Produtos.CodProd = DetalhesPed.CodProd
					  INNER JOIN Pedidos     on DetalhesPed.NumPed = Pedidos.NumPed and Pedidos.DataPed = '1996-07-08'

/* 07) Mostre o nome de todos os funcionários e o número dos pedidos que eles fizeram em '1997-05-01'. */

SELECT Funcionarios.Nome, Pedidos.NumPed
FROM Funcionarios INNER JOIN Pedidos on Funcionarios.CodFun = Pedidos.CodFun and Pedidos.DataPed = '1997-05-01'

/*08) Mostre o número dos pedidos feitos em maio de 1997 e o nome de todos os clientes.*/

SELECT Pedidos.NumPed, Clientes.Nome
FROM Pedidos INNER JOIN Clientes on Pedidos.CodCli = Clientes.CodCli and MONTH(Pedidos.DataPed) = 05 and YEAR(Pedidos.DataPed) = 1997
