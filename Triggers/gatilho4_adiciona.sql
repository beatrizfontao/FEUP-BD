.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

---Não permite um restaurante ter mais que um tipoDeComida

CREATE TRIGGER IF NOT EXISTS adicionaTipoDeComida
BEFORE INSERT ON TipoComidaRestaurante
FOR EACH ROW
WHEN EXISTS (SELECT * FROM TipoComidaRestaurante WHERE idRestaurante = NEW.idRestaurante)
BEGIN
  SELECT raise(abort, 'Um restaurante só pode ter um tipo de comida');
END;
  
