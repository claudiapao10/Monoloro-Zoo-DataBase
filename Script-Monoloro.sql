SET ECHO ON
SET LINESIZE 150; 
   
--------------- BORRANDO TABLAS ASOCIATIVAS O TRINARIAS  ---------------
show user
SELECT systimestamp FROM dual

DROP TABLE evento CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual

DROP TABLE animal_alimento CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual

DROP TABLE agenda_empleado CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual

DROP TABLE agenda_animal CASCADE CONSTRAINTS;
	
--------------- BORRANDO TABLAS CON FK---------------
show user
SELECT systimestamp FROM dual

DROP TABLE animal CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual

DROP TABLE cueva CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual

DROP TABLE agenda CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual

DROP TABLE empleado CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual

DROP TABLE departamento CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;	
--------------- BORRANDO TABLAS SIN FK---------------
show user
SELECT systimestamp FROM dual

DROP TABLE actividad CASCADE CONSTRAINTS; 

show user
SELECT systimestamp FROM dual

DROP TABLE plan_medico CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual

DROP TABLE contrato CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual

DROP TABLE sucursal CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual

DROP TABLE calendario CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual

DROP TABLE alimento CASCADE CONSTRAINTS;

REM **************************************************************
REM * Author : Claudia P. Monge Torres                           *
REM * Num.Est: 841-18-9451                                       *
REM * Curso : SICI-4030 KH1                                      *
REM * Creado : 21 de noviembre de 2020                           *
REM * Source : Proyecto#4: Monoloro                              *
REM * Desc. : Este script ejecuta todas las tareas solicitadas   *
REM * del proyecto#4 Monoloro                                    *
REM **************************************************************
REM *** Comandos de consola solicitados como parte del proyecto***
REM **************************************************************  

------------------------------------------		   
-- CREANDO LAS TABLAS   
------------------------------------------ 

--------------- TABLAS SIN FK ---------------
show user
SELECT systimestamp FROM dual;

--Creando la tabla de alimento
CREATE TABLE alimento
(idAlimento                   NUMBER(3),
 nombre                       CHAR(30)            NOT NULL         UNIQUE,
 descripcion                  VARCHAR2(75)        NOT NULL,
 unidad                       CHAR(6)             NOT NULL,
 cantidad                     NUMBER(3)           NOT NULL,
    CONSTRAINT alimento_idAlimento_pk PRIMARY KEY(idAlimento));
	  
show user
SELECT systimestamp FROM dual;

--Creando la tabla de calendario
CREATE TABLE calendario
(idCalendario                 NUMBER(3),
 dia                          VARCHAR2(30)        NOT NULL,
 descripcion                  VARCHAR2(30)        NOT NULL,
    CONSTRAINT calendario_idCalendario_pk PRIMARY KEY(idCalendario));

show user
SELECT systimestamp FROM dual;

--Creando la tabla de sucursal
CREATE TABLE sucursal
(codigoSucursal               NUMBER(6),
 nombre                       VARCHAR2(100)        NOT NULL        UNIQUE,
 linea_uno                    CHAR(30)             NOT NULL,
 pueblo                       CHAR(10)             NOT NULL,
 pais                         CHAR(2)              NOT NULL,
 codigo_postal                NUMBER(5)            NOT NULL,
 telefono                     VARCHAR2(12)         NOT NULL        UNIQUE,
    CONSTRAINT sucursal_codigoSucursal_pk PRIMARY KEY(codigoSucursal));
	
show user
SELECT systimestamp FROM dual;

--Creando la tabla de contrato
CREATE TABLE contrato
(idContrato                   NUMBER(6),
 descripcion                  VARCHAR2(80)         NOT NULL,
    CONSTRAINT contrato_idContrato_pk PRIMARY KEY(idContrato));
	
show user
SELECT systimestamp FROM dual;

--Creando la tabla de plan_medico
CREATE TABLE plan_medico
(idPlan                      NUMBER(4),
 nombre                      CHAR(30)             NOT NULL         UNIQUE,
 telefono                    VARCHAR2(12)         NOT NULL         UNIQUE,
    CONSTRAINT  plan_medico_idPlan_pk PRIMARY KEY(idPlan));
	
show user
SELECT systimestamp FROM dual;

--Creando la tabla de actividad
CREATE TABLE actividad
(idActividad                NUMBER(5),
 nombre                     CHAR(45)            NOT NULL          UNIQUE,
 duracion                   VARCHAR2(20)        NOT NULL,
    CONSTRAINT actividad_idActividad_pk PRIMARY KEY(idActividad));
 
--------------- TABLAS CON FK ---------------

show user
SELECT systimestamp FROM dual;

--Creando la tabla de departamento
CREATE TABLE departamento
(idDepartamento           NUMBER(5),
 nombre                   CHAR(30)              NOT NULL          UNIQUE,
 localizacion             VARCHAR2(50)          NOT NULL,
 codigoSucursal           NUMBER(6)             NOT NULL,
    CONSTRAINT departamento_idDepartamento_pk PRIMARY KEY(idDepartamento),
	CONSTRAINT departamento_codigoSucursal_fk FOREIGN KEY(codigoSucursal)
	      REFERENCES sucursal(codigoSucursal));

show user
SELECT systimestamp FROM dual;

