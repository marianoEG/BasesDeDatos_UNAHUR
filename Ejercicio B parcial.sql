CREATE DATABASE EjercicioB;

USE EjercicioB;

CREATE TABLE empleados(
codEmpleado	INT(11),
ciudad		VARCHAR(20),
cargo			VARCHAR(20),
fechanacimiento DATE,
cp				VARCHAR(10)
);

INSERT INTO empleados(codEmpleado,ciudad,cargo,fechanacimiento,cp)
VALUES
(1,'salta','cobrador','1940-02-02','abc'),
(2,'corrientes','cobrador','1940-02-02','abc'),
(3,'tucuman','jefe','1950-02-02','abc'),
(4,'buenos aires','cobrador','1957-02-02','abc'),
(5,'chaco','cobrador','1940-02-02','abc'),
(6,'chaco','cobrador','1940-02-02','abc'),
(7,'cordoba','cobrador','1981-02-02','abc'),
(8,'chubut','cobrador','1940-02-02','abc'),
(9,'salta','jefe','1957-02-02','abc');

UPDATE empleados
SET cp = 'AA15236'
WHERE ciudad='salta' AND (cargo LIKE 'J%') AND (fechaNacimiento BETWEEN '1956-1-1' AND '1982-1-1') 

SELECT * FROM empleados