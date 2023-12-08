T05.001- Número de pedido e identificador, apellidos y nombre del usuario que realiza el pedido
(usando join).
select numpedido,usuario,apellidos,nombre
from pedido join usuario on (usuario=email)
order by apellidos,nombre;

Solución alternativa:
select numpedido,usuario,apellidos,nombre
from pedido, usuario
where usuario=email
order by 3,4;

T05.002- Número de pedido e identificador, apellidos y nombre del usuario que realiza el pedido, y
nombre de la localidad del usuario (usando join).
select numpedido,usuario,apellidos,u.nombre,l.pueblo
from pedido
join usuario u on (usuario=email)
join localidad l on (l.codm=u.pueblo and l.provincia=u.provincia)
order by apellidos,u.nombre;

T05.003- Número de pedido e identificador, apellidos y nombre del usuario que realiza el pedido,
nombre de la localidad y nombre de la provincia del usuario (usando join).
select numpedido,usuario,apellidos,u.nombre,l.pueblo,p.nombre
from pedido join usuario u on (usuario=email)
join localidad l on (l.codm=u.pueblo and l.provincia=u.provincia)
join provincia p on (l.provincia=codp)
order by apellidos,u.nombre;

T05.004- Nombre de provincia y nombre de localidad ordenados por provincia y localidad (usando
join) de las provincias de Aragón y de localidades cuyo nombre comience por "B".
select nombre,pueblo from provincia join localidad on (provincia=codp)
where nombre in ('huesca','zaragoza','teruel')
and pueblo like 'B%' order by nombre,pueblo;

T05.005- Apellidos y nombre de los usuarios y, si tienen, pedido que han realizado.
select apellidos,nombre,numpedido
from usuario left join pedido on (email=usuario);

T05.006- Código y nombre de los artículos, si además es una cámara, mostrar también la resolución y el
sensor.
select a.cod, nombre, resolucion, sensor
from articulo a
Fundamentos de las Bases de Datos, grados I. Informática e I. Multimedia 17
BDgite, DLSI, Universidad de Alicante
left join camara c on (a.cod = c.cod);

T05.007- Código, nombre y precio de venta al público de los artículos, si además se trata de un objetivo
mostrar todos sus datos.
select a.cod, nombre, pvp, o.*
from articulo a
left join objetivo o on (a.cod = o.cod);

T05.008- Muestra las cestas del año 2010 junto con el nombre del artículo al que referencia y su precio
de venta al público.
select c.*, nombre, pvp
from cesta c
join articulo on (cod=articulo)
where year(fecha) = 2010;
Solución alternativa:
select c.*, nombre, pvp
from cesta c
join articulo on (cod=articulo and year(fecha) = 2010);

T05.009- Muestra toda la información de los artículos. Si alguno aparece en una cesta del año 2010
muestra esta información.
select a.*, c.*
from articulo a
left join cesta c on (articulo=cod and year(fecha) = 2010);
A diferencia del ejercicio anterior, es obligatorio incluir la condición de la fecha en la condición del join puesto que
queremos la información de todos los artículos y solo las cestas de 2010 en las que estén aquellos. Prueba lo
siguiente:
select a.*, c.*
from articulo a
left join cesta c on (articulo=cod)
where year(fecha) = 2010;

T05.010- Disponibilidad en el stock de cada cámara junto con la resolución de todas las cámaras.
select s.*, resolucion
from stock s
right join camara on (cod=articulo);

T05.011- Código y nombre de los artículos que no tienen marca.
select cod, nombre
from articulo
where marca is null;

T05.012- Código, nombre y marca de todos los artículos, tengan o no marca.
select cod, nombre, marca
from articulo;

T05.013- Código, nombre, marca y empresa responsable de la misma de todos los artículos. Si algún
artículo no tiene marca debe aparecer en el listado con esta información vacía.
select cod, nombre, a.marca, empresa
from articulo a
left join marca m on (a.marca = m.marca);

T05.014- Información de todos los usuarios de la comunidad valenciana cuyo nombre empiece por 'P'
incluyendo la dirección de envío en caso de que la tenga.
select u.*, d.*
from usuario u
left join direnvio d on (d.email=u.email)
where u.provincia in ('46','03','12')
and u.nombre like 'P%';

Solución alternativa:
select u.*, d.*
from usuario u
join provincia p on (u.provincia = codp)
left join direnvio d on (d.email=u.email)
where (p.nombre like '%Alicante%'
or p.nombre like '%Valencia%'
or p.nombre like '%Castell%')
and u.nombre like 'P%';
La forma más sencilla necesita conocer los códigos de provincia y, además, tener en cuenta que estos códigos son
cadenas de caracteres.
La forma alternativa utiliza el like para evitar problemas de comparación.

T05.015- Código y nombre de los artículos, y código de pack en el caso de que pertenezca a alguno.
select cod, nombre, pack
from articulo
left join ptienea on (cod=articulo);

T05.016- Usuarios y pedidos que han realizado.
select u.*, p.*
from usuario u, pedido p
where u.email=p.usuario;
Solución alternativa:
select *
from usuario u
join pedido p on (u.email=p.usuario);
Nótese que no se ha dicho "...y, si tienen, pedidos que..."

T05.017- Información de aquellos usuarios de la comunidad valenciana (códigos 03, 12 y 46) cuyo
nombre empiece por 'P' que tienen dirección de envío pero mostrando, a la derecha, todas las
direcciones de envío de la base de datos.
select u.*, d.*
from usuario u
right join direnvio d
on (d.email=u.email
and u.provincia in ('46','03','12')
and u.nombre like 'P%');
Nótese, respecto de otro ejercicio similar, que las condiciones del usuario se han introducido dentro de la condición
del right join.