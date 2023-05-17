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

CREATE TABLE usuario(

    id_usu INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombres TEXT NOT NULL ,
    apellidos TEXT NOT NULL ,
    edad INT NOT NULL NOT NULL ,
    correo TEXT NOT NULL,
    password TEXT

);



INSERT INTO usuario(nombres, apellidos, edad, correo)
VALUES ('SERGIO', 'MENDOZA', 19,'sergio@gmail.com');


INSERT INTO usuario(nombres, apellidos, edad, correo)
VALUES ('Jose', 'Quispe', 19,'sergio@gmail.com');

INSERT INTO usuario(nombres, apellidos, edad, correo)
VALUES ('William', 'Barra', 23,'sergio@gmail.com');


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


CREATE OR REPLACE TRIGGER gen_pass_2 
    BEFORE INSERT 
    ON usuario
    FOR EACH ROW 
    BEGIN 
        
        SET NEW.password = CONCAT(
            SUBSTR(NEW.nombres,1,2),SUBSTR(NEW.apellidos),NEW.edad
            );
        END;
