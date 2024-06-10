CONSULTAS

1. Obtener el historial de reparaciones de un vehículo específico
   
~~~mysql
SELECT reparacion_id, fecha, vehiculo_id, empleado_id, servicio_id, costo_total, duracion, descripcion
FROM reparaciones
WHERE vehiculo_id = 1;
~~~
