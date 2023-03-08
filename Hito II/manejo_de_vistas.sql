CREATE DATABASE Hito_2;
USE Hito_2;

CREATE TABLE usuarios(
    is_usuarios INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellido VARCHAR(50)NOT NULL,
    edad INT NOT NULL,
    email VARCHAR(100)NOT NULL
);

INSERT INTO usuarios(nombres, apellido, edad, email)
VALUES ('nombres1','apellidos1',20,'nombre1@gmail.com'),
       ('nombres2','apellido2',30,'nombre2@gmail.com'),
       ('nombres3','apellido3',40,'nombre3@gmail.com');

select * from usuarios;

#Esta es una vista, son tablas virtuales, no se guardan en disco
#porque solo es una consulta SQL
CREATE VIEW mayores_A_30 as
SELECT * FROM usuarios WHERE edad>30;


#para cambiar datos de una vista:
ALTER VIEW mayores_A_30 as
    SELECT user.nombres,user.apellido,user.edad,user.email
        FROM usuarios as user
            WHERE user.edad >30;


ALTER VIEW mayores_A_30 as
    SELECT CONCAT(user.nombres,user.apellido)as 'FULLNAME',
           user.edad as 'EDAD_USUARIO',
           user.email AS 'EMAIL_USUARIO'
         FROM usuarios as user
            WHERE user.edad >30;

SELECT m30.FULLNAME,
       m30.EDAD_USUARIO,
       m30.EMAIL_USUARIO
FROM mayores_A_30 as M30 WHERE m30.FULLNAME LIKE '%3';



ALTER VIEW mayores_A_30 as
    SELECT user.nombres,
           user.apellido,
           user.edad,
           user.email
        FROM usuarios as user
            WHERE user.apellido LIKE '%3';




SELECT * FROM mayores_A_30;

