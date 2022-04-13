.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

---Quando se adiciona um menu a um pedido, o seu preço é adicionado ao valor dos produtos e o valor total do pedido;
CREATE TRIGGER IF NOT EXISTS adicionaMenuAPedido
AFTER INSERT ON MenuPedido
FOR EACH ROW
BEGIN
  UPDATE Pedido
  SET valorProdutos = valorProdutos + (SELECT precoMenu FROM Menu natural join MenuPedido WHERE idMenu = NEW.idMenu),
      valorTotal = valorTotal + (SELECT precoMenu FROM Menu natural join MenuPedido WHERE idMenu = NEW.idMenu)
  WHERE idPedido = NEW.idPedido;
END;

---Quando se retirado um Menu a um pedido, o seu preço é subtraído ao valor dos produtos e o valor total do pedido;
CREATE TRIGGER IF NOT EXISTS removeMenuDoPedido
BEFORE DELETE ON MenuPedido
FOR EACH ROW
BEGIN
  UPDATE Pedido
  SET valorProdutos = valorProdutos - (SELECT precoMenu FROM MenuPedido natural join Menu WHERE idMenu = OLD.idMenu),
      valorTotal = valorTotal - (SELECT precoMenu FROM MenuPedido natural join Menu WHERE idMenu = OLD.idMenu)
  WHERE idPedido = OLD.idPedido;
END;