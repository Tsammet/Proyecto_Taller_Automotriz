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

1. Crear un procedimiento almacenado para insertar una nueva reparación.

~~~mysql
DELIMITER $$

DROP PROCEDURE IF EXISTS insertar_reparacion;
CREATE PROCEDURE insertar_reparacion(
IN ir_fecha DATE,
IN ir_vehiculo_id INT,
IN ir_empleado_id INT,
IN ir_servicio_id INT,
IN ir_costo_total double(10,3),
IN ir_duracion TIME,
IN ir_descripcion VARCHAR(50)
)
BEGIN 
INSERT INTO reparaciones (reparacion_id, fecha, vehiculo_id, empleado_id, servicio_id, costo_total, duracion, descripcion)
VALUES (NULL, ir_fecha, ir_vehiculo_id, ir_empleado_id, ir_servicio_id, ir_costo_total, ir_duracion, ir_descripcion);
END $$

DELIMITER ;

CALL insertar_reparacion('2024-08-01', 1,2,2,20.000, '2:00:00', 'NUEVO SERVICIO');
+---------------+------------+-------------+-------------+-------------+-------------+----------+-----------------------------------------+
| reparacion_id | fecha      | vehiculo_id | empleado_id | servicio_id | costo_total | duracion | descripcion                             |
+---------------+------------+-------------+-------------+-------------+-------------+----------+-----------------------------------------+
|             1 | 2023-01-15 |           1 |           2 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|             2 | 2023-02-25 |           2 |           3 |           2 |     100.000 | 01:00:00 | Cambio Aceite para carro                |
|             3 | 2023-03-15 |           3 |           4 |           3 |      70.000 | 01:00:00 | Revision frenos del vehiculo            |
|             4 | 2023-04-12 |           4 |           5 |           4 |     100.000 | 01:00:00 | Recarga Aire Acondicionado del vehiculo |
|             5 | 2023-05-01 |           5 |           6 |           5 |      25.000 | 01:00:00 | Reparacion de parabrisas del vehiculo   |
|             6 | 2023-06-30 |           6 |           2 |           6 |      30.000 | 01:00:00 | Lavado a todo el vehiculo               |
|             7 | 2023-07-30 |           7 |           3 |           4 |     100.000 | 01:00:00 | Recarga Aire Acondicionado del vehiculo |
|             8 | 2023-08-29 |           1 |           4 |           3 |      70.000 | 01:00:00 | Revision frenos del vehiculo            |
|             9 | 2023-09-28 |           2 |           5 |           5 |      25.000 | 01:00:00 | Reparacion de parabrisas del vehiculo   |
|            10 | 2023-10-27 |           3 |           6 |           6 |      30.000 | 01:00:00 | Lavado a todo el vehiculo               |
|            11 | 2023-11-22 |           4 |           2 |           2 |     100.000 | 01:00:00 | Cambio Aceite para carro                |
|            12 | 2023-12-24 |           5 |           3 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|            13 | 2024-01-26 |           6 |           4 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|            14 | 2024-02-15 |           7 |           5 |           2 |     100.000 | 01:00:00 | Cambio Aceite para carro                |
|            15 | 2024-03-12 |           1 |           6 |           3 |      70.000 | 01:00:00 | Revision frenos del vehiculo            |
|            16 | 2024-04-10 |           1 |           4 |           4 |     100.000 | 01:00:00 | Recarga Aire Acondicionado del vehiculo |
|            17 | 2024-05-08 |           3 |           3 |           5 |      25.000 | 01:00:00 | Reparacion de parabrisas del vehiculo   |
|            18 | 2024-06-07 |           2 |           6 |           6 |      30.000 | 01:00:00 | Lavado a todo el vehiculo               |
|            19 | 2024-06-06 |           6 |           2 |           4 |     100.000 | 01:00:00 | Recarga Aire Acondicionado del vehiculo |
|            20 | 2024-06-01 |           4 |           5 |           3 |      30.000 | 01:00:00 | Revision frenos del vehiculo            |
|            21 | 2024-07-02 |           7 |           3 |           6 |      30.000 | 01:00:00 | Lavado a todo el vehiculo               |
|            22 | 2024-08-04 |           4 |           5 |           5 |      25.000 | 01:00:00 | Reparacion de parabrisas del vehiculo   |
|            23 | 2024-08-10 |           5 |           4 |           2 |     100.000 | 01:00:00 | Cambio Aceite para carro                |
|            24 | 2024-08-11 |           1 |           6 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|            25 | 2024-09-12 |           2 |           2 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|            26 | 2024-10-18 |           3 |           3 |           4 |     100.000 | 01:00:00 | Recarga Aire Acondicionado del vehiculo |
|            27 | 2024-11-12 |           6 |           4 |           5 |      25.000 | 01:00:00 | Reparacion de parabrisas del vehiculo   |
|            28 | 2024-11-25 |           5 |           2 |           6 |      30.000 | 01:00:00 | Lavado a todo el vehiculo               |
|            29 | 2024-12-15 |           5 |           3 |           2 |     100.000 | 01:00:00 | Cambio Aceite para carro                |
|            30 | 2024-12-25 |           2 |           5 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|            31 | 2024-12-15 |           3 |           4 |           6 |      70.000 | 04:00:00 | Lavado del vehiculo                     |
|            32 | 2024-01-15 |           1 |           2 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|            33 | 2024-08-01 |           1 |           2 |           2 |      20.000 | 02:00:00 | NUEVO SERVICIO                          |
+---------------+------------+-------------+-------------+-------------+-------------+----------+-----------------------------------------+
~~~


