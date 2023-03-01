SHOW DATABASES;

CREATE DATABASE hito_2;
USE hito_2;
CREATE TABLE students(
    nombre VARCHAR(50) NOT NULL,
    codigo VARCHAR(50)NOT NULL,
    Titulo VARCHAR(20)NOT NULL
);

insert into students values('Sergio Mendoza','SIS9908488','SISTEMAS');
SELECT * FROM students;

DROP DATABASE hito_2;


CREATE DATABASE universidad;
USE universidad;

CREATE TABLE students(
  id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  nombres VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  edad INT NOT NULL,
  phone INT NOT NULL,
  email VARCHAR(100) NOT NULL
);

DESCRIBE students;

INSERT INTO students(nombres,apellidos,edad,phone,email)
VALUES('Nombre1','Apellido1',10,111111,'usu1@gmail.com'),
      ('Nombre2','Apellido2',20,111111,'usu2@gmail.com'),
      ('Nombre3','Apellido3',10,111111,'usu3@gmail.com');

SELECT * FROM students;

ALTER TABLE students ADD COLUMN direccion VARCHAR(200)
    NOT NULL DEFAULT 'El Alto';

ALTER TABLE students DROP COLUMN direccion;