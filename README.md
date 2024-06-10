CONSULTAS

1. Obtener el historial de reparaciones de un vehículo específico
   
~~~mysql
SELECT reparacion_id, fecha, vehiculo_id, empleado_id, servicio_id, costo_total, duracion, descripcion
FROM reparaciones
WHERE vehiculo_id = 1;
+---------------+------------+-------------+-------------+-------------+-------------+----------+-----------------------------------------+
| reparacion_id | fecha      | vehiculo_id | empleado_id | servicio_id | costo_total | duracion | descripcion                             |
+---------------+------------+-------------+-------------+-------------+-------------+----------+-----------------------------------------+
|             1 | 2023-01-15 |           1 |           2 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|             8 | 2023-08-29 |           1 |           4 |           3 |      70.000 | 01:00:00 | Revision frenos del vehiculo            |
|            15 | 2024-03-12 |           1 |           6 |           3 |      70.000 | 01:00:00 | Revision frenos del vehiculo            |
|            16 | 2024-04-10 |           1 |           4 |           4 |     100.000 | 01:00:00 | Recarga Aire Acondicionado del vehiculo |
|            24 | 2024-08-11 |           1 |           6 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|            32 | 2024-01-15 |           1 |           2 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
+---------------+------------+-------------+-------------+-------------+-------------+----------+-----------------------------------------+
~~~

2. Calcular el costo total de todas las reparaciones realizadas por un empleado
específico en un período de tiempo

~~~mysql
SELECT empleado_id ,SUM(costo_total) AS 'Costo Total Reparaciones'
FROM reparaciones
WHERE empleado_id = 2
AND YEAR(fecha) = 2024
AND MONTH(fecha) = 6;
+-------------+--------------------------+
| empleado_id | Costo Total Reparaciones |
+-------------+--------------------------+
|           2 |                  100.000 |
+-------------+--------------------------+
~~~

3. Listar todos los clientes y los vehículos que poseen
   
~~~mysql
SELECT  CONCAT(cli.nombre, ' ', cli.apellido) AS nombre_cliente, veh.vehiculo_id
FROM cliente AS cli
INNER JOIN vehiculo AS veh
ON cli.cliente_id = veh.cliente_id;
+----------------+-------------+
| nombre_cliente | vehiculo_id |
+----------------+-------------+
| Juan Torres    |           1 |
| Juan Torres    |           6 |
| Alvaro Sánchez |           2 |
| Alvaro Sánchez |           7 |
| Maryi Leon     |           3 |
| Diana Leon     |           4 |
| Carlos Diaz    |           5 |
+----------------+-------------+
~~~

4. Obtener la cantidad de piezas en inventario para cada pieza

~~~mysql
SELECT pieza_id, SUM(cantidad)
FROM inventario
GROUP BY pieza_id;
+----------+---------------+
| pieza_id | SUM(cantidad) |
+----------+---------------+
|        1 |            10 |
|        2 |            20 |
|        3 |           156 |
|        4 |            55 |
|        5 |            15 |
|        6 |            25 |
|        7 |            10 |
|        8 |             5 |
|        9 |             7 |
|       10 |             8 |
|       11 |            65 |
+----------+---------------+
~~~


5. Obtener las citas programadas para un día específico

~~~mysql
SELECT cita_id, fecha_hora, cliente_id, vehiculo_id, servicio_id
FROM cita
WHERE DATE(fecha_hora) = '2024-06-20';

+---------+---------------------+------------+-------------+-------------+
| cita_id | fecha_hora          | cliente_id | vehiculo_id | servicio_id |
+---------+---------------------+------------+-------------+-------------+
|      17 | 2024-06-20 15:00:00 |          2 |           7 |           1 |
+---------+---------------------+------------+-------------+-------------+
~~~

6. Generar una factura para un cliente específico en una fecha determinada

