.headers on
.mode columns
.nullvalue NULL

---Listagem da quantidade de vezes que cada produto aparece num menu
SELECT nome, numVezes
FROM(SELECT nome, count(*) AS numVezes
     FROM(SELECT nome, Produto.idProduto, idMenu
          FROM ProdutosMenu, Produto
          WHERE Produto.idProduto = ProdutosMenu.idProduto)
     GROUP BY nome)
ORDER BY numVezes;