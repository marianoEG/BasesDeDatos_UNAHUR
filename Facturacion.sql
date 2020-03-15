CREATE DATABASE IF NOT EXISTS Facturacion;

USE Facturacion;

CREATE TABLE IF NOT EXISTS cliente(
cod_cliente			INT(15)  	 NOT NULL,
nombre 				TEXT 			 NOT NULL,
apellido				TEXT 			 NOT NULL,
direccion			TEXT 			 NOT NULL,
dni					INT(15) 		 NOT NULL,
telefono 			INT(15) 		 NOT NULL,
fecha_nac			DATE 			 NOT NULL,
email					VARCHAR(100) NOT NULL,
cp						TEXT			 NOT NULL,	
PRIMARY KEY (cod_cliente)
);

CREATE TABLE IF NOT EXISTS vendedor(
cod_vendedor		 INT(15)		  NOT NULL,
nombre				 TEXT			  NOT NULL,
apellido				 TEXT 		  NOT NULL,
direccion			 TEXT			  NOT NULL,
cp						 TEXT			  NOT NULL,
fecha_contratacion DATE			  NOT NULL,
fecha_nac			 DATE			  NOT NULL,
mail					 VARCHAR(100) NOT NULL,
dni					 INT(15)		  NOT NULL,
ciudad				 TEXT			  NOT NULL,
localidad			 TEXT			  NOT NULL,
pais				    TEXT 		  NOT NULL,
PRIMARY KEY(cod_vendedor)
);

CREATE TABLE IF NOT EXISTS producto(
cod_producto		 INT(15)		  NOT NULL,
tipo				    VARCHAR(100) NOT NULL,
marca				    TEXT			  NOT NULL,
proveedor			 TEXT		     NOT NULL,
precio_unitario	 FLOAT 	     NOT NULL,
vencimiento		    DATE			  NOT NULL,
PRIMARY KEY(cod_producto)
);

CREATE TABLE IF NOT EXISTS factura(
cod_factura			 INT(15)		  NOT NULL,
cod_cliente		    INT(15)	     NOT NULL,
cod_vendedor		 INT(15)		  NOT NULL,
fecha_factura      DATE		     NOT NULL,
total					 FLOAT 		  NOT NULL,
PRIMARY KEY(cod_factura),
CONSTRAINT FK_cod_cliente FOREIGN KEY (cod_cliente) REFERENCES cliente(cod_cliente),
CONSTRAINT FK_cod_vendedor FOREIGN KEY (cod_vendedor) REFERENCES vendedor(cod_vendedor)
);

CREATE TABLE IF NOT EXISTS detalle_factura(
cod_factura			 INT(15)		  NOT NULL,
cod_producto	 	 INT(15)		  NOT NULL,
cantidad			    INT(15)	     NOT NULL,
CONSTRAINT FK_cod_factura FOREIGN KEY (cod_factura) REFERENCES factura(cod_factura),
CONSTRAINT FK_cod_producto FOREIGN KEY (cod_producto) REFERENCES producto(cod_producto)
);

CREATE TABLE IF NOT EXISTS medio_pago(
cod_mpago			 INT(15)		  NOT NULL,
cod_cliente			 INT(15)		  NOT NULL,
tipo		   	    TEXT			  NOT NULL,
numero				 TEXT 		  NOT NULL,
descripcion 	    TEXT 	     NOT NULL,
empresa 				 TEXT			  NOT NULL,
banco    	       TEXT    	  NOT NULL,
PRIMARY KEY(cod_mpago),
CONSTRAINT FK1_cod_cliente	FOREIGN KEY (cod_cliente) REFERENCES cliente(cod_cliente)
);			 


INSERT INTO cliente(cod_cliente,nombre,apellido,direccion,dni,telefono,fecha_nac,email,cp)
VALUES 
(4,'claudio','ferro','origone 158',54872156,0303456,'1992-04-12','claudio@hotmail.com','1688'),
(5,'tito','puente','mambo 23',25588796,128578,'1923-04-20','titopuente@gmail.com','4785'),
(1, 'Silvina', 'Lopez', 'pedro 3669', 2323123, 12345, '1991-05-04', 'silvina@hotmail.com', '1787'),
(2, 'Bautista', 'Benjamin', 'Santa1234', 546372, 23456, '2014-08-14', 'benja@gmail.com', '1234'),
(3, 'Sandra', 'roz', 'diaz 4536', 546372, 1234567, '1972-08-05', 'cata@gmail.com', '1686')
;

INSERT INTO vendedor(cod_vendedor,nombre,apellido,direccion,cp,fecha_contratacion,fecha_nac,mail,dni,ciudad,localidad,pais)
VALUES
(1,'fabian', 'suarez', 'sew213','1234','2079-07-04','1989-09-12','fabiol@gmail',654321,'hurlingham','hurlingham','argentina'),
(2,'adrian', 'merlo','ert546','1689','2018-07-04','1985-07-04','adrian@hotmail.com',234567,'buenos aires','moreno','argentina'),
(3,'fernando', 'profe','ytr','7654', '1977-07-23','1980-07-04','fer@gmail.com',123456,'buenos aires','caba','argentina')
;

