
CREATE DATABASE practica_h3_BDA;
USE practica_h3_BDA;

CREATE TABLE estudiantes(
  nombres VARCHAR(50) NOT NULL ,
  apellidos VARCHAR(50) NOT NULL ,
  edad INT NOT NULL ,
  fono INT NOT NULL ,
  email VARCHAR(100) NOT NULL ,
  direccion VARCHAR(100) NOT NULL ,
  sexo VARCHAR(50) NOT NULL ,
  id_est INT PRIMARY KEY AUTO_INCREMENT NOT NULL
);

CREATE TABLE materias(

    nombre_mat VARCHAR(100)NOT NULL ,
    cod_mat VARCHAR(100)NOT NULL ,
    id_mat int PRIMARY KEY AUTO_INCREMENT NOT NULL
);

CREATE TABLE inscripcion(
    semestre VARCHAR(20)NOT NULL ,
    gestion int NOT NULL ,
    id_est int NOT NULL ,
    id_mat int NOT NULL ,
    id_ins INT NOT NULL  PRIMARY KEY AUTO_INCREMENT,
    FOREIGN KEY (id_est) REFERENCES estudiantes(id_est),
    FOREIGN KEY (id_mat) REFERENCES materias(id_mat)
);

INSERT INTO estudiantes(nombres, apellidos, edad, fono, email, direccion, sexo)
VALUES ('Miguel','Gonzales Veliz',20,2832115,'miguel@gmail.com','Av. 6 de Agosto','masculino'),
       ('Sandre','Mavir Uria',22,2832116,'sandra@gmail.com','Av. 6 de Agosto','femenino'),
       ('Joel','Adubiri Mondar',30,2832117,'joel@gmail.com','Av. 6 de Agosto','masculino'),
       ('Andrea','Arias Ballesteros',21,2832118,'andres@gmail.com','Av. 6 de Agosto','femenino'),
       ('Santos','Montes Valenzuela',24,2832119,'santos@gmail.com','Av. 6 de Agosto','masculino');


INSERT INTO materias(nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura','ARQ-101'),
       ('Urbanismo y diseño','ARQ-102'),
       ('Dibujo y pintura Arquitectonico','ARQ-103'),
       ('Matematica Discreta','ARQ-104'),
       ('Fisica basica','ARQ-105');


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

SELECT serieFibonacci(11);


SET @limit = 7;
SELECT @limit;

CREATE OR REPLACE FUNCTION serieFibonacci_con_car_global()
RETURNS TEXT
BEGIN

    DECLARE num1,num2,num3 INT DEFAULT 1;
    DECLARE resp TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 0;

    WHILE (@limit > cont) DO  #solamenta cambiamos la cantidad de repeticoones en el bucle
        SET resp = CONCAT(resp,num3,',');
        SET num3 = num1 + num2;
        SET num1 = num2;
        SET num2 = num3;
        SET cont = cont + 1;
    END WHILE;
    RETURN resp;
END;

SELECT serieFibonacci_con_car_global();


CREATE FUNCTION edad_min()
RETURNS INT
BEGIN

    DECLARE var1,var2,var3 INT DEFAULT 0;

    SELECT MIN(est.edad)
        FROM estudiantes as est into var1;
        RETURN var1;
    END;

SELECT edad_min(); #edad minima es 20



CREATE OR REPLACE FUNCTION gen_par_con_funcMin()
RETURNS TEXT
BEGIN

    DECLARE var1,var2,var3,var4,var5 INT DEFAULT 0;
    DECLARE a,b,c TEXT DEFAULT '';
    SET var2 = edad_min();
    SET var3 = (edad_min() = 0);

    IF var2 MOD(2) = 0 THEN

        WHILE (var5 <= var2)DO
            SET a = CONCAT(a,var5,',');
            SET var5 = var5 + 2;
            END WHILE;
        ELSE WHILE (var2 >= 0)DO

            SET a = CONCAT(a,var2,',');
            SET var2 = var2 -2;
            end while;
    END IF;
        return a;
    END;

SELECT gen_par_con_funcMin();




CREATE OR REPLACE FUNCTION separar_vocales(cadena TEXT)
RETURNS TEXT
BEGIN

    DECLARE letter_a, letter_e, letter_i, letter_o, letter_u INT DEFAULT 0;
    DECLARE b,c,d INT DEFAULT 1;
    DECLARE text1,text2,text3, resp TEXT DEFAULT '';

    WHILE b <= char_length(cadena) DO

        SET text1 = substring(cadena, b, 1);
        IF text1 = 'a' THEN
            SET letter_a = letter_a+1;
        end if;
        IF text1 = 'e' THEN
            SET letter_e = letter_e+1;
        end if;
        IF text1 = 'i' THEN
            SET letter_i = letter_i+1;
        end if;
        IF text1 = 'o' THEN
            SET letter_o = letter_o+1;
        end if;
        IF text1 = 'u' THEN
            SET letter_u = letter_u+1;
        end if;
        SET b = b+1;
    end while;

    set resp = concat('a: ', letter_a, ', e: ', letter_e, ', i: ', letter_i,', o: ', letter_o, ', u: ', letter_u);
    return resp;

end;

select separar_vocales('Hola mundo');




CREATE OR REPLACE FUNCTION plat_sil_gold(num1 INT)
RETURNS TEXT
BEGIN

    DECLARE resp TEXT DEFAULT '';

    CASE
        WHEN num1 > 50000 THEN
            SET resp = 'USTED ES PLATINIUM';

        WHEN num1 >= 10000 AND num1 <= 50000 THEN
            SET resp =  'USTED ES GOLD';

        WHEN num1 < 10000 THEN
            SET resp = 'USTED ES SILVER';

    END CASE;

    return resp;
end;


SELECT plat_sil_gold(-1);



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
            ELSE SET  a = CONCAT(a,cont);
        END CASE;
        SET d = d + 1;
        END WHILE;
    RETURN a;
END;

SELECT only_consonants('Hola como estan');


