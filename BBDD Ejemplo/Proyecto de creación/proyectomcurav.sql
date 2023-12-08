DROP DATABASE IF EXISTS proyectomcurav;
CREATE DATABASE proyectomcurav;

USE proyectomcurav;

DROP TABLE IF EXISTS profesores;
CREATE TABLE if not exists profesores(
dni char(9),
ingreso date ,
categoria varchar(15),
nombre varchar(15),
primary key(dni)
); 

DROP TABLE IF EXISTS asignaturas;
CREATE TABLE if not exists asignaturas(
codigo VARCHAR(5),
descripcion VARCHAR(30) NOT null,
creditos DECIMAL(1,1) NOT null,
creditosp DECIMAL(1,1) NOT null,
primary key(codigo)
); 


DROP TABLE IF EXISTS coordinadores;
CREATE TABLE if not exists coordinadores(
dni CHAR (9),
nombre VARCHAR(15),
dpt CHAR(5),
codigoasignatura VARCHAR(5),
primary key(dni),
constraint fk_coordinadores_asignaturas FOREIGN KEY(codigoasignatura) REFERENCES asignaturas(codigo) ON UPDATE restrict ON DELETE restrict 
);

DROP TABLE IF EXISTS imparte;
CREATE TABLE if not exists imparte(
dniprofesores CHAR(9),
codigoasignaturas VARCHAR(5),
primary key(dniprofesores,codigoasignaturas),
constraint fk_imparte_profesores FOREIGN KEY(dniprofesores) REFERENCES coordinadores(dni) ON UPDATE restrict ON DELETE RESTRICT, 
constraint fk_imparte_asignaturas FOREIGN KEY(codigoasignaturas) REFERENCES asignaturas(codigo) ON UPDATE restrict ON DELETE restrict 
); 

DROP TABLE IF EXISTS prepara;
CREATE TABLE if not exists prepara(
dniprofesores CHAR(9),
codigoasignaturas VARCHAR(5),
primary key(dniprofesores,codigoasignaturas),
constraint fk_prepara_profesores FOREIGN KEY(dniprofesores) REFERENCES coordinadores(dni) ON UPDATE restrict ON DELETE RESTRICT, 
constraint fk_prepara_asignaturas FOREIGN KEY(codigoasignaturas) REFERENCES asignaturas(codigo) ON UPDATE restrict ON DELETE restrict 
); 