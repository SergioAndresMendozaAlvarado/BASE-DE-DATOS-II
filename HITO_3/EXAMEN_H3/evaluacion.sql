CREATE DATABASE defensa_hito3_2023;
USE defensa_hito3_2023;

CREATE OR REPLACE FUNCTION elimina_consonantes_y_numeros(cadena1 TEXT)
RETURNS TEXT
BEGIN

 DECLARE R TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 1;
    DECLARE Nveces TEXT DEFAULT 0;
    DECLARE con_p CHAR;
    DECLARE contar_A,contar_E,contar_I,contar_O,contar_U text DEFAULT '';

 WHILE cont <= char_length(cadena1) DO
        SET con_p = SUBSTR(cadena1,cont,1);
        CASE con_p
            WHEN 'a' THEN SET contar_A = 'A';
            WHEN 'e' THEN SET contar_E = 'E';
            WHEN 'i' THEN SET contar_I = 'I';
            WHEN 'o' THEN SET contar_O = 'O';
            WHEN 'u' THEN SET contar_U = 'U';
            ELSE SET  Nveces = 'no hay vocales';
        END CASE;
        SET cont = cont + 1;
        END WHILE;

    IF(contar_A != 0 || contar_E != 0 || contar_I != 0 || contar_O != 0 || contar_U != 0)THEN

    #   SET R = CONCAT('a:',contar_A,', e:',contar_E,', i:',contar_I,', o:',contar_O,', u:',contar_U);
        SET cadena1 = (SELECT CONCAT(contar_A,contar_E,contar_I,contar_O,contar_U));
        ELSE

        SET R = Nveces;
    END IF;

    RETURN cadena1;
END;DROP FUNCTION elimina_consonantes_y_numeros;

SELECT elimina_consonantes_y_numeros('Hola mundo 12');


CREATE FUNCTION con(cad1 TEXT)
RETURNS TEXT
BEGIN

    DECLARE a,e,i,o,u TEXT DEFAULT '';


    END;


CREATE TABLE clientes(

    id_client INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(20),
    last_name VARCHAR(20),
    age INT,
    genero CHAR(1) #M o F

);

INSERT INTO  clientes (fullname, last_name, age, genero)
VALUES ('Sergio','Mendoza',19,'M'),
       ('Jhonatan','Alanoca',21,'M'),
       ('Sara','Choque Amaru',24,'F');

CREATE OR REPLACE FUNCTION edad_min()
RETURNS INT
BEGIN

    DECLARE edad_min INT DEFAULT 0;
    SELECT MAX(cl.age)
        FROM clientes as cl into edad_min;
    RETURN edad_min;
end;

SELECT edad_min();

CREATE OR REPLACE FUNCTION pares_imapres_loop()
RETURNS INT
BEGIN
    DECLARE var TEXT DEFAULT '';
    DECLARE save INT DEFAULT 0;
    DECLARE max_age INT;
    SET max_age = edad_min();


    a:
    LOOP
        if edad_min() MOD(2) THEN
            LEAVE a;
        end if;
        IF edad_min() MOD(2) THEN
             SET var = CONCAT(var, edad_min(), ',');

        end if;
         SET save = edad_min() + 1;
    end loop;

RETURN save;
    END;

SELECT pares_imapres_loop();



CREATE OR REPLACE FUNCTION serieFibonacci(num1 INT)
RETURNS TEXT
BEGIN
    DECLARE num_1 INT DEFAULT 1;
    DECLARE n2,n3,contador INT DEFAULT 0;
    DECLARE resp TEXT DEFAULT '';


    WHILE (num1 > contador) DO
        SET resp = CONCAT(resp,n3,',');
        SET n3 = num_1 + n2;
        SET num_1 = n2;
        SET n2 = n3;
        SET contador = contador + 1;
    END WHILE;
    RETURN resp;
END;

SELECT serieFibonacci(7);

CREATE FUNCTION change_name(cad_com TEXT,cad_to_change TEXT,cad_to_replace TEXT)
RETURNS TEXT
BEGIN

    DECLARE a,b,c TEXT;
    SET a = (SELECT LOCATE(cad_to_change, cad_com));

    RETURN a;
    END;

SELECT change_name('Bienvenidos a Unifranz, Unifranz tiene 10 carreras','Unifranz','univalle');




CREATE OR REPLACE FUNCTION reemplaza_palabra(cad_com TEXT, cad_to_change TEXT, cad_to_replace TEXT)
RETURNS TEXT
BEGIN

  DECLARE resultado TEXT DEFAULT '';
  DECLARE a,b,c INT DEFAULT 1;
  DECLARE cad_com_11,cad_change_11 INT DEFAULT 0;

  SET cad_com_11 = CHAR_LENGTH(cad_com);
  SET cad_change_11 = CHAR_LENGTH(cad_to_change);

  WHILE a <= cad_com_11 DO
    IF SUBSTRING(cad_com, a, cad_change_11) = cad_to_change THEN
      SET resultado = CONCAT(resultado, cad_to_replace, ''); #AND a = a + cad_change_11;
      SET a = a + cad_change_11;
    ELSE
      SET resultado = CONCAT(resultado, SUBSTRING(cad_com, a, 1));
      SET a = a + 1;
    END IF;
  END WHILE;

  RETURN resultado;
END;

SELECT reemplaza_palabra('Bienvenidos a Unifranz, Unifranz tiene 10 carreras','Unifranz','Univalle');


CREATE function reve(cad1 TEXT)
RETURNS TEXT
BEGIN

    DECLARE a TEXT;
    SET a = (SELECT REVERSE(cad1));
    RETURN a;
    END;

SELECT reve('Holaa');



CREATE OR REPLACE FUNCTION _v2(cad TEXT)
RETURNS TEXT
BEGIN

  DECLARE tam, a,b,c INT DEFAULT 0;
  DECLARE resp TEXT DEFAULT '';

  SET tam = CHAR_LENGTH(cad);
    lopp_11:
        LOOP
        if a <= tam THEN
            LEAVE lopp_11;


        end if;
          SET resp = (SELECT CONCAT(SUBSTRING(cad, a+1, 1), resp));
        SET a = a + 1;
    end loop;


  RETURN resp;
END;

SELECT _v2('Hola');
