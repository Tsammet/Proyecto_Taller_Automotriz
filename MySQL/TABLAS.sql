CREATE DATABASE tienda_autos;
USE tienda_autos;

CREATE TABLE pais(
	pais_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25) NOT NULL
);

CREATE TABLE region(
	region_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25) NOT NULL,
	pais_id INT,
	FOREIGN KEY(pais_id) REFERENCES pais(pais_id)
);

CREATE TABLE ciudad(
	ciudad_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25) NOT NULL,
	region_id INT NOT NULL,
	FOREIGN KEY(region_id) REFERENCES region(region_id)
);

CREATE TABLE telefono_cliente(
	telefono_cliente_id INT PRIMARY KEY AUTO_INCREMENT,
	telefono VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL
);

CREATE TABLE cliente(
	cliente_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25) NOT NULL,
	apellido VARCHAR(25) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	ciudad_id INT NOT NULL,
	telefono_cliente_id INT NOT NULL,
	FOREIGN KEY(ciudad_id) REFERENCES ciudad(ciudad_id),
	FOREIGN KEY(telefono_cliente_id) REFERENCES telefono_cliente(telefono_cliente_id)
);

CREATE TABLE color(
	color_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25) NOT NULL
);

CREATE TABLE marca(
	marca_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25)
);

CREATE TABLE modelo(
	modelo_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25),
	marca_id INT NOT NULL,
	FOREIGN KEY(marca_id) REFERENCES marca(marca_id)
);


CREATE TABLE vehiculo(
	vehiculo_id INT PRIMARY KEY AUTO_INCREMENT,
	placa VARCHAR(7),
	año DATE,
	modelo_id INT NOT NULL,
	cliente_id INT NOT NULL,
	color_id INT NOT NULL,
	kilometraje INT NOT NULL,
	FOREIGN KEY(modelo_id) REFERENCES modelo(modelo_id),
	FOREIGN KEY(cliente_id) REFERENCES cliente(cliente_id),
	FOREIGN KEY(color_id) REFERENCES color(color_id)
);

CREATE TABLE facturacion(
	factura_id INT PRIMARY KEY AUTO_INCREMENT,
	fecha DATE NOT NULL,
	total double(10,3) NOT NULL,
	cliente_id INT NOT NULL,
	FOREIGN KEY(cliente_id) REFERENCES cliente(cliente_id)
);

CREATE TABLE servicio(
	servicio_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25) NOT NULL,
	descripcion VARCHAR(100) NOT NULL,
	costo DOUBLE(10,3)
);

CREATE TABLE cita(
	cita_id INT PRIMARY KEY AUTO_INCREMENT,
	fecha_hora DATETIME,
	cliente_id INT NOT NULL,
	vehiculo_id INT NOT NULL,
	servicio_id INT NOT NULL,
	FOREIGN KEY(cliente_id) REFERENCES cliente(cliente_id),
	FOREIGN KEY(vehiculo_id) REFERENCES vehiculo(vehiculo_id),
	FOREIGN KEY(servicio_id) REFERENCES servicio(servicio_id)
);

CREATE TABLE cargo_empleado(
	cargo_empleado_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre_cargo VARCHAR(25)
);

CREATE TABLE telefono_empleado(
	telefono_empleado_id INT PRIMARY KEY AUTO_INCREMENT,
	telefono VARCHAR(20),
	email VARCHAR(50)
);

CREATE TABLE empleado(
	empleado_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25) NOT NULL,
	apellido VARCHAR(25) NOT NULL,
	cargo_id INT NOT NULL,
	telefono_empleado_id INT NOT NULL,
	FOREIGN KEY(cargo_id) REFERENCES cargo_empleado(cargo_empleado_id),
	FOREIGN KEY(telefono_empleado_id) REFERENCES telefono_empleado(telefono_empleado_id)
);

