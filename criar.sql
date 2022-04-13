.mode columns
.headers on
.nullvalue NULL

PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

----
-- Table: Localidade
DROP TABLE IF EXISTS Localidade;
CREATE TABLE Localidade (
    idLocalidade INTEGER CONSTRAINT idLocalidade_PK PRIMARY KEY,
    localidade   TEXT    UNIQUE
                         NOT NULL
);

-- Table: CodigoPostal
DROP TABLE IF EXISTS CodigoPostal;
CREATE TABLE CodigoPostal (
    idCodigo     INTEGER CONSTRAINT idCodigoPostal_PK PRIMARY KEY,
    codigo       TEXT    NOT NULL
                         UNIQUE,
    idLocalidade INTEGER CONSTRAINT CodigoPostal_idLocalidade_FK1 REFERENCES Localidade (idLocalidade) 
                         NOT NULL
);

-- Table: Morada
DROP TABLE IF EXISTS Morada;
CREATE TABLE Morada (
    idMorada       INTEGER CONSTRAINT idMorada_PK PRIMARY KEY,
    linha1         TEXT    NOT NULL,
    linha2         TEXT,
    idCodigo INTEGER CONSTRAINT Morada_idCodigo_FK1 REFERENCES CodigoPostal (idCodigo) 
                           NOT NULL
);

-- Table: Cliente
DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente (
    idCliente INTEGER CONSTRAINT idCliente_PK PRIMARY KEY AUTOINCREMENT,
    nome      TEXT    NOT NULL,
    email     TEXT    NOT NULL
                      UNIQUE,
    nif       INTEGER UNIQUE
                      NOT NULL,
    telefone  INTEGER UNIQUE
                      NOT NULL,
    idMorada  INTEGER CONSTRAINT Cliente_idMorada_FK1 REFERENCES Morada (idMorada) 
                      NOT NULL
);

-- Table: Estafeta
DROP TABLE IF EXISTS Estafeta;
CREATE TABLE Estafeta (
    idEstafeta       INTEGER CONSTRAINT idEstafeta_PK PRIMARY KEY,
    nome             TEXT    NOT NULL,
    email            TEXT    NOT NULL
                             UNIQUE,
    nif              INTEGER UNIQUE
                             NOT NULL,
    telefone         INTEGER UNIQUE
                             NOT NULL,
    idMorada         INTEGER NOT NULL
                             CONSTRAINT Estafeta_idMorada_FK1 REFERENCES Morada (idMorada),
    numCartaConducao INTEGER UNIQUE
                             NOT NULL,
    numEntregas      INTEGER DEFAULT (0) 
                             NOT NULL
);

-- Table: TipoVeiculo
DROP TABLE IF EXISTS TipoVeiculo;
CREATE TABLE TipoVeiculo (
    idTipoVeiculo INTEGER CONSTRAINT idTipoVeiculo_PK PRIMARY KEY,
    designacao    TEXT    NOT NULL
                          CHECK (designacao = "Carro" OR 
                                 designacao = "Mota") 
                          UNIQUE
);

-- Table: Veiculo
DROP TABLE IF EXISTS Veiculo;
CREATE TABLE Veiculo (
    matricula     TEXT CONSTRAINT matricula_PK PRIMARY KEY, 
    idTipoVeiculo INTEGER  CONSTRAINT Veiculo_idTipoVeiculo_FK1 REFERENCES TipoVeiculo (idTipoVeiculo) 
                           NOT NULL
);

-- Table: VeiculoEstafeta
DROP TABLE IF EXISTS VeiculoEstafeta;
CREATE TABLE VeiculoEstafeta (
    idEstafeta INTEGER CONSTRAINT VeiculoEstafeta_idEstafeta_FK1 REFERENCES Estafeta (idEstafeta),
    matricula  INTEGER CONSTRAINT VeiculoEstafeta_matricula_FK2 REFERENCES Veiculo (matricula),
    PRIMARY KEY (
        idEstafeta,
        matricula
    )
);

-- Table: TipoComida
DROP TABLE IF EXISTS TipoComida;
CREATE TABLE TipoComida (
    idTipoComida INTEGER CONSTRAINT idTipoComida_PK PRIMARY KEY,
    nome         TEXT    UNIQUE
                         NOT NULL
);

-- Table: Restaurante
DROP TABLE IF EXISTS Restaurante;
CREATE TABLE Restaurante (
    idRestaurante INTEGER CONSTRAINT idRestaurante_PK PRIMARY KEY,
    nome          TEXT    NOT NULL,
    telefone      INTEGER NOT NULL
                          UNIQUE,
    idMorada      INTEGER CONSTRAINT Restaurante_idMorada_FK1 REFERENCES Morada (idMorada) 
                          NOT NULL
                          UNIQUE
);

