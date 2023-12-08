T08.001- Obtener el precio total por línea para el pedido 1, en la salida aparecerá los campos numlinea,
articulo y el campo calculado total.
select linea, articulo, (precio*cantidad) total
from linped
where numPedido=1;

T08.002- Obtener la cantidad de provincias distintas de las que tenemos conocimiento de algún
usuario.
select count(distinct provincia) provincias from usuario;

T08.003- Cantidad de usuarios de nuestra BD.
select count(*) usuarios from usuario;

T08.004- Número de articulos con precio de venta mayor de 200 euros.
select count(*) from articulo where pvp>200;

T08.005- Total en euros de la cesta del usuario "bmm@agwab.com".
select sum(pvp) total
from cesta, articulo
where usuario='bmm@agwab.com' and articulo=cod;

T08.006- Tamaño máximo de pantalla para las televisiones.
select MAX(pantalla) maxPantalla from tv;

T08.007- Media de precios de venta al público distintos de los articulos, redondeada a dos decimales.
select round(avg(distinct pvp),2) mediaventa from articulo;

T08.008- Nombre y precio de los articulos con el mínimo stock disponible.
select nombre,pvp
from articulo,stock
where cod=articulo
and disponible = (select min(disponible) from stock);
Fundamentos de las Bases de Datos, grados I. Informática e I. Multimedia 30
BDgite, DLSI, Universidad de Alicante

T08.009- Número de pedido, fecha y nombre y apellidos del usuario de las lineas de pedido cuyo total
en euros es el más alto.
select p.numPedido,fecha,nombre,apellidos
from pedido p,linped l,usuario u
where p.usuario=email
and p.numPedido=l.numPedido
and (cantidad*precio)=(select max(cantidad*precio) from linped);

T08.010- Máximo, mínimo y media de precio de venta de los artículos.
select MAX(pvp) maxPvp, MIN(pvp) minPvp, AVG(pvp) mediaPvp from articulo;

T08.011- Código, nombre, pvp y fecha de incorporación del artículo a la cesta más reciente.
select cod, nombre, pvp
from cesta, articulo
where articulo=cod
and fecha=(select MAX(fecha) from cesta);

T08.012- Cantidad de artículos que están descatalogados.
select count(*) NumArtDescatalogados
from stock
where entrega='Descatalogado'

T08.013- Precio máximo del artículo en stock que será entregado próximamente.
select max(pvp)
from articulo, stock
where cod=articulo
and entrega='Próximamente';

T08.014- Nombre, código y disponible en stock para todos los artículos cuyo código acabe en 3, siendo
ese disponible el mínimo de toda la tabla.
select nombre, cod, disponible MinDisponible
from stock, articulo
where articulo=cod
and cod like '%3'
and disponible=(select MIN(disponible) from stock);

T08.015- Precio máximo, mínimo y medio de las líneas de pedido que incluyen el artículo “Bravia KDL-
32EX402”
select MAX(precio) MaxPrecio, MIN(precio) MinPrecio, AVG(precio) PrecioMedio
Fundamentos de las Bases de Datos, grados I. Informática e I. Multimedia 31
BDgite, DLSI, Universidad de Alicante
from linped l, articulo a
where a.cod=l.articulo and a.nombre='Bravia KDL-32EX402';

T08.016- Cantidad total que se ha pedido de los artículos cuyo nombre empieza por "UE22".
select SUM(cantidad) cantidadTotal
from linped, articulo
where articulo=cod and nombre like 'UE22%';

T08.017- Precio medio de los artículos incluidos en la línea de pedido número 4, redondeado a 3
decimales.
select round(avg(precio),3) PrecioMedio
from linped
where linea=4;

T08.018- Número de pedido, nombre, teléfono y email de usuario del pedido (o los pedidos) que
contiene líneas de pedido cuyo precio sea igual al precio más alto de entre todas las segundas líneas de
todos los pedidos.
select l.numPedido, nombre, telefono, email
from usuario u, pedido p, linped l
where l.numPedido=p.numPedido
and p.usuario=u.email
and precio=(select MAX(precio) from linped where linea=2);
Primero se ha de calcular el precio máximo de entre todas las segundas líneas (la subconsulta) y, entonces, ya se
pueden comparar TODAS las líneas de pedido: saldrá, seguro, el pedido de esa segunda línea que da el máximo, pero
ese precio máximo se puede repetir en cualquier otra línea.

T08.019- Diferencia entre el precio máximo y el precio mínimo del pedido número 30.
select (MAX(precio)-MIN(precio)) DiferenciaPrecios
from linped
where numPedido=30;

T08.020- Código, nombre, precio de venta del artículo que más hay en stock.
select cod,nombre,pvp
from articulo,stock
where cod=articulo
and disponible = (select MAX(disponible) from stock);


T08.021- Fecha de nacimiento del usuario más viejo.
select MIN(nacido) from usuario;

T08.022- Obtener en una única consulta, cuántas filas tiene la tabla artículo, cuántas de ellas tienen valor en la columna marca y cuántas marcas distintas hay almacenadas en la tabla.
select count(*) filas, count(marca) conmarca, count(distinct marca) marcas from
articulo;