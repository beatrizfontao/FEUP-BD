.print 'Gatilho 3'

.print ''
.print 'Antes de adicionar o novo menu ao pedido com idPedido = 1:'
.print ''

SELECT * FROM Pedido WHERE idPedido = 1;

.print ''
.print 'Menu que vai ser adicionado:'
.print ''

SELECT * FROM Menu WHERE idMenu = 3;

---Adição de um novo menu no pedido
INSERT INTO MenuPedido (idMenu,idPedido) VALUES (3,1);

.print ''
.print 'Depois de adicionar o menu com idMenu = 3 ao pedido com idPedido = 1:'
.print ''

SELECT * FROM Pedido WHERE idPedido = 1;

---Removendo o menu com idMenu = 3 do pedido com idPedido = 1
DELETE FROM MenuPedido
WHERE idMenu = 3 AND idPedido = 1;

.print ''
.print 'Depois de remover o menu com idMenu = 3 ao pedido com idPedido = 1:'
.print ''

SELECT * FROM Pedido WHERE idPedido = 1;