-- Table: TipoComidaRestaurante
DROP TABLE IF EXISTS TipoComidaRestaurante;
CREATE TABLE TipoComidaRestaurante (
    idRestaurante INTEGER CONSTRAINT TipoComidaRestaurante_idRestaurante_FK1 REFERENCES Restaurante (idRestaurante),
    idTipoComida  INTEGER CONSTRAINT TipoComidaRestaurante_idTipoComida_FK2 REFERENCES TipoComida (idTipoComida),
    PRIMARY KEY (
        idRestaurante,
        idTipoComida
    )
);

-- Table: Produto
DROP TABLE IF EXISTS Produto;
CREATE TABLE Produto (
    idProduto     INTEGER CONSTRAINT idProduto_PK PRIMARY KEY,
    nome          TEXT    NOT NULL,
    precoProduto  REAL    NOT NULL
                          CHECK (precoProduto > 0),
    idRestaurante INTEGER CONSTRAINT Produto_idRestaurante_FK1 REFERENCES Restaurante (idRestaurante) 
                          NOT NULL
);

-- Table: Menu
DROP TABLE IF EXISTS Menu;
CREATE TABLE Menu (
    idMenu        INTEGER CONSTRAINT idMenu_PK PRIMARY KEY,
    nome          TEXT    NOT NULL,
    precoMenu     REAL    NOT NULL
                          CHECK (precoMenu > 0),
    idRestaurante INTEGER CONSTRAINT Menu_idRestaurante_FK1 REFERENCES Restaurante (idRestaurante) 
                          NOT NULL
);

-- Table: ProdutosMenu
DROP TABLE IF EXISTS ProdutosMenu;
CREATE TABLE ProdutosMenu (
    idProduto INTEGER CONSTRAINT ProdutosMenu_idProduto_FK1 REFERENCES Produto (idProduto),
    idMenu    INTEGER CONSTRAINT ProdutosMenu_idMenu_FK2 REFERENCES Menu (idMenu),
    PRIMARY KEY (
        idProduto,
        idMenu
    )
);

-- Table: MetodoPagamento
DROP TABLE IF EXISTS MetodoPagamento;
CREATE TABLE MetodoPagamento (
    idMetodo INTEGER CONSTRAINT idMetodo_PK PRIMARY KEY,
    metodo   TEXT    NOT NULL
                     CHECK (metodo = "Multibanco" OR 
                            metodo = "MBWay" OR 
                            metodo = "PayPal") 
                     UNIQUE
);

-- Table: Pedido
DROP TABLE IF EXISTS Pedido;
CREATE TABLE Pedido (
    idPedido         INTEGER CONSTRAINT idPedido_PK PRIMARY KEY,
    valorProdutos    REAL    DEFAULT ('0'),
    taxaDeEnvio      REAL    CHECK (taxaDeEnvio >= 0)
                             DEFAULT ('0'),
    valorTotal       REAL    DEFAULT ('0'),
    data             DATE    NOT NULL,
    grauDeSatisfacao INTEGER CHECK (grauDeSatisfacao = 1 OR 
                                    grauDeSatisfacao = 2 OR 
                                    grauDeSatisfacao = 3 OR 
                                    grauDeSatisfacao = 4 OR 
                                    grauDeSatisfacao = 5),
    idMorada         INTEGER CONSTRAINT Pedido_idMorada_FK1 REFERENCES Morada (idMorada)
                             NOT NULL,
    idMetodo         INTEGER CONSTRAINT Pedido_idMetodo_FK2 REFERENCES MetodoPagamento (idMetodo) 
                             NOT NULL,
    idEstafeta       INTEGER CONSTRAINT Pedido_idEstafeta_FK3 REFERENCES Estafeta (idEstafeta) 
                             NOT NULL,
    idCliente        INTEGER NOT NULL
                             CONSTRAINT Pedido_idCliente_FK4 REFERENCES Cliente (idCliente) 
);

-- Table: ProdutoPedido
DROP TABLE IF EXISTS ProdutoPedido;
CREATE TABLE ProdutoPedido (
    idPedido  INTEGER CONSTRAINT ProdutoPedido_idPedido_FK1 REFERENCES Pedido (idPedido),
    idProduto INTEGER CONSTRAINT ProdutoPedido_idProduto_FK2 REFERENCES Produto (idProduto),
    PRIMARY KEY (
        idPedido,
        idProduto
    )
);

-- Table: MenuPedido
DROP TABLE IF EXISTS MenuPedido;
CREATE TABLE MenuPedido (
    idPedido INTEGER CONSTRAINT MenuPedido_idPedido_FK1 REFERENCES Pedido (idPedido),
    idMenu   INTEGER CONSTRAINT MenuPedido_idMenu_FK2 REFERENCES Menu (idMenu),
    PRIMARY KEY (
        idPedido,
        idMenu
    )
);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;