~~~mysql
SELECT fac.factura_id, CONCAT(cli.nombre, ' ', cli.apellido) AS 'nombre cliente',
fac.fecha,rep.vehiculo_id,rep.duracion ,fac.total  
FROM facturacion AS fac
INNER JOIN cliente AS cli
ON cli.cliente_id = fac.cliente_id
INNER JOIN factura_detalle AS fade
ON fac.factura_id = fade.factura_id
INNER JOIN reparaciones AS rep
ON fade.reparacion_id = rep.reparacion_id
WHERE cli.cliente_id = 4 AND DATE(fac.fecha) = '2024-06-06';

+------------+----------------+------------+-------------+----------+---------+
| factura_id | nombre cliente | fecha      | vehiculo_id | duracion | total   |
+------------+----------------+------------+-------------+----------+---------+
|         19 | Diana Leon     | 2024-06-06 |           6 | 01:00:00 | 120.000 |
+------------+----------------+------------+-------------+----------+---------+
~~~


7. Listar todas las órdenes de compra y sus detalles

~~~mysql
SELECT oc.orden_id, od.cantidad, od.precio
FROM orden_compra AS oc
INNER JOIN orden_detalle AS od
ON oc.orden_id = od.orden_id;

+----------+----------+--------+
| orden_id | cantidad | precio |
+----------+----------+--------+
|        1 |        3 | 20.000 |
|        5 |        6 | 20.000 |
|        2 |       18 | 20.000 |
|        6 |        2 | 20.000 |
|        3 |       15 | 20.000 |
|        7 |       10 | 20.000 |
|        4 |        8 | 20.000 |
|        8 |        5 | 20.000 |
+----------+----------+--------+
~~~


8. Obtener el costo total de piezas utilizadas en una reparación específica

~~~mysql
SELECT rep.reparacion_id, repi.cantidad * pi.precio AS 'Costo Total Piezas'
FROM reparaciones AS rep
INNER JOIN reparacion_pieza AS repi
ON rep.reparacion_id = repi.reparacion_id
INNER JOIN pieza AS pi
ON repi.pieza_id = pi.pieza_id
WHERE rep.reparacion_id = 3;

+---------------+--------------------+
| reparacion_id | Costo Total Piezas |
+---------------+--------------------+
|             3 |            150.000 |
+---------------+--------------------+
~~~

9. Obtener el inventario de piezas que necesitan ser reabastecidas (cantidad
menor que un umbral)

~~~mysql
SELECT inv.cantidad, inv.stock_minimo
FROM inventario AS inv
INNER JOIN pieza AS pie
ON inv.pieza_id = pie.pieza_id
WHERE inv.cantidad < inv.stock_minimo;

+----------+--------------+
| cantidad | stock_minimo |
+----------+--------------+
|       10 |           25 |
|        5 |           50 |
|        7 |           20 |
+----------+--------------+
~~~

10. Obtener la lista de servicios más solicitados en un período específico
    
~~~mysql
SELECT cit.servicio_id, ser.nombre, COUNT(cit.servicio_id) AS cantidad
FROM cita AS cit
INNER JOIN servicio AS ser
ON cit.servicio_id = ser.servicio_id
WHERE cit.fecha_hora BETWEEN '2024-01-01' AND '2024-07-30'
GROUP BY cit.servicio_id
ORDER BY cantidad DESC;

+-------------+-----------------------+----------+
| servicio_id | nombre                | cantidad |
+-------------+-----------------------+----------+
|           5 | Reparacion parabrisas |        2 |
|           1 | Mantenimiento         |        1 |
|           2 | Cambio Aceite         |        1 |
|           3 | Revision Frenos       |        1 |
|           4 | Aire Acondicionado    |        1 |
|           6 | Lavado                |        1 |
+-------------+-----------------------+----------+
~~~

11. Obtener el costo total de reparaciones para cada cliente en un período
específico

~~~mysql
SELECT cli.cliente_id, SUM(rep.costo_total) AS 'COSTO TOTAL REPARACIONES'
FROM reparaciones AS rep
INNER JOIN vehiculo AS veh
ON rep.vehiculo_id = veh.vehiculo_id
INNER JOIN cliente AS cli
ON veh.cliente_id = cli.cliente_id
WHERE rep.fecha BETWEEN '2024-06-01' AND '2024-09-30'
GROUP BY cli.cliente_id;

