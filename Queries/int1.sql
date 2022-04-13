.headers on
.mode columns
.nullvalue NULL

---Listagem dos nomes dos Utilizadores que são simultaneamente Estafetas e Clientes. 
SELECT utilizador.nome
FROM(SELECT nif, nome
     FROM Cliente
     INTERSECT
     SELECT nif, nome
     FROM Estafeta) AS utilizador;