--Creando la tabla de empleado
CREATE TABLE empleado
(numeroEmp               NUMBER(6),
 primer_nombre           CHAR(15)               NOT NULL,
 segundo_nombre          CHAR(15),
 apellido_paterno        CHAR(20)               NOT NULL,
 apellido_materno        CHAR(20),
 tipo                    CHAR(1)                NOT NULL,
 telefono                VARCHAR2(12)                           UNIQUE, 
 correo_electronico      VARCHAR2(64)           NOT NULL        UNIQUE,
 horas_trabajadas        NUMBER(2),
 pago_por_hora           NUMBER(4,2),
 salario_mensual         NUMBER(6,2),
 estatus                 CHAR(10),
 licencia                NUMBER(10),
 asociacion              CHAR(25),
 cobro                   NUMBER(5,2),
 idContrato              NUMBER(6),
 idPlan                  NUMBER(4),
 codigoSucursal          NUMBER(6)              NOT NULL,
 idDepartamento          NUMBER(5)              NOT NULL,
    CONSTRAINT empleado_numeroEmp_pk PRIMARY KEY(numeroEmp),
	CONSTRAINT empleado_idContrato_fk FOREIGN KEY(idContrato)
	      REFERENCES contrato(idContrato),
    CONSTRAINT empleado_idPlan_fk FOREIGN KEY(idPlan)
		  REFERENCES plan_medico(idPlan),
    CONSTRAINT empleado_codigoSucursal_fk FOREIGN KEY(codigoSucursal)
		  REFERENCES sucursal(codigoSucursal),
    CONSTRAINT departamento_idDepartamento_fk FOREIGN KEY(idDepartamento)
		  REFERENCES departamento(idDepartamento),
    CONSTRAINT empleado_tipo_ck
		      CHECK(tipo IN('P', 'A','G', 'M')));

show user
SELECT systimestamp FROM dual;

--Creando la tabla de agenda
CREATE TABLE agenda
(idAgenda		         NUMBER(6),
 narrativa               VARCHAR2(80)           NOT NULL,
 idActividad             NUMBER(5)              NOT NULL,
    CONSTRAINT agenda_idAgenda_pk PRIMARY KEY(idAgenda),
	CONSTRAINT agenda_idActividad_fk FOREIGN KEY(idActividad)
	      REFERENCES actividad(idActividad));
		  
show user
SELECT systimestamp FROM dual;

--Creando la tabla de cueva
CREATE TABLE cueva
(idCueva                NUMBER(3),
 codigoSucursal         NUMBER(6)                NOT NULL,
    CONSTRAINT cueva_idCueva_pk PRIMARY KEY(idCueva),
	CONSTRAINT cueva_codigoSucursal_fk FOREIGN KEY(codigoSucursal)
	    REFERENCES sucursal(codigoSucursal));
		
--Creando la tabla de animal
CREATE TABLE animal
(numAnimal               NUMBER(6),
 nombre                  CHAR(10)                NOT NULL              UNIQUE,
 especie                 CHAR(15)                NOT NULL,
 estatura                NUMBER(5,2)             NOT NULL,
 peso                    NUMBER(3)               NOT NULL,
 idCueva                 NUMBER(3)               NOT NULL,
    CONSTRAINT animal_numAnimal_pk PRIMARY KEY(numAnimal),
    CONSTRAINT animal_idCueva_fk FOREIGN KEY(idCueva)
	     REFERENCES cueva(idCueva));
		 
--------------- TABLAS ASOCIATIVAS ---------------

show user
SELECT systimestamp FROM dual;

--Creando la tabla de agenda_animal
CREATE TABLE agenda_animal
(idAgenda              NUMBER(6)                  NOT NULL,
 numAnimal             NUMBER(6)                  NOT NULL,
    CONSTRAINT agenda_animal_pk PRIMARY KEY(idAgenda,numAnimal),
    CONSTRAINT agenda_animal_idAgenda_fk FOREIGN KEY(idAgenda)
	     REFERENCES agenda(idAgenda),
	CONSTRAINT agenda_animal_numAnimal_fk FOREIGN KEY(numAnimal)
	     REFERENCES animal(numAnimal));
		 
show user
SELECT systimestamp FROM dual;

--Creando la tabla de agenda_empleado
CREATE TABLE agenda_empleado
(idAgenda              NUMBER(6)                  NOT NULL,
 numeroEmp             NUMBER(6)                  NOT NULL,
    CONSTRAINT agenda_empleado_pk PRIMARY KEY(idAgenda,numeroEmp),
    CONSTRAINT agenda_empleado_idAgenda_fk FOREIGN KEY(idAgenda)
	     REFERENCES agenda(idAgenda),
	CONSTRAINT agenda_empleado_numeroEmp_fk FOREIGN KEY(numeroEmp)
	     REFERENCES empleado(numeroEmp));
		 
show user
SELECT systimestamp FROM dual;

--Creando la tabla de animal_alimento
CREATE TABLE animal_alimento
(numAnimal          NUMBER(6)                     NOT NULL,
 idAlimento         NUMBER(3)                     NOT NULL,
    CONSTRAINT animal_alimento_pk PRIMARY KEY(numAnimal, idAlimento),
    CONSTRAINT animal_alimento_numAnimal_fk FOREIGN KEY(numAnimal)
	     REFERENCES animal(numAnimal),
	CONSTRAINT animal_alimento_idAlimento_fk FOREIGN KEY(idAlimento)
	     REFERENCES alimento(idAlimento));
		 
show user
SELECT systimestamp FROM dual;

--Creando la tabla de evento
CREATE TABLE evento
(idActividad        NUMBER(5)                     NOT NULL,
 idCalendario       NUMBER(3)                     NOT NULL,
 codigoSucursal     NUMBER(6)                     NOT NULL,
    CONSTRAINT evento_pk PRIMARY KEY(idActividad,idCalendario,codigoSucursal),
	CONSTRAINT evento_idActividad_fk FOREIGN KEY(idActividad)
	     REFERENCES actividad(idActividad),
	CONSTRAINT evento_idCalendario_fk FOREIGN KEY(idCalendario)
	     REFERENCES calendario(idCalendario),
	CONSTRAINT evento_codigoSucursal_fk FOREIGN KEY(codigoSucursal)
	     REFERENCES sucursal(codigoSucursal));

------------------------------------------		   
-- INSERTANDO VALORES EN  LAS TABLAS   
------------------------------------------		 

