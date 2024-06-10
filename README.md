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
