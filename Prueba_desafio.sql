--Crear Base de datos

create database prueba_desafio;

--Creación de tablas de contenido

CREATE TABLE Peliculas (
    id integer, 
    nombre varchar(255), 
    anno integer, PRIMARY KEY (“id”));

CREATE TABLE Tags (
    id integer, 
    tag varchar(32), 
    PRIMARY KEY (“id”));

-- Creación de tabal relacional

CREATE TABLE PeliculasTags (
    Peliculas_id integer, 
    Tags_id integer, 
    foreign KEY (Peliculas_id) REFERENCES Peliculas (id),
    foreign KEY (Tags_id) REFERENCES Tags(id));

-- insertar contenido en las tablas

insert into Peliculas (id, nombre, anno) values 
    (1, 'Terror en Amityville', 1979),
    (2, 'El Exorsista', 1973),
    (3, 'Psicosis', 1960),
    (4, 'La isla Misteriosa', 2010),
    (5, 'Gremlins', 1984);

insert into Tags (id, tag) values 
    (1, 'Terror'),
    (2, 'Suspenso'),
    (3, 'Drama'),
    (4, 'Animacion'),
    (5, 'Comedia');

--indicar que la primera pelicula tenga 3 tags y la segunda pelicula tenga 2 tags

insert into PeliculasTags values
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 2),
    (3, null),
    (4, null),
    (5, null);

--Contar cantidad de tags por pelicula

select p.nombre, count(pt.tags_id) as "cantidad tags"
from peliculas p
left join PeliculasTags pt on p.id = pt.peliculas_id
group by p.id
order by "cantidad tags" desc;