show user
SELECT systimestamp FROM dual;
-- Insertando valores a alimento
INSERT INTO alimento
VALUES(500,'Frutas','Ideal para primates pequenos.','onzas',24);
INSERT INTO alimento
VALUES(501,'Semillas','Exclusivamente para aves.','onzas',25);
INSERT INTO alimento
VALUES(502,'Vegetales','Para primates omnivoros grandes.','onzas',56);
INSERT INTO alimento
VALUES(503,'Concentrado','Alimento concentrado.','libras',245);
INSERT INTO alimento
VALUES(504,'Carne','Carne roja para maminferos.','libras',567);
INSERT INTO alimento
VALUES(505,'Huevo cocido','Alimento en caso de enfermedad.','gramos',34);
INSERT INTO alimento
VALUES(506,'Raices','Para aves.','gramos',20);
INSERT INTO alimento
VALUES(507,'Granos','Para aves.','gramos',11);
INSERT INTO alimento
VALUES(508,'Presa entera','Presa viva para maminferos.','libras',346);
INSERT INTO alimento
VALUES(509,'Insectos','Para reptiles.','onzas',10);
INSERT INTO alimento
VALUES(510,'Lombrices','Para aves o reptiles.','onzas',24);
INSERT INTO alimento
VALUES(511,'Vegetales amarillos y verdes','Exclusivamente para primates omnivoros.','onzas',56);
INSERT INTO alimento
VALUES(512,'Proteina','Anadido en el alimento.','libras',75);
INSERT INTO alimento
VALUES(513,'Cereal','Para animal domestico.','gramos',268);
INSERT INTO alimento
VALUES(514,'Hortalizas','Para aves.','gramos',235);
INSERT INTO alimento
VALUES(515,'Pescado','Para maminferos.','libras',154);
INSERT INTO alimento
VALUES(516,'Suplementos','Anadido en el alimento.','libras',45);
INSERT INTO alimento
VALUES(517,'Galletas','Merienda o recompenza.','onzas',37);
INSERT INTO alimento
VALUES(518,'tuberculos','Para aves.','gramos',26);
INSERT INTO alimento
VALUES(519,'Hormigas','Para reptiles.','gramos',38);

show user
SELECT systimestamp FROM dual;
-- Insertando valores a calendario
INSERT INTO calendario
VALUES(212,'Jueves 24 diciembre','Fiesta de Navidad');
INSERT INTO calendario
VALUES(213,'Martes 19 de enero','Visita escolar.');
INSERT INTO calendario
VALUES(214,'Miercoles 20 de enero','Cumpleanos.');
INSERT INTO calendario
VALUES(215,'21 de enero','Conferencia veterinaria.');
INSERT INTO calendario
VALUES(216,'Jueves 22 de enero','Conferencia estudiantil.');
INSERT INTO calendario
VALUES(217,'Domingo 25 de enero','Visita escolar.');
INSERT INTO calendario
VALUES(218,'Lunes 26 de enero','Cumpleanos.');
INSERT INTO calendario
VALUES(219,' Martes 1 de febrero','Cumpleanos.');
INSERT INTO calendario
VALUES(220,'Miercoles 13 de febrero','Charla a estudiantes.');
INSERT INTO calendario
VALUES(221,'Viernes 23 de febrero','Visita escolar.');
INSERT INTO calendario
VALUES(222,'Sabado 24 de febrero','Agronomia para ninos.');
INSERT INTO calendario
VALUES(223,'Martes 27 de febrero','Cumpleanos.');
INSERT INTO calendario
VALUES(224,'Jueves 1 de marzo','Dia del nino');
INSERT INTO calendario
VALUES(225,'Viernes 2 de marzo','Dia del elefante.');
INSERT INTO calendario 
VALUES(226,'Sabado 3 de marzo','Visita escolar.');
INSERT INTO calendario
VALUES(227,'Lunes 5 de marzo','Cumpleanos animal.');
INSERT INTO calendario
VALUES(228,'Sabado 10 de marzo','Charla a estudiantes.');
INSERT INTO calendario
VALUES(229,'Jueves 15 de marzo','Visita escolar.');
INSERT INTO calendario
VALUES(230,'Viernes 16 de marzo','Cumpleanos animal.');
INSERT INTO calendario
VALUES(231,'Jueves 4 de abril','Visita escolar.');

show user
SELECT systimestamp FROM dual;
-- Insertando valores a sucursal
INSERT INTO sucursal
VALUES(300100,'Centro Rodriguez-Diaz','Calle Ashford','San Juan','PR',00901,'898-639-0979');
INSERT INTO sucursal
VALUES(300101,'Parque Rivera','Avenida Lima','Lajas','PR',00667,'472-604-8802');
INSERT INTO sucursal
VALUES(300102,'Edificio Jose de Diego ','Calle De Diego','Yabucoa','PR',00767,'793-877-0034');
INSERT INTO sucursal
VALUES(300103,'Centro Paquito Morales','Calle Pomarosa ','San Juan','PR',00901,'284-542-1452');
INSERT INTO sucursal
VALUES(300104,'Parque Emilio Huyke','Avenida Justicia','Yabucoa','PR',00767,'865-326-1463');
INSERT INTO sucursal
VALUES(300105,'Zoologico de Humacao','Calle Rosa','San Juan','PR',00901,'344-183-6691');
INSERT INTO sucursal
VALUES(300106,'Edificio Anita Otero ','Calle Lopez ','San Juan','PR',00901,'733-588-1279');
INSERT INTO sucursal
VALUES(300107,'Parque Ramon Powell ','Calle flamboyan ','Humacao','PR',00791,'520-448-0603');
INSERT INTO sucursal
VALUES(300108,'J.C Center Park','Calle Laurel ','Guaynabo','PR',00921,'789-804-5304');
INSERT INTO sucursal
VALUES(300109,'Ana Roque Building','Calle Rosario','San Juan','PR',00901,'357-766-9749');
INSERT INTO sucursal
VALUES(300110,'Parque Rodriguez-Torres','Calle Libertad','Guaynabo','PR',00921,'223-740-9051');
INSERT INTO sucursal
VALUES(300111,'Edificio Linea Azul 2','Avenida Los Montes','Bayamon','PR',00782,'979-846-3258');
INSERT INTO sucursal
VALUES(300112,'Parque Ana Roque','Calle Font Martelo','San Juan','PR',00901,'306-413-2968');
INSERT INTO sucursal
VALUES(300113,'Parque La Felicidad','Calle Victoria','Bayamon','PR',00782,'323-895-3321');
INSERT INTO sucursal
VALUES(300114,'Centro Mojica','Avenida Pomales','Luquillo','PR',00738,'247-834-1350');
INSERT INTO sucursal
VALUES(300115,'Parque Rodriguez Garcia','Calle ocho','Dorado','PR',00646,'791-472-1778');
INSERT INTO sucursal
VALUES(300116,'Ohal Building','Avenida Milagros','San Juan','PR',00901,'754-696-5110');
INSERT INTO sucursal
VALUES(300117,'Parque Ramos Ortega','Calle Azul','Humacao','PR',00791,'968-722-5684');
INSERT INTO sucursal
VALUES(300118,'Centro A','Calle Gallo','Caguas','PR',00725,'152-972-2696');
INSERT INTO sucursal
VALUES(300119,'Parque Zayas B','Avenida Antigua','Humacao','PR',00791,'272-748-9962');