+------------+--------------------------+
| cliente_id | COSTO TOTAL REPARACIONES |
+------------+--------------------------+
|          1 |                  150.000 |
|          2 |                  110.000 |
|          4 |                   55.000 |
|          5 |                  100.000 |
+------------+--------------------------+
~~~


12. Listar los empleados con mayor cantidad de reparaciones realizadas en un
período específico

~~~mysql
SELECT CONCAT(emp.nombre, ' ', emp.apellido) AS 'Nombre Empleado', COUNT(rep.reparacion_id)
FROM empleado AS emp
INNER JOIN reparaciones AS rep
ON emp.empleado_id = rep.empleado_id
WHERE rep.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY CONCAT(emp.nombre, ' ', emp.apellido)
ORDER BY COUNT(rep.reparacion_id) DESC;

+-----------------+--------------------------+
| Nombre Empleado | COUNT(rep.reparacion_id) |
+-----------------+--------------------------+
| Daniel Poveda   |                        5 |
| Carlos Tobar    |                        4 |
| Alberto Pachon  |                        4 |
| Diego Barrios   |                        4 |
| Carlos Basto    |                        3 |
+-----------------+--------------------------+
~~~


13. Obtener las piezas más utilizadas en reparaciones durante un período
específico

~~~mysql
SELECT pie.nombre, SUM(repi.cantidad) AS 'CANTIDAD PIEZAS USADAS'
FROM reparacion_pieza AS repi
INNER JOIN pieza AS pie
ON pie.pieza_id = repi.pieza_id
INNER JOIN reparaciones AS rep
ON rep.reparacion_id = repi.reparacion_id
WHERE rep.fecha BETWEEN '2024-06-01' AND '2024-09-30'
GROUP BY pie.nombre
ORDER BY SUM(repi.cantidad) DESC;

+--------------------+------------------------+
| nombre             | CANTIDAD PIEZAS USADAS |
+--------------------+------------------------+
| Radiadores         |                     12 |
| Mangueras Radiador |                      8 |
| Bombas Agua        |                      7 |
| Tuercas            |                      6 |
| Termostatos        |                      5 |
| Bateria            |                      5 |
| Retrovisor         |                      2 |
| LLanta             |                      1 |
+--------------------+------------------------+
~~~


14. Calcular el promedio de costo de reparaciones por vehículo

~~~mysql
SELECT veh.placa, AVG(rep.costo_total) AS 'Promedio Costo Reparaciones'
FROM vehiculo AS veh
INNER JOIN reparaciones AS rep
ON veh.vehiculo_id = rep.vehiculo_id
GROUP BY veh.placa;

+---------+-----------------------------+
| placa   | Promedio Costo Reparaciones |
+---------+-----------------------------+
| TSM 616 |                  65.0000000 |
| FIZ 516 |                  51.0000000 |
| RIP 123 |                  59.0000000 |
| KHT 243 |                  63.7500000 |
| KSO 754 |                  61.0000000 |
| PPP 258 |                  51.2500000 |
| AMD 924 |                  76.6666667 |
+---------+-----------------------------+
~~~


15. Obtener el inventario de piezas por proveedor

~~~mysql
SELECT pro.proveedor_id, pro.nombre AS 'nombre proveedor', pie.nombre AS 'nombre pieza', pie.descripcion, pie.precio, inv.cantidad
FROM inventario AS inv
INNER JOIN pieza AS pie
ON pie.pieza_id = inv.pieza_id
INNER JOIN proveedor AS pro
ON pro.proveedor_id = pie.proveedor_id
ORDER BY pro.proveedor_id;

