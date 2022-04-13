.headers on
.mode columns
.nullvalue NULL

---Por morada, listagem dos nomes de utilizadores que efetuaram o pedido mais caro.
SELECT Morada.linha1, nome, maxPedido
FROM(SELECT idMorada, MAX(valorTotal) maxPedido 
     FROM Pedido 
     GROUP BY idMorada) AS Pedido1, Pedido, Cliente, Morada
WHERE (valorTotal = maxPedido
       AND Pedido.idCliente = Cliente.idCliente
       AND Morada.idMorada = Pedido.idMorada)
ORDER BY maxPedido;