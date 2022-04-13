.headers on
.mode columns
.nullvalue NULL

---Método de pagamento mais utilizado.
SELECT MetodoPagamento.metodo, max(metodocount) AS vezesUsadas
FROM (SELECT idMetodo, COUNT(*) AS metodocount
      FROM Pedido
      GROUP BY idMetodo) AS Conta, MetodoPagamento
WHERE MetodoPagamento.idMetodo = Conta.idMetodo;