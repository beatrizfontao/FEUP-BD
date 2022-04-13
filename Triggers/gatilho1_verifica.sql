.print 'Gatilho 1'

.print ''
.print 'Antes de adicionar o novo pedido com idEstafeta = 1:'
.print ''

SELECT * FROM Estafeta WHERE idEstafeta = 1;

---Criação de um novo pedido
INSERT INTO Pedido (idPedido,data,grauDeSatisfacao,idMorada,idMetodo,idEstafeta,idCliente) VALUES (31,"2022-05-23",1,1,1,1,1);

.print ''
.print 'Após adicionar o novo pedido com idEstafeta = 1:'
.print ''
SELECT * FROM Estafeta WHERE idEstafeta = 1;
