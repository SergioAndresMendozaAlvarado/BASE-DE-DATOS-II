CREATE DATABASE hito_4_BDA;
USE hito_4_BDA;
#TRIGGER Y VISTAS
#CUANDO EL TRIGGER ES DE DELETE SE USA OLD.

CREATE TABLE numeros(

  numero BIGINT PRIMARY KEY NOT NULL,
  cuadrado BIGINT,
  cubo BIGINT,
  raiz REAL,
  suma DOUBLE
);

CREATE OR REPLACE TRIGGER tr_complete_data
    BEFORE INSERT  #NEW
    ON numeros
    FOR EACH ROW
    BEGIN

        DECLARE valor_cuadrado, valor_cubo, suma_tol BIGINT;
        DECLARE valor_raiz REAL;

        SET valor_cuadrado = POWER(NEW.numero,2);
        SET valor_cubo = POWER(NEW.numero, 3);
        SET valor_raiz = SQRT(NEW.numero);


        SET NEW.cuadrado = valor_cuadrado;
        SET NEW.cubo = valor_cubo;
        SET NEW.raiz = valor_raiz;
        SET NEW.suma = NEW.cuadrado + NEW.cubo + NEW.raiz + NEW.numero;

        END;

SELECT POWER(2,4);

INSERT INTO numeros(numero)
VALUES (2);
SELECT * FROM numeros;







SELECT * from usuario;


CREATE OR REPLACE TRIGGER gen_pass
    BEFORE INSERT
    ON usuario
    FOR EACH ROW
    BEGIN
        DECLARE nom,app TEXT;
        SET nom = (SELECT nombres FROM usuario);
        SET app = (SELECT apellidos FROM usuario);

        SET NEW.nombres = (SELECT SUBSTR(new.nombres,1,2));
        SET NEW.apellidos = (SELECT SUBSTR(new.apellidos,1,2));
        SET NEW.password = CONCAT(NEW.nombres,NEW.apellidos,NEW.edad);
        SET NEW.apellidos = app;
        SET NEW.nombres = nom;

    END;


CREATE OR REPLACE TRIGGER tr_calcular_passs_edad
    BEFORE INSERT
    ON usuario
    FOR EACH ROW
    BEGIN

        DECLARE a,b,c INT DEFAULT 0;

        SET NEW.password = LOWER(CONCAT(
            SUBSTR(NEW.nombres,1,2),
            SUBSTR(NEW.apellidos,1,2),
            SUBSTR(NEW.correo,1,2)));

        SET NEW.edad = ( SELECT TIMESTAMPDIFF(YEAR, NEW.fecha_nac, CURDATE()));

    END;

SELECT TIMESTAMPDIFF(YEAR, '2003-08-01',CURDATE());


CREATE OR REPLACE TRIGGER aument_pass
    BEFORE INSERT
    ON usuario
    FOR EACH ROW
    BEGIN

        DECLARE a,b,c INT DEFAULT 0;


        SET a = (SELECT CHAR_LENGTH(NEW.password));
        IF a < 10 THEN
            SET NEW.password = LOWER(CONCAT(NEW.password,
            SUBSTR(NEW.nombres,-2),
            SUBSTR(NEW.apellidos,-2),
            SUBSTR(NEW.edad,-2)));

        SET NEW.edad = ( SELECT TIMESTAMPDIFF(YEAR, NEW.fecha_nac, CURDATE()));

        END IF;
    END;



CREATE TABLE usuario(
    id_usu INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombres TEXT NOT NULL ,
    apellidos TEXT NOT NULL ,
    fecha_nac DATE NOT NULL,
    edad INT NOT NULL NOT NULL ,
    correo TEXT NOT NULL,
    password TEXT,
    nacionalidad TEXT
);

INSERT INTO usuario(nombres, apellidos, fecha_nac,edad, correo, password)
VALUES ('SERGIO', 'MENDOZA', '2003-08-01',19,'sergio@gmail.com','menos10');

INSERT INTO usuario(nombres, apellidos, fecha_nac,edad, correo,password)
VALUES ('Jose', 'Quispe', '2010-08-01',23,'sergio@gmail.com','12345678900');

SELECT * from usuario;
DROP TABLE usuario;



CREATE TRIGGER us_mant
    BEFORE INSERT
    ON usuario
    FOR EACH ROW
    BEGIN

        DECLARE dia_sem TEXT DEFAULT '';
        SET dia_sem = DAYNAME(current_date);

        IF dia_sem = 'Wednesday' THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Base de datos en MANTINIMIENTO';
        END IF;
        END;




CREATE OR REPLACE TRIGGER nacionalidad_block #chile
    BEFORE INSERT
    ON usuario
    FOR EACH ROW
    BEGIN

        DECLARE a,b,c INT DEFAULT 0;

        IF LOWER(NEW.nacionalidad) = 'chile' THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Your country is not aviable';

        END IF;

    END;



SELECT * from usuario;

INSERT INTO usuario(nombres, apellidos, fecha_nac,edad,correo,password,nacionalidad)
VALUES ('SERGIO', 'MENDOZA', '2003-08-01',19,'sergio@gmail.com','menos10','Bolivia');

INSERT INTO usuario(nombres, apellidos, fecha_nac,edad, correo,password,nacionalidad)
VALUES ('Jose', 'Quispe', '2010-08-01',23,'sergio@gmail.com','12345678900','chile');





