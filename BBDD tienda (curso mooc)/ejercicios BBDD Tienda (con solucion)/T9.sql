T09.001- �Cu�ntos art�culos de cada marca hay?
select marca,count(*)
from articulo
group by marca;

T09.002- �Cu�les son las marcas que tienen menos de 150 art�culos?
select marca,count(*) from articulo
group by marca
having count(*)<150;

T09.003- �Cu�les son las marcas que tienen menos de 150 art�culos (eliminar las marcas que sean
null)?
select marca,count(*) from articulo
where marca is not null
group by marca
having count(*)<150

T09.004- N�mero de c�maras que tienen sensor CMOS
select count(*) from camara where sensor like 'CMOS%'

T09.005- Dni, nombre, apellidos y email de los usuarios que han realizado m�s de un pedido.
select dni,nombre,apellidos,email
from usuario U, pedido P
where U.email=P.Usuario
group by dni,nombre,apellidos,email
having count(*)>1;

Soluci�n alternativa:
select max(dni),max(nombre),max(apellidos),email
from usuario U, pedido P
where U.email=P.Usuario
group by email
having count(*)>1;

T09.006- Pedidos (n�mero de pedido y usuario) de importe mayor a 4000 euros.
select p.numpedido,p.usuario
from pedido p, linped l
where p.numpedido=l.numpedido
group by p.numpedido,p.usuario
having sum(cantidad*precio)>4000;
Cuando nos piden el importe (total) de un pedido, se entiende que es el precio unitario de cada l�nea de ese pedido
multiplicado por la cantidad pedida de ese art�culo.

T09.007- Pedidos (n�mero de pedido y usuario) con m�s de 10 art�culos, mostrando esta cantidad.
select P.numPedido,P.usuario, sum(cantidad)
from pedido P, linped L
where P.numPedido=L.numPedido
group by P.numPedido,P.usuario
having sum(cantidad)>10;

T09.008- Pedidos (n�mero de pedido y usuario) que contengan m�s de cuatro art�culos distintos.
select P.numPedido,P.usuario, count(distinct articulo)
from pedido P, linped L
where P.numPedido=L.numPedido
group by P.numPedido,P.usuario
having count(distinct articulo)>4;

T09.009- �Hay dos provincias que se llamen igual (con nombre repetido)?
select nombre,count(*) from provincia group by nombre having count(*)>1;

T09.010- �Hay alg�n pueblo con nombre repetido?
select pueblo,count(*) from localidad group by pueblo having count(*)>1;

T09.011- Obtener el c�digo y nombre de las provincias que tengan m�s de 100 pueblos.
select P.codp,P.nombre,count(*)
FROM provincia P, localidad L
WHERE P.codp=L.provincia
group by P.codp,P.nombre
having count(*)>100;

T09.012- Ha habido un error en Tiendaonline y se han colado varios art�culos sin stock en la cesta.
Averigua el c�digo de esos art�culos y las veces que aparecen en la cesta.
select c.articulo, count(c.articulo)
from cesta c, stock s
where c.articulo=s.articulo
and disponible=0
group by c.articulo;

T09.013- Clientes que hayan adquirido (pedido) m�s de 2 tv
select p.usuario, sum(cantidad)
from pedido p, linped l, tv
where p.numpedido=l.numpedido
and l.articulo=tv.cod
group by p.usuario
having sum(cantidad)>2;

T09.014- �Cu�ntas veces se ha pedido cada art�culo? Si hubiese art�culos que no se han incluido en
pedido alguno tambi�n se mostrar�n. Mostrar el c�digo y nombre del art�culo junto con las veces que
ha sido incluido en un pedido (solo si ha sido incluido, no se trata de la "cantidad").
select cod, nombre, count(numpedido)
from articulo a
left join linped l on (a.cod=l.articulo)
group by cod, nombre;
El "truco" consiste en contar los n�meros de pedido asociados a algunos art�culos. El left join hace que ciertos
art�culos aparezcan una vez junto con NULL como numpedido. El resto de art�culos aparecen tantas veces como l�neas
tengan en LINPED. Como count(numpedido) solo cuenta los valores distintos de NULL, por eso conseguimos que la
cuenta sea 0 en los art�culos no pedidos nunca.

T09.015- C�digo y nombre de las provincias que tienen m�s de 50 usuarios (provincia del usuario, no
de la direcci�n de env�o).
select p.codp, p.nombre
from provincia p, usuario u
where p.codp=u.provincia
group by p.codp, p.nombre
having count(email)>50;

T09.016- Cantidad de art�culos con stock 0
select count(*) from stock where disponible=0;

T09.017- Cantidad de art�culos que no son ni memoria, ni tv, ni objetivo, ni c�mara ni pack.
select count(*)
from articulo
where cod not in (select cod from camara)
and cod not in (select cod from tv)
and cod not in (select cod from memoria)
and cod not in (select cod from objetivo)
and cod not in (select cod from pack);

Soluci�n alternativa:
select count(*)
from articulo
where cod not in (select cod from camara

union select cod from tv
union select cod from memoria
union select cod from objetivo
union select cod from pack);

T09.018- N�mero de art�culos pedidos por provincia (provincia del usuario no de la direcci�n de
env�o). Mostrar el c�digo de la provincia, su nombre y la cantidad de veces que se ha pedido el art�culo;
si la provincia no tiene asociada esta cantidad, mostrar "0" en esa columna.
select pr.codp, pr.nombre, IFNULL(sum(cantidad),0)
from provincia pr
left join usuario u on (pr.codp=u.provincia)
left join pedido p on (p.usuario=u.email)
left join linped l on (p.numpedido=l.numpedido)
group by pr.codp,pr.nombre;