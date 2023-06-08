CREATE DATABASE practica_hito_4;
USE practica_hito_4;

CREATE TABLE proyecto(

    id_proy INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombreProy TEXT,
    tipoProy TEXT

);

INSERT INTO proyecto(id_proy, nombreProy, tipoProy)
VALUES (1,'Construccion','Remodelacion'),
       (2,'Construccio1','Remodelacion1'),
       (3,'Construccion3','Remodelacion2');

SELECT * FROM proyecto;

CREATE TABLE detalle_proyecto(

    id_dp INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_per INT NOT NULL,
    id_proy INT,
    FOREIGN KEY (id_per) REFERENCES persona(id_per),
    FOREIGN KEY (id_proy) REFERENCES proyecto(id_proy)

);

INSERT INTO detalle_proyecto (id_per, id_proy)
VALUES (1, 1),
       (2, 2),
       (3, 3);

SELECT * FROM detalle_proyecto;

CREATE TABLE persona(

    id_per INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre TEXT,
    apellidos TEXT,
    fecha_nac DATE,
    edad INT,
    email TEXT,
    sexo CHAR,
    id_dep INT,
    id_prov INT,
    FOREIGN KEY (id_dep) REFERENCES departamento(id_dep),
    FOREIGN KEY (id_prov) REFERENCES provincia(id_prov)

);

INSERT INTO persona(id_per, nombre, apellidos, fecha_nac, edad, email, sexo, id_dep, id_prov)
VALUES (1,'Sergio','Mendoza','2003-01-01',19,'ser@gmail.com','m',1,1),
       (2,'Andres','Qis','2003-01-01',21,'seras@gmail.com','m',2,2),
       (3,'Jose','Alanoca','2003-01-01',23,'serquis@gmail.com','m',3,3);

SELECT  * FROM persona;

CREATE TABLE provincia(

    id_prov INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre TEXT,
    id_dep INT,
    FOREIGN KEY (id_dep) REFERENCES departamento(id_dep)

);

INSERT INTO provincia(id_prov, nombre, id_dep)
VALUES (1,'Chijini',1),
       (2,'Viacha',2),
        (3,'Omasuyo',3);

SELECT * FROM provincia;

CREATE TABLE departamento(

    id_dep INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre TEXT

);

INSERT INTO departamento( nombre)
VALUES ('La paz'),
       ('El alto'),
       ('Cochabamba');

SELECT * FROM departamento;


CREATE OR REPLACE FUNCTION serieFibonacci(num_ser INT)
RETURNS TEXT
BEGIN

    DECLARE num1,num2,num3 INT DEFAULT 1;
    DECLARE resp TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 0;

    WHILE (num_ser > cont) DO
        SET resp = CONCAT(resp,num3,',');
        SET num3 = num1 + num2;
        SET num1 = num2;
        SET num2 = num3;
        SET cont = cont + 1;
    END WHILE;
    RETURN resp;
END;

SELECT serieFibonacci(8);

CREATE OR REPLACE FUNCTION serieFibonacci_v2_SUMA(num_ser INT)
RETURNS TEXT
BEGIN

    DECLARE num1,num2,num3 INT DEFAULT 1;
    DECLARE suma INT DEFAULT 0;
    DECLARE resp TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 0;

    WHILE (num_ser > cont) DO
        SET resp = CONCAT(resp,num3,',');

        SET num3 = num1 + num2;
        SET num1 = num2;
        SET num2 = num3;
        SET cont = cont + 1;
        SET suma = num2 + num1;
    END WHILE;
    RETURN suma;
END;

SELECT serieFibonacci_v2_SUMA(8); #metodo random

SELECT serieFibonacci(5);


CREATE OR REPLACE FUNCTION sum_serie_FIBO(fun_cad INT)
RETURNS INT
BEGIN

    DECLARE n1, n3 INT;
    DECLARE n2 INT DEFAULT 0;
    DECLARE suma INT DEFAULT 0;
    DECLARE cad1, cad2, cad3 TEXT;

    SET cad1 =  serieFibonacci(fun_cad); #1,2,3,5,8,13,21,34, #en el caso de elegir 8 en la funcion

    WHILE cad1 != '' DO

        SET n1 = CAST(SUBSTRING_INDEX(cad1, ',' ,1) AS UNSIGNED); #obteniendo el primer valor en este caso el valor sera 1

        SET suma = suma + n1;

        SET cad1 =  SUBSTRING(cad1, LOCATE(',', cad1)+1); #,2,3,5,8,13,21,34



        END WHILE;
    RETURN suma;
    END;

SELECT serieFibonacci(5);
SELECT sum_serie_FIBO(5);


SELECT SUBSTRING_INDEX('Sergio es programador', ' ',3);

SELECT sum_serie_FIBO(5);

SELECT INSERT(',1,2,3,', LOCATE(',', ',1,2,3,'), 1, '');

SELECT LOCATE(1,serieFibonacci(8));

SELECT sum_serie_FIBO();

SELECT INSERT(',2,3,5,8,13,21,34', LOCATE(',', '1, 2, 3,'), 1, '');

SET @a = '1,2,3,';
SET @cad = 'es entero';
SELECT REPLACE('1,2,3,',',','');

CREATE OR REPLACE FUNCTION ver()
RETURNS TEXT
BEGIN

    IF @a = 123 THEN
        return @cad;
    end if;
    RETURN @cad;
    END;

SELECT ver();

SELECT REPLACE('1,2,3,', ',', '') AS cadena_actualizada;



