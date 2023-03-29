CREATE DATABASE ejemplo;

USE ejemplo;

CREATE TABLE usu(
  id_usu INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user VARCHAR(20) NOT NULL,
  pass VARCHAR(20) NOT NULL,
  nacionalidad VARCHAR(20) NOT NULL
);



CREATE TABLE relacion(
    id_relacion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_usu INT,
    FOREIGN KEY (id_usu) REFERENCES usu(id_usu)
);

SELECT AVG(id_usu) as 'BigValor'
from relacion;

SELECT * FROM relacion;

INSERT INTO relacion(id_usu) values
                                 (1),(2),(3);

INSERT INTO usu(user, pass,nacionalidad)
VALUES('Sergio7843','mendoza123','Bolivia'),('Jose','manuel23','Peruano'),('Miguel','Fernando12','Colombiano'),
      ('Anna','Maria743','Bolivia');


SELECT * FROM usu;
SELECT * FROM relacion;

SELECT os.user,os.nacionalidad,os.id_usu
    FROM relacion as rel
INNER JOIN usu as os ON rel.id_usu = os.id_usu
WHERE OS.nacionalidad = 'Peruano';

SELECT * FROM usu;
SELECT * FROM usu WHERE nacionalidad = 'Bolivia';


CREATE OR REPLACE FUNCTION numer() #para valorees numericos
    RETURNS INT
    BEGIN
        RETURN 24;
    END;


drop function numer;

select  numer();



