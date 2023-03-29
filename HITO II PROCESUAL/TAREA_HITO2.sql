CREATE DATABASE TareaHito2;
USE TareaHito2;

CREATE TABLE estudiantes(
id_est INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
nombres VARCHAR(50),
apellidos VARCHAR(50),
edad int,
gestion int,
fono int,
email VARCHAR(100),
direccion VARCHAR(100),
sexo VARCHAR(10)
);

CREATE TABLE inscripcion( #TABLA RELACIONAL
    id_ins INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    semestre VARCHAR(20),
    gestion int,
    id_est int,#se encuentra en la tabla estudiantes
    id_mat int, #se encuentra en la tabla materias
    FOREIGN KEY (id_est) REFERENCES estudiantes(id_est),
    FOREIGN KEY (id_mat) REFERENCES materias(id_mat)
);

CREATE TABLE materias(
    id_mat INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre_mat VARCHAR(100),
    cod_mat VARCHAR(100)
);


INSERT INTO estudiantes (nombres, apellidos, edad, fono, email,
direccion, sexo)
VALUES ('Miguel', 'Gonzales Veliz', 20, 2832115,
'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
('Sandra', 'Mavir Uria', 25, 2832116, 'sandra@gmail.com',
'Av. 6 de Agosto', 'femenino'),
('Joel', 'Adubiri Mondar', 30, 2832117, 'joel@gmail.com','Av. 6 de Agosto', 'masculino'),
('Andrea', 'Arias Ballesteros', 21, 2832118,
'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
('Santos', 'Montes Valenzuela', 24, 2832119,
'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura', 'ARQ-101'),
('Urbanismo y Diseno', 'ARQ-102'),
('Dibujo y Pintura Arquitectonico', 'ARQ-103'),
('Matematica discreta', 'ARQ-104'),
('Fisica Basica', 'ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion)
VALUES (1, 1, '1er Semestre', 2018),
(1, 2, '2do Semestre', 2018),
(2, 4, '1er Semestre', 2019),
(2, 3, '2do Semestre', 2019),
(3, 3, '2do Semestre', 2020),
(3, 1, '3er Semestre', 2020),
(4, 4, '4to Semestre', 2021),
(5, 5, '5to Semestre', 2021);



SELECT * FROM estudiantes;

SELECT * FROM materias;

SELECT * FROM inscripcion;

# Mostrar los nombres y apellidos de los estudiantes inscritos en la
#materia ARQ-105, adicionalmente mostrar el nombre de la materia.

SELECT est.id_est,est.nombres,est.apellidos,mat.nombre_mat,mat.cod_mat
    FROM estudiantes as est
INNER JOIN inscripcion as ins on est.id_est = ins.id_ins
INNER JOIN materias as mat on ins.id_ins = mat.id_mat

WHERE CompararMateria(mat.cod_mat,'ARQ-105');



CREATE OR REPLACE FUNCTION CompararMateria(
nombre varchar(30),
materia_1 VARCHAR(30)
)
    RETURNS VARCHAR(40)
    BEGIN
        DECLARE resp VARCHAR(200);
        DECLARE resp_1 BOOL DEFAULT  FALSE; #0
        IF nombre = materia_1 THEN SET resp_1 = TRUE;END IF;RETURN resp_1;

    END;


SELECT CompararMateria('ARQ-105','ARQ-105'); #true 1

#Crear una función que permita obtener el promedio de las edades del género
#masculino o femenino de los estudiantes inscritos en la asignatura ARQ-104.



#sacar promedio de edades del ARQ-104
CREATE OR REPLACE FUNCTION edad_prom(genero VARCHAR(30), materia VARCHAR(30))
RETURNS VARCHAR(200)
BEGIN
    DECLARE resp VARCHAR(200);
   SET resp = (SELECT CONCAT('EDAD PROMEDIO: ',AVG(est.edad)) as EDAD_PROMEDIO
        FROM estudiantes as est
INNER JOIN inscripcion as ins on est.id_est = ins.id_ins
INNER JOIN materias as mat on ins.id_ins = mat.id_mat
        WHERE est.sexo = genero AND mat.cod_mat = materia);RETURN resp;
end;

SELECT edad_prom('masculino','ARQ-104');
SELECT edad_prom('femenino','ARQ-104');

SELECT AVG(edad) FROM estudiantes;
SELECT * FROM estudiantes;




#Crear una función que permita concatenar 3 cadenas.


CREATE OR REPLACE FUNCTION concatenar_3_cadenas()
RETURNS VARCHAR(200)
BEGIN

    DECLARE resp,cadena1,cadena2,cadena3 VARCHAR(200);

   SET resp = (SELECT CONCAT(est.nombres,est.apellidos,est.edad) as EDAD_PROMEDIO
        FROM estudiantes as est
INNER JOIN inscripcion as ins on est.id_est = ins.id_ins
INNER JOIN materias as mat on ins.id_ins = mat.id_mat
        WHERE est.nombres = cadena1 AND est.apellidos = cadena2  AND est.edad = cadena3);
    RETURN resp;
END;
SELECT concatenar_3_cadenas();


#Crear la siguiente VISTA:

CREATE or replace VIEW DIA_LIBRE AS
SELECT concat(
est.nombres,
 ' ',
 est.apellidos
 )
 AS Fullname,
  concat(est.edad) AS Edad,concat( ins.gestion) AS Gestion, concat(
    CASE
        WHEN ins.gestion = 2021 THEN 'Libre' ELSE 'no libre'
    END
    ) AS Dia_Libre
    FROM estudiantes AS est
INNER JOIN inscripcion ins ON est.id_est = ins.id_est;

SELECT * from dia_libre;









