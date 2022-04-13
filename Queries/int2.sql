.headers on
.mode columns
.nullvalue NULL

---Listagem dos Clientes que partilham a mesma morada.
SELECT DISTINCT Cliente.idCliente, Cliente.nome, Morada.linha1
FROM Cliente, Cliente AS Cliente1, Morada
WHERE (Cliente.idMorada = Cliente1.idMorada 
       AND Cliente.idCliente <> Cliente1.idCliente 
       AND Cliente.idMorada = Morada.idMorada)
ORDER BY Cliente.idMorada;