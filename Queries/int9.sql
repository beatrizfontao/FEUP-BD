.mode columns
.headers on
.nullvalue NULL

---Listagem dos valores totais gastos na aplicação, por utilizador.
SELECT Cliente.idCliente, nome, SUM(valorTotal) AS valorTotalGasto
FROM Pedido, Cliente
WHERE Pedido.idCliente = Cliente.idCliente
GROUP BY Cliente.idCliente
ORDER BY valorTotalGasto DESC;