2. Crear un procedimiento almacenado para actualizar el inventario de una pieza.

~~~mysql
DELIMITER $$

DROP PROCEDURE IF EXISTS actualizar_pieza;
CREATE PROCEDURE actualizar_pieza(
IN p_pieza_id INT,
IN p_nombre VARCHAR(25),
IN p_descripcion VARCHAR(100),
IN p_precio DOUBLE(10,3),
IN p_proveedor_id INT
)
BEGIN
UPDATE pieza
SET nombre = p_nombre,
descripcion = p_descripcion,
precio = p_precio,
proveedor_id = p_proveedor_id
WHERE pieza_id = p_pieza_id;
END$$

DELIMITER ;

CALL actualizar_pieza(11, 'Tuercas' , 'Tuercas para el carro',6000,1);
+----------+--------------------+-------------------------------+----------+--------------+
| pieza_id | nombre             | descripcion                   | precio   | proveedor_id |
+----------+--------------------+-------------------------------+----------+--------------+
|        1 | Retrovisor         | Retrovisores para carro       |   25.000 |            1 |
|        2 | LLanta             | LLanta para el carro          |  150.000 |            2 |
|        3 | Bateria            | Baterias para carro           |  150.000 |            3 |
|        4 | Tornillos          | Tornillos  para carro         |    2.000 |            4 |
|        5 | Filtros Aire       | Filtros Aire para carro       |   20.000 |            1 |
|        6 | Bujias             | Bujias para carro             |   15.000 |            2 |
|        7 | Bombas Agua        | Bombas Agua para carro        |   25.000 |            4 |
|        8 | Radiadores         | Radiadores para carro         |   50.000 |            3 |
|        9 | Termostatos        | Termostatos para carro        |   15.000 |            2 |
|       10 | Mangueras Radiador | mangueras radiador para carro |   50.000 |            1 |
|       11 | Tuercas            | Tuercas para el carro         | 6000.000 |            1 |
+----------+--------------------+-------------------------------+----------+--------------+
~~~


3. Crear un procedimiento almacenado para eliminar una cita

~~~mysql
DELIMITER $$

DROP PROCEDURE IF EXISTS eliminar_cita;
CREATE PROCEDURE eliminar_cita(
IN e_cita_id INT
)
BEGIN
DELETE FROM cita
WHERE cita_id = e_cita_id;
END$$

DELIMITER ;

CALL eliminar_cita(11);

