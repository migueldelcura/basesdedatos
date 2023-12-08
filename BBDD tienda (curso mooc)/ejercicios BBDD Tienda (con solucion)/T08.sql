T08.001- Obtener el precio total por l�nea para el pedido 1, en la salida aparecer� los campos numlinea,
articulo y el campo calculado total.
select linea, articulo, (precio*cantidad) total
from linped
where numPedido=1;

T08.002- Obtener la cantidad de provincias distintas de las que tenemos conocimiento de alg�n
usuario.
select count(distinct provincia) provincias from usuario;

T08.003- Cantidad de usuarios de nuestra BD.
select count(*) usuarios from usuario;

T08.004- N�mero de articulos con precio de venta mayor de 200 euros.
select count(*) from articulo where pvp>200;

T08.005- Total en euros de la cesta del usuario "bmm@agwab.com".
select sum(pvp) total
from cesta, articulo
where usuario='bmm@agwab.com' and articulo=cod;

T08.006- Tama�o m�ximo de pantalla para las televisiones.
select MAX(pantalla) maxPantalla from tv;

T08.007- Media de precios de venta al p�blico distintos de los articulos, redondeada a dos decimales.
select round(avg(distinct pvp),2) mediaventa from articulo;

T08.008- Nombre y precio de los articulos con el m�nimo stock disponible.
select nombre,pvp
from articulo,stock
where cod=articulo
and disponible = (select min(disponible) from stock);
Fundamentos de las Bases de Datos, grados I. Inform�tica e I. Multimedia 30
BDgite, DLSI, Universidad de Alicante

T08.009- N�mero de pedido, fecha y nombre y apellidos del usuario de las lineas de pedido cuyo total
en euros es el m�s alto.
select p.numPedido,fecha,nombre,apellidos
from pedido p,linped l,usuario u
where p.usuario=email
and p.numPedido=l.numPedido
and (cantidad*precio)=(select max(cantidad*precio) from linped);

T08.010- M�ximo, m�nimo y media de precio de venta de los art�culos.
select MAX(pvp) maxPvp, MIN(pvp) minPvp, AVG(pvp) mediaPvp from articulo;

T08.011- C�digo, nombre, pvp y fecha de incorporaci�n del art�culo a la cesta m�s reciente.
select cod, nombre, pvp
from cesta, articulo
where articulo=cod
and fecha=(select MAX(fecha) from cesta);

T08.012- Cantidad de art�culos que est�n descatalogados.
select count(*) NumArtDescatalogados
from stock
where entrega='Descatalogado'

T08.013- Precio m�ximo del art�culo en stock que ser� entregado pr�ximamente.
select max(pvp)
from articulo, stock
where cod=articulo
and entrega='Pr�ximamente';

T08.014- Nombre, c�digo y disponible en stock para todos los art�culos cuyo c�digo acabe en 3, siendo
ese disponible el m�nimo de toda la tabla.
select nombre, cod, disponible MinDisponible
from stock, articulo
where articulo=cod
and cod like '%3'
and disponible=(select MIN(disponible) from stock);

T08.015- Precio m�ximo, m�nimo y medio de las l�neas de pedido que incluyen el art�culo �Bravia KDL-
32EX402�
select MAX(precio) MaxPrecio, MIN(precio) MinPrecio, AVG(precio) PrecioMedio
Fundamentos de las Bases de Datos, grados I. Inform�tica e I. Multimedia 31
BDgite, DLSI, Universidad de Alicante
from linped l, articulo a
where a.cod=l.articulo and a.nombre='Bravia KDL-32EX402';

T08.016- Cantidad total que se ha pedido de los art�culos cuyo nombre empieza por "UE22".
select SUM(cantidad) cantidadTotal
from linped, articulo
where articulo=cod and nombre like 'UE22%';

T08.017- Precio medio de los art�culos incluidos en la l�nea de pedido n�mero 4, redondeado a 3
decimales.
select round(avg(precio),3) PrecioMedio
from linped
where linea=4;

T08.018- N�mero de pedido, nombre, tel�fono y email de usuario del pedido (o los pedidos) que
contiene l�neas de pedido cuyo precio sea igual al precio m�s alto de entre todas las segundas l�neas de
todos los pedidos.
select l.numPedido, nombre, telefono, email
from usuario u, pedido p, linped l
where l.numPedido=p.numPedido
and p.usuario=u.email
and precio=(select MAX(precio) from linped where linea=2);
Primero se ha de calcular el precio m�ximo de entre todas las segundas l�neas (la subconsulta) y, entonces, ya se
pueden comparar TODAS las l�neas de pedido: saldr�, seguro, el pedido de esa segunda l�nea que da el m�ximo, pero
ese precio m�ximo se puede repetir en cualquier otra l�nea.

T08.019- Diferencia entre el precio m�ximo y el precio m�nimo del pedido n�mero 30.
select (MAX(precio)-MIN(precio)) DiferenciaPrecios
from linped
where numPedido=30;

T08.020- C�digo, nombre, precio de venta del art�culo que m�s hay en stock.
select cod,nombre,pvp
from articulo,stock
where cod=articulo
and disponible = (select MAX(disponible) from stock);


T08.021- Fecha de nacimiento del usuario m�s viejo.
select MIN(nacido) from usuario;

T08.022- Obtener en una �nica consulta, cu�ntas filas tiene la tabla art�culo, cu�ntas de ellas tienen valor en la columna marca y cu�ntas marcas distintas hay almacenadas en la tabla.
select count(*) filas, count(marca) conmarca, count(distinct marca) marcas from
articulo;