show user
SELECT systimestamp FROM dual;
--Insertando valores a contrato
INSERT INTO contrato
VALUES(123456,'Contrato indefinido, paga de 14.50 la hora. Hacer 20 horas semanales.');
INSERT INTO contrato
VALUES(123457,'Trabajo a tiempo completo,  8 horas por dia. Paga de 15.00 la hora');
INSERT INTO contrato
VALUES(123458,'Contrato eventual, paga de 14.00 la hora .');
INSERT INTO contrato
VALUES(123459,'Contrato de interinidad, paga de 13.55 la hora.');
INSERT INTO contrato
VALUES(123460,'Contrato de relevo, paga de 13.00 la hora.');
INSERT INTO contrato
VALUES(123461,'Trabajo a tiempo parcial. Hacer 20 horas semanales, paga de 13.50 la hora.');
INSERT INTO contrato
VALUES(123462,'Contrato de 12 meses. Paga de 5,500.00 mensuales.');
INSERT INTO contrato
VALUES(123463,'Contrato de 24 meses. Paga de 6,00.00 mensuales.');
INSERT INTO contrato
VALUES(123464,'Contrato de 6 meses. Paga de 4,000.00 mensuales.');
INSERT INTO contrato
VALUES(123465,'Contrato de internado por 2 meses. Paga de 10.00 la hora.');
INSERT INTO contrato
VALUES(123466,'Contrato de internado por 4 meses. Paga de 12.00 la hora.');
INSERT INTO contrato
VALUES(123467,'Contrato de internado por 6 meses. Paga de 12.00 la hora.');
INSERT INTO contrato
VALUES(123468,'Posicion de entrada. Pago de 14.00 la hora.');
INSERT INTO contrato
VALUES(123469,'Posicion de entada para candidato con experiencia. 20.00 la hora.');
INSERT INTO contrato
VALUES(123470,'Posicion de entrada. Pago de 10.00 la hora.');
INSERT INTO contrato
VALUES(123471,'Contrato de relevo, paga 11.00 la hora.');
INSERT INTO contrato
VALUES(123472,'Contrato indefinido. Pago de 10.00 la hora.');
INSERT INTO contrato
VALUES(123473,'Posicion intermedia. Pago de 16.00 la hora.');
INSERT INTO contrato
VALUES(123474,'Posicion intermedia. Pago de 13.00 la hora.');
INSERT INTO contrato
VALUES(123475,'Tiempo completo, paga de 13.00 la hora.');

show user
SELECT systimestamp FROM dual;
--Insertando valores a plan medico

INSERT INTO plan_medico
VALUES(1001,'Plan de Salud Menonita','939-720-1580');
INSERT INTO plan_medico
VALUES(1002,'Triple S Salud','939-720-1130');
INSERT INTO plan_medico
VALUES(1003,'First Medical Plan','787-981-1111');
INSERT INTO plan_medico
VALUES(1004,'MCS Life Insurance','939-252-0051');
INSERT INTO plan_medico
VALUES(1005,'Humana Insurance','939-300-1120');
INSERT INTO plan_medico
VALUES(1006,'MAPFRE Life Insurance','787-285-3348');
INSERT INTO plan_medico
VALUES(1007,'Ryder Health Plan','787-852-3302');
INSERT INTO plan_medico
VALUES(1008,'Pan American Life Insurance','787-479-4514');
INSERT INTO plan_medico
VALUES(1009,'MMM Healthcare','787-843-1485');
INSERT INTO plan_medico
VALUES(1010,'Molina Healthcare','939-130-1120');
INSERT INTO plan_medico
VALUES(1011,'PMC Medicare Choice','939-998-3020');
INSERT INTO plan_medico
VALUES(1012,'Auxilio Platino','787-254-1415');
INSERT INTO plan_medico
VALUES(1013,'Buena Vista','939-787-2504');
INSERT INTO plan_medico
VALUES(1014,'Cigna Healthcare','787-479-0013');
INSERT INTO plan_medico
VALUES(1015,'COSVI','787-638-1514');
INSERT INTO plan_medico
VALUES(1016,'Cruz Azul','787-643-1485');
INSERT INTO plan_medico
VALUES(1017,'Global Health Plan','787-430-1680');
INSERT INTO plan_medico
VALUES(1018,'Medicare Optimo','787-981-2053');
INSERT INTO plan_medico
VALUES(1019,'Natural Health','787-479-2041');
INSERT INTO plan_medico
VALUES(1020,'PALIC Health Insurance','787-999-9999');

show user
SELECT systimestamp FROM dual;
--Insertando valores a actividad