#NO MUENTRA A NADIE SI UTILIZAMOS LA FECHA: '2000-10-10' PORQUE EN MIS REGISTROS NO EXISTE ALGUIEN CON TAL
#FECHA DE NACIMIENTO, EN OTRO CASO, SIN UTILIZAR LA FECHA DE NACIMIENTO, SI QUE ME MUETRA A ALGUIEN NACIDO
#EN EL ALTO Y DE GENERO MASCULINO PORQUE TAMBIEN NO TENGO A,LGUIEN DE GENERO FEMENINO EN LA TABLA

CREATE OR REPLACE VIEW know_nom_age_nom_proy AS
SELECT CONCAT(pe.nombre,' ',pe.apellidos) AS 'FULLNAME', pe.edad, pe.fecha_nac, pro.nombreProy
    FROM persona as pe
    INNER JOIN detalle_proyecto AS det_pro ON pe.id_per = det_pro.id_proy
    INNER JOIN proyecto AS pro ON det_pro.id_proy = pro.id_proy
    INNER JOIN departamento AS dep ON pe.id_per = dep.id_dep
    WHERE pe.sexo = 'm' AND dep.nombre = 'El alto'; #AND pe.fecha_nac = '2000-10-10';


    SELECT * FROM know_nom_age_nom_proy;

SELECT * FROM departamento;
SELECT * from persona;



ALTER TABLE proyecto ADD COLUMN estado TEXT;

SELECT * FROM proyecto;

CREATE OR REPLACE TRIGGER insercion_proy_trigger
    BEFORE INSERT
    ON proyecto
    FOR EACH ROW
    BEGIN

        IF NEW.tipoProy = 'Educacion' OR
           NEW.tipoProy = 'Forestacion' OR
           NEW.tipoProy = 'Cultura' THEN

            SET NEW.estado = 'ACTIVO';

        ELSE

            SET NEW.estado = 'INACTIVO';

        end if;
    end;

INSERT INTO proyecto(nombreProy, tipoProy)
VALUES ('Escuelas', 'Educacion');

SELECT * FROM proyecto;

INSERT INTO proyecto(nombreProy, tipoProy)
VALUES ('Limpieza', 'Derrumbe');

INSERT INTO proyecto(nombreProy, tipoProy)
VALUES ('Escuelitas', 'Cultura');

INSERT INTO proyecto(nombreProy, tipoProy)
VALUES ('Remodelacion', 'Construccion');



CREATE OR REPLACE TRIGGER update_proy_trigger
    BEFORE UPDATE
    ON proyecto
    FOR EACH ROW
    BEGIN
         IF NEW.tipoProy = 'Educacion' OR
            NEW.tipoProy = 'Forestacion' OR
            NEW.tipoProy = 'Cultura' THEN

            SET NEW.estado = 'ACTIVO';
        ELSE

            SET NEW.estado = 'INACTIVO';

        end if;
    end;



SELECT  timestampdiff(year, '2003-08-01', curdate());

CREATE OR REPLACE TRIGGER calculaEdad
    BEFORE INSERT
    ON persona
    FOR EACH ROW
    BEGIN

        SET NEW.edad = timestampdiff(year, NEW.fecha_nac, curdate());

        END;

INSERT INTO persona(nombre, apellidos, fecha_nac, email, sexo)
VALUES ('Daniela','Quisbert','2003-08-01','Daniela@gmail.com','f');


INSERT INTO persona(nombre, apellidos, fecha_nac, email, sexo)
VALUES ('Daniela','Quisbert','2003-08-01','Daniela@gmail.com','f');

INSERT INTO persona(nombre, apellidos, fecha_nac, email, sexo)
VALUES ('Carla','Alvarez','2003-08-01','Daniela@gmail.com','f');

SELECT * FROM persona;



CREATE TABLE persona_copia(

    id_per INT NOT NULL,
    nombre TEXT,
    apellidos TEXT,
    fecha_nac DATE,
    edad INT,
    email TEXT,
    sexo CHAR,
    id_dep INT,
    id_prov INT

);

CREATE OR REPLACE TRIGGER gen_copy_presona_trigger
    BEFORE INSERT
    ON persona
    FOR EACH ROW
    BEGIN

        INSERT INTO persona_copia(id_per, nombre, apellidos, fecha_nac, edad, email, sexo, id_dep, id_prov)
            VALUES (NEW.id_per,NEW.nombre,NEW.apellidos,NEW.fecha_nac,NEW.edad,NEW.email,NEW.sexo,NEW.id_dep,NEW.id_prov);


        END;

INSERT INTO persona ( nombre, apellidos, fecha_nac, email, sexo)
VALUES ('Jose','Miguel','2003-08-01','jose@gmail.com','m');

SELECT * FROM persona;

SELECT * FROM persona_copia;




CREATE VIEW uso_todas_las_tablas AS
SELECT CONCAT(pe.nombre,' ',pe.apellidos) AS 'FULLNAME', proy.tipoProy, dep.nombre
    FROM proyecto as proy
    INNER JOIN detalle_proyecto as DP ON dp.id_dp = proy.id_proy
    INNER JOIN persona as pe ON dp.id_dp = pe.id_per
    INNER JOIN provincia as prov ON prov.id_prov = pe.id_per
    INNER JOIN departamento as dep ON dep.id_dep = prov.id_prov;
   # WHERE pe.edad = 19 AND proy.estado ='ACTIVO';

SELECT * FROM uso_todas_las_tablas;


SELECT * FROM departamento;
SELECT * FROM proyecto;