+---------+---------------------+------------+-------------+-------------+
| cita_id | fecha_hora          | cliente_id | vehiculo_id | servicio_id |
+---------+---------------------+------------+-------------+-------------+
|       1 | 2023-01-01 14:30:00 |          1 |           1 |           2 |
|       2 | 2023-03-05 14:30:00 |          2 |           2 |           1 |
|       3 | 2023-04-15 13:30:00 |          3 |           3 |           6 |
|       4 | 2023-05-12 16:30:00 |          4 |           4 |           3 |
|       5 | 2023-06-17 17:30:00 |          5 |           5 |           1 |
|       6 | 2023-07-25 18:30:00 |          1 |           6 |           1 |
|       7 | 2023-08-12 12:00:00 |          2 |           7 |           2 |
|       8 | 2023-09-17 16:00:00 |          3 |           3 |           5 |
|       9 | 2023-10-15 11:00:00 |          4 |           4 |           6 |
|      10 | 2023-11-29 18:00:00 |          5 |           5 |           2 |
|      12 | 2024-01-02 21:00:00 |          2 |           2 |           6 |
|      13 | 2024-02-07 22:00:00 |          3 |           3 |           5 |
|      14 | 2024-03-12 23:00:00 |          4 |           4 |           4 |
|      15 | 2024-04-16 06:00:00 |          5 |           5 |           3 |
|      16 | 2024-05-18 16:00:00 |          1 |           6 |           2 |
|      17 | 2024-06-20 15:00:00 |          2 |           7 |           1 |
|      18 | 2024-07-22 12:00:00 |          3 |           3 |           5 |
|      19 | 2024-08-25 10:00:00 |          4 |           4 |           4 |
|      20 | 2024-09-28 11:00:00 |          5 |           5 |           6 |
|      21 | 2024-10-30 12:00:00 |          1 |           6 |           1 |
|      22 | 2024-11-12 17:00:00 |          2 |           7 |           3 |
|      23 | 2024-12-17 13:00:00 |          3 |           3 |           2 |
|      24 | 2024-12-15 12:00:00 |          4 |           4 |           6 |
+---------+---------------------+------------+-------------+-------------+
~~~

4. Crear un procedimiento almacenado para generar una factura

~~~mysql
DELIMITER $$

DROP PROCEDURE IF EXISTS generar_factura;
CREATE PROCEDURE generar_factura(
IN gf_fecha DATE,
IN gf_total DOUBLE(10,3),
IN gf_cliente_id INT
)
BEGIN
INSERT INTO facturacion(fecha, total,cliente_id)
VALUES(gf_fecha,gf_total,gf_cliente_id);
END $$

DELIMITER ;

CALL generar_factura('2024-12-29', 30.000, 2);

+------------+------------+---------+------------+
| factura_id | fecha      | total   | cliente_id |
+------------+------------+---------+------------+
|          1 | 2023-01-15 | 150.000 |          1 |
|          2 | 2023-02-25 | 120.000 |          2 |
|          3 | 2023-03-15 | 130.000 |          3 |
|          4 | 2023-04-12 | 140.000 |          4 |
|          5 | 2023-05-01 | 150.000 |          5 |
|          6 | 2023-06-30 | 110.000 |          1 |
|          7 | 2023-07-30 |  50.000 |          2 |
|          8 | 2023-08-29 |  60.000 |          3 |
|          9 | 2023-09-28 |  70.000 |          4 |
|         10 | 2023-10-27 |  80.000 |          5 |
|         11 | 2023-11-22 |  50.000 |          1 |
|         12 | 2023-12-24 |  90.000 |          2 |
|         13 | 2024-01-26 | 150.000 |          3 |
|         14 | 2024-02-15 | 110.000 |          4 |
|         15 | 2024-03-12 | 125.000 |          5 |
|         16 | 2024-04-10 | 130.000 |          1 |
|         17 | 2024-05-08 | 160.000 |          2 |
|         18 | 2024-06-07 | 145.000 |          3 |
|         19 | 2024-06-06 | 120.000 |          4 |
|         20 | 2024-06-01 | 150.000 |          5 |
|         21 | 2024-07-02 | 250.000 |          1 |
|         22 | 2024-08-04 | 170.000 |          2 |
|         23 | 2024-08-10 | 120.000 |          3 |
|         24 | 2024-08-11 | 110.000 |          4 |
|         25 | 2024-09-12 |  50.000 |          5 |
|         26 | 2024-10-18 |  60.000 |          1 |
|         27 | 2024-11-12 |  70.000 |          2 |
|         28 | 2024-11-25 |  75.000 |          4 |
|         29 | 2024-12-15 |  85.000 |          3 |
|         30 | 2024-12-25 | 150.000 |          5 |
|         31 | 2024-12-15 | 120.000 |          1 |
|         32 | 2024-12-29 |  30.000 |          2 |
+------------+------------+---------+------------+
~~~