INSERT INTO actividad
VALUES(45041,'Fiesta de Navidad','10 horas');
INSERT INTO actividad
VALUES(45042,'10 dias con la tierra','10 dias de 8 horas');
INSERT INTO actividad
VALUES(45043,'Cumpleanos','4 horas.');
INSERT INTO actividad
VALUES(45044,'Charla a estudiantes','1 hora.');
INSERT INTO actividad
VALUES(45045,'Conferencia veterinaria','5 horas.');
INSERT INTO actividad
VALUES(45046,'Apreciacion animal','8 horas.');
INSERT INTO actividad
VALUES(45047,'Dia del Elefante','8 horas.');
INSERT INTO actividad
VALUES(45048,'Conferencia de agronomia','6 horas.');
INSERT INTO actividad
VALUES(45049,'Visita escolar','3 horas.');
INSERT INTO actividad
VALUES(45050,'Dia de Reyes','7 horas.');
INSERT INTO actividad
VALUES(45051,'San Valentin con animales','4 horas.');
INSERT INTO actividad
VALUES(45052,'Dia del Nino','7 horas.');
INSERT INTO actividad
VALUES(45053,'Dia del Planeta Tierra','8 horas.');
INSERT INTO actividad
VALUES(45054,'Conservacion de la naturaleza','8 horas.');
INSERT INTO actividad
VALUES(45055,'Dia del Leon','8 horas.');
INSERT INTO actividad
VALUES(45056,'Cumpleanos de animal','3 horas.');
INSERT INTO actividad
VALUES(45057,'Agronomia para ninos','2 horas.');
INSERT INTO actividad
VALUES(45058,'Agronomia para adultos','3 horas.');
INSERT INTO actividad
VALUES(45059,'Charla educativa','2 horas.');
INSERT INTO actividad
VALUES(45060,'Charla veterinaria','5 horas.');

show user
SELECT systimestamp FROM dual;
--Insertando valores a departamento

INSERT INTO departamento
VALUES(50555,'Finanzas','Cerca de la fuente azul.',300110);
INSERT INTO departamento
VALUES(50556,'Recursos Humanos','Al lado del edificio 2.',300109);
INSERT INTO departamento
VALUES(50557,'Marketing','En edificio de planificacion.',300102);
INSERT INTO departamento
VALUES(50558,'Compras','Calle 3.',300100);
INSERT INTO departamento
VALUES(50559,'Logistica','Edificio 5.',300100);
INSERT INTO departamento
VALUES(50560,'Operaciones','Edificio 5.',300110);
INSERT INTO departamento
VALUES(50561,'Control de gestion','Calle 8.',300113);
INSERT INTO departamento
VALUES(50562,'Limpieza','Edificio de limpieza.',300107);
INSERT INTO departamento
VALUES(50563,'Veterinaria','Al lado del edificio 2.',300113);
INSERT INTO departamento
VALUES(50564,'Biologia','Al lado del edificio 2.',300113);
INSERT INTO departamento
VALUES(50565,'Conservacion','Al lado del edificio 2.',300113);
INSERT INTO departamento
VALUES(50566,'Educacion','Edificio de educacion.',300103);
INSERT INTO departamento
VALUES(50567,'Servicio al cliente','Centro de servicio a cliente.',300107);
INSERT INTO departamento
VALUES(50568,'Adiestramiento','Edificio de educacion.',300113);
INSERT INTO departamento
VALUES(50569,'Grooming','Edificio de veterinaria.',300100);
INSERT INTO departamento
VALUES(50570,'Planificacion','Calle 8.',300100);
INSERT INTO departamento
VALUES(50571,'Direccion','Edificio 13',300102);
INSERT INTO departamento
VALUES(50572,'Voluntariado','Edificio de educacion.',300117);
INSERT INTO departamento
VALUES(50573,'Agronomia','Al lado del edificio 2.',300114);
INSERT INTO departamento
VALUES(50574,'Entrenamiento animal','Edificio de veterinaria.',300105);

show user
SELECT systimestamp FROM dual;
--Insertando valores a empleado

