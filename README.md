CONSULTAS

1. Obtener el historial de reparaciones de un vehículo específico
   
~~~mysql
SELECT reparacion_id, fecha, vehiculo_id, empleado_id, servicio_id, costo_total, duracion, descripcion
FROM reparaciones
WHERE vehiculo_id = 1;
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
