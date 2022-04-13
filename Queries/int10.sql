.mode columns
.headers on
.nullvalue NULL

---Listagem dos produtos que não se encontram em nenhum menu.
SELECT idProduto, nome
FROM Produto
WHERE idProduto IN(SELECT idProduto
                   FROM Produto
                   EXCEPT
                   SELECT idProduto
                   FROM ProdutosMenu
                   GROUP BY idProduto
                   HAVING count(*) > 0);