INSERT INTO empleado
VALUES(6000,'Candace',NULL,'Wolland','Flinn','P','287-297-8273','cwolland0@si.edu',NULL,NULL,NULL,NULL,234543,'SaniClown',234,NULL,NULL,300103,50566);
INSERT INTO empleado
VALUES(6001,'Lise','Carol','Bloschke','Rollins','P','451-183-1845','lbloschke1@posterous.com',NULL,NULL,NULL,NULL,1111104,'APPUR',138,NULL,NULL,300105,50574);
INSERT INTO empleado
VALUES(6002,'Rebecca','Marie','ONeal','Smith','A','681-890-7662','roneal2@g.co',NULL,NULL,4568,'activo',NULL,NULL,NULL,NULL,1003,300110,50555);
INSERT INTO empleado
VALUES(6003,'Margret','Gil','Assiratti',NULL,'G','183-341-0795','massiratti3@cornell.edu',NULL,NULL,NULL,NULL,NULL,NULL,NULL,123458,NULL,300114,50573);
INSERT INTO empleado
VALUES(6004,'Inger','Boyce','Sayce','Hampton','A','592-190-2115','isayce4@purevolume.com',NULL,NULL,5200,'activo',NULL,NULL,NULL,NULL,1020,300100,50570);
INSERT INTO empleado
VALUES(6005,'Rudolf','Red','Sivills',NULL,'G','127-239-8432','rsivills5@spiegel.de',NULL,NULL,NULL,NULL,NULL,NULL,NULL,123460,NULL,300103,50566);
INSERT INTO empleado
VALUES(6006,'Leola',NULL,'Springle','Clay','M','996-276-5273','lspringle6@plala.or.jp',7,10.25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,300107,50562);
INSERT INTO empleado
VALUES(6007,'Jacky','Emma','Espinola','Gonzalez','A','741-933-4761','jespinola7@multiply.com',NULL,NULL,3700,'pendiente',NULL,NULL,NULL,NULL,1001,300102,50557);
INSERT INTO empleado
VALUES(6008,'Dag',NULL,'Caw','Ellison','G','922-922-8075','dcaw8@ox.ac.uk',NULL,NULL,NULL,NULL,NULL,NULL,NULL,123457,NULL,300118,50564);
INSERT INTO empleado
VALUES(6009,'Nani','Bell','Lorente','Lane','M',NULL,'nlorente9@etsy.com',7,10.25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,300107,50567);
INSERT INTO empleado
VALUES(6010,'Dew','George','Cayley','Foster','G','984-225-4080','dcayleya@google.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,123458,NULL,300113,50561);
INSERT INTO empleado
VALUES(6011,'Hercules','Joseph','Mussilli',NULL,'A','262-348-3580','hmussillib@tripadvisor.com',NULL,NULL,3800,'cancelado',NULL,NULL,NULL,NULL,1001,300102,50557);
INSERT INTO empleado
VALUES(6012,'Cathrin','May','Macken','Finley','M','623-937-1653','cmackenc@adobe.com',8,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,300119,50568);
INSERT INTO empleado
VALUES(6013,'Trenna','Gray','Dightham','Mercer','M','682-776-2212','tdighthamd@dot.gov',6,9.25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,300114,50573);
INSERT INTO empleado
VALUES(6014,'Eziechiele','Mohammed','Fantham',NULL,'P','394-199-0289','efanthame@nytimes.com',NULL,NULL,NULL,NULL,1111109,'APPUR',223,NULL,NULL,300103,50566);
INSERT INTO empleado
VALUES(6015,'Perle',NULL,'Gracey','Tucker','A','951-201-8224','pgraceyf@un.org',NULL,NULL,4000,'activo',NULL,NULL,NULL,NULL,1005,300100,50558);
INSERT INTO empleado
VALUES(6016,'Ives','Summer','Balstone','Yang','M','596-312-6788','ibalstoneg@blog.com',7,10.25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,300105,50574);
INSERT INTO empleado
VALUES(6017,'Averell',NULL,'Fraulo','Swanson','P','535-906-9639','afrauloh@npr.org',NULL,NULL,NULL,NULL,4892020,'Payasos Sin Fronteras',240,NULL,NULL,300103,50566);
INSERT INTO empleado
VALUES(6018,'Melicent','Grace','Pedlar','Cole','A','846-383-8318','mpedlari@independent.co.uk',NULL,NULL,6789,'pendiente',NULL,NULL,NULL,NULL,1013,300102,50571);
INSERT INTO empleado
VALUES(6019,'Salem','Jill','Bee',NULL,'P','243-894-7539','sbeej@bandcamp.com',NULL,NULL,NULL,NULL,9292729,'Asociacion Entre Payasos',356,NULL,NULL,300113,50565);

show user
SELECT systimestamp FROM dual;
--Insertando valores a agenda

INSERT INTO agenda
VALUES(532423,'Fiesta de Navidad el 24 de diciembre.',45041);
INSERT INTO agenda
VALUES(532424,'Visita escolar el 19 de enero.',45049);
INSERT INTO agenda
VALUES(532425,'Cumpleanos de nino.',45043);
INSERT INTO agenda
VALUES(532426,'Conferencia veterinaria de la Universidad Central.',45045);
INSERT INTO agenda
VALUES(532427,'Charla a estudiantes de tercer grado.',45044);
INSERT INTO agenda
VALUES(532428,'Visita escolar el 25 de enero.',45049);
INSERT INTO agenda
VALUES(532429,'Cumpleanos de nina.',45043);
INSERT INTO agenda
VALUES(532430,'Cumpleanos de nina.',45043);
INSERT INTO agenda
VALUES(532431,'Charla a estudiantes de quinto grado.',45044);
INSERT INTO agenda
VALUES(532432,'Visita escolar el 23 de febrero.',45049);
INSERT INTO agenda
VALUES(532433,'Agronomia para ninos.',45057);
INSERT INTO agenda
VALUES(532434,'Cumpleanos de nina.',45043);
INSERT INTO agenda
VALUES(532435,'Dia del nino',45052);
INSERT INTO agenda
VALUES(532436,'Dia del elefante.',45047);
INSERT INTO agenda
VALUES(532437,'Visita escolar el 2 de marzo.',45049);
INSERT INTO agenda
VALUES(532438,'Cumpleanos de animal',45056);
INSERT INTO agenda
VALUES(532439,'Charla a estudiantes de sexto grado.',45044);
INSERT INTO agenda
VALUES(532440,'Visita escolar el 15 de marzo.',45049);
INSERT INTO agenda
VALUES(532441,'Cumpleanos de animal.',45056);
INSERT INTO agenda
VALUES(532442,'Visita escolar el 4 de abril.',45049);

show user
SELECT systimestamp FROM dual;
--Insertando valores a cueva

--Creando secuencia
DROP SEQUENCE cueva_sequence;
CREATE SEQUENCE cueva_sequence
start with 755
increment by 1
minvalue 0
maxvalue 774
cycle;

INSERT INTO cueva
VALUES(cueva_sequence.nextval,300103);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300103);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300103);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300105);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300105);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300105);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300107);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300107);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300107);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300108);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300108);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300108);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300113);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300113);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300113);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300117);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300117);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300118);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300118);
INSERT INTO cueva
VALUES(cueva_sequence.nextval,300118);

show user
SELECT systimestamp FROM dual;
--Insertando valores a animal

