T05.001- N�mero de pedido e identificador, apellidos y nombre del usuario que realiza el pedido
(usando join).
select numpedido,usuario,apellidos,nombre
from pedido join usuario on (usuario=email)
order by apellidos,nombre;

Soluci�n alternativa:
select numpedido,usuario,apellidos,nombre
from pedido, usuario
where usuario=email
order by 3,4;

T05.002- N�mero de pedido e identificador, apellidos y nombre del usuario que realiza el pedido, y
nombre de la localidad del usuario (usando join).
select numpedido,usuario,apellidos,u.nombre,l.pueblo
from pedido
join usuario u on (usuario=email)
join localidad l on (l.codm=u.pueblo and l.provincia=u.provincia)
order by apellidos,u.nombre;

T05.003- N�mero de pedido e identificador, apellidos y nombre del usuario que realiza el pedido,
nombre de la localidad y nombre de la provincia del usuario (usando join).
select numpedido,usuario,apellidos,u.nombre,l.pueblo,p.nombre
from pedido join usuario u on (usuario=email)
join localidad l on (l.codm=u.pueblo and l.provincia=u.provincia)
join provincia p on (l.provincia=codp)
order by apellidos,u.nombre;

T05.004- Nombre de provincia y nombre de localidad ordenados por provincia y localidad (usando
join) de las provincias de Arag�n y de localidades cuyo nombre comience por "B".
select nombre,pueblo from provincia join localidad on (provincia=codp)
where nombre in ('huesca','zaragoza','teruel')
and pueblo like 'B%' order by nombre,pueblo;

T05.005- Apellidos y nombre de los usuarios y, si tienen, pedido que han realizado.
select apellidos,nombre,numpedido
from usuario left join pedido on (email=usuario);

T05.006- C�digo y nombre de los art�culos, si adem�s es una c�mara, mostrar tambi�n la resoluci�n y el
sensor.
select a.cod, nombre, resolucion, sensor
from articulo a
Fundamentos de las Bases de Datos, grados I. Inform�tica e I. Multimedia 17
BDgite, DLSI, Universidad de Alicante
left join camara c on (a.cod = c.cod);

T05.007- C�digo, nombre y precio de venta al p�blico de los art�culos, si adem�s se trata de un objetivo
mostrar todos sus datos.
select a.cod, nombre, pvp, o.*
from articulo a
left join objetivo o on (a.cod = o.cod);

T05.008- Muestra las cestas del a�o 2010 junto con el nombre del art�culo al que referencia y su precio
de venta al p�blico.
select c.*, nombre, pvp
from cesta c
join articulo on (cod=articulo)
where year(fecha) = 2010;
Soluci�n alternativa:
select c.*, nombre, pvp
from cesta c
join articulo on (cod=articulo and year(fecha) = 2010);

T05.009- Muestra toda la informaci�n de los art�culos. Si alguno aparece en una cesta del a�o 2010
muestra esta informaci�n.
select a.*, c.*
from articulo a
left join cesta c on (articulo=cod and year(fecha) = 2010);
A diferencia del ejercicio anterior, es obligatorio incluir la condici�n de la fecha en la condici�n del join puesto que
queremos la informaci�n de todos los art�culos y solo las cestas de 2010 en las que est�n aquellos. Prueba lo
siguiente:
select a.*, c.*
from articulo a
left join cesta c on (articulo=cod)
where year(fecha) = 2010;

T05.010- Disponibilidad en el stock de cada c�mara junto con la resoluci�n de todas las c�maras.
select s.*, resolucion
from stock s
right join camara on (cod=articulo);

T05.011- C�digo y nombre de los art�culos que no tienen marca.
select cod, nombre
from articulo
where marca is null;

T05.012- C�digo, nombre y marca de todos los art�culos, tengan o no marca.
select cod, nombre, marca
from articulo;

T05.013- C�digo, nombre, marca y empresa responsable de la misma de todos los art�culos. Si alg�n
art�culo no tiene marca debe aparecer en el listado con esta informaci�n vac�a.
select cod, nombre, a.marca, empresa
from articulo a
left join marca m on (a.marca = m.marca);

T05.014- Informaci�n de todos los usuarios de la comunidad valenciana cuyo nombre empiece por 'P'
incluyendo la direcci�n de env�o en caso de que la tenga.
select u.*, d.*
from usuario u
left join direnvio d on (d.email=u.email)
where u.provincia in ('46','03','12')
and u.nombre like 'P%';

Soluci�n alternativa:
select u.*, d.*
from usuario u
join provincia p on (u.provincia = codp)
left join direnvio d on (d.email=u.email)
where (p.nombre like '%Alicante%'
or p.nombre like '%Valencia%'
or p.nombre like '%Castell%')
and u.nombre like 'P%';
La forma m�s sencilla necesita conocer los c�digos de provincia y, adem�s, tener en cuenta que estos c�digos son
cadenas de caracteres.
La forma alternativa utiliza el like para evitar problemas de comparaci�n.

T05.015- C�digo y nombre de los art�culos, y c�digo de pack en el caso de que pertenezca a alguno.
select cod, nombre, pack
from articulo
left join ptienea on (cod=articulo);

T05.016- Usuarios y pedidos que han realizado.
select u.*, p.*
from usuario u, pedido p
where u.email=p.usuario;
Soluci�n alternativa:
select *
from usuario u
join pedido p on (u.email=p.usuario);
N�tese que no se ha dicho "...y, si tienen, pedidos que..."

T05.017- Informaci�n de aquellos usuarios de la comunidad valenciana (c�digos 03, 12 y 46) cuyo
nombre empiece por 'P' que tienen direcci�n de env�o pero mostrando, a la derecha, todas las
direcciones de env�o de la base de datos.
select u.*, d.*
from usuario u
right join direnvio d
on (d.email=u.email
and u.provincia in ('46','03','12')
and u.nombre like 'P%');
N�tese, respecto de otro ejercicio similar, que las condiciones del usuario se han introducido dentro de la condici�n
del right join.