-- CONSULTAS

-- 1 . Obtener el historial de reparaciones de un vehículo específico

SELECT reparacion_id, fecha, vehiculo_id, empleado_id, servicio_id, costo_total, duracion, descripcion
FROM reparaciones
WHERE vehiculo_id = 1;

-- ------------------------------------------------------

-- 2. Calcular el costo total de todas las reparaciones realizadas por un empleado
-- específico en un período de tiempo

SELECT empleado_id ,SUM(costo_total) AS 'Costo Total Reparaciones'
FROM reparaciones
WHERE empleado_id = 2
AND YEAR(fecha) = 2024
AND MONTH(fecha) = 6; 

-- -------------------------------------------------------

-- 3. Listar todos los clientes y los vehículos que poseen

SELECT  CONCAT(cli.nombre, ' ', cli.apellido) AS nombre_cliente, veh.vehiculo_id
FROM cliente AS cli
INNER JOIN vehiculo AS veh
ON cli.cliente_id = veh.cliente_id;

-- -------------------------------------------------------

-- 4. Obtener la cantidad de piezas en inventario para cada pieza

SELECT pieza_id, SUM(cantidad)
FROM inventario
GROUP BY pieza_id;

-------------------------------------------------------------

-- 5. Obtener las citas programadas para un día específico

SELECT cita_id, fecha_hora, cliente_id, vehiculo_id, servicio_id
FROM cita
WHERE DATE(fecha_hora) = '2024-06-20';

-- ------------------------------------------------------

-- 6. Generar una factura para un cliente específico en una fecha determinada

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

-- ----------------------------------------------------------

-- 7. Listar todas las órdenes de compra y sus detalles

SELECT oc.orden_id, od.cantidad, od.precio
FROM orden_compra AS oc
INNER JOIN orden_detalle AS od
ON oc.orden_id = od.orden_id;


-- -------------------------------- -----------

-- 8. Obtener el costo total de piezas utilizadas en una reparación específica

SELECT rep.reparacion_id, repi.cantidad * pi.precio AS 'Costo Total Piezas'
FROM reparaciones AS rep
INNER JOIN reparacion_pieza AS repi
ON rep.reparacion_id = repi.reparacion_id
INNER JOIN pieza AS pi
ON repi.pieza_id = pi.pieza_id
WHERE rep.reparacion_id = 3;

-- ----------------------------------------


-- 9. Obtener el inventario de piezas que necesitan ser reabastecidas (cantidad
-- menor que un umbral)

SELECT inv.cantidad, inv.stock_minimo
FROM inventario AS inv
INNER JOIN pieza AS pie
ON inv.pieza_id = pie.pieza_id
WHERE inv.cantidad < inv.stock_minimo;

-- ----------------------------------------

-- 10. Obtener la lista de servicios más solicitados en un período específico

SELECT cit.servicio_id, ser.nombre, COUNT(cit.servicio_id) AS cantidad
FROM cita AS cit
INNER JOIN servicio AS ser
ON cit.servicio_id = ser.servicio_id
WHERE cit.fecha_hora BETWEEN '2024-01-01' AND '2024-07-30'
GROUP BY cit.servicio_id
ORDER BY cantidad DESC;

-- ----------------------------------------

-- 11. Obtener el costo total de reparaciones para cada cliente en un período
-- específico

SELECT cli.cliente_id, SUM(rep.costo_total) AS 'COSTO TOTAL REPARACIONES'
FROM reparaciones AS rep
INNER JOIN vehiculo AS veh
ON rep.vehiculo_id = veh.vehiculo_id
INNER JOIN cliente AS cli
ON veh.cliente_id = cli.cliente_id
WHERE rep.fecha BETWEEN '2024-06-01' AND '2024-09-30'
GROUP BY cli.cliente_id;

-- ----------------------------------------

-- 12. Listar los empleados con mayor cantidad de reparaciones realizadas en un
-- período específico

SELECT CONCAT(emp.nombre, ' ', emp.apellido) AS 'Nombre Empleado', COUNT(rep.reparacion_id)
FROM empleado AS emp
INNER JOIN reparaciones AS rep
ON emp.empleado_id = rep.empleado_id
WHERE rep.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY CONCAT(emp.nombre, ' ', emp.apellido)
ORDER BY COUNT(rep.reparacion_id) DESC;

-- ------------------------------------------

-- 13. Obtener las piezas más utilizadas en reparaciones durante un período
-- específico

SELECT pie.nombre, SUM(repi.cantidad) AS 'CANTIDAD PIEZAS USADAS'
FROM reparacion_pieza AS repi
INNER JOIN pieza AS pie
ON pie.pieza_id = repi.pieza_id
INNER JOIN reparaciones AS rep
ON rep.reparacion_id = repi.reparacion_id
WHERE rep.fecha BETWEEN '2024-06-01' AND '2024-09-30'
GROUP BY pie.nombre
ORDER BY SUM(repi.cantidad) DESC;

-- ----------------------------------------