INSERT INTO animal
VALUES(202021,'Rocco','Felino',152.00,245,757);
INSERT INTO animal
VALUES(202022,'Sky','Reptil',165.00,312,763);
INSERT INTO animal
VALUES(202023,'Leo','Ave',60.80,27,769);
INSERT INTO animal
VALUES(202024,'Iggy','Felino',152.50,221,757);
INSERT INTO animal
VALUES(202025,'Coco','Pez',509.70,456,758);
INSERT INTO animal
VALUES(202026,'Chocolate','Pez',61.30,13,758);
INSERT INTO animal
VALUES(202027,'Princesa','Reptil',56.90,24,761);
INSERT INTO animal
VALUES(202028,'Ricardo','Maminfero',304.80,776,774);
INSERT INTO animal
VALUES(202029,'Spike','Reptil',30.48,35,763);
INSERT INTO animal
VALUES(202030,'Amy','Ave',213.40,300,769);
INSERT INTO animal
VALUES(202031,'Alvin','Maminfero',91.44,57,766);
INSERT INTO animal
VALUES(202032,'Spidy','Reptil',45.90,50,761);
INSERT INTO animal
VALUES(202033,'George','Maminfero',145.00,123,774);
INSERT INTO animal
VALUES(202034,'Wile E','Felino',167.90,199,756);
INSERT INTO animal
VALUES(202035,'Spirit','Maminfero',214.55,476,764);
INSERT INTO animal
VALUES(202036,'Blu','Ave',254.80,23,768);
INSERT INTO animal
VALUES(202037,'Cosmo','Ave',93.40,244,768);
INSERT INTO animal
VALUES(202038,'Oscar','Anfibio',121.70,68,771);
INSERT INTO animal
VALUES(202039,'Bison','Maminfero',194.50,677,766);
INSERT INTO animal
VALUES(202040,'Rey Julian','Anfibio',87.40,45,771);

show user
SELECT systimestamp FROM dual;
--Insertando valores a agenda_animal

INSERT INTO agenda_animal 
VALUES(532436,202035);
INSERT INTO agenda_animal 
VALUES(532426,202026);
INSERT INTO agenda_animal 
VALUES(532431,202023);
INSERT INTO agenda_animal 
VALUES(532438,202037);
INSERT INTO agenda_animal 
VALUES(532441,202031);
INSERT INTO agenda_animal 
VALUES(532440,202026);
INSERT INTO agenda_animal 
VALUES(532423,202038);
INSERT INTO agenda_animal 
VALUES(532425,202038);
INSERT INTO agenda_animal 
VALUES(532429,202026);
INSERT INTO agenda_animal 
VALUES(532435,202031);

show user
SELECT systimestamp FROM dual;
--Insertando valores a agenda_empleado

INSERT INTO agenda_empleado
VALUES(532430,6014);
INSERT INTO agenda_empleado
VALUES(532431,6019);
INSERT INTO agenda_empleado
VALUES(532432,6003);
INSERT INTO agenda_empleado
VALUES(532433,6014);
INSERT INTO agenda_empleado
VALUES(532433,6010);
INSERT INTO agenda_empleado
VALUES(532435,6009);
INSERT INTO agenda_empleado
VALUES(532436,6004);
INSERT INTO agenda_empleado
VALUES(532441,6000);
INSERT INTO agenda_empleado
VALUES(532441,6001);
INSERT INTO agenda_empleado
VALUES(532442,6010);

show user
SELECT systimestamp FROM dual;
--Insertando valores a animal_alimento

INSERT INTO animal_alimento
VALUES(202036,501);
INSERT INTO animal_alimento
VALUES(202022,510);
INSERT INTO animal_alimento
VALUES(202033,504);
INSERT INTO animal_alimento
VALUES(202023,501);
INSERT INTO animal_alimento
VALUES(202037,501);
INSERT INTO animal_alimento
VALUES(202027,510);
INSERT INTO animal_alimento
VALUES(202039,515);
INSERT INTO animal_alimento
VALUES(202033,515);
INSERT INTO animal_alimento
VALUES(202032,519);
INSERT INTO animal_alimento
VALUES(202028,517);

show user
SELECT systimestamp FROM dual;
--Insertando valores a evento

INSERT INTO evento
VALUES(45041,212,300100);
INSERT INTO evento
VALUES(45049,213,300113);
INSERT INTO evento
VALUES(45043,214,300107);
INSERT INTO evento
VALUES(45045,215,300113);
INSERT INTO evento
VALUES(45044,216,300113);
INSERT INTO evento
VALUES(45049,217,300113);
INSERT INTO evento
VALUES(45043,218,300108);
INSERT INTO evento
VALUES(45043,219,300109);
INSERT INTO evento
VALUES(45044,220,300113);
INSERT INTO evento
VALUES(45049,221,300113);

------------------------------------------		   
--               QUERIES
------------------------------------------ 
show user
SELECT systimestamp FROM dual;
-- a.	Mostrar toda la informacion de los animales.

SELECT *
  FROM animal;
 
show user
SELECT systimestamp FROM dual; 
-- b.	Dar una descripcion de la tabla de los alimentos.

DESC alimento

show user
SELECT systimestamp FROM dual;
-- c.	Mostrar el nombre, apellidos, numero de celular y el correo electrónico de los empleados.

SELECT primer_nombre ||''|| segundo_nombre AS "Nombre", apellido_paterno||''|| apellido_materno AS "Apellido", telefono, correo_electronico
   FROM empleado;

show user
SELECT systimestamp FROM dual; 
-- d.	Muestre los nombres de los animales y la localizacion de la jaula de cada uno de esos animales.

SELECT animal.nombre, animal.idCueva, sucursal.nombre AS "Localizacion"
    FROM animal 
	    JOIN cueva
	       ON animal.idCueva=cueva.idCueva
		JOIN sucursal
		   ON sucursal.codigoSucursal = cueva.codigoSucursal;

show user
SELECT systimestamp FROM d ual;
-- e.	Mostrar totales de animales por especie (debe haber por lo menos 3 especies) 

SELECT DISTINCT especie, COUNT(especie) AS "Total por especie"
   FROM animal 
	 GROUP BY especie
		ORDER BY COUNT(especie) DESC;

show user
SELECT systimestamp FROM dual;		
-- f. Animal que tiene el mayor peso y el menor peso

SELECT nombre, peso AS "Peso Minimo y Maximo"
     FROM animal
	    WHERE peso IN ((SELECT MAX(peso) FROM animal), (SELECT MIN(peso) FROM animal));
		
show user
SELECT systimestamp FROM dual;
-- g.	Promedio de estatura de los animales que son aves

SELECT DISTINCT especie, AVG(estatura) AS "Promedio de estatura"
     FROM animal
	   WHERE especie = 'Ave'
		  GROUP BY especie;

