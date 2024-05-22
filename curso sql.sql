
---- Crear una base de datos

CREATE DATABASE proyecto;




---- Crear tabalas dentro de la BD. se pueden hacer de hartas a la vez

CREATE TABLE productos (
    id_producto INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (Id_producto),
    nombre VARCHAR(150),
    precio int
);

CREATE TABLE clientes (
	id_cliente INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id_cliente),
    nombre VARCHAR (100),
    apellido VARCHAR (100),
    edad int,
    telefono int
);

CREATE TABLE pedidos (
	id_pedido INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id_pedido),
    fecha DATE,
    cantidad INT,
    id_cliente INT,
    id_producto INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);





---- eliminar base de datos
DROP DATABASE dos

---- eliminar tabla
DROP TABLE proyectos


---- eliminar columna
ALTER TABLE usuario DROP COLUMN edad


---- agregar columna
ALTER TABLE usuario ADD COLUMN (direccion VARCHAR(20))






---- insertar 1 ´por 1 LOS REGISTROS
INSERT INTO clientes (nombre, apellido, edad, telefono) VALUES('ALEX','GONZALEZ', '29', '7026698') 

---- el id aunque se rellena solo, si lo pongo, no pasa nada 
INSERT INTO clientes (id_cliente, nombre, apellido, edad, telefono) VALUES('2','YONEY','MENDEZ', '24', '77777777') 


---- de a hartos a la vez, separando con ;
INSERT INTO clientes (nombre, apellido, edad, telefono) VALUES('MARIA','FERNANDEZ', '34', '6666666') ;
INSERT INTO clientes (nombre, apellido, edad, telefono) VALUES('TERESA','SARMIENTO', '30', '9099909') ;






---- de phpmyadmin puedo cargar mas facil en "import". acá igual está el código.

LOAD DATA LOCAL INFILE 'C:/Users/leona/Desktop/SQL/SQL_pedido.csv'
INTO TABLE clientes
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'               // el \n quiere decir "salto de linea", AVECES, la bd pude estar escrita entera en una sola fila con un '%' u otro symbolo que indica el salto de fila
(nombre, apellido, edad, telefono);




---- EXPORTAR DATOS

SELECT * FROM clientes   // EL '*' SIGNIFICA "TODO" O SEA SELECIONAR TODO
INTO OUTFILE 'C:/Users/leona/Desktop/SQL/MIS-CLIENTRES.csv'

FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n\r';  






---- MODIFICAR UN ELEMENTE DE UN REGISTRO. EN ESTE CASO EL TELEFONO DEL PRIMERO
UPDATE clientes SET telefono ='55555555' WHERE id_cliente=1     // OJO ES SUPER IMPORTATNTE PONER EL WHERE. PORQ O SI NO ME VA A MODIFICAR TODOS LOS VALORES DE LA COLUMNA 'TELEFONO'


---- CON "BTEWEEN", PODEMOS MODIFICAR UN RANGO DE LA TABLA
UPDATE clientes SET telefono ='69696969' WHERE id_cliente BETWEEN 5 AND 10





---- ELIMINAR TODOS LOS REGISTROS DE UNA TABLA
DELETE FROM productos


---- ELIMINAR SOLO UN REGISTRO DE UNA TABLA
DELETE FROM productos WHERE id_producto = 1






---- CONSULTAS(QUERY) O SELECT (CON LAS QUE MAS SE HACEN)

---- DENTRO DE SELECT HAY DIFERENTES FUNCIONES:

----ORDENAMIENTO
----AGREGACION
----AGRUPAMIENTO
----UNIONES O COMPOSICIÓN



---- Mostrar una tabala entera de la basde de datos
SELECT * FROM clientes

---- Seleccionar solamente una columna
SELECT nombre FROM clientes


----- Selecionar varias columnas. Se va separando con coma
SELECT nombre,apellido FROM clientes


----- Seleccionar exclusivamente un nombre. tambien puede ser solamente un telefono, apellido, etc. (una busqueda exclusiva)
SELECT * FROM clientes WHERE nombre='ALEX'


---- Seleccionar doble condición. usando el operador AND
SELECT * FROM clientes WHERE nombre='ALEX' AND apellido='GONZALEZ'


---- MOSTRAR si cumple cualquiera de las condiciones. las separo por OR
SELECT * FROM clientes WHERE nombre='ALEX' OR apellido='GONZALEZ'
SELECT * FROM clientes WHERE apellido='PIT' OR edad='30'




---- Selecionar valores con condicion mayor que >
SELECT * FROM clientes WHERE id_cliente >15

---- Mayor o igual
SELECT * FROM clientes WHERE id_cliente >=15

---- Menor que
SELECT * FROM clientes WHERE id_cliente < 15