INSERT INTO producto(cod_producto,tipo,marca,proveedor,precio_unitario,vencimiento)
VALUES 
(2, 'ropa', 'chiquis', 'roperito', 1500, '2019-07-04'),
(3, 'bicicleta', 'rodado', 'bicicleteria', 1000, '2019-09-12'),
(4, 'zapatillas', 'pies', 'calzados', 3000, '2019-08-08')
;

INSERT INTO factura(cod_factura,cod_cliente,cod_vendedor,fecha_factura,total)
VALUES
(10, 4, 3, '2018-02-28', 75000),
(11, 5, 1, '2019-03-11', 25000),
(7, 3, 3, '2018-01-09', 150000),
(8, 2, 2, '2019-02-04', 1000000),
(9, 1, 1, '2019-06-04', 1500000)
;

INSERT INTO detalle_factura(cod_factura,cod_producto,cantidad)
VALUES 
(10,2,50),
(11,3,25),
(7, 2, 100),
(8, 3, 1000),
(9, 4, 500)
;

INSERT INTO medio_pago(cod_mpago,cod_cliente,tipo,numero,descripcion,empresa,banco)
VALUES
(3, 4, 'efectivo','5','pago','none','none'),
(7, 5, 'efectivo','9','pago','none','none'),
(4, 2, 'credito', '2', 'pago', 'master card', 'provincia'),
(5, 3, 'debito', '4', 'asc', 'visa', 'santander'),
(6, 1, 'credito', '3', 'ert', 'american express', 'icbc')
;	

--1.- Listar todos los clientes donde el nombre comience con 'S'

SELECT cliente.nombre FROM cliente WHERE nombre LIKE 'S%'

--2.- Listar todos los clientes donde donde la direccion de mail sea del tipo @hotmail.com

SELECT * FROM cliente WHERE email LIKE '%@hotmail.com'

--3.- Listar todos los medios de pago

SELECT * FROM medio_pago

--4.- Listar la cantidad de productos

SELECT COUNT(*) AS NumProducto FROM producto

--5.- Listar la suma total de las ventas realizadas.

SELECT SUM(factura.total) AS TotalVentas FROM factura 

--6.- Listar la menor Venta

SELECT MIN(factura.total) AS MenorVenta FROM factura

--7.- Listar el promedio del costo total de ventas.

SELECT AVG(factura.total) AS PromedioVenta FROM factura

--Ejercicio Modelo Examen 2do Parcial

--Listar todas las ventas realizadas, con el siguiente formato de salida: 
/*
  +---------------+---+-----------+-----+--------------+----------------------+---------------+-------------+
  |CLIENTE NOMBRE |DNI|NRO FACTURA|TOTAL|PRODUCTO MARCA|PRODUCTO FECHA DE VENC|NOMBRE VENDEDOR|MEDIO DE PAGO|
  +---------------+---+-----------+-----+--------------+----------------------+---------------+-------------+
*/
SELECT cliente.nombre,cliente.dni,factura.cod_factura,factura.total,producto.marca,producto.vencimiento,vendedor.nombre,medio_pago.tipo FROM cliente,factura,producto,vendedor,medio_pago,detalle_factura
WHERE cliente.cod_cliente=medio_pago.cod_cliente AND cliente.cod_cliente=factura.cod_cliente AND factura.cod_vendedor=vendedor.cod_vendedor AND factura.cod_factura=detalle_factura.cod_factura
AND detalle_factura.cod_producto=producto.cod_producto

-- Listar la mayor venta realizada, para los medios de pago con tarjeta de crédito. (respetando el formato de salida del 2.1)

SELECT cliente.nombre,cliente.dni,factura.cod_factura,MAX(factura.total),producto.marca,producto.vencimiento,vendedor.nombre,medio_pago.tipo FROM cliente,factura,producto,vendedor,medio_pago,detalle_factura
WHERE cliente.cod_cliente=medio_pago.cod_cliente AND cliente.cod_cliente=factura.cod_cliente AND factura.cod_vendedor=vendedor.cod_vendedor AND factura.cod_factura=detalle_factura.cod_factura
AND detalle_factura.cod_producto=producto.cod_producto AND medio_pago.tipo = 'credito'

--  Listar las ventas realizadas en efectivo, aplicando un 50% de descuento al costo total (respetando el formato de salida del 2.1)

SELECT cliente.nombre,cliente.dni,factura.cod_factura,factura.total*0.5 AS totalConDesc,producto.marca,producto.vencimiento,vendedor.nombre,medio_pago.tipo FROM cliente,factura,producto,vendedor,medio_pago,detalle_factura
WHERE cliente.cod_cliente=medio_pago.cod_cliente AND cliente.cod_cliente=factura.cod_cliente AND factura.cod_vendedor=vendedor.cod_vendedor AND factura.cod_factura=detalle_factura.cod_factura
AND detalle_factura.cod_producto=producto.cod_producto AND medio_pago.tipo='efectivo'

--  Mostrar el número de productos cargados en la Tabla producto. 

SELECT COUNT(*) AS numProd FROM producto

-- Mostrar el Promedio de todas las ventas realizadas. 

SELECT AVG(factura.total) AS PromedioVenta FROM factura

-- Mostrar la suma de todas las ventas realizadas. 

SELECT SUM(factura.total) AS TotalVentas FROM factura 



SELECT factura.total,cliente.nombre FROM factura,cliente WHERE factura.cod_cliente = cliente.cod_cliente ORDER BY factura.total DESC