show user
SELECT systimestamp FROM dual;					   
-- h.	Empleados en total por departamento

SELECT nombre AS "Departamento", COUNT(idDepartamento) AS "Cantidad de empleados"
    FROM departamento LEFT OUTER JOIN empleado 
	   USING(idDepartamento)
	      GROUP BY nombre;

show user
SELECT systimestamp FROM dual;		  
-- i.	Mostrar los nombres de aquellos empleados que nos administrativos únicamente 

SELECT primer_nombre ||''|| segundo_nombre AS "Nombre", apellido_paterno ||''|| apellido_materno AS "Apellido(s)"
    FROM empleado
       WHERE tipo = 'A';

show user
SELECT systimestamp FROM dual;			 
-- j. Indicar cuales jaulas (cuevas) no se están utilizando (disponibles).

SELECT cueva.idCueva as "Cuevas Disponibles"
    FROM cueva FULL OUTER JOIN animal
	  ON cueva.idCueva= animal.idCueva
	    WHERE animal.idCueva IS NULL
	      ORDER BY cueva.idCueva ASC;

show user
SELECT systimestamp FROM dual;
------------------------------------------		   
--        QUERIES SQL PLUS
------------------------------------------		  
REM *******************************************
REM *   Author: Claudia P. Monge Torres       *
REM *   Comentarios: Este sript corre y crea  *
REM *   un reporte de los empleados           *
REM *   y sus departamentos.                  *
REM *******************************************

SET ECHO OFF
SET PAGESIZE 70
SET LINESIZE 150
SET FEEDBACK OFF
TTITLE 'REPORTE DE EMPLEADOS'
BTITLE 'ReporteEmpleados.sql'

-- Se crean las columnas del reportes 
COLUMN  primer_nombre                 HEADING  'NOMBRE'         FORMAT A15
COLUMN  apellido_paterno              HEADING  'APELLIDO'       FORMAT A15
COLUMN  telefono                      HEADING  'TELEFONO'       FORMAT A13
COLUMN  correo_electronico            HEADING  'EMAIL'          FORMAT A30
COLUMN  nombre                        HEADING  'DEPARTAMENTO'   FORMAT 99999
COLUMN  tipo                          HEADING  'TIPO'           FORMAT A1
COLUMN  numeroEmp                     HEADING  'ID EMP'         FORMAT 99999
COLUMN  departamento.idDepartamento   HEADING  'DEPT'           FORMAT 99999
COLUMN  empleado.idDepartamento       HEADING  'CANT'           FORMAT A2

--Hacer un count del total los empleados en la base de datos
BREAK ON numeroEmp    SKIP 1                     ON  REPORT
COMPUTE               count OF numeroEmp         ON  REPORT
SPOOL ON
SPOOL C:\Users\claud\Desktop\RepEmpleados.txt

-- Buscar la info de los empleados 
SELECT DISTINCT primer_nombre, apellido_paterno, telefono, correo_electronico, tipo, departamento.nombre, numeroEmp
  FROM empleado FULL OUTER JOIN departamento
       ON (empleado.idDepartamento = departamento.idDepartamento) 
         WHERE empleado.idDepartamento IS NOT NULL 
		  GROUP BY primer_nombre, apellido_paterno, telefono, correo_electronico, tipo, departamento.nombre, numeroEmp
	       ORDER BY empleado.primer_nombre ASC;
		   
--Buscar la cantidad de empleados por departamneto
SELECT departamento.nombre AS "Departamento", COUNT(idDepartamento) AS "Cantidad de empleados"
    FROM departamento LEFT OUTER JOIN empleado 
	   USING(idDepartamento)
	    GROUP BY nombre;
		
SPOOL OFF
CLEAR COMPUTE
CLEAR BREAK
COLUMN primer_nombre                  CLEAR
COLUMN apellido_paterno               CLEAR
COLUMN telefono                       CLEAR
COLUMN correo_electronico             CLEAR
COLUMN idDepartamento                 CLEAR
COLUMN tipo                           CLEAR
COLUMN numeroEmp                      CLEAR
COLUMN  departamento.idDepartamento   CLEAR
COLUMN  empleado.idDepartamento       CLEAR

BTITLE  OFF
TTITLE  OFF
SET FEEDBACK  ON
SET PAGESIZE 14
SET ECHO ON   
--Finalizar corrida

--------------- BORRANDO TABLAS ASOCIATIVAS O TRINARIAS  ---------------
show user
SELECT systimestamp FROM dual;
truncate table evento;
DROP TABLE evento CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;
truncate table animal_alimento;
DROP TABLE animal_alimento CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;
truncate table agenda_empleado;
DROP TABLE agenda_empleado CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;
truncate table agenda_animal;
DROP TABLE agenda_animal CASCADE CONSTRAINTS;
	
--------------- BORRANDO TABLAS CON FK---------------
show user
SELECT systimestamp FROM dual;
TRUNCATE TABLE animal;
DROP TABLE animal CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;
TRUNCATE TABLE cueva;
DROP TABLE cueva CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;
TRUNCATE TABLE  agenda;
DROP TABLE agenda CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;
TRUNCATE TABLE empleado;
DROP TABLE empleado CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;
TRUNCATE TABLE departamento;
DROP TABLE departamento CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;	
--------------- BORRANDO TABLAS SIN FK---------------
show user
SELECT systimestamp FROM dual;
TRUNCATE TABLE  actividad;
DROP TABLE actividad CASCADE CONSTRAINTS; 

show user
SELECT systimestamp FROM dual;
TRUNCATE TABLE plan_medico;
DROP TABLE plan_medico CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;
TRUNCATE TABLE contrato;
DROP TABLE contrato CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;
TRUNCATE TABLE sucursal;
DROP TABLE sucursal CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;
TRUNCATE TABLE calendario;
DROP TABLE calendario CASCADE CONSTRAINTS;

show user
SELECT systimestamp FROM dual;
TRUNCATE TABLE alimento;
DROP TABLE alimento CASCADE CONSTRAINTS;

SET ECHO OFF