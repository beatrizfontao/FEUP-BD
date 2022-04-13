.headers on
.mode columns
.nullvalue NULL

---Estafeta com melhor média de grau de satisfação.
SELECT Estafeta.idEstafeta, Estafeta.nome, max(avgGrau) AS grauDeSatisfaçaoMedio
FROM(SELECT idEstafeta, AVG(grauDeSatisfacao) AS avgGrau
     FROM Pedido
     GROUP BY idEstafeta) AS A, Estafeta
WHERE Estafeta.idEstafeta = A.idEstafeta;