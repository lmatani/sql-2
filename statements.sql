/* Relación tipo 1:1 */
-- PASO 1
-- CREO UN SCHEMA 
CREATE SCHEMA 'test2';

CREATE TABLE test2.usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    edad INT
);

INSERT INTO test2.usuarios (nombre, apellido, email, edad) VALUES
('Juan', 'Gomez', 'juan.gomez@example.com', 28),
('Maria', 'Lopez', 'maria.lopez@example.com', 32),
('Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', 25),
('Laura', 'Fernandez', 'laura.fernandez@example.com', 30),
('Pedro', 'Martinez', 'pedro.martinez@example.com', 22),
('Ana', 'Hernandez', 'ana.hernandez@example.com', 35),
('Miguel', 'Perez', 'miguel.perez@example.com', 28),
('Sofia', 'Garcia', 'sofia.garcia@example.com', 26),
('Javier', 'Diaz', 'javier.diaz@example.com', 31),
('Luis', 'Sanchez', 'luis.sanchez@example.com', 27),
('Elena', 'Moreno', 'elena.moreno@example.com', 29),
('Daniel', 'Romero', 'daniel.romero@example.com', 33),
('Paula', 'Torres', 'paula.torres@example.com', 24),
('Alejandro', 'Ruiz', 'alejandro.ruiz@example.com', 28),
('Carmen', 'Vega', 'carmen.vega@example.com', 29),
('Adrian', 'Molina', 'adrian.molina@example.com', 34),
('Isabel', 'Gutierrez', 'isabel.gutierrez@example.com', 26),
('Hector', 'Ortega', 'hector.ortega@example.com', 30),
('Raquel', 'Serrano', 'raquel.serrano@example.com', 32),
('Alberto', 'Reyes', 'alberto.reyes@example.com', 28);

-- PASO 2
CREATE TABLE test2.roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL
);

INSERT INTO test2.roles (nombre_rol) VALUES
('Bronce'),
('Plata'),
('Oro'),
('Platino');


-- PASO 3
ALTER TABLE test2.usuarios ADD COLUMN id_rol INT;
ALTER TABLE test2.usuarios ADD FOREIGN KEY (id_rol) REFERENCES test2.roles(id_rol);

-- actualizo a 1 los que terminan en 'ez', a 2 los que terminan en 'o' y a 3 los que terminan en 'a'
UPDATE test2.usuarios SET id_rol = 1 WHERE apellido like '%ez';
UPDATE test2.usuarios SET id_rol = 2 WHERE apellido like '%o';
UPDATE test2.usuarios SET id_rol = 3 WHERE apellido like '%a';
-- actualizo el resto a 4
UPDATE test2.usuarios SET id_rol = 4 WHERE id_rol IS NULL;

-- PASO 4 (JOIN)
SELECT usuarios.id_usuario AS ID
	 , usuarios.nombre AS NOMBRE
	 , usuarios.apellido AS APELLIDO
     , usuarios.email AS EMAIL
     , usuarios.edad AS EDAD
     , roles.nombre_rol AS ROL
FROM test2.usuarios as usuarios
JOIN test2.roles as roles on usuarios.id_rol = roles.id_rol;



/* Relación tipo 1:N */
-- PASO 1
CREATE TABLE test2.categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

-- Insertar datos de categorías
INSERT INTO test2.categorias (nombre_categoria) VALUES
('Electrónicos'),
('Ropa y Accesorios'),
('Libros'),
('Hogar y Cocina'),
('Deportes y aire libre'),
('Salud y cuidado personal'),
('Herramientas y mejoras para el hogar'),
('Juguetes y juegos'),
('Automotriz'),
('Música y Películas');

-- PASO 2
ALTER TABLE test2.usuarios ADD COLUMN id_categoria INT;
ALTER TABLE test2.usuarios ADD FOREIGN KEY (id_categoria) REFERENCES test2.categorias (id_categoria);

-- PASO 3

UPDATE test2.usuarios SET id_categoria = 1 WHERE nombre like 'J%';
UPDATE test2.usuarios SET id_categoria = 2 WHERE nombre like 'M%';
UPDATE test2.usuarios SET id_categoria = 3 WHERE nombre like 'C%';
UPDATE test2.usuarios SET id_categoria = 4 WHERE nombre like 'L%';
UPDATE test2.usuarios SET id_categoria = 5 WHERE nombre like 'P%';
UPDATE test2.usuarios SET id_categoria = 6 WHERE nombre like 'S%';
UPDATE test2.usuarios SET id_categoria = 7 WHERE nombre like 'E%';
UPDATE test2.usuarios SET id_categoria = 8 WHERE nombre like 'D%';
UPDATE test2.usuarios SET id_categoria = 9 WHERE nombre like 'A%';
-- actualizo el resto
UPDATE test2.usuarios SET id_categoria = 10 WHERE id_categoria IS NULL;


-- PASO 4
SELECT usuarios.id_usuario AS ID
	 , usuarios.nombre AS NOMBRE
	 , usuarios.apellido AS APELLIDO
     , usuarios.email AS EMAIL
     , usuarios.edad AS EDAD
     , roles.nombre_rol AS ROL
     , categorias.nombre_categoria as CATEGORIA
FROM test2.usuarios as usuarios
JOIN test2.roles as roles on usuarios.id_rol = roles.id_rol
JOIN test2.categorias as categorias on usuarios.id_categoria = categorias.id_categoria;

/* Relación tipo N:M */
-- PASO 1
CREATE TABLE test2.usuarios_categorias (
    id_usuario_categoria INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_categoria INT NOT NULL
);

ALTER TABLE test2.usuarios_categorias ADD FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);
ALTER TABLE test2.usuarios_categorias ADD FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria);


-- PASO 2
INSERT INTO test2.usuarios_categorias (id_usuario, id_categoria) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 8), (4, 9), (4, 10);


-- PASO 3
SELECT usuarios.id_usuario AS ID
	 , usuarios.nombre AS NOMBRE
	 , usuarios.apellido AS APELLIDO
     , usuarios.email AS EMAIL
     , usuarios.edad AS EDAD
     , roles.nombre_rol AS ROL
     , categorias.nombre_categoria as CATEGORIA
FROM test2.usuarios AS usuarios
JOIN test2.roles AS roles ON usuarios.id_rol = roles.id_rol
JOIN test2.usuarios_categorias AS usu_cat ON usuarios.id_categoria = usu_cat.id_categoria 
JOIN test2.categorias AS categorias ON categorias.id_categoria = usu_cat.id_categoria;

