T06.001- Crea una tabla de nombre XX con 2 columnas, col1 de tipo integer, y col2 de tipo char(3), con
col1 como clave primaria.
create table XX (col1 integer, col2 char(3), primary key (col1))

T06.002- Consulta la tabla
select * from xx
Obviamente, la tabla está vacía y muestra 0 filas.

T06.003- Inserta en la tabla la fila (1,’AA’)
insert into xx values (1,'AA')
Ningún problema, fila insertada.

T06.004- inserta en la tabla la fila ('BB',2)
insert into xx values ('BB',2)
Esta orden falla porque los valores no están en el orden adecuado. En este caso deberíamos escribir:
insert into xx (col2,col1) values ('BB',2)
NOTA: en nuestro servidor MySQL, el sistema lanza un warning pero ejecuta la sentencia realizando una conversión
de tipos de varchar a int, pero como 'BB' no sabe interpretarlo, lo almacena como 0.

T06.005- Inserta en la tabla la fila (2,'BB')
insert into xx values (2,'BB')
Hemos cambiado el orden de los valores y coinciden con la estructura de la tabla.

T06.006- Consulta la tabla XX
select * from xx
Deberías ver 2 filas.


T06.007- Cierra la sesión e identifícate de nuevo (“salte y vuelve a entrar” o "desconecta" y "conecta" )
A continuación consulta de nuevo XX
En realidad, si lo tienes claro, no hace falta que lo hagas. Lo que se pretende es comprobar la
persistencia de la tabla creada y los datos que pueda contener: el cierre de sesión no borra lo
almacenado. Sólo drop table puede eliminar la tabla del catálogo.
select * from xx
Al volver a entrar, identificarte correctamente y seleccionar tu base de datos, la consulta devuelve otra vez las
mismas 2 filas, la información se ha mantenido intacta.

T06.008- Borra la tabla XX
drop table xx
Borrar una tabla elimina todo del sistema, sus filas y la propia tabla. Si intentas ahora select * from xx obtendrás un
mensaje de error.

T06.009- Crea una tabla YY con 3 columnas
col1(integer),
col2(char(2)) y
col3(varchar(10)),
y con clave primaria (col1, col2)
create table yy (
col1 integer,
col2 char(2),
col3 varchar(10),
primary key (col1, col2))
Ahora la clave primaria está compuesta por 2 columnas.

T06.010- Inserta los siguientes datos y consulta la tabla para ver los datos almacenados
(1,'AA','primera')
(2,'AA','segunda')
(2,'BB','tercera')
(1,'AA','cuarta')
(NULL,NULL,'quinta')
(NULL,'CC','sexta')
(3,NULL,'séptima')
(0,'','octava') --0, cadena vacía, 'octava'
(3,'AA',NULL)
insert into yy values (1,'AA','primera');
insert into yy values (2,'AA','segunda');
insert into yy values (2,'BB','tercera');
insert into yy values (1,'AA','cuarta');
insert into yy values (NULL,NULL,'quinta');
insert into yy values (NULL,'CC','sexta');
insert into yy values (3,NULL,'séptima');
insert into yy values (0,'','octava');
insert into yy values (3,'AA',NULL);
* insert into yy values (1,'AA','cuarta') falla por que estamos introduciendo un duplicado de clave primaria.
* insert into yy values (NULL,NULL,'quinta') falla por que la clave primaria no admite nulos.
* insert into yy values (NULL,'CC','sexta') falla por que tampoco los admite parcialmente.
* insert into yy values (3,NULL,'séptima') falla por la misma razón.
* insert into yy values (0,'','octava') NO falla porque cadena vacía es un valor, NO es NULL.

T06.011- Ejecuta lo siguiente:
create table T1(a int,b int,c int,
primary key(a)) engine=innodb;
create table T2(a int,d int,e int,
primary key(d),foreign key(a) references T1(a)) engine=innodb;
y comprueba, buscando el porqué en caso de fallo, el resultado de cada una de las órdenes de la
siguiente secuencia:
a) insertar en T1(1,10,100)
b) insertar en T1(NULO,20,NULO)
c) insertar en T1(2,20,NULO)
d) insertar en T1(3,NULO,300)
e) insertar en T2(2,NULO,NULO)
f) insertar en T2(2,20,NULO)
g) insertar en T1(1,20,200)
h) insertar en T2(4,10,100)
i) insertar en T2(2,30,230)
insert into T1 values (1,10,100); -- a
insert into T1 values (NULL,20,NULL); -- b falla
insert into T1 values (2,20,NULL); -- c
Fundamentos de las Bases de Datos, grados I. Informática e I. Multimedia 23
BDgite, DLSI, Universidad de Alicante
insert into T1 values (3,NULL,300); -- d
insert into T2 values (2,NULL,NULL); -- e falla
insert into T2 values (2,20,NULL); -- f
insert into T1 values (1,20,200); -- g falla
insert into T2 values (4,10,100); -- h falla
insert into T2 values (2,30,230);-- i

T06.012- Continúa el anterior
j) modificar T1(1,10,100) a (2,10,100)
k) modificar T1(1,10,100) a (5,10,100)
l) modificar T2(2,20,NULO) a (2,20,220)
m) modificar T2(2,20,220) a (5,20,220)
n) modificar T2(5,20,220) a (2,10,100)
o) modificar T1(2,20,200) a (6,60,600)
p) modificar T1(3,NULO,300) a (7,70,700)
q) modificar T2(2,10,100) a (7,10,100)
r) modificar T2(2,30,230) a (7,30,230)
s) modificar T1(2,20,NULO) a (6,60,600)
update T1 set a=2 where a=1; -- j falla
update T1 set a=5 where a=1; -- k
update T2 set e=220 where d=20; -- l
update T2 set a=5 where d=20; -- m
update T2 set a=2,d=10,e=100 where d=20; -- n
update T1 set a=6,b=60,c=600 where a=2; -- o falla
update T1 set a=7,b=70,c=700 where a=3; -- p
update T2 set a=7 where d=10; -- q
update T2 set a=7 where d=30; -- r
update T1 set a=6,b=60,c=600 where a=2; -- s

T06.013- Continúa el anterior
t) borrar T2(7,30,230)
u) borrar T1(7,70,700)
v) borrar T1(5,10,100)
w) borrar T2(7,10,100)
x) borrar T1(7,70,700)
y) borrar T1(6,60,600)
delete from T2 where d=30; -- t
delete from T1 where a=7; -- u falla
delete from T1 where a=5; -- v
delete from T2 where d=10; -- w
delete from T1 where a=7; -- x ahora sí
delete from T1 where a=6; -- y
El resultado final debe ser las 2 tablas vacías de filas.