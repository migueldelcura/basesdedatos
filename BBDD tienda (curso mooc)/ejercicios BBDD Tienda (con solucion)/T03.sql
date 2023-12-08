T03.001- Código y nombre de los articulos con un precio entre 400 y 500 euros.
select cod,nombre from articulo where pvp between 400 and 500;
Solución alternativa:
select cod,nombre from articulo where pvp >= 400 and pvp <= 500;

T03.002- Código y nombre de los articulos con precio 415, 129, 1259 o 3995.
select cod,nombre from articulo
where pvp in (415, 129, 1259, 3995);
Solución alternativa:
select cod,nombre from articulo
where pvp = 415 or pvp = 129 or pvp = 1259 or pvp = 3995;

T03.003- Código y nombre de las provincias que no son Huelva, Sevilla, Asturias ni Barcelona.
select codp,nombre from provincia
where nombre not in ('huelva', 'sevilla', 'asturias', 'barcelona');
Solución alternativa:
select codp,nombre from provincia
where nombre != 'huelva' and nombre != 'sevilla'
and nombre != 'asturias'and nombre != 'barcelona';

T03.004- Código de la provincia Alicante.
select codp from provincia
where nombre like 'Alicante%';

T03.005- Obtener el código, nombre y pvp de los articulos cuya marca comience por S.
select cod, nombre, pvp from articulo where marca like 'S%'

T03.006- Información sobre los usuarios cuyo email es de la eps.
select * from usuario where email like '%@eps.%'

T03.007- Código, nombre y resolución de los televisores cuya pantalla no esté entre 22 y 42.
select a.cod, nombre, resolucion
from articulo a, tv
where a.cod=tv.cod and pantalla not between 22 and 42;

T03.008- Código y nombre de los televisores cuyo panel sea tipo LED y su precio no supere los 1000 euros.
select t.cod, nombre from tv t, articulo a where t.cod=a.cod and panel like '%LED%' and pvp<=1000;

T03.009- Email de los usuarios cuyo código postal no sea 02012, 02018 o 02032.
select email from usuario
where codpos not in ('02012','02018','02032');

T03.010- Código y nombre de los packs de los que se conoce qué articulos los componen.
select distinct cod, nombre
from articulo, ptienea
where pack=cod;

T03.011- ¿Hay algún artículo en cesta que esté descatalogado?
select *
from cesta c, stock s
where c.articulo=s.articulo
and entrega='descatalogado';

T03.012- Código, nombre y pvp de las cámaras de tipo compacta.
select a.cod, nombre, pvp
from articulo a, camara c
where a.cod=c.cod and tipo like'%compacta%';

T03.013- Código, nombre y diferencia entre pvp y precio de los articulos que hayan sido solicitados en
algún pedido a un precio distinto de su precio de venta.
select cod, nombre, pvp-precio
from articulo, linped
where cod=articulo and pvp<>precio;

T03.014- Número de pedido,fecha y nombre y apellidos del usuario que solicita el pedido, para aquellos
pedidos solicitados por algún usuario de apellido MARTINEZ.
select numpedido, fecha, nombre, apellidos
from pedido, usuario
where usuario=email and apellidos like'%MARTINEZ%'

T03.015- Código, nombre y marca del artículo más caro.
select cod, nombre, marca, pvp
from articulo
where pvp = (select max(pvp) from articulo);
Solución alternativa:
select cod, nombre, marca, pvp
from articulo
where pvp >= all (select pvp from articulo);
La solución alternativa no funciona por un "bug" de la versión instalada del motor MySQL.

T03.016- Nombre, marca y resolucion de las cámaras que nunca se han solicitado.
select nombre, marca, resolucion
from articulo a, camara c
where a.cod=c.cod and
c.cod not in (select articulo from linped);

T03.017- Código, nombre, tipo y marca de las cámaras de marca Nikon, LG o Sigma.
select a.cod, nombre, tipo, marca
from articulo a, camara c
where a.cod=c.cod and marca in ('NIKON','LG','SIGMA');

T03.018- Código, nombre y pvp de la cámara más cara de entre las de tipo réflex.
select a.cod, nombre, pvp
from articulo a, camara c
where a.cod=c.cod
and tipo like '%reflex%'
and pvp=(
select max(pvp)
from articulo a, camara c
where a.cod=c.cod and tipo like '%reflex%');
Solución alternativa:
select a.cod, nombre, pvp
from articulo a, camara c
where a.cod=c.cod and tipo like'%réflex%'
and pvp >= all (select pvp from articulo a, camara c
where a.cod=c.cod and tipo like'%réflex%');


T03.019- Marcas de las que no existe ningún televisor en nuestra base de datos.
select marca from marca
where marca not in (select marca
from articulo a, tv t
where a.cod=t.cod);

Solución alternativa:
SELECT marca
FROM marca m
WHERE NOT EXISTS
(SELECT 1 FROM articulo a, tv t
where a.cod=t.cod and a.marca=m.marca);

T03.020- Código, nombre y disponibilidad de los artículos con menor disponibilidad de entre los que
pueden estar disponibles en 24 horas.
select cod,nombre,disponible
from stock, articulo
where cod=articulo
and entrega='24 horas'
and disponible=(select min(disponible)
from stock
where entrega='24 horas');

Solución alternativa:
select cod, nombre, disponible
from stock, articulo
where cod=articulo
and entrega ='24 horas'
and disponible <=all (select disponible
from stock
where entrega='24 horas');

T03.021- Nombre de los artículos cuyo nombre contenga la palabra EOS.
select nombre from articulo where nombre like '%EOS%';

T03.022- Tipo y focal de los objetivos que se monten en una cámara Canon sea cual sea el modelo.
select tipo, focaL from objetivo where montura like 'Canon%';

T03.023- Nombre de los artículos cuyo precio sea mayor de 100 pero menor o igual que 200.
select nombre from articulo where pvp>100 and pvp<=200;

T03.024- Nombre de los artículos cuyo precio sea mayor o igual que 100 pero menor o igual que 300.
select nombre from articulo where pvp between 100 and 300;

T03.025- Nombre de las cámaras cuya marca no comience por la letra S.
select nombre from articulo a, camara c where a.cod=c.cod and marca not like 'S%';