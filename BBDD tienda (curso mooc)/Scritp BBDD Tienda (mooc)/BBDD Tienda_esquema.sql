
DROP DATABASE IF EXISTS tienda;
CREATE DATABASE IF NOT EXISTS tienda;
USE tienda;



DROP TABLE IF EXISTS provincia;
CREATE TABLE IF NOT EXISTS provincia (
  codp char(2) NOT NULL,
  nombre char(25) NOT NULL,
  PRIMARY KEY (codp)
);

DROP TABLE IF EXISTS localidad;
CREATE TABLE IF NOT EXISTS localidad (
  provincia char(2) NOT NULL DEFAULT '',
  codloc char(4) NOT NULL DEFAULT '',
  nombre varchar(80) DEFAULT NULL,
  PRIMARY KEY (provincia,codloc),
  CONSTRAINT localidad_ibfk_1 FOREIGN KEY (provincia) REFERENCES provincia (codp)
);

DROP TABLE IF EXISTS usuario;
CREATE TABLE IF NOT EXISTS usuario (
  email varchar(50) NOT NULL,
  nombre varchar(35) NOT NULL,
  apellidos varchar(55) NOT NULL,
  dni varchar(12) NOT NULL,
  telefono varchar(15) DEFAULT NULL,
  calle varchar(45) DEFAULT NULL,
  codpos varchar(5) DEFAULT NULL,
  provincia char(2) DEFAULT NULL,
  localidad char(4) DEFAULT NULL,
  nacido date DEFAULT NULL,
  PRIMARY KEY (email),
  UNIQUE KEY dni_UNIQUE (dni),
  CONSTRAINT FK_usuario_loc FOREIGN KEY (provincia, localidad) REFERENCES localidad (provincia, codloc)
);

DROP TABLE IF EXISTS unidad;
CREATE TABLE IF NOT EXISTS unidad (
  unidad char(1) NOT NULL,
  nombre varchar(15) DEFAULT NULL,
  PRIMARY KEY (unidad)
);


DROP TABLE IF EXISTS articulo;
CREATE TABLE IF NOT EXISTS articulo (
  cod char(5) NOT NULL,
  nombre varchar(45) DEFAULT NULL,
  precio decimal(5,2) DEFAULT NULL,
  unidad char(1) DEFAULT NULL,
  PRIMARY KEY (cod),
  CONSTRAINT articulo_ibfk_1 FOREIGN KEY (unidad) REFERENCES unidad (unidad)
);

DROP TABLE IF EXISTS empaquetado;
CREATE TABLE IF NOT EXISTS empaquetado (
  cod char(7) NOT NULL,
  nombre varchar(45) DEFAULT NULL,
  pvp decimal(7,2) DEFAULT NULL,
  especificaciones varchar(1024) DEFAULT NULL,
  PRIMARY KEY (cod)
);

DROP TABLE IF EXISTS contiene;
CREATE TABLE IF NOT EXISTS contiene (
  empaquetado char(7) NOT NULL,
  articulo char(5) NOT NULL,
  cantidad decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (empaquetado,articulo),
  CONSTRAINT fk_contiene_articulo1 FOREIGN KEY (articulo) REFERENCES articulo (cod),
  CONSTRAINT fk_contiene_empaquetado FOREIGN KEY (empaquetado) REFERENCES empaquetado (cod)
);

DROP TABLE IF EXISTS transporte;
CREATE TABLE IF NOT EXISTS transporte (
  cod char(4) NOT NULL,
  nombre varchar(25) DEFAULT NULL,
  url varchar(60) DEFAULT NULL,
  PRIMARY KEY (cod)
);

DROP TABLE IF EXISTS pedido;
CREATE TABLE IF NOT EXISTS pedido (
  numpedido mediumint(8) unsigned NOT NULL,
  usuario varchar(50) NOT NULL,
  fecha datetime NOT NULL,
  transportista char(4) DEFAULT NULL,
  PRIMARY KEY (numpedido),
  CONSTRAINT fk_PEDIDO_TRANSPORTE FOREIGN KEY (transportista) REFERENCES transporte (cod),
  CONSTRAINT FK_pedido_usu FOREIGN KEY (usuario) REFERENCES usuario (email)
);


DROP TABLE IF EXISTS linped;
CREATE TABLE IF NOT EXISTS linped (
  numpedido mediumint(8) unsigned NOT NULL,
  linea tinyint(3) unsigned NOT NULL,
  articulo char(7) NOT NULL,
  pagado decimal(9,2) NOT NULL,
  cantidad tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (linea,numpedido),
  CONSTRAINT FKpedido FOREIGN KEY (numPedido) REFERENCES pedido (numpedido),
  CONSTRAINT fk_LINPED_ARTICULO FOREIGN KEY (articulo) REFERENCES empaquetado (cod)
);






















