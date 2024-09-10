-- crear tablas usuario, preguntas y respuestas

CREATE TABLE Usuarios (
    id integer,
    nombre varchar(255),
    edad integer,
    primary key (id));

CREATE TABLE Preguntas (
    id integer,
    pregunta varchar(255),
    respuesta_correcta varchar,
    primary key (id));

CREATE TABLE Respuestas (
    id integer,
    respuesta varchar (255),
    usuarios_id integer,
    preguntas_id integer,
    primary key (id),
    foreign key (usuarios_id) references Usuarios(id),
    foreign key (preguntas_id) references Preguntas(id));

--Insertar Contenido en las tablas

insert into Usuarios (id, nombre, edad) values 
    (1, 'Carlos', 45),
    (2, 'Cristobal', 23),
    (3, 'Luz Maria', 27),
    (4, 'Allen', 34),
    (5, 'Melany', 33);


insert into Preguntas (id, pregunta, respuesta_correcta) values 
    (1, '¿La Tierra es plana?', 'No'),
    (2, '¿Cuantos pares son 3 moscas?', '3'),
    (3, '¿Los cangrejos son inmortales?', 'Si'),
    (4, '¿La vida es cruel?', 'depende de quien la viva'),
    (5, '¿Ya no se que preguntar?', 'Si');


insert into Respuestas (id, respuesta, usuarios_id, preguntas_id) values
    (1, 'No', 1, 1),
    (2, 'No', 2, 1),
    (3, '3', 1, 2),
    (4, 'No', 3, 3),
    (5, 'No se que responder', 4, 4),
    (6, 'No', 5, 5);

-- ¿Cuantos usuarios respondieron correctamente?

select u.nombre, count(r.id) as "respuestas correctas"
from Usuarios u
join Respuestas r on u.id = r.usuarios_id
join Preguntas p on r.preguntas_id = p.id
where r.respuesta = p.respuesta_correcta
group by u.id;

-- conteo por de usuarios con repsuestas correctas, el "case when" lo utilizaremos para evaluar la condiciones de
-- respuestas correctas, si la condiciones es verdadera contara como 1 de lo contrario se devuelve null que se refleja 
-- como 0, y como se antepone el "count" este contara los resultados para expresarlos en la tabla.

select u.nombre, count(case when r.respuesta = p.respuesta_correcta then 1 else null end) as "respuestas correctas"
from Usuarios u
left join Respuestas r on U.id = r.usuarios_id
left join Preguntas p on r.preguntas_id = p.id
group by u.nombre
order by "respuestas correctas" desc;

--Por cada pregunta, en la tabla preguntas,cuenta cuántos usuarios respondieron correctamente

select p.pregunta, count(r.id) as "usuarios correctos"
from Preguntas p
left join Respuestas r on p.id = r.preguntas_id and r.respuesta = p.respuesta_correcta
group by p.id, p.pregunta
order by "usuarios correctos" desc;


--Implementa un borrado en cascada de las respuestas al borrar un usuario.

select * from Respuestas;
select * from Usuarios;

--consultar en sql shell \d Respuestas para identificar la tabla relacionada a borrar

alter table Respuestas drop constraint respuestas_usuarios_id_fkey,
add foreign key (usuarios_id) references usuarios(id) on delete cascade;

delete from Usuarios where id = 1;

-- Crea una restricción que impida insertar usuarios menores de 18 año sen la base de datos

alter table usuarios add constraint restriccion_edad check (edad >= 18);

insert into usuarios values (6, 'iñigo', 17);


--Altera la tabla existente de usuarios agregando el campo email. Debe tener la restricción de ser único

alter table usuarios add column email varchar(100) unique;

select* from usuarios;