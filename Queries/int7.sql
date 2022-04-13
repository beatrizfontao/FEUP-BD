.mode columns
.headers on
.nullvalue NULL

---Lucro total de cada restaurante.
SELECT idRestaurante, SUM(preco)
FROM(SELECT idRestaurante, Produto.idProduto, precoProduto AS preco
     FROM ProdutoPedido, Produto
     WHERE ProdutoPedido.idProduto = Produto.idProduto
     UNION
     SELECT idRestaurante, Menu.idMenu, precoMenu AS preco
     FROM MenuPedido, Menu
     WHERE MenuPedido.idMenu = Menu.idMenu)
GROUP BY idRestaurante;