-- 14. Calcular el promedio de costo de reparaciones por vehículo

SELECT veh.placa, AVG(rep.costo_total) AS 'Promedio Costo Reparaciones'
FROM vehiculo AS veh
INNER JOIN reparaciones AS rep
ON veh.vehiculo_id = rep.vehiculo_id
GROUP BY veh.placa;

-- ----------------------------------------

-- 15. Obtener el inventario de piezas por proveedor

SELECT pro.proveedor_id, pro.nombre AS 'nombre proveedor', pie.nombre AS 'nombre pieza', pie.descripcion, pie.precio, inv.cantidad
FROM inventario AS inv
INNER JOIN pieza AS pie
ON pie.pieza_id = inv.pieza_id
INNER JOIN proveedor AS pro
ON pro.proveedor_id = pie.proveedor_id
ORDER BY pro.proveedor_id;

-- ----------------------------------------

-- 16. Listar los clientes que no han realizado reparaciones en el último año

SELECT cli.nombre
FROM cliente AS cli
LEFT JOIN vehiculo AS veh
ON cli.cliente_id = veh.cliente_id
LEFT JOIN reparaciones AS rep
ON veh.vehiculo_id = rep.vehiculo_id
WHERE YEAR(fecha) is NULL;

-- ----------------------------------------

-- 17. Obtener las ganancias totales del taller en un período específico

SELECT SUM(total) AS 'GANANCIAS TOTALES'
FROM facturacion
WHERE fecha BETWEEN '2024-01-01' AND '2024-12-31';

-- ----------------------------------------

-- 18. Listar los empleados y el total de horas trabajadas en reparaciones en un
-- período específico (asumiendo que se registra la duración de cada reparación)

SELECT emp.nombre, emp.apellido,SEC_TO_TIME(SUM(TIME_TO_SEC(rep.duracion)))
FROM empleado AS emp
INNER JOIN reparaciones AS rep
ON emp.empleado_id = rep.empleado_id
WHERE rep.fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY emp.nombre, emp.apellido;


-- ----------------------------------------

-- 19. Obtener el listado de servicios prestados por cada empleado en un período
-- específico

SELECT emp.nombre, emp.apellido, ser.nombre AS 'Nombre Servicio'
FROM empleado AS emp
INNER JOIN reparaciones AS rep
ON emp.empleado_id = rep.empleado_id
INNER JOIN servicio AS ser
ON rep.servicio_id = ser.servicio_id
WHERE rep.fecha BETWEEN '2024-01-01' AND '2024-12-31';



-- ------------------------------------------








-- SUBCONSULTAS

-- 1. Obtener el cliente que ha gastado más en reparaciones durante el último año.

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


-- -----------------------------------------------

-- 2. Obtener la pieza más utilizada en reparaciones durante el último mes

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


-- ---------------------------------------------------------

-- 3. Obtener los proveedores que suministran las piezas más caras

SELECT pro.nombre, pie.precio, pie.nombre
FROM proveedor AS pro
INNER JOIN pieza AS pie
ON pro.proveedor_id = pie.proveedor_id
WHERE pie.precio IN(
SELECT MAX(pie1.precio)
FROM pieza AS pie1);


-- -----------------------------------------------------------

-- 4. Listar las reparaciones que no utilizaron piezas específicas durante el último
-- año

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


-- --------------------------------------------------------------

-- 5. Obtener las piezas que están en inventario por debajo del 10% del stock inicial

SELECT pie.nombre
FROM pieza AS pie
INNER JOIN inventario AS inv
ON pie.pieza_id = inv.pieza_id
WHERE pie.pieza_id IN (
SELECT inv2.pieza_id
FROM inventario AS inv2
WHERE inv2.cantidad < inv2.stock_inicial * 0.1);

-- ------------------------------------------





-- PROCEDIMIENTOS

-- 1. Crear un procedimiento almacenado para insertar una nueva reparación.

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

-- ----------------------------------------------

-- 2. Crear un procedimiento almacenado para actualizar el inventario de una pieza.

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

-- ------------------------------------------

-- 3. Crear un procedimiento almacenado para eliminar una cita

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

-- --------------------------------------------

-- 4. Crear un procedimiento almacenado para generar una factura

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

-- --------------------------------------------

-- 5. Crear un procedimiento almacenado para obtener el historial de reparaciones
-- de un vehículo

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

-- ------------------------------------------------

-- 6. Crear un procedimiento almacenado para calcular el costo total de
-- reparaciones de un cliente en un período

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


-- ----------------------------------------------------

-- 7. Crear un procedimiento almacenado para obtener la lista de vehículos que
-- requieren mantenimiento basado en el kilometraje.

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

-- ------------------------------------------------------

-- 8. Crear un procedimiento almacenado para insertar una nueva orden de compra

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

-- ------------------------------------------------------

-- 9. Crear un procedimiento almacenado para actualizar los datos de un cliente

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

-- ---------------------------------------------------------------

-- 10. Crear un procedimiento almacenado para obtener los servicios más solicitados
-- en un período

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