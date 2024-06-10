INSERT INTO pais(nombre)
VALUES ('Colombia'),
('Argentina'),
('Venezuela');

INSERT INTO region(nombre, pais_id)
VALUES ('Santander', 1),
('Cundinamarca', 1),
('Antioquia', 1);

INSERT INTO ciudad(nombre, region_id)
VALUES ('Bucaramanga', 1),
('Bogotá', 2),
('Medellin', 3);

INSERT INTO telefono_cliente(telefono, email)
VALUES ('3133367825', 'Juan@gmail.com'),
('3157537965', 'Alvaro@gmail.com'),
('3175437965', 'Maryi@gmail.com'),
('3565379653', 'Diana@gmail.com'),
('3565354353', 'Carlos@gmail.com');

INSERT INTO cliente(nombre, apellido, direccion, ciudad_id, telefono_cliente_id)
VALUES ('Juan', 'Torres', 'cra 2d 13s #5', 1, 1),
('Alvaro', 'Sánchez', 'cra 8B 3s #4', 1, 2),
('Maryi', 'Leon', 'cra 7B 3s #4', 1, 3),
('Diana', 'Leon', 'cra 9C 2s #4', 1, 4),
('Carlos', 'Diaz', 'cra 4d 33s #54', 1, 5);

INSERT INTO color(nombre)
VALUES ('Negro'),
('Azul'),
('Gris'),
('Blanco');

INSERT INTO marca(nombre)
VALUES ('NISSAN'),
('TOYOTA'),
('MAZDA');

INSERT INTO modelo(nombre, marca_id)
VALUES ('NISSAN 2023', 1),
('NISSAN 2024', 1),
('Mazda CX‑30 2024', 3),
('TOYOTA 2023', 2),
('TOYOTA 2024', 2),
('VERSA MODELO 2024', 3);

INSERT INTO vehiculo(placa, año, modelo_id, cliente_id, color_id, kilometraje)
VALUES ('TSM 616', '2024-01-01', 1, 1, 1,25000),
('FIZ 516', '2023-01-06', 1, 2, 2, 30000),
('RIP 123', '2024-06-15', 2, 3, 3,60000),
('KHT 243', '2022-11-07', 3, 4, 4, 15000),
('KSO 754', '2023-12-06', 4, 5, 1, 105000),
('PPP 258', '2024-05-17', 5, 1, 2, 120000),
('AMD 924', '2023-06-29', 6, 2, 3, 96000);

INSERT INTO cargo_empleado(nombre_cargo)
VALUES ('Gerente'),
('Tecnico 1'),
('Tecnico 2'),
('Tecnico 3'),
('Auxiliar Tecnico'),
('Auxiliar Tecnico');

INSERT INTO telefono_empleado(telefono, email)
VALUES ('3125748912', 'empleado1@gmail.com'),
('3115438912', 'empleado2@gmail.com'),
('3186428912', 'empleado3@gmail.com'),
('3126738912', 'empleado4@gmail.com'),
('3125863212', 'empleado5@gmail.com'),
('3125474212', 'empleado6@gmail.com');

INSERT INTO empleado(nombre, apellido, cargo_id, telefono_empleado_id)
VALUES ('Juan', 'Jimenez', 1, 1),
('Carlos', 'Tobar', 2, 2),
('Alberto', 'Pachon', 3, 3),
('Daniel', 'Poveda', 4, 4),
('Diego', 'Barrios', 5, 5),
('Carlos', 'Basto', 6, 6);

INSERT INTO servicio(nombre, descripcion, costo)
VALUES ('Mantenimiento', 'Mantenimiento del vehiculo', 50.000),		
('Cambio Aceite', 'Cambio Aceite para carro', 100.000),	
('Revision Frenos', 'frenos del vehiculo', 70.000),	
('Aire Acondicionado', 'Recarga Aire del vehiculo', 100.000),	
('Reparacion parabrisas', 'Reparacion de parabrisas del vehiculo', 25.000),	
('Lavado', 'Lavado del vehiculo', 30.000);

