CREATE DATABASE defensa_hito4_2023;
USE defensa_hito4_2023;

CREATE TABLE proyecto(

    id_proy INT PRIMARY KEY NOT NULL,
    nombreProy TEXT,
    tipoProy TEXT

);

INSERT INTO proyecto(id_proy, nombreProy, tipoProy)
VALUES (1,'Construccion','Remodelacion'),
       (2,'Construccio1','Remodelacion1'),
       (3,'Construccion3','Remodelacion2');

SELECT * FROM proyecto;

CREATE TABLE detalle_proyecto(

    id_do INT PRIMARY KEY NOT NULL,
    id_per INT NOT NULL,
    id_proy INT NOT NULL,
    FOREIGN KEY (id_per) REFERENCES persona(id_per),
    FOREIGN KEY (id_proy) REFERENCES proyecto(id_proy)

);

INSERT INTO detalle_proyecto(id_do, id_per, id_proy)
VALUES (1,1,1),
       (2,2,2),
       (3,3,3);

SELECT * FROM detalle_proyecto;

CREATE TABLE persona(

    id_per INT PRIMARY KEY NOT NULL,
    nombre TEXT NOT NULL,
    apellidos TEXT NOT NULL,
    fecha_nac DATE NOT NULL,
    edad INT NOT NULL,
    email TEXT NOT NULL,
    sexo CHAR NOT NULL,

    id_dep INT NOT NULL,
    id_prov INT NOT NULL,
    FOREIGN KEY (id_dep) REFERENCES departamento(id_dep),
    FOREIGN KEY (id_prov) REFERENCES provincia(id_prov)
);

INSERT INTO persona(id_per, nombre, apellidos, fecha_nac, edad, email, sexo, id_dep, id_prov)
VALUES (1,'Sergio','Mendoza','2003-01-01',19,'ser@gmail.com','m',1,1),
       (2,'Andres','Qis','2003-01-01',21,'seras@gmail.com','m',2,2),
       (3,'Jose','Alanoca','2003-01-01',23,'serquis@gmail.com','m',3,3);

SELECT * FROM persona;

CREATE TABLE provincia(

    id_prov INT NOT NULL PRIMARY KEY ,
    nombre TEXT,
    id_dep INT NOT NULL ,
    FOREIGN KEY (id_dep) REFERENCES departamento(id_dep)

);

INSERT INTO provincia(id_prov, nombre, id_dep)
VALUES (1,'Chijini',1),
       (2,'Viacha',2),
        (3,'Omasuyo',3);

SELECT * FROM provincia;

CREATE TABLE departamento(

    id_dep INT PRIMARY KEY NOT NULL,
    nombre TEXT

);

INSERT INTO departamento(id_dep, nombre)
VALUES (1,'La paz'),
       (2,'El alto'),
       (3,'Cochabamba');

SELECT * FROM departamento;


ALTER VIEW datos AS
SELECT CONCAT(pe.nombre,' ',pe.apellidos) as 'FULLNAME',CONCAT('Tipo proy: ',proy.tipoProy,' ',proy.nombreProy) AS 'PROYECTO',d.nombre,only_consonants(d.nombre)
    FROM persona as pe

    INNER JOIN proyecto as proy on proy.id_proy = pe.id_per
    INNER JOIN departamento as d on pe.id_dep = d.id_dep;

SELECT * FROM datos;




CREATE OR REPLACE FUNCTION only_consonants(cadena TEXT)
RETURNS TEXT
BEGIN
    DECLARE a,b,c TEXT DEFAULT '';
    DECLARE num1,num2,num3 INT DEFAULT 0;
    DECLARE d,e,f INT DEFAULT 1;
    DECLARE cont, cont1, cont2 CHAR;

    WHILE d <= CHAR_LENGTH(cadena) DO
        SET cont = SUBSTR(cadena,d,1);
        CASE cont
            WHEN 'a' THEN SET a = a;
            WHEN 'e' THEN SET a = a;
            WHEN 'i' THEN SET a = a;
            WHEN 'o' THEN SET a = a;
            WHEN 'u' THEN SET a = a;
            WHEN ' ' THEN SET  a = CONCAT(a,' ');
            ELSE SET  a = REPLACE(CONCAT(a,cont),' ','');
        END CASE;
        SET d = d + 1;
        END WHILE;
    RETURN a;
