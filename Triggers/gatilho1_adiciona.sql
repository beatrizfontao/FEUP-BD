.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

---Quando um estafeta é atribuido a um pedido, o número de entregas dele é atualizado
CREATE TRIGGER IF NOT EXISTS adicionaEntrega
AFTER INSERT ON Pedido
FOR EACH ROW
BEGIN
  UPDATE Estafeta
  SET numEntregas = numEntregas + 1
  WHERE (idEstafeta = NEW.idEstafeta);
END;