+--------------+---------------------+--------------------+-------------------------------+---------+----------+
| proveedor_id | nombre proveedor    | nombre pieza       | descripcion                   | precio  | cantidad |
+--------------+---------------------+--------------------+-------------------------------+---------+----------+
|            1 | Auto Parts          | Retrovisor         | Retrovisores para carro       |  25.000 |       10 |
|            1 | Auto Parts          | Filtros Aire       | Filtros Aire para carro       |  20.000 |       15 |
|            1 | Auto Parts          | Mangueras Radiador | mangueras radiador para carro |  50.000 |        8 |
|            2 | Reparaciones Carros | LLanta             | LLanta para el carro          | 150.000 |       20 |
|            2 | Reparaciones Carros | Bujias             | Bujias para carro             |  15.000 |       25 |
|            2 | Reparaciones Carros | Termostatos        | Termostatos para carro        |  15.000 |        7 |
|            2 | Reparaciones Carros | Tuercas            | Tuercas para el carro         |   5.000 |       65 |
|            3 | Cuidados carros     | Bateria            | Baterias para carro           | 150.000 |      156 |
|            3 | Cuidados carros     | Radiadores         | Radiadores para carro         |  50.000 |        5 |
|            4 | cars                | Tornillos          | Tornillos  para carro         |   2.000 |       55 |
|            4 | cars                | Bombas Agua        | Bombas Agua para carro        |  25.000 |       10 |
+--------------+---------------------+--------------------+-------------------------------+---------+----------+
~~~

16. Listar los clientes que no han realizado reparaciones en el último año

~~~mysql
SELECT cli.nombre
FROM cliente AS cli
LEFT JOIN vehiculo AS veh
ON cli.cliente_id = veh.cliente_id
LEFT JOIN reparaciones AS rep
ON veh.vehiculo_id = rep.vehiculo_id
WHERE YEAR(fecha) is NULL;
~~~


17. Obtener las ganancias totales del taller en un período específico

~~~mysql
SELECT SUM(total) AS 'GANANCIAS TOTALES'
FROM facturacion
WHERE fecha BETWEEN '2024-01-01' AND '2024-12-31';

+-------------------+
| GANANCIAS TOTALES |
+-------------------+
|          2350.000 |
+-------------------+
~~~


18. Listar los empleados y el total de horas trabajadas en reparaciones en un
período específico (asumiendo que se registra la duración de cada reparación)

~~~mysql
SELECT emp.nombre, emp.apellido,SEC_TO_TIME(SUM(TIME_TO_SEC(rep.duracion)))
FROM empleado AS emp
INNER JOIN reparaciones AS rep
ON emp.empleado_id = rep.empleado_id
WHERE rep.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY emp.nombre, emp.apellido;

+---------+----------+---------------------------------------------+
| nombre  | apellido | SEC_TO_TIME(SUM(TIME_TO_SEC(rep.duracion))) |
+---------+----------+---------------------------------------------+
| Daniel  | Poveda   | 09:00:00                                    |
| Diego   | Barrios  | 05:00:00                                    |
| Carlos  | Basto    | 04:00:00                                    |
| Alberto | Pachon   | 04:00:00                                    |
| Carlos  | Tobar    | 06:00:00                                    |
+---------+----------+---------------------------------------------+
~~~

19. Obtener el listado de servicios prestados por cada empleado en un período
específico

~~~mysql
SELECT emp.nombre, emp.apellido, ser.nombre AS 'Nombre Servicio'
FROM empleado AS emp
INNER JOIN reparaciones AS rep
ON emp.empleado_id = rep.empleado_id
INNER JOIN servicio AS ser
ON rep.servicio_id = ser.servicio_id
WHERE rep.fecha BETWEEN '2024-01-01' AND '2024-12-31';
+---------+----------+-----------------------+
| nombre  | apellido | Nombre Servicio       |
+---------+----------+-----------------------+
| Carlos  | Tobar    | Aire Acondicionado    |
| Carlos  | Tobar    | Mantenimiento         |
| Carlos  | Tobar    | Lavado                |
| Carlos  | Tobar    | Mantenimiento         |
| Alberto | Pachon   | Reparacion parabrisas |
| Alberto | Pachon   | Lavado                |
| Alberto | Pachon   | Aire Acondicionado    |
| Alberto | Pachon   | Cambio Aceite         |
| Daniel  | Poveda   | Mantenimiento         |
| Daniel  | Poveda   | Aire Acondicionado    |
| Daniel  | Poveda   | Cambio Aceite         |
| Daniel  | Poveda   | Reparacion parabrisas |
| Daniel  | Poveda   | Lavado                |
| Diego   | Barrios  | Cambio Aceite         |
| Diego   | Barrios  | Revision Frenos       |
| Diego   | Barrios  | Reparacion parabrisas |
| Diego   | Barrios  | Mantenimiento         |
| Carlos  | Basto    | Revision Frenos       |
| Carlos  | Basto    | Lavado                |
| Carlos  | Basto    | Mantenimiento         |
+---------+----------+-----------------------+
~~~