END;
SELECT only_consonants('Hola como estan');


create OR REPLACE trigger no_insersion
    BEFORE INSERT
    on proyecto
    FOR EACH ROW
    begin
        IF new.tipoProy = 'Forestacion' AND
           DAYNAME(current_date) = 'Wednesday' AND
           MONTH(CURRENT_DATE) = 6 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'PROYECTO O FECHA NO ADMINITIDA';

        else
            set new.tipoProy = NEW.tipoProy;

        end if;
    end;




INSERT INTO proyecto(id_proy, nombreProy, tipoProy)
VALUES (1,'aasdsa','Forestacion');

INSERT INTO proyecto(id_proy, nombreProy, tipoProy)
VALUES (5,'aasdsa','Limpieza');


SELECT * FROM proyecto;

SELECT   DAYNAME(current_date);


CREATE FUNCTION dicc(day TEXT)
    RETURNS TEXT
    BEGIN
        DECLARE d1 TEXT;

        IF LOWER(day) = 'monday' THEN
            SET d1 = 'Lunes';

            ELSEIF LOWER(day) = 'tuesday' THEN
            SET d1 = 'Martes';

            ELSEIF LOWER(day) = 'wednesday' THEN
            SET d1 = 'Miercoles';

            ELSEIF LOWER(day) = 'thursday' THEN
            SET d1 = 'Jueves';

            ELSEIF LOWER(day) = 'friday' THEN
            SET d1 = 'Viernes';

            ELSEIF LOWER(day) = 'saturday' THEN
            SET d1 = 'Sabado';

            ELSEIF LOWER(day) = 'sunday' THEN
            SET d1 = 'Domingo';

        end if;
    RETURN d1;

    END;

SELECT dicc('MoNdAY');

SELECT dicc('sunday');









CREATE TABLE auditoria(

    nombre_proy_ant TEXT,
    nombre_proy_post TEXT,
    tipo_proy_ant TEXT,
    tipo_proy_post TEXT,
    operation TEXT,
    iser_id TEXT,
    hostname_1 TEXT,
    fecha_mod TEXT

);

INSERT INTO auditoria(nombre_proy_ant,  tipo_proy_ant, operation, iser_id, hostname_1)
VALUES ('Unifranz','Construccion','INSERSION',USER(),@@HOSTNAME);

SELECT * FROM auditoria;

CREATE OR REPLACE TRIGGER event_insert
    BEFORE UPDATE
    ON auditoria
    FOR EACH ROW
    BEGIN

        INSERT INTO auditoria(nombre_proy_ant, nombre_proy_post, tipo_proy_ant, tipo_proy_post, operation, iser_id, hostname_1)
            SELECT CONCAT('ANTES: ',OLD.nombre_proy_ant),
                   OLD.nombre_proy_post,
                   CONCAT('ANTES: ',OLD.tipo_proy_ant),
                   OLD.nombre_proy_post,
                   'UPDATE',
                   USER(),
                   @@HOSTNAME;

        END;

UPDATE auditoria SET nombre_proy_post = 'Univalle' WHERE nombre_proy_ant = 'Unifranz';


CREATE OR REPLACE TRIGGER insersion_event
    AFTER INSERT
    ON auditoria
    FOR EACH ROW
    BEGIN

        DECLARE id_us, nom_past, pass TEXT;
        DECLARE cad1,cad2,cad3,cad4 TEXT;

        SET cad1 = NEW.nombre_proy_post;
        SET cad2 = NEW.tipo_proy_post;
        INSERT INTO auditoria(nombre_proy_ant, nombre_proy_post, tipo_proy_ant,
                              tipo_proy_post, operation, iser_id, hostname_1,
                              fecha_mod)
            SELECT nombre_proy_ant,
                   cad1,
                   tipo_proy_ant,
                   cad2,
                   'INSERSION',
                   USER(),
                   @@HOSTNAME,
                   NOW();

        END;
