#este codigo fue utilizado para realizar el video de la explicaion de la parte teorica

CREATE DATABASE marco_teorico;
USE marco_teorico;

CREATE TABLE estudiantes(

    nombre TEXT,
    edad INT,
    aula TEXT,
    id_est INT

);


INSERT INTO estudiantes(nombre, edad, aula, id_est)
VALUES ('Sergio',19,'aul-213',1),
('Andres',20,'aul-213',2),
 ('Jose',21,'aul-213',3),
 ('Mario',22,'aul-213',4);

SELECT * FROM estudiantes;


CREATE OR REPLACE FUNCTION edad_minima()
RETURNS TEXT
BEGIN

    DECLARE var1,var2,var3 TEXT;

    SET var1 = (SELECT MIN(est.edad) FROM estudiantes as est);

    RETURN var1;
END;

SELECT edad_minima();


# 1,2,3,4,5,

SELECT REPLACE('1,2,3,4,5,',',','');



CREATE OR REPLACE TRIGGER mantenimiento
    BEFORE INSERT
    ON estudiantes
    FOR EACH ROW
    BEGIN
        IF DAYNAME(current_date) = 'Wednesday' THEN

            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'MANTENIMIENTO DE MIERCOLES';

        end if;

        END;


INSERT INTO estudiantes(nombre, edad, aula, id_est) VALUES
                             ('pepe',23,'aul-214',6);


SELECT * FROM estudiantes;