INSERT INTO cita(fecha_hora, cliente_id, vehiculo_id, servicio_id)
VALUES ('2023-01-01 14:30:00',1,1,2),
('2023-03-05 14:30:00',2,2,1),
('2023-04-15 13:30:00',3,3,6),
('2023-05-12 16:30:00',4,4,3),
('2023-06-17 17:30:00',5,5,1),
('2023-07-25 18:30:00',1,6,1),
('2023-08-12 12:00:00',2,7,2),
('2023-09-17 16:00:00',3,3,5),
('2023-10-15 11:00:00',4,4,6),
('2023-11-29 18:00:00',5,5,2),
('2023-12-01 22:00:00',1,1,3),
('2024-01-02 21:00:00',2,2,6),
('2024-02-07 22:00:00',3,3,5),
('2024-03-12 23:00:00',4,4,4),
('2024-04-16 06:00:00',5,5,3),
('2024-05-18 16:00:00',1,6,2),
('2024-06-20 15:00:00',2,7,1),
('2024-07-22 12:00:00',3,3,5),
('2024-08-25 10:00:00',4,4,4),
('2024-09-28 11:00:00',5,5,6),
('2024-10-30 12:00:00',1,6,1),
('2024-11-12 17:00:00',2,7,3),
('2024-12-17 13:00:00',3,3,2),
('2024-12-15 12:00:00',4,4,6);

INSERT INTO reparaciones(fecha,vehiculo_id, empleado_id, servicio_id, costo_total, duracion, descripcion)
VALUES ('2023-01-15', 1,2,1, 50.000,'2:00:00', 'Mantenimento al vehiculo'),
('2023-02-25', 2,3,2, 100.000,'1:00:00', 'Cambio Aceite para carro'),
('2023-03-15', 3,4,3, 70.000,'1:00:00', 'Revision frenos del vehiculo'),
('2023-04-12', 4,5,4, 100.000,'1:00:00', 'Recarga Aire Acondicionado del vehiculo'),
('2023-05-01', 5,6,5, 25.000,'1:00:00', 'Reparacion de parabrisas del vehiculo'),
('2023-06-30', 6,2,6, 30.000,'1:00:00', 'Lavado a todo el vehiculo'),
('2023-07-30', 7,3,4, 100.000,'1:00:00', 'Recarga Aire Acondicionado del vehiculo'),
('2023-08-29', 1,4,3, 70.000,'1:00:00', 'Revision frenos del vehiculo'),
('2023-09-28', 2,5,5, 25.000,'1:00:00', 'Reparacion de parabrisas del vehiculo'),
('2023-10-27', 3,6,6, 30.000,'1:00:00', 'Lavado a todo el vehiculo'),
('2023-11-22', 4,2,2, 100.000,'1:00:00', 'Cambio Aceite para carro'),
('2023-12-24', 5,3,1, 50.000,'2:00:00', 'Mantenimento al vehiculo'),
('2024-01-26', 6,4,1, 50.000,'2:00:00', 'Mantenimento al vehiculo'),
('2024-02-15', 7,5,2, 100.000,'1:00:00', 'Cambio Aceite para carro'),
('2024-03-12', 1,6,3, 70.000,'1:00:00', 'Revision frenos del vehiculo'),
('2024-04-10', 1,4,4, 100.000,'1:00:00', 'Recarga Aire Acondicionado del vehiculo'),
('2024-05-08', 3,3,5, 25.000,'1:00:00', 'Reparacion de parabrisas del vehiculo'),
('2024-06-07', 2,6,6, 30.000,'1:00:00', 'Lavado a todo el vehiculo'),
('2024-06-06', 6,2,4, 100.000,'1:00:00', 'Recarga Aire Acondicionado del vehiculo'),
('2024-06-01', 4,5,3, 30.000,'1:00:00', 'Revision frenos del vehiculo'),
('2024-07-02', 7,3,6, 30.000,'1:00:00', 'Lavado a todo el vehiculo'),
('2024-08-04', 4,5,5, 25.000,'1:00:00', 'Reparacion de parabrisas del vehiculo'),
('2024-08-10', 5,4,2, 100.000,'1:00:00', 'Cambio Aceite para carro'),
('2024-08-11', 1,6,1, 50.000,'2:00:00', 'Mantenimento al vehiculo'),
('2024-09-12', 2,2,1, 50.000,'2:00:00', 'Mantenimento al vehiculo'),
('2024-10-18', 3,3,4, 100.000,'1:00:00', 'Recarga Aire Acondicionado del vehiculo'),
('2024-11-12', 6,4,5, 25.000,'1:00:00', 'Reparacion de parabrisas del vehiculo'),
('2024-11-25', 5,2,6, 30.000,'1:00:00', 'Lavado a todo el vehiculo'),
('2024-12-15', 5,3,2, 100.000,'1:00:00', 'Cambio Aceite para carro'),
('2024-12-25', 2,5,1, 50.000,'2:00:00', 'Mantenimento al vehiculo'),
('2024-12-15', 3,4,6, 70.000,'4:00:00', 'Lavado del vehiculo'),
('2024-01-15', 1,2,1, 50.000,'2:00:00', 'Mantenimento al vehiculo');