5. Crear un procedimiento almacenado para obtener el historial de reparaciones
de un vehículo

~~~mysql
DELIMITER $$

DROP PROCEDURE IF EXISTS historia_reparaciones;
CREATE PROCEDURE historia_reparaciones(
IN hr_vehiculo_id INT
)
BEGIN
SELECT reparacion_id, fecha, vehiculo_id,empleado_id, servicio_id,costo_total,duracion,descripcion
FROM reparaciones
WHERE vehiculo_id = hr_vehiculo_id;
END$$

DELIMITER ;

CALL historia_reparaciones(1);
+---------------+------------+-------------+-------------+-------------+-------------+----------+-----------------------------------------+
| reparacion_id | fecha      | vehiculo_id | empleado_id | servicio_id | costo_total | duracion | descripcion                             |
+---------------+------------+-------------+-------------+-------------+-------------+----------+-----------------------------------------+
|             1 | 2023-01-15 |           1 |           2 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|             8 | 2023-08-29 |           1 |           4 |           3 |      70.000 | 01:00:00 | Revision frenos del vehiculo            |
|            15 | 2024-03-12 |           1 |           6 |           3 |      70.000 | 01:00:00 | Revision frenos del vehiculo            |
|            16 | 2024-04-10 |           1 |           4 |           4 |     100.000 | 01:00:00 | Recarga Aire Acondicionado del vehiculo |
|            24 | 2024-08-11 |           1 |           6 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|            32 | 2024-01-15 |           1 |           2 |           1 |      50.000 | 02:00:00 | Mantenimento al vehiculo                |
|            33 | 2024-08-01 |           1 |           2 |           2 |      20.000 | 02:00:00 | NUEVO SERVICIO                          |
+---------------+------------+-------------+-------------+-------------+-------------+----------+-----------------------------------------+
~~~

6. Crear un procedimiento almacenado para calcular el costo total de
reparaciones de un cliente en un período
~~~mysql
DELIMITER $$

DROP PROCEDURE IF EXISTS costo_total_reparaciones_cliente;
CREATE PROCEDURE costo_total_reparaciones_cliente(
IN cr_cliente_id INT,
IN cr_fecha_inicio DATE,
IN cr_fecha_fin DATE
)
BEGIN
SELECT cli.nombre, cli.apellido, SUM(rep.costo_total)
FROM reparaciones AS rep
INNER JOIN vehiculo AS veh
ON rep.vehiculo_id = veh.vehiculo_id
INNER JOIN cliente AS cli
ON cli.cliente_id = veh.cliente_id
WHERE cli.cliente_id = cr_cliente_id
AND rep.fecha BETWEEN cr_fecha_inicio AND cr_fecha_fin
GROUP BY cli.nombre, cli.apellido;
END $$

DELIMITER ;

CALL costo_total_reparaciones_cliente(1, '2024-06-01', '2024-07-30');
+--------+----------+----------------------+
| nombre | apellido | SUM(rep.costo_total) |
+--------+----------+----------------------+
| Juan   | Torres   |              100.000 |
+--------+----------+----------------------+
~~~


7. Crear un procedimiento almacenado para obtener la lista de vehículos que
requieren mantenimiento basado en el kilometraje.

~~~mysql
DELIMITER $$

DROP PROCEDURE IF EXISTS requiere_mantenimiento;
CREATE PROCEDURE requiere_mantenimiento(
IN rm_kilometraje_limite INT
)
BEGIN
SELECT vehiculo_id, placa, kilometraje, rm_kilometraje_limite
FROM vehiculo
WHERE kilometraje > rm_kilometraje_limite;
END $$

DELIMITER ;

CALL requiere_mantenimiento(100000);
+-------------+---------+-------------+-----------------------+
| vehiculo_id | placa   | kilometraje | rm_kilometraje_limite |
+-------------+---------+-------------+-----------------------+
|           5 | KSO 754 |      105000 |                100000 |
|           6 | PPP 258 |      120000 |                100000 |
+-------------+---------+-------------+-----------------------+
~~~

8. Crear un procedimiento almacenado para insertar una nueva orden de compra

