CREATE DATABASE COLEGIO;
USE COLEGIO;

CREATE TABLE estudiantes
(
    id_est INT PRIMARY KEY AUTO_INCREMENT,
    nombres VARCHAR(50),
    apellidos VARCHAR(50),
    edad INT,
    fono INT,
    email VARCHAR(100),
    direccion VARCHAR(100),
    sexo VARCHAR(10)
);

INSERT INTO estudiantes(nombres, apellidos, edad, fono, email, direccion, sexo)
VALUES ('Miguel','Gonzales Veliz',20,2832115,'miguel@gmail.com','Av. 6 de Agosto','masculino'),
       ('Sandra','Mavir Uria',25,2832116,'sandra@gmail.com','Av. 6 de Agosto','femenino'),
       ('Joel','Aduviri Mondar',30,2832117,'joel@gmail.com','Av. 6 de Agosto','masculino'),
       ('Andrea','Arias Ballesteros',21,2832118,'andrea@gmail.com','Av. 6 de Agosto','femenino'),
       ('Santos','Montes Valenzuela',24,2832119,'santos@gmail.com','Av. 6 de Agosto','masculino');


CREATE TABLE materias
(
    id_mat INT PRIMARY KEY AUTO_INCREMENT,
    nombres_mat VARCHAR(100),
    cod_mat VARCHAR(100)
);

INSERT INTO materias(nombres_mat, cod_mat)
VALUES('Introduccion a la Arquitectura','ARQ-101'),
      ('Urbanismo y Diseño','ARQ-102'),
      ('Dibujo y Pintura Arquitectonico','ARQ-103'),
      ('Matematica Discreta','ARQ-104'),
      ('Fisica Basica','ARQ-105');

CREATE TABLE inscripcion
(
    id_ins INT PRIMARY KEY AUTO_INCREMENT,
    semestre VARCHAR(20),
    gestion INT,
    id_est INT,
    id_mat INT,
    FOREIGN KEY (id_est) REFERENCES estudiantes(id_est),
    FOREIGN KEY (id_mat) REFERENCES materias(id_mat)
);

INSERT INTO inscripcion(semestre, gestion, id_est, id_mat)
VALUES ('1er Semestre',2018,1,1),
       ('2do Semestre',2018,1,2),
       ('1er Semestre',2018,2,4),
       ('2do Semestre',2018,2,3),
       ('2do Semestre',2018,3,3),
       ('3er Semestre',2018,3,1),
       ('4to Semestre',2018,4,4),
       ('5to Semestre',2018,5,5);


#EJERCICIO 12

CREATE OR REPLACE FUNCTION serieFibonacci(n INT)
RETURNS TEXT
BEGIN
    DECLARE a INT DEFAULT 1;
    DECLARE b INT DEFAULT 0;
    DECLARE c INT DEFAULT 0;
    DECLARE R TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 0;

    WHILE (n > cont) DO
        SET R = CONCAT(R,c,',');
        SET c = a + b;
        SET a = b;
        SET b = c;
        SET cont = cont + 1;
    END WHILE;
    RETURN R;
END;

SELECT serieFibonacci(7);

#EJERCICIO 13
SET @limit = 7;

SELECT @limit;

CREATE OR REPLACE FUNCTION sserieFibonacciV2()
RETURNS TEXT
BEGIN
    DECLARE a INT DEFAULT 1;
    DECLARE b INT DEFAULT 0;
    DECLARE c INT DEFAULT 0;
    DECLARE R TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 0;

    WHILE (@limit > cont) DO
        SET R = CONCAT(R,c,',');
        SET c = a + b;
        SET a = b;
        SET b = c;
        SET cont = cont + 1;
    END WHILE;
    RETURN R;
END;

SELECT sserieFibonacciV2();




#EJERCICIO 14
CREATE OR REPLACE FUNCTION minEdad()
RETURNS TEXT
BEGIN
    DECLARE R INT DEFAULT 0;

    SELECT MIN(E.edad)
    FROM estudiantes E
    INTO R;
    RETURN R;
END;
SELECT minEdad();

CREATE OR REPLACE FUNCTION paresImpares()
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    DECLARE num INT DEFAULT minEdad();
    DECLARE cont INT DEFAULT 0;
    DECLARE numipar INT DEFAULT minEdad();


    REPEAT
        IF num % 2 = 0 THEN
            SET R = CONCAT(R,cont,',');
            SET cont = cont + 2;
        ELSE
            SET R = CONCAT(R,numipar,',');
            SET numipar = numipar - 2;
            SET cont = cont + 2;
        END IF;
    UNTIL cont > num END REPEAT;
    RETURN R;
