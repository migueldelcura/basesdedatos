-- T02.001- Obtén toda la información de los usuarios
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

T02.007- DNI,email,nombre y apellidos de los usuarios de la provincia de Asturias (código 33).
select dni,email,nombre,apellidos
from usuario
where provincia='33';

Solución alternativa:
select dni,email,u.nombre,apellidos
from usuario u, provincia pv
where u.provincia=codp and pv.nombre='Asturias';

El código de las localidades y de las provincias es texto, no número.

T02.008- Toda la información (código y nombre) de las provincias de las que se tienen usuarios
select pv.*
from usuario u, provincia pv
where u.provincia=codp;

T02.009- Toda la información (código y nombre) de las provincias de las que se tienen usuarios,
eliminando duplicados y ordenando por nombre
select distinct pv.*
from usuario u, provincia pv
where u.provincia=codp
order by pv.nombre;

Solución alternativa:
select distinct pv.*
from usuario u, provincia pv
where u.provincia=codp
order by 2;

T02.010- Email de los usuarios de la provincia de Murcia que no tienen teléfono, acompañado en la
salida por un mensaje que diga "No tiene teléfono"
select email,'No tiene teléfono'
from usuario u, provincia pv
where u.provincia=codp and pv.nombre = 'Murcia'
and telefono is null;

T02.011- Marcas
select * from marca;

T02.012- Artículos que no tienen marca
select * from articulo where marca is null

T02.013- Código de los artículos que pertenecen a algún pack.
select articulo
from ptienea;

T02.014- Número de pack, nombre y precio del mismo.
select p.cod,nombre,pvp
from articulo a, pack p
where a.cod = p.cod

T02.015- Código, nombre y marca de los articulos que pertenecen a algún pack.
select articulo,nombre,marca
from articulo, ptienea
where cod = articulo

T02.016- Código y precio de venta de los artículos solicitados en el pedido número 1.
select articulo,precio
from linped
where numpedido=1

T02.017- Código, nombre, marca, pvp y precio de venta de los artículos solicitados en el pedido número 1.
select articulo,nombre,marca,pvp,precio
from linped l, articulo a
where numpedido=1
and a.cod=l.articulo

T02.018- Código, nombre, marca, pvp y precio de venta de los artículos solicitados en el pedido número 1 que sean televisores.
select articulo,nombre,marca,pvp,precio
from linped l, articulo a, tv t
where numpedido=1
and a.cod=l.articulo
and a.cod=t.cod

T02.019- Fecha y usuario del pedido, código, nombre, marca, pvp y precio de venta de los artículos
solicitados en el pedido número 1 que sean televisores.
select fecha,usuario,articulo,nombre,marca,pvp,precio
from linped l, articulo a, tv t, pedido p
where l.numpedido=1 and l.numpedido = p.numpedido
and a.cod=l.articulo
and a.cod=t.cod

T02.021- Código,nombre y precio de venta al público de los artículos de menos de 100€; la salida ha de
ser código, nombre, "tiene el precio de", pvp.
select cod,nombre,'tiene el precio de',pvp from articulo where pvp < 100

T02.022- Código, sensor y pantalla de las cámaras, si es que "pantalla" tiene valor, ordenado por código
descendentemente;
select cod,sensor,pantalla
from camara
where pantalla is not null order by cod desc;

T02.023- Panel de los televisores de 21 pulgadas o menos de pantalla, eliminando duplicados.
select distinct panel
from tv
where pantalla <= 21;

T02.024- Código, nombre, marca y precio de venta al público de los artículos que tienen ese precio
entre 350 y 450.
select cod, nombre, marca, pvp
from articulo
where pvp >=350 and pvp <= 450;

T02.025- Número de pack, nombre y precio del mismo, y código, nombre y pvp de los artículos que
pertenezcan a ellos.
select p.cod, a1.nombre, a1.pvp, a2.cod, a2.nombre, a2.pvp
from articulo a1, pack p, ptienea pp, articulo a2
where a1.cod = p.cod
and pp.pack = p.cod
and pp.articulo = a2.cod