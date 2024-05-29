DROP DATABASE IF EXISTS peliculas_clase_1;

CREATE DATABASE peliculas_clase_1;

USE peliculas_clase_1;

CREATE TABLE peliculas (
    id      INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    titulo  VARCHAR(500) NOT NULL,
    anio    INT UNSIGNED NOT NULL
    -- ,rating  TINYINT UNSIGNED NOT NULL
);

CREATE TABLE actores (
    id          INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre      VARCHAR(100) NOT NULL,
    apellido    VARCHAR(100) NOT NULL
);

INSERT INTO peliculas (titulo, anio) VALUES 
('Avatar', 2009),
('Titanic', 1997),
('La Guerra de las galaxias: Episodio VI', 1983),
('La Guerra de las galaxias: Episodio VII', 2015),
('Parque Jurasico', 1993),
('Harry Potter y las Reliquias de la Muerte - Parte 2', 2011),
('Transformers: el lado oscuro de la luna', 2011),
('Harry Potter y la piedra filosofal', 2001),
('Harry Potter y la cámara de los secretos', 2001),
('El rey león', 2001),
('Alicia en el país de las maravillas', 2010),
('Buscando a Nemo', 2010),
('Toy Story', 1995),
('Toy Story 2', 1999),
('Toy Story 3', 2010)
;

INSERT INTO actores (nombre, apellido) VALUES
('Sam', 'Worthington'),
('Zoe', 'Saldana'),
('Sigourney', 'Weaver'),
('Leonardo', 'Di Caprio'),
('Kate', 'Winslet'),
('Billy', 'Zane'),
('Mark', 'Hamill'),
('Harrison', 'Ford'),
('Carrie', 'Fisher'),
('Sam', 'Neill'),
('Laura', 'Dern'),
('Jeff', 'Goldblum'),
('Daniel', 'Radcliffe'),
('Emma', 'Watson'),
('Rupert', 'Grint'),
('Shia', 'LaBeouf'),
('Rosie', 'Huntington-Whiteley'),
('Matthew', 'Broderick'),
('James', 'Earl Jones'),
('Jeremy', 'Irons'),
('Johnny', 'Depp'),
('Helena', 'Bonham Carter'),
('Mia', 'Wasikowska'),
('Albert', 'Brooks'),
('Ellen', 'DeGeneres'),
('Alexander', 'Gould'),
('Tom', 'Hanks'),
('Tim', 'Allen'),
('Mark', 'Ruffalo')
;