INSERT INTO telefono_contacto_proveedor(telefono, email)
VALUES ('3156438321', 'contactoproveedor1@gmail.com'),
('3156435243', 'contactoproveedor2@gmail.com'),
('3152543321', 'contactoproveedor3@gmail.com'),
('3112538321', 'contactoproveedor4@gmail.com');

INSERT INTO contacto_proveedor(nombre_contacto, apellido_contacto, telefono_id)
VALUES ('Camilo', 'Caceres', 1),
('Wilson', 'Melo', 2),
('Juan', 'Gomez', 3),
('Kevin', 'Ramirez', 4);

INSERT INTO telefono_proveedor(telefono, email)
VALUES ('364223453', 'proveedor1@gmail.com'),
('364223353', 'proveedo2@gmail.com'),
('364223453', 'proveedor3@gmail.com'),
('362312453', 'proveedo4@gmail.com');

INSERT INTO proveedor(nombre, contacto_id, telefono_proveedor_id)
VALUES ('Auto Parts', 1, 1),
('Reparaciones Carros', 2, 2),
('Cuidados carros', 3, 3),
('cars', 4, 4);

INSERT INTO pieza(nombre, descripcion, precio, proveedor_id)
VALUES ('Retrovisor', 'Retrovisores para carro', 25.000, 1),
('LLanta', 'LLanta para el carro', 150.000, 2),
('Bateria', 'Baterias para carro', 150.000, 3),
('Tornillos', 'Tornillos  para carro', 2.000, 4),
('Filtros Aire', 'Filtros Aire para carro', 20.000, 1),
('Bujias', 'Bujias para carro', 15.000, 2),
('Bombas Agua', 'Bombas Agua para carro', 25.000, 4),
('Radiadores', 'Radiadores para carro', 50.000, 3),
('Termostatos', 'Termostatos para carro', 15.000, 2),
('Mangueras Radiador', 'mangueras radiador para carro', 50.000, 1),
('Tuercas', 'Tuercas para el carro', 5.000, 2);

INSERT INTO inventario(pieza_id, cantidad, stock_minimo)
VALUES (1, 10, 5),
(2, 20, 10),
(3, 156, 25),
(4, 55, 5),
(5, 15, 7),
(6, 25, 5),
(7, 10, 25),
(8, 5, 50),
(9, 7, 20),
(10, 8, 5),
(11, 65, 25);

