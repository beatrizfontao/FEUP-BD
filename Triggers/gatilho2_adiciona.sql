.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

---Quando se adiciona um produto a um pedido, o seu preço é adicionado ao valor dos produtos e o valor total do pedido;
CREATE TRIGGER IF NOT EXISTS adicionaProdutoAPedido
AFTER INSERT ON ProdutoPedido
FOR EACH ROW
BEGIN
  UPDATE Pedido
  SET valorProdutos = valorProdutos + (SELECT precoProduto FROM Produto natural join ProdutoPedido WHERE idProduto = NEW.idProduto),
      valorTotal = valorProdutos + (SELECT precoProduto FROM Produto natural join ProdutoPedido WHERE idProduto = NEW.idProduto) + taxaDeEnvio
  WHERE idPedido = NEW.idPedido;
END;

---Quando se retirado um produto a um pedido, o seu preço é subtraído ao valor dos produtos e o valor total do pedido;
CREATE TRIGGER IF NOT EXISTS removeProdutoDoPedido
BEFORE DELETE ON ProdutoPedido
FOR EACH ROW
BEGIN
  UPDATE Pedido
  SET valorProdutos = valorProdutos - (SELECT precoProduto FROM ProdutoPedido natural join Produto WHERE idProduto = OLD.idProduto),
      valorTotal = valorProdutos - (SELECT precoProduto FROM ProdutoPedido natural join Produto WHERE idProduto = OLD.idProduto) + taxaDeEnvio
  WHERE idPedido = OLD.idPedido;
END;