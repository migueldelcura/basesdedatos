T04.001- Toda la información de los pedidos anteriores a octubre de 2010.
select * from pedido where fecha < '2010-10-01';

T04.002- Toda la información de los pedidos posteriores a agosto de 2010.
select * from pedido where fecha > '2010-08-31';

T04.003- Toda la información de los pedidos realizados entre agosto y octubre de 2010.
select * from pedido where fecha > '2010-07-31' and fecha < '2010-11-01';

Solución alternativa:
select * from pedido where fecha between '2010-08-01' and '2010-10-30';

T04.004- Toda la información de los pedidos realizados el 3 de marzo o el 27 de octubre de 2010.
select * from pedido where fecha = '2010-03-03' or fecha = '2010-10-27';

T04.005- Toda la información de los pedidos realizados el 3 de marzo o el 27 de octubre de 2010, y que han sido realizados por usuarios del dominio "cazurren"
select * from pedido
where (fecha = '2010-03-03' or fecha = '2010-10-27')
and usuario like '%@cazurren.%';

T04.006- ¿En qué día y hora vivimos?
select now();

T04.007- 21 de febrero de 2011 en formato dd/mm/aaaa
select date_format('2011-02-21','%d/%m/%Y') lafecha;

T04.008- 31 de febrero de 2011 en formato dd/mm/aaaa
select date_format('2011-02-31','%d/%m/%Y') lafecha;

T04.009- Pedidos realizados el 13.9.2010 (este formato, obligatorio en la comparación).
select * from pedido
where fecha = str_to_date('13.9.2010','%d.%c.%Y');
¿Por qué no obtiene el mismo resultado la orden siguiente?
select * from pedido
where '13.9.2010' = date_format(fecha,'%d.%m.%Y');
Pista: ejecuta "select date_format('2010-09-13','%d.%m.%Y'), date_format('2010-09-13','%e.%c.%Y'),
str_to_date('13.9.2010','%d.%m.%Y')"

T04.010- Numero y fecha de los pedidos realizados el 13.9.2010 (este formato, obligatorio tanto en la
comparación como en la salida).
select numpedido, date_format(fecha,'%d.%c.%Y') fecha
from pedido
where fecha = str_to_date('13.9.2010','%d.%c.%Y');
El formato '%c' es para los meses con uno o dos dígitos (no es lo mismo '09' que '9') aunque MySQL es bastante
flexible y permite ciertas "licencias": str_to_date('13.9.2010','%d.%m.%Y') también funcionaría.
Igualmente, podríamos haber usado el formato '%e' para los días con uno o dos dígitos '1.3.2012'

T04.011- Numero, fecha, y email de cliente de los pedidos (formato dd.mm.aa) ordenado
descendentemente por fecha y ascendentemente por cliente.
select numpedido, date_format(fecha,'%d.%m.%y') lafecha, usuario
from pedido
order by fecha desc, usuario;
¿Por qué parece que no funciona correctamente la ordenación si cambiamos el nombre de la columna de salidad de
la fecha (hemos cambiado la etiqueta de la columna de la fecha)?
select numpedido, date_format(fecha,'%d.%m.%y') fecha, usuario
from pedido
order by fecha desc, usuario;

T04.012- Códigos de articulos solicitados en 2010, eliminando duplicados y ordenado
ascendentemente.
select distinct articulo
from linped l, pedido p
where l.numpedido=p.numpedido
and year(fecha)=2010
order by articulo;
Solución alternativa:
select distinct articulo
from linped l, pedido p
where l.numpedido=p.numpedido
and fecha between '2010-01-01' and '2010-12-31'
Fundamentos de las Bases de Datos, grados I. Informática e I. Multimedia 14
BDgite, DLSI, Universidad de Alicante
order by articulo;

T04.013- Códigos de articulos solicitados en pedidos de marzo de 2010, eliminando duplicados y
ordenado ascendentemente.
select articulo
from linped l, pedido p
where l.numpedido=p.numpedido
and month(fecha)=3 and year(fecha)=2010
order by articulo;
Solución alternativa:
select articulo
from linped l, pedido p
where l.numpedido=p.numpedido
and fecha between '2010-03-01' and '2010-03-31'
order by articulo;

T04.014- Códigos de articulos solicitados en pedidos de septiembre de 2010, y semana del año (la
semana comienza en lunes) y año del pedido, ordenado por semana.
select articulo, date_format(fecha,'%u') semana, year(fecha) año
from linped l, pedido p
where l.numpedido=p.numpedido
and month(fecha)=9 and year(fecha)=2010
order by semana;

T04.015- Nombre, apellidos y edad (aproximada) de los usuarios del dominio "dlsi.ua.es", ordenado
descendentemente por edad.
select nombre, apellidos, year(now())-year(nacido) edad
from usuario
where email like '%@dlsi.ua.es'
order by edad desc;
Para para obtener la edad exacta: http://dev.mysql.com/doc/refman/5.0/es/date-calculations.html
O también:
select email, year(now())-year(nacido) + IF(date_format(now(),'%m-%d') > date_format(nacido,'%m-%d'), 0, -1) edad
FROM usuario...

T04.016- Email y cantidad de días que han pasado desde los pedidos realizados por cada usuario hasta
la fecha de cada cesta que también sea suya. Eliminad duplicados.
select distinct c.usuario, datediff(c.fecha,p.fecha) dias
from cesta c, pedido p
where c.usuario=p.usuario;
Fundamentos de las Bases de Datos, grados I. Informática e I. Multimedia 15
BDgite, DLSI, Universidad de Alicante

T04.017- Información sobre los usuarios menores de 25 años.
select * from usuario
where year(now())-year(nacido)<25;

T04.018- Número de pedido, usuario y fecha (dd/mm/aaaa) al que se le solicitó para los pedidos que se
realizaron durante la semana del 7 de noviembre de 2010.
select numpedido, usuario, date_format(fecha,'%d/%m/%Y') cuando
from pedido
where date_format(fecha,'%u')=date_format('2010-11-07','%u');

Solución alternativa:
select numpedido, usuario, date_format(fecha,'%d/%m/%Y') cuando
from pedido
where date_format(fecha,'%u')=date_format(str_to_date('10/11/07','%y/%m/%d'),'%u');
La solución alternativa es un ejemplo de tratamiento más complejo de una fecha: se supone que nos llega en ese
formato (la del where) y tenemos que transformarla a algo que MySQL entienda.
Consejo: consultad sobre las diferencias entre '%u', '%U' para date_format y la función weekofyear().

T04.019- Código, nombre, panel y pantalla de los televisores que no se hayan solicitado ni en lo que va
de año, ni en los últimos seis meses del año pasado.
select a.cod, nombre, panel, pantalla
from articulo a, tv
where a.cod=tv.cod
and a.cod not in (select articulo
from linped l, pedido p
where l.numpedido=p.numpedido
and (
(year(fecha)=year(now())-1
and month(fecha) between 7 and 12)
) or year(fecha)=year(now())
);
Este ejercicio es demasiado lioso incluso para nuestra "dificultad alta", pero lo dejamos como "curiosidad".

T04.020- Email y cantidad de días que han pasado desde los pedidos realizados por cada usuario hasta
la fecha de cada artículo que ahora mismo hay en su cesta. Eliminad duplicados.
select distinct c.usuario, datediff(c.fecha,p.fecha) dias
from cesta c, pedido p, linped l
where c.usuario=p.usuario
and l.numpedido=p.numpedido
and l.articulo = c.articulo;