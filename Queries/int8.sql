.mode columns
.headers on
.nullvalue NULL

---Tipo de Comida mais popular (presente em mais pedidos).
SELECT nome, MAX(numPorTipo) AS numeroDeVezes
FROM(SELECT idTipoComida, SUM(numVezes) AS numPorTipo
     FROM(SELECT idRestaurante, SUM(menus+produtos) AS numVezes
          FROM(SELECT idRestaurante, count(*) AS produtos
               FROM (SELECT idRestaurante, Produto.idProduto
                     FROM ProdutoPedido, Produto
                     WHERE ProdutoPedido.idProduto = Produto.idProduto)
               GROUP BY idRestaurante)
          JOIN(SELECT idRestaurante, count(*) AS menus
               FROM (SELECT idRestaurante, Menu.idMenu
                     FROM MenuPedido, Menu
                     WHERE MenuPedido.idMenu = Menu.idMenu)
               GROUP BY idRestaurante)
          USING(idRestaurante)
          GROUP BY idRestaurante) AS A, TipoComidaRestaurante
     WHERE TipoComidaRestaurante.idRestaurante = A.idRestaurante
     GROUP BY idTipoComida) AS B, TipoComida
WHERE B.idTipoComida = TipoComida.idTipoComida;
