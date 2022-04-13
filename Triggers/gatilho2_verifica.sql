.print 'Gatilho 2'

.print ''
.print 'Antes de adicionar o novo produto ao pedido com idPedido = 1:'
.print ''

SELECT * FROM Pedido WHERE idPedido = 1;

.print ''
.print 'Produto que vai ser adicionado:'
.print ''

SELECT * FROM Produto WHERE idProduto = 77;

---Adição de um novo produto no pedido
INSERT INTO ProdutoPedido (idProduto,idPedido) VALUES (77,1);

.print ''
.print 'Depois de adicionar o produto com idProduto = 77 ao pedido com idPedido = 1:'
.print ''

SELECT * FROM Pedido WHERE idPedido = 1;

---Removendo o produto com idProduto = 77 do pedido com idPedido = 1
DELETE FROM ProdutoPedido
WHERE idProduto = 77 AND idPedido = 1;

.print ''
.print 'Depois de remover o produto com idProduto = 77 ao pedido com idPedido = 1:'
.print ''

SELECT * FROM Pedido WHERE idPedido = 1;