SUBCONSULTAS

1. Obtener el cliente que ha gastado más en reparaciones durante el último año.

~~~mysql
SELECT cli.nombre, cli.apellido, SUM(rep.costo_total) AS 'gasto total reparaciones'
FROM cliente AS cli
INNER JOIN vehiculo AS veh
ON cli.cliente_id = veh.cliente_id
INNER JOIN reparaciones AS rep
ON rep.vehiculo_id = veh.vehiculo_id
WHERE rep.reparacion_id IN (SELECT rep1.reparacion_id
FROM reparaciones AS rep1 
WHERE rep1.fecha BETWEEN '2024-01-01' AND '2024-12-31')
GROUP BY cli.nombre, cli.apellido
ORDER BY SUM(rep.costo_total) DESC
LIMIT 1;

+--------+----------+--------------------------+
| nombre | apellido | gasto total reparaciones |
+--------+----------+--------------------------+
| Juan   | Torres   |                  445.000 |
+--------+----------+--------------------------+
~~~

2. Obtener la pieza más utilizada en reparaciones durante el último mes

~~~mysql
SELECT pie.nombre, MAX(repi.cantidad)
FROM pieza AS pie
INNER JOIN reparacion_pieza as repi
ON pie.pieza_id = repi.pieza_id
INNER JOIN reparaciones AS rep
ON rep.reparacion_id = repi.reparacion_id
WHERE rep.reparacion_id IN(
SELECT rep1.reparacion_id
FROM reparaciones AS rep1
WHERE rep1.fecha BETWEEN '2024-06-01' AND '2024-06-30'
)
GROUP BY pie.nombre
ORDER BY MAX(repi.cantidad) DESC
LIMIT 1
;
+------------+--------------------+
| nombre     | MAX(repi.cantidad) |
+------------+--------------------+
| Radiadores |                 12 |
+------------+--------------------+
~~~

3. Obtener los proveedores que suministran las piezas más caras

~~~mysql
SELECT pro.nombre, pie.precio, pie.nombre
FROM proveedor AS pro
INNER JOIN pieza AS pie
ON pro.proveedor_id = pie.proveedor_id
WHERE pie.precio IN(
SELECT MAX(pie1.precio)
FROM pieza AS pie1);

+---------------------+---------+---------+
| nombre              | precio  | nombre  |
+---------------------+---------+---------+
| Reparaciones Carros | 150.000 | LLanta  |
| Cuidados carros     | 150.000 | Bateria |
+---------------------+---------+---------+
~~~

4. Listar las reparaciones que no utilizaron piezas específicas durante el último
año

~~~mysql
SELECT rep.reparacion_id
FROM reparaciones AS rep
LEFT JOIN reparacion_pieza AS repi
ON rep.reparacion_id = repi.reparacion_id
WHERE rep.reparacion_id IN (SELECT rep2.reparacion_id 
FROM reparaciones AS rep2
LEFT JOIN reparacion_pieza AS repi2
ON rep2.reparacion_id = repi2.reparacion_id
WHERE YEAR(rep.fecha) = 2024
AND repi2.pieza_id IS NULL);

+---------------+
| reparacion_id |
+---------------+
|            32 |
+---------------+
~~~

5. Obtener las piezas que están en inventario por debajo del 10% del stock inicial

~~~mysql
SELECT pie.nombre
FROM pieza AS pie
INNER JOIN inventario AS inv
ON pie.pieza_id = inv.pieza_id
WHERE pie.pieza_id IN (
SELECT inv2.pieza_id
FROM inventario AS inv2
WHERE inv2.cantidad < inv2.stock_inicial * 0.1);

+-------------+
| nombre      |
+-------------+
| Radiadores  |
| Termostatos |
+-------------+
~~~
