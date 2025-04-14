-- Ejemplos de subconsultas
-- 1.	Obtener estudiantes que tienen un promedio superior al promedio 
SELECT Estudiantes.estudiante_id, Estudiantes.nombre, Estudiantes.apellido, AVG(Historial_Academico.calificacion) AS promedio_estudiante
FROM Estudiantes
JOIN Historial_Academico ON Estudiantes.estudiante_id = Historial_Academico.estudiante_id
GROUP BY Estudiantes.estudiante_id, Estudiantes.nombre, Estudiantes.apellido
HAVING AVG(Historial_Academico.calificacion) > (SELECT AVG(calificacion) FROM Historial_Academico);


-- 2.	Cursos que nunca han sido asignados a un profesor 
SELECT Cursos.curso_id, Cursos.nombre
FROM Cursos 
WHERE Cursos.curso_id NOT IN (
    SELECT DISTINCT Horarios_Cursos.curso_id
    FROM Horarios_Cursos
    JOIN Asignacion_Profesores ON Horarios_Cursos.horario_id = Asignacion_Profesores.horario_id
);


-- 3.	Estudiantes con mejor promedio que el de su carrera
SELECT Estudiantes.estudiante_id, Estudiantes.nombre, Estudiantes.apellido, AVG(Historial_Academico.calificacion) AS promedio_estudiante
FROM Estudiantes
JOIN Historial_Academico ON Estudiantes.estudiante_id = Historial_Academico.estudiante_id
JOIN Matriculas ON Estudiantes.estudiante_id = Matriculas.estudiante_id
GROUP BY Estudiantes.estudiante_id, Estudiantes.nombre, Estudiantes.apellido, Matriculas.carrera_id
HAVING AVG(Historial_Academico.calificacion) > (
    SELECT AVG(Historial_Academico.calificacion)
    FROM Historial_Academico
    JOIN Matriculas ON Historial_Academico.estudiante_id = Matriculas.estudiante_id
    WHERE Matriculas.carrera_id = Matriculas.carrera_id 
);


-- 4.	Profesores con cantidad de cursos asignados
SELECT Profesores.profesor_id, Profesores.nombre, Profesores.apellido, COUNT(DISTINCT Horarios_Cursos.curso_id) AS cursos_asignados
FROM Profesores
JOIN Asignacion_Profesores ON Profesores.profesor_id = Asignacion_Profesores.profesor_id
JOIN Horarios_Cursos ON Asignacion_Profesores.horario_id = Horarios_Cursos.horario_id
GROUP BY Profesores.profesor_id, Profesores.nombre, Profesores.apellido;



-- 5.	Estudiantes que nunca han reprobado un curso
SELECT Estudiantes.estudiante_id, Estudiantes.nombre, Estudiantes.apellido
FROM estudiantes
WHERE NOT EXISTS (
    SELECT 1
    FROM Historial_Academico
    WHERE Historial_Academico.estudiante_id = Estudiantes.estudiante_id AND Historial_Academico.estado = 'reprobado'
);


-- 6.	Cursos obligatorios no aprobados por un estudiante
SELECT Cursos.curso_id, Cursos.nombre AS Nombre_Curso
FROM Cursos
WHERE Cursos.tipo = 'obligatorio'
AND Cursos.curso_id NOT IN (
    SELECT historial_academico.curso_id
    FROM historial_academico
    WHERE historial_academico.estudiante_id = 1 AND historial_academico.estado = 'aprobado' -- Cambia el ID del estudiante según sea necesario
);