~~~mysql
DELIMITER $$

DROP PROCEDURE IF EXISTS nueva_orden;
CREATE PROCEDURE nueva_orden(
IN no_fecha DATE,
IN no_proveedor_id INT,
IN no_empleado_id INT,
IN no_total DOUBLE(10,3)
)
BEGIN
INSERT INTO orden_compra(orden_id,fecha,proveedor_id,empleado_id,total)
VALUES(NULL, no_fecha, no_proveedor_id, no_empleado_id, no_total);
END $$

DELIMITER ; 

CALL nueva_orden('2024-06-07', 1,1,20.000);
+----------+------------+--------------+-------------+---------+
| orden_id | fecha      | proveedor_id | empleado_id | total   |
+----------+------------+--------------+-------------+---------+
|        1 | 2023-02-03 |            1 |           2 |  60.000 |
|        2 | 2023-06-05 |            2 |           3 |  70.000 |
|        3 | 2023-09-08 |            3 |           4 |  80.000 |
|        4 | 2024-03-15 |            4 |           5 |  90.000 |
|        5 | 2024-04-22 |            1 |           6 | 100.000 |
|        6 | 2024-05-30 |            2 |           2 |  25.000 |
|        7 | 2024-06-05 |            3 |           3 |  40.000 |
|        8 | 2024-06-05 |            4 |           2 |  50.000 |
|        9 | 2024-06-07 |            1 |           1 |  20.000 |
+----------+------------+--------------+-------------+---------+
~~~

9. Crear un procedimiento almacenado para actualizar los datos de un cliente
~~~mysql
DELIMITER $$

DROP PROCEDURE IF EXISTS actualizar_cliente;
CREATE PROCEDURE actualizar_cliente(
IN ac_cliente_id INT,
IN ac_nombre VARCHAR(25),
IN ac_apellido VARCHAR(25),
IN ac_direccion VARCHAR(50),
IN ac_ciudad_id INT,
IN ac_telefono_cliente_id INT
)
BEGIN
UPDATE cliente
SET nombre = ac_nombre,
apellido = ac_apellido,
direccion = ac_direccion,
ciudad_id = ac_ciudad_id,
telefono_cliente_id = ac_telefono_cliente_id
WHERE cliente_id = ac_cliente_id;
END $$

DELIMITER ; 

CALL actualizar_cliente (1,'Juan','Torress', 'blablaBogota',1,1);
+------------+--------+----------+----------------+-----------+---------------------+
| cliente_id | nombre | apellido | direccion      | ciudad_id | telefono_cliente_id |
+------------+--------+----------+----------------+-----------+---------------------+
|          1 | Juan   | Torress  | blablaBogota   |         1 |                   1 |
|          2 | Alvaro | Sánchez  | cra 8B 3s #4   |         1 |                   2 |
|          3 | Maryi  | Leon     | cra 7B 3s #4   |         1 |                   3 |
|          4 | Diana  | Leon     | cra 9C 2s #4   |         1 |                   4 |
|          5 | Carlos | Diaz     | cra 4d 33s #54 |         1 |                   5 |
+------------+--------+----------+----------------+-----------+---------------------+
~~~

10. Crear un procedimiento almacenado para obtener los servicios más solicitados
en un período
~~~mysql
DELIMITER $$

DROP PROCEDURE IF EXISTS servicio_mas_solicitado;
CREATE PROCEDURE servicio_mas_solicitado(
IN ss_fecha_inicio DATE,
IN ss_fecha_fin DATE
)
BEGIN
SELECT ser.nombre, COUNT(rep.reparacion_id) AS 'cantidad reparaciones'
FROM servicio AS ser
INNER JOIN reparaciones AS rep
ON rep.servicio_id = ser.servicio_id
WHERE rep.fecha BETWEEN DATE(ss_fecha_inicio) AND DATE(ss_fecha_fin)
GROUP BY ser.nombre
ORDER BY COUNT(rep.reparacion_id) DESC
LIMIT 1;
END$$

DELIMITER ;

CALL servicio_mas_solicitado('2024-01-01','2024-12-31');

+---------------+-----------------------+
| nombre        | cantidad reparaciones |
+---------------+-----------------------+
| Mantenimiento |                     5 |
+---------------+-----------------------+
~~~
