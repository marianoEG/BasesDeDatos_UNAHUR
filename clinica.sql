CREATE DATABASE if NOT EXISTS Clinica;

USE Clinica;

CREATE TABLE if NOT EXISTS estado(
idEstado		INT(11)NOT NULL,
nombre		VARCHAR(50),
PRIMARY KEY(idEstado)
);

CREATE TABLE if NOT EXISTS municipio(
idMunicipio		INT(11)NOT NULL,
idEstado			INT(11)NOT NULL,
nombre		VARCHAR(50),
PRIMARY KEY(idMunicipio),
CONSTRAINT FK_idEstado FOREIGN KEY(idEstado) REFERENCES estado(idEstado)
);

CREATE TABLE if NOT EXISTS colonia(
idColonia	INT(11) NOT NULL,
idMunicipio   INT(11) NOT NULL,
nombre 		VARCHAR(50),
cp			 VARCHAR(10)NOT NULL,
PRIMARY KEY (idColonia,cp),
CONSTRAINT FK_idMunicipio 	FOREIGN KEY (idMunicipio) REFERENCES municipio(idMunicipio)
);

CREATE TABLE if NOT EXISTS domicilio(
idDomicilio INT(11)NOT NULL,
idColonia	INT(11)NOT NULL,
calle 		VARCHAR(30),
numExt		VARCHAR(10),
numInt		VARCHAR(10),
PRIMARY KEY(idDomicilio),
CONSTRAINT FK_idColonia FOREIGN KEY (idColonia) REFERENCES colonia(idColonia)
);

CREATE TABLE if NOT EXISTS hospital(
idHospital		INT(11) NOT NULL,
nombre 			VARCHAR(150),
idDomicilio 	INT(11)NOT null,
PRIMARY KEY(idHospital),
CONSTRAINT FK_idDomicilio FOREIGN KEY (idDomicilio) REFERENCES domicilio(idDomicilio)
);

CREATE TABLE if NOT EXISTS persona(
idPersona						INT(11) NOT NULL,
idDomicilio						INT(11) NOT NULL,
nombre							VARCHAR(40),
apellidoPaterno				VARCHAR(30),
apellidoMaterno				VARCHAR(30),
fechaNacimiento				DATE,
sexo								CHAR(1),
telefono							VARCHAR(15),
rfc								VARCHAR(13),
curp								VARCHAR(18),
login								VARCHAR(13),
pass								VARCHAR(25),
PRIMARY KEY(idPersona),
CONSTRAINT FK1_idDomicilio FOREIGN KEY (idDomicilio) REFERENCES domicilio(idDomicilio)
); 


CREATE TABLE if NOT EXISTS paciente(
idPaciente						INT(11) NOT NULL,
ocupacion						VARCHAR(100),
idPersona						INT(11) NOT NULL,
PRIMARY KEY(idPaciente),
CONSTRAINT FK_idPersona FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
);

CREATE TABLE if NOT EXISTS cita(
idCita		INT(11) NOT NULL,
idPaciente		INT(11) NOT NULL,
fecha		DATETIME,
comentarios 		VARCHAR(200),
PRIMARY KEY(idCita),
CONSTRAINT FK_idPaciente FOREIGN KEY (idPaciente) REFERENCES paciente(idPaciente)
);

CREATE TABLE if NOT EXISTS expediente(
idExpediente		INT(11)NOT NULL,
idPaciente			INT(11)NOT NULL,
fechaElaboracion 	DATETIME,
PRIMARY KEY(idExpediente),
CONSTRAINT FK1_idPaciente FOREIGN KEY (idPaciente) REFERENCES paciente(idPaciente)
);

CREATE TABLE if NOT EXISTS medico(
idMedico		INT(11) NOT NULL,
idPersona		INT(11) NOT NULL,
idHospital		INT(4) NOT NULL,
cedula			CHAR(15),
especialidad		VARCHAR(45),
PRIMARY KEY(idMedico),
CONSTRAINT FK1_idPersona FOREIGN KEY (idPersona) REFERENCES persona(idPersona),
CONSTRAINT FK_idHospital FOREIGN KEY (idHospital) REFERENCES hospital(idHospital)
); 

CREATE TABLE if NOT EXISTS notaMedica(
idNotaMedica		INT(11)NOT NULL,
idExpediente		INT(11)NOT NULL,
idMedico				INT(11)NOT NULL,
fecha					DATETIME,
diagnostico			TEXT,
PRIMARY KEY(idNotaMedica),
CONSTRAINT FK_idExpediente FOREIGN KEY (idExpediente) REFERENCES expediente(idExpediente),
CONSTRAINT FK_idMedico FOREIGN KEY (idMedico) REFERENCES medico(idMedico)
);

CREATE TABLE if NOT EXISTS enfermera(
idEnfermera		INT(11) NOT NULL,
idPersona		INT(11) NOT NULL,
idHospital		INT(11) NOT NULL,
cedula			CHAR(15),
PRIMARY KEY(idEnfermera),
CONSTRAINT FK2_idPersona FOREIGN KEY (idPersona) REFERENCES persona(idPersona),
CONSTRAINT FK1_idHospital FOREIGN KEY (idHospital) REFERENCES hospital(idHospital)
);

CREATE TABLE if NOT EXISTS medicamento(
idMedicamento		INT(11)NOT NULL,
nombre	VARCHAR(75),
activo	VARCHAR(75),
cantidad 	INT(11),
observaciones VARCHAR(200),
contraindicaciones	VARCHAR(200),
PRIMARY KEY (idMedicamento)
);

CREATE TABLE if NOT EXISTS receta(
idReceta	INT(11)NOT NULL,
idPaciente INT(11) NOT NULL,
idMedico	INT(11)NOT NULL,
fecha		DATETIME,
observaciones	VARCHAR(250),
PRIMARY KEY (idReceta),
CONSTRAINT FK3_idPaciente FOREIGN KEY (idPaciente) REFERENCES paciente(idPaciente),
CONSTRAINT fk3_idMedico	FOREIGN KEY (idMedico)	REFERENCES medico(idMedico)
);	

CREATE TABLE if NOT EXISTS receta_medicamento(
idReceta INT(11)NOT NULL,
idMedicamento	INT(11)NOT NULL,
dosis 	VARCHAR(250),
CONSTRAINT FK_idReceta FOREIGN KEY (idReceta) REFERENCES receta(idReceta),
CONSTRAINT FK_idMedicamento FOREIGN KEY (idMedicamento) REFERENCES medicamento(idMedicamento)
);


