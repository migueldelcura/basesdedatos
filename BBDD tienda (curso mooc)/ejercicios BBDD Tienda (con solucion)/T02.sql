-- T02.001- Obt�n toda la informaci�n de los usuarios
select * from usuario;

T02.002- Lista los email y nombre y apellidos de los usuarios
select email,nombre,apellidos from usuario

T02.003- Lista los email y nombre y apellidos de los usuarios ordenados por email
select email,nombre,apellidos
from usuario
order by email;

T02.004- Lista los email y nombre y apellidos de los usuarios ordenados por apellidos y nombre
select email,nombre,apellidos
from usuario
order by apellidos,nombre;

T02.005- Lista los email y nombre y apellidos de los usuarios ordenados ascendentemente por
apellidos y descendentemente por nombre
select email,nombre,apellidos
from usuario
order by apellidos,nombre desc;

T02.006- Lista los email y nombre y apellidos de los usuarios en orden descendente de apellidos y nombre
select email,nombre,apellidos
from usuario
order by apellidos desc, nombre desc;

T02.007- DNI,email,nombre y apellidos de los usuarios de la provincia de Asturias (c�digo 33).
select dni,email,nombre,apellidos
from usuario
where provincia='33';

Soluci�n alternativa:
select dni,email,u.nombre,apellidos
from usuario u, provincia pv
where u.provincia=codp and pv.nombre='Asturias';

El c�digo de las localidades y de las provincias es texto, no n�mero.

T02.008- Toda la informaci�n (c�digo y nombre) de las provincias de las que se tienen usuarios
select pv.*
from usuario u, provincia pv
where u.provincia=codp;

T02.009- Toda la informaci�n (c�digo y nombre) de las provincias de las que se tienen usuarios,
eliminando duplicados y ordenando por nombre
select distinct pv.*
from usuario u, provincia pv
where u.provincia=codp
order by pv.nombre;

Soluci�n alternativa:
select distinct pv.*
from usuario u, provincia pv
where u.provincia=codp
order by 2;

T02.010- Email de los usuarios de la provincia de Murcia que no tienen tel�fono, acompa�ado en la
salida por un mensaje que diga "No tiene tel�fono"
select email,'No tiene tel�fono'
from usuario u, provincia pv
where u.provincia=codp and pv.nombre = 'Murcia'
and telefono is null;

T02.011- Marcas
select * from marca;

T02.012- Art�culos que no tienen marca
select * from articulo where marca is null

T02.013- C�digo de los art�culos que pertenecen a alg�n pack.
select articulo
from ptienea;

T02.014- N�mero de pack, nombre y precio del mismo.
select p.cod,nombre,pvp
from articulo a, pack p
where a.cod = p.cod

T02.015- C�digo, nombre y marca de los articulos que pertenecen a alg�n pack.
select articulo,nombre,marca
from articulo, ptienea
where cod = articulo

T02.016- C�digo y precio de venta de los art�culos solicitados en el pedido n�mero 1.
select articulo,precio
from linped
where numpedido=1

T02.017- C�digo, nombre, marca, pvp y precio de venta de los art�culos solicitados en el pedido n�mero 1.
select articulo,nombre,marca,pvp,precio
from linped l, articulo a
where numpedido=1
and a.cod=l.articulo

T02.018- C�digo, nombre, marca, pvp y precio de venta de los art�culos solicitados en el pedido n�mero 1 que sean televisores.
select articulo,nombre,marca,pvp,precio
from linped l, articulo a, tv t
where numpedido=1
and a.cod=l.articulo
and a.cod=t.cod

T02.019- Fecha y usuario del pedido, c�digo, nombre, marca, pvp y precio de venta de los art�culos
solicitados en el pedido n�mero 1 que sean televisores.
select fecha,usuario,articulo,nombre,marca,pvp,precio
from linped l, articulo a, tv t, pedido p
where l.numpedido=1 and l.numpedido = p.numpedido
and a.cod=l.articulo
and a.cod=t.cod

T02.021- C�digo,nombre y precio de venta al p�blico de los art�culos de menos de 100�; la salida ha de
ser c�digo, nombre, "tiene el precio de", pvp.
select cod,nombre,'tiene el precio de',pvp from articulo where pvp < 100

T02.022- C�digo, sensor y pantalla de las c�maras, si es que "pantalla" tiene valor, ordenado por c�digo
descendentemente;
select cod,sensor,pantalla
from camara
where pantalla is not null order by cod desc;

T02.023- Panel de los televisores de 21 pulgadas o menos de pantalla, eliminando duplicados.
select distinct panel
from tv
where pantalla <= 21;

T02.024- C�digo, nombre, marca y precio de venta al p�blico de los art�culos que tienen ese precio
entre 350 y 450.
select cod, nombre, marca, pvp
from articulo
where pvp >=350 and pvp <= 450;

T02.025- N�mero de pack, nombre y precio del mismo, y c�digo, nombre y pvp de los art�culos que
pertenezcan a ellos.
select p.cod, a1.nombre, a1.pvp, a2.cod, a2.nombre, a2.pvp
from articulo a1, pack p, ptienea pp, articulo a2
where a1.cod = p.cod
and pp.pack = p.cod
and pp.articulo = a2.cod