INSERT INTO facturacion(fecha, total, cliente_id)
VALUES ('2023-01-15', 150.000,1),
('2023-02-25', 120.000,2),
('2023-03-15', 130.000,3),
('2023-04-12', 140.000,4),
('2023-05-01', 150.000,5 ),
('2023-06-30', 110.000,1 ),
('2023-07-30', 50.000,2),
('2023-08-29', 60.000,3 ),
('2023-09-28', 70.000,4),
('2023-10-27', 80.000,5),
('2023-11-22', 50.000,1 ),
('2023-12-24', 90.000,2 ),
('2024-01-26', 150.000,3 ),
('2024-02-15', 110.000,4 ),
('2024-03-12', 125.000,5),
('2024-04-10', 130.000,1 ),
('2024-05-08', 160.000,2 ),
('2024-06-07', 145.000,3),
('2024-06-06', 120.000,4),
('2024-06-01', 150.000,5),
('2024-07-02', 250.000,1),
('2024-08-04', 170.000,2 ),
('2024-08-10', 120.000,3),
('2024-08-11', 110.000,4 ),
('2024-09-12', 50.000,5),
('2024-10-18', 60.000,1),
('2024-11-12', 70.000,2),
('2024-11-25', 75.000,4),
('2024-12-15', 85.000,3),
('2024-12-25', 150.000,5),
('2024-12-15', 120.000,1 );

INSERT INTO reparacion_pieza(reparacion_id, pieza_id, cantidad)
VALUES (1, 1, 5),
(2,2,10),
(3,3,1),
(4,4,1),
(5,5,2),
(6,6,1),
(7,7,1),
(8,8,7),
(9,9,4),
(10,10,1),
(11,11,1),
(12,1,2),
(13,2,1),
(14,3,5),
(15,4,12),
(16,5,10),
(17,6,8),
(18,7,7),
(19,8,12),
(20,9,5),
(21,10,8),
(22,11,6),
(23,1,2),
(24,2,1),
(25,3,5),
(26,4,4),
(27,5,3),
(28,6,5),
(29,7,2),
(30,8,15),
(31,9,25);

INSERT INTO orden_compra(fecha,proveedor_id,empleado_id,total)
VALUES ('2023-02-03',1,2,60.000),
('2023-06-05',2,3,70.000),
('2023-09-08',3,4,80.000),
('2024-03-15',4,5,90.000),
('2024-04-22',1,6,100.000),
('2024-05-30',2,2,25.000),
('2024-06-05',3,3,40.000),
('2024-06-05',4,2,50.000);

INSERT INTO orden_detalle(orden_id,pieza_id,cantidad,precio)
VALUES (1,1,3,20.000),
(2,2,18,20.000),
(3,3,15,20.000),
(4,4,8,20.000),
(5,6,6,20.000),
(6,5,2,20.000),
(7,4,10,20.000),
(8,7,5,20.000);

INSERT INTO factura_detalle(factura_id,reparacion_id, cantidad, precio)
VALUES (1,1,2,55.000),
(2,1,2,65.000),
(3,3,2,75.000),
(4,4,2,25.000),
(5,5,2,35.000),
(6,6,2,45.000),
(7,7,2,55.000),
(8,8,2,65.000),
(9,9,2,75.000),
(10,10,2,15.000),
(11,11,2,25.000),
(12,12,2,35.000),
(13,13,2,45.000),
(14,14,2,55.000),
(15,15,2,65.000),
(16,16,2,75.000),
(17,17,2,85.000),
(18,18,2,25.000),
(19,19,2,35.000),
(20,20,2,45.000),
(21,21,2,55.000),
(22,22,2,65.000),
(23,23,2,75.000),
(24,24,2,15.000),
(25,25,2,25.000),
(26,26,2,35.000),
(27,27,2,45.000),
(28,28,2,55.000),
(29,29,2,55.000),
(30,30,2,65.000),
(31,31,2,45.000);