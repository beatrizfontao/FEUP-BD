.print 'Gatilho 4'

.print ''
.print 'Estado atual dos restaurantes e dos seus tipos de comida:'
.print ''

SELECT Restaurante.idRestaurante, Restaurante.nome, TipoComida.idTipoComida, TipoComida.nome 
FROM Restaurante, TipoComida, TipoComidaRestaurante
WHERE TipoComida.idTipoComida = TipoComidaRestaurante.idTipoComida
      AND Restaurante.idRestaurante = TipoComidaRestaurante.idRestaurante;

---Adição de um restaurante e de um tipo de comida (dados válidos):
INSERT INTO Restaurante(idRestaurante,nome,telefone,idMorada) VALUES (11,"Restaurante","912345678",41);
INSERT INTO TipoComidaRestaurante(idTipoComida,idRestaurante) VALUES (7,11);

.print ''
.print 'Estado atual dos restaurantes e dos seus tipos de comida após adição de um restaurante e do seu tipo de comida:'
.print ''

SELECT Restaurante.idRestaurante, Restaurante.nome, TipoComida.idTipoComida, TipoComida.nome 
FROM Restaurante, TipoComida, TipoComidaRestaurante
WHERE TipoComida.idTipoComida = TipoComidaRestaurante.idTipoComida
      AND Restaurante.idRestaurante = TipoComidaRestaurante.idRestaurante;

.print ''
---Adição de um novo tipo de comida a um restaurante que já tem tipo de comida associado:
INSERT INTO TipoComidaRestaurante(idTipoComida,idRestaurante) VALUES (6,11);


.print ''
.print 'Estado atual dos restaurantes e dos seus tipos de comida após tentativa de adição de um novo tipo de comida a um restaurante:'
.print ''

SELECT Restaurante.idRestaurante, Restaurante.nome, TipoComida.idTipoComida, TipoComida.nome 
FROM Restaurante, TipoComida, TipoComidaRestaurante
WHERE TipoComida.idTipoComida = TipoComidaRestaurante.idTipoComida
      AND Restaurante.idRestaurante = TipoComidaRestaurante.idRestaurante;