---- los diferentes a. <> o usando !=
SELECT * FROM clientes WHERE id_cliente <> 15
SELECT * FROM clientes WHERE id_cliente != 15

---- ACA ME MUESTRA LOS ENTRE. USANDO "BETWEEN"
SELECT * FROM clientes WHERE id_cliente BETWEEN 5 AND 10


----- BUSCAR SOLAMENTE LOS QUE ME EMPIEZAN POR UN VALOR DETERMINADO
SELECT * FROM clientes WHERE nombre LIKE 'M%'


---- SI QUEIERO BUSCAR LOS QUE TERMINAN, PONGO LA LETRA AL OTRO LADO DEL %
SELECT * FROM clientes WHERE nombre LIKE '%A'


---- Concatenar valores en la busqueda. concatenar se hace usando 'in'
SELECT * FROM clientes WHERE id_cliente in (1,3,5,7)





---- FUNCIONES DE ORDENAMIENTO

---- Order by
---- ASC
---- DESC



----- QUE ME MUESTRE ORDENADO ALFABETICAMENTE, Y ADEMAS LOS PRIMEROS 10 REGISTROS
SELECT * FROM clientes WHERE id_cliente < 10 ORDER BY nombre

---- QUE SE ASCENDENTE . 'ASC'. POR DEFECTO VIENE ASCENDENTE
SELECT * FROM clientes WHERE id_cliente < 10 ORDER BY nombre ASC

---- DESCENDENTE. 'DESC'
SELECT * FROM clientes WHERE id_cliente < 10 ORDER BY nombre DESC







----- FUNCIONES DE AGREGACIÓN----
----- COUNT
----- SUMA
----- MAX
----- MIN
----- Avg


---- COUNT . Que me cuente cuantos se llaman YONEY
SELECT COUNT(*) AS nombre FROM clientes WHERE nombre ='YONEY'


---- Sumar toda la  columna edad
SELECT SUM(edad) AS edad FROM clientes



---- Sumar con condicion
SELECT SUM(edad) AS edad FROM clientes WHERE Id_cliente=1

---- Edad Máxima
SELECT MAX(edad) AS edad FROM clientes


---- promedio de la edad de los clientes
SELECT AVG(edad) AS edad FROM clientes






----- FUNCIONES DE AGRUPAMIENTO
----GROUP BY


---- Hacer una cuenta agrupada. me va imprimir una tabla ordenada por nombre con la cuenta de cuanto se repite cada uno.
SELECT nombre, COUNT(*) FROM clientes GROUP BY nombre






----- FUNCIONES DE UNIONES

----- INNER JOIN
----- LEFT JOIN
----- RIGHT JOIN


--- primero insertar valores a la tabla pedido

INSERT INTO pedidos (fecha, cantidad, id_cliente, id_producto) VALUES ('2020-02-10','2','1','2');
INSERT INTO pedidos (fecha, cantidad, id_cliente, id_producto) VALUES ('2020-02-11','5','2','5');
INSERT INTO pedidos (fecha, cantidad, id_cliente, id_producto) VALUES ('2020-02-12','1','1','3');
INSERT INTO pedidos (fecha, cantidad, id_cliente, id_producto) VALUES ('2020-02-13','3','8','9');
INSERT INTO pedidos (fecha, cantidad, id_cliente, id_producto) VALUES ('2020-02-14','2','1','4');
INSERT INTO pedidos (fecha, cantidad, id_cliente, id_producto) VALUES ('2020-02-15','4','4','1');



---- ACA PUEDO RELACIONAR TABLAS
---- EN ESTE CASO RELACIONO LOS REGISTROS DE LA TABAL CLIENTES CON LA TABLA PEDIDOS UNIDOS POR LA LLAVE ID




----INNER JOIN

SELECT * FROM clientes INNER JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente


---- Solamente nombre e ID_ producto. Como sacamos el * nos muestra todas las columnas
SELECT nombre,id_producto FROM clientes INNER JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente


--- ACA LE DECIMOS QUE NOS MUESTRE SOLO 3 COLUMNAS, PERO CON UNA CONDICION DE QUE CUANDO SEA CANTIDAD MAYOR A 4
SELECT nombre, cantidad, id_producto FROM clientes INNER JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente WHERE cantidad >4







---- LEFT JOIN ---- Toma todos los clientes (tabla izquierda) y le dice sus respectivos pedidos
SELECT * FROM clientes LEFT JOIN pedidos ON clientes.id_cliente = pedidos.id_pedido



---- RIGHT JOIN ---- Toma todos los pedidos(tabla derecha) y le dice su respectivo cliente que ejecuto la orden
SELECT * FROM clientes RIGHT JOIN pedidos ON clientes.id_cliente = pedidos.id_pedido











