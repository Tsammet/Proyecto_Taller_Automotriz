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
~~~
