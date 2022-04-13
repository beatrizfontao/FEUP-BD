.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

DROP TRIGGER IF EXISTS adicionaProdutoAPedido;
DROP TRIGGER IF EXISTS removeProdutoDoPedido;