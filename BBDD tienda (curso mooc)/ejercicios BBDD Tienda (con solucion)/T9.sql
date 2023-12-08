T09.001- ¿Cuántos artículos de cada marca hay?
select marca,count(*)
from articulo
group by marca;

T09.002- ¿Cuáles son las marcas que tienen menos de 150 artículos?
select marca,count(*) from articulo
group by marca
having count(*)<150;

T09.003- ¿Cuáles son las marcas que tienen menos de 150 artículos (eliminar las marcas que sean
null)?
select marca,count(*) from articulo
where marca is not null
group by marca
having count(*)<150

T09.004- Número de cámaras que tienen sensor CMOS
select count(*) from camara where sensor like 'CMOS%'

T09.005- Dni, nombre, apellidos y email de los usuarios que han realizado más de un pedido.
select dni,nombre,apellidos,email
from usuario U, pedido P
where U.email=P.Usuario
group by dni,nombre,apellidos,email
having count(*)>1;

Solución alternativa:
select max(dni),max(nombre),max(apellidos),email
from usuario U, pedido P
where U.email=P.Usuario
group by email
having count(*)>1;

T09.006- Pedidos (número de pedido y usuario) de importe mayor a 4000 euros.
select p.numpedido,p.usuario
from pedido p, linped l
where p.numpedido=l.numpedido
group by p.numpedido,p.usuario
having sum(cantidad*precio)>4000;
Cuando nos piden el importe (total) de un pedido, se entiende que es el precio unitario de cada línea de ese pedido
multiplicado por la cantidad pedida de ese artículo.

T09.007- Pedidos (número de pedido y usuario) con más de 10 artículos, mostrando esta cantidad.
select P.numPedido,P.usuario, sum(cantidad)
from pedido P, linped L
where P.numPedido=L.numPedido
group by P.numPedido,P.usuario
having sum(cantidad)>10;

T09.008- Pedidos (número de pedido y usuario) que contengan más de cuatro artículos distintos.
select P.numPedido,P.usuario, count(distinct articulo)
from pedido P, linped L
where P.numPedido=L.numPedido
group by P.numPedido,P.usuario
having count(distinct articulo)>4;

T09.009- ¿Hay dos provincias que se llamen igual (con nombre repetido)?
select nombre,count(*) from provincia group by nombre having count(*)>1;

T09.010- ¿Hay algún pueblo con nombre repetido?
select pueblo,count(*) from localidad group by pueblo having count(*)>1;

T09.011- Obtener el código y nombre de las provincias que tengan más de 100 pueblos.
select P.codp,P.nombre,count(*)
FROM provincia P, localidad L
WHERE P.codp=L.provincia
group by P.codp,P.nombre
having count(*)>100;

T09.012- Ha habido un error en Tiendaonline y se han colado varios artículos sin stock en la cesta.
Averigua el código de esos artículos y las veces que aparecen en la cesta.
select c.articulo, count(c.articulo)
from cesta c, stock s
where c.articulo=s.articulo
and disponible=0
group by c.articulo;

T09.013- Clientes que hayan adquirido (pedido) más de 2 tv
select p.usuario, sum(cantidad)
from pedido p, linped l, tv
where p.numpedido=l.numpedido
and l.articulo=tv.cod
group by p.usuario
having sum(cantidad)>2;

T09.014- ¿Cuántas veces se ha pedido cada artículo? Si hubiese artículos que no se han incluido en
pedido alguno también se mostrarán. Mostrar el código y nombre del artículo junto con las veces que
ha sido incluido en un pedido (solo si ha sido incluido, no se trata de la "cantidad").
select cod, nombre, count(numpedido)
from articulo a
left join linped l on (a.cod=l.articulo)
group by cod, nombre;
El "truco" consiste en contar los números de pedido asociados a algunos artículos. El left join hace que ciertos
artículos aparezcan una vez junto con NULL como numpedido. El resto de artículos aparecen tantas veces como líneas
tengan en LINPED. Como count(numpedido) solo cuenta los valores distintos de NULL, por eso conseguimos que la
cuenta sea 0 en los artículos no pedidos nunca.

T09.015- Código y nombre de las provincias que tienen más de 50 usuarios (provincia del usuario, no
de la dirección de envío).
select p.codp, p.nombre
from provincia p, usuario u
where p.codp=u.provincia
group by p.codp, p.nombre
having count(email)>50;

T09.016- Cantidad de artículos con stock 0
select count(*) from stock where disponible=0;

T09.017- Cantidad de artículos que no son ni memoria, ni tv, ni objetivo, ni cámara ni pack.
select count(*)
from articulo
where cod not in (select cod from camara)
and cod not in (select cod from tv)
and cod not in (select cod from memoria)
and cod not in (select cod from objetivo)
and cod not in (select cod from pack);

Solución alternativa:
select count(*)
from articulo
where cod not in (select cod from camara

union select cod from tv
union select cod from memoria
union select cod from objetivo
union select cod from pack);

T09.018- Número de artículos pedidos por provincia (provincia del usuario no de la dirección de
envío). Mostrar el código de la provincia, su nombre y la cantidad de veces que se ha pedido el artículo;
si la provincia no tiene asociada esta cantidad, mostrar "0" en esa columna.
select pr.codp, pr.nombre, IFNULL(sum(cantidad),0)
from provincia pr
left join usuario u on (pr.codp=u.provincia)
left join pedido p on (p.usuario=u.email)
left join linped l on (p.numpedido=l.numpedido)
group by pr.codp,pr.nombre;