END;

SELECT paresImpares();


#EJERCICIO 15
CREATE OR REPLACE FUNCTION separaVocales(CAD VARCHAR(100))
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 1;
    DECLARE Nveces TEXT DEFAULT 0;
    DECLARE PUNTERO CHAR;
    DECLARE acont INT DEFAULT 0;
    DECLARE econt INT DEFAULT 0;
    DECLARE icont INT DEFAULT 0;
    DECLARE ocont INT DEFAULT 0;
    DECLARE ucont INT DEFAULT 0;

    WHILE cont <= char_length(CAD) DO
        SET PUNTERO = SUBSTR(CAD,cont,1);
        CASE PUNTERO
            WHEN 'a' THEN SET acont = acont + 1;
            WHEN 'e' THEN SET econt = econt + 1;
            WHEN 'i' THEN SET icont = icont + 1;
            WHEN 'o' THEN SET ocont = ocont + 1;
            WHEN 'u' THEN SET ucont = ucont + 1;
            ELSE SET  Nveces = 'no hay vocales';
        END CASE;
        SET cont = cont + 1;
        END WHILE;

    IF(acont != 0 || econt != 0 || icont != 0 || ocont != 0 || ucont != 0)THEN
        SET R = CONCAT('a:',acont,', e:',econt,', i:',icont,', o:',ocont,', u:',ucont);
    ELSE
        SET R = Nveces;
    END IF;

    RETURN R;
END;

SELECT separaVocales('TALLER');


#EJERCICIO 16
CREATE FUNCTION detTipoCliente(creditLimit INT)
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT 'Customer Level: ';
    CASE
        WHEN creditLimit > 50000 THEN SET R = CONCAT(R,'PLATINIUM');
        WHEN creditLimit BETWEEN 10000 AND 50000 THEN SET R = CONCAT(R,'GOLD');
        WHEN creditLimit < 10000 THEN SET R = CONCAT(R,'SILVER');
        ELSE SET R = 'No esta dentro del rango de dinero requerido para determinar el tipo de cliente';
    END CASE;
    RETURN R;
END;

SELECT detTipoCliente(9999);
SELECT detTipoCliente(25000);
SELECT detTipoCliente(50001);


#EJERCICIO 17
CREATE OR REPLACE FUNCTION quitaVacales(cadena VARCHAR(20))
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';

    DECLARE cont INT DEFAULT 1;
    DECLARE PUNTERO CHAR;

    WHILE cont <= char_length(cadena) DO
        SET PUNTERO = SUBSTR(cadena,cont,1);
        CASE PUNTERO
            WHEN 'a' THEN SET R = R;
            WHEN 'e' THEN SET R = R;
            WHEN 'i' THEN SET R = R;
            WHEN 'o' THEN SET R = R;
            WHEN 'u' THEN SET R = R;
            WHEN ' ' THEN SET  R = CONCAT(R,' ');
            ELSE SET  R = CONCAT(R,PUNTERO);
        END CASE;
        SET cont = cont + 1;
        END WHILE;
    RETURN R;
END;

SELECT quitaVacales('TALLER DBA II');


CREATE OR REPLACE FUNCTION suma2CadenasSinVocales(CAD1 VARCHAR(20), CAD2 VARCHAR(20))
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    DECLARE R1 TEXT DEFAULT quitaVacales(CAD1);
    DECLARE R2 TEXT DEFAULT quitaVacales(CAD2);

    SET R = CONCAT(R1,' - ',R2);
    RETURN R;
END;

SELECT suma2CadenasSinVocales('TALLER DBA II','GESTION 2023');


#EJERCICIO 18
CREATE OR REPLACE FUNCTION Nveces(cadena VARCHAR(20))
RETURNS TEXT
BEGIN

    DECLARE R TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 1;
    DECLARE PUNTERO VARCHAR(100);

   REPEAT
        SET PUNTERO = SUBSTR(cadena,cont);
        SET R = CONCAT(R,PUNTERO,', ');
        SET cont = cont + 1;
        UNTIL cont > char_length(cadena) END REPEAT;

   RETURN R;
END;

SELECT Nveces('dbaii');