CREATE TABLE reparaciones(
	reparacion_id INT PRIMARY KEY AUTO_INCREMENT,
	fecha DATE,
	vehiculo_id INT NOT NULL,
	empleado_id INT NOT NULL,
	servicio_id INT NOT NULL,
	costo_total DOUBLE(10,3),
	duracion TIME,
	descripcion VARCHAR(50),
	FOREIGN KEY(vehiculo_id) REFERENCES vehiculo(vehiculo_id),
	FOREIGN KEY(empleado_id) REFERENCES empleado(empleado_id),
	FOREIGN KEY(servicio_id) REFERENCES servicio(servicio_id)
);

CREATE TABLE factura_detalle(
	factura_id INT NOT NULL,
	reparacion_id INT NOT NULL,
	cantidad INT NOT NULL,
	precio DOUBLE(10,3),
	PRIMARY KEY(factura_id, reparacion_id),
	FOREIGN KEY(factura_id) REFERENCES facturacion(factura_id),
	FOREIGN KEY(reparacion_id) REFERENCES reparaciones(reparacion_id)
);

CREATE TABLE telefono_contacto_proveedor(
	telefono_contacto_proveedor_id INT PRIMARY KEY AUTO_INCREMENT,
	telefono VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL
);

CREATE TABLE contacto_proveedor(
	contacto_proveedor_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre_contacto VARCHAR(25),
	apellido_contacto VARCHAR(25),
	telefono_id INT NOT NULL,
	FOREIGN KEY(telefono_id) REFERENCES telefono_contacto_proveedor(telefono_contacto_proveedor_id)
);

CREATE TABLE telefono_proveedor(
	telefono_proveedor_id INT PRIMARY KEY AUTO_INCREMENT,
	telefono VARCHAR(20),
	email VARCHAR(50)
);

CREATE TABLE proveedor(
	proveedor_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25),
	contacto_id INT NOT NULL,
	telefono_proveedor_id INT,
	FOREIGN KEY(contacto_id) REFERENCES contacto_proveedor(contacto_proveedor_id),
	FOREIGN KEY(telefono_proveedor_id) REFERENCES telefono_proveedor(telefono_proveedor_id)
);


CREATE TABLE pieza(
	pieza_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25),
	descripcion VARCHAR(100),
	precio DOUBLE(10,3),
	proveedor_id INT NOT NULL,
	FOREIGN KEY(proveedor_id) REFERENCES proveedor(proveedor_id)
);

CREATE TABLE orden_compra(
	orden_id INT PRIMARY KEY AUTO_INCREMENT,
	fecha DATE,
	proveedor_id INT NOT NULL,
	empleado_id INT NOT NULL,
	total DOUBLE(10,3),
	FOREIGN KEY(proveedor_id) REFERENCES proveedor(proveedor_id),
	FOREIGN KEY(empleado_id) REFERENCES empleado(empleado_id)
);

CREATE TABLE orden_detalle(
	orden_id INT,
	pieza_id INT,
	cantidad INT NOT NULL,
	precio DOUBLE(10,3),
	PRIMARY KEY(orden_id, pieza_id),
	FOREIGN KEY(orden_id) REFERENCES orden_compra(orden_id),
	FOREIGN KEY(pieza_id) REFERENCES pieza(pieza_id)
);

CREATE TABLE inventario(
	inventario_id INT PRIMARY KEY AUTO_INCREMENT,
	pieza_id INT NOT NULL,
	cantidad INT NOT NULL,
	stock_minimo INT NOT NULL,
	stock_inicial INT NOT NULL
);

CREATE TABLE reparacion_pieza(
	reparacion_id INT,
	pieza_id INT,
	cantidad INT,
	PRIMARY KEY(reparacion_id, pieza_id),
	FOREIGN KEY(reparacion_id) REFERENCES reparaciones(reparacion_id),
	FOREIGN KEY(pieza_id) REFERENCES pieza(pieza_id)	
);




