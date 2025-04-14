<?php
require_once '../config/conexion.php'; // Asegúrate de que este archivo contiene tu conexión a la base de datos

// Función para ejecutar consultas y devolver resultados
function ejecutarConsulta($conn, $query) {
    $result = $conn->query($query);
    if ($result->num_rows > 0) {
        echo "<table class='table table-bordered'><thead><tr>";
        // Mostrar encabezados
        while ($field = $result->fetch_field()) {
            echo "<th>" . htmlspecialchars($field->name) . "</th>";
        }
        echo "</tr></thead><tbody>";
        // Mostrar filas
        while ($row = $result->fetch_assoc()) {
            echo "<tr>";
            foreach ($row as $value) {
                echo "<td>" . htmlspecialchars($value) . "</td>";
            }
            echo "</tr>";
        }
        echo "</tbody></table>";
    } else {
        echo "<p>No se encontraron resultados.</p>";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Subconsultas</title>
        <link rel="icon" type="image/x-icon" href="../assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
        <style>
            .hidden {
                display: none;
            }
        </style>
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="../index.php">LOS FOO 🤡</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../index.php">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../Procedimientos/Procedimientos.php">Procedimientos</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../subconsultas/subconsultas.php">Subconsultas</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../disparadores/disparadores.php">Disparadores</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="auditorias.php">Auditorias</a></li>
                    </ul>
            </div>
        </nav>
        <!-- Page Header-->
        <header class="masthead" style="background-image: url('../assets/img/home-bg.jpg')">
            <div class="container position-relative px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <div class="site-heading">
                            <h1>SUBCONSULTAS</h1>
                            <span class="subheading">Práctica para Programación Avanzada de Base de Datos</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Main Content-->
        <div class="container px-4 px-lg-5">
            <div class="row gx-4 gx-lg-5 justify-content-center">
                <div class="col-md-10 col-lg-8 col-xl-7">
                    <h2 class="section-heading">Ejemplos de Subconsultas</h2>
                    <hr class="my-4" />
                    
                    <!-- Subconsulta 1 -->
                    <div class="post-preview">
                        <h3>1. Obtener estudiantes que tienen un promedio superior al promedio</h3>
                        <button class="btn btn-primary" onclick="toggleVisibility('subconsulta1')">Mostrar/Ocultar</button>
                        <div id="subconsulta1" class="hidden">
                            <?php
                            $query1 = "SELECT Estudiantes.estudiante_id, Estudiantes.nombre, Estudiantes.apellido, AVG(Historial_Academico.calificacion) AS promedio_estudiante
                                       FROM Estudiantes
                                       JOIN Historial_Academico ON Estudiantes.estudiante_id = Historial_Academico.estudiante_id
                                       GROUP BY Estudiantes.estudiante_id, Estudiantes.nombre, Estudiantes.apellido
                                       HAVING AVG(Historial_Academico.calificacion) > (SELECT AVG(calificacion) FROM Historial_Academico)";
                            ejecutarConsulta($conn, $query1);
                            ?>
                        </div>
                    </div>
                    <hr class="my-4" />
                    
                    <!-- Subconsulta 2 -->
                    <div class="post-preview">
                        <h3>2. Cursos que nunca han sido asignados a un profesor</h3>
                        <button class="btn btn-primary" onclick="toggleVisibility('subconsulta2')">Mostrar/Ocultar</button>
                        <div id="subconsulta2" class="hidden">
                            <?php
                            $query2 = "SELECT Cursos.curso_id, Cursos.nombre
                                       FROM Cursos 
                                       WHERE Cursos.curso_id NOT IN (
                                           SELECT DISTINCT Horarios_Cursos.curso_id
                                           FROM Horarios_Cursos
                                           JOIN Asignacion_Profesores ON Horarios_Cursos.horario_id = Asignacion_Profesores.horario_id
                                       )";
                            ejecutarConsulta($conn, $query2);
                            ?>
                        </div>
                    </div>
                    <hr class="my-4" />
                    
                    <!-- Subconsulta 3 -->
                    <div class="post-preview">
                        <h3>3. Estudiantes con mejor promedio que el de su carrera</h3>
                        <button class="btn btn-primary" onclick="toggleVisibility('subconsulta3')">Mostrar/Ocultar</button>
                        <div id="subconsulta3" class="hidden">
                            <?php
                            $query3 = "SELECT Estudiantes.estudiante_id, Estudiantes.nombre, Estudiantes.apellido, AVG(Historial_Academico.calificacion) AS promedio_estudiante
                                       FROM Estudiantes
                                       JOIN Historial_Academico ON Estudiantes.estudiante_id = Historial_Academico.estudiante_id
                                       JOIN Matriculas ON Estudiantes.estudiante_id = Matriculas.estudiante_id
                                       GROUP BY Estudiantes.estudiante_id, Estudiantes.nombre, Estudiantes.apellido, Matriculas.carrera_id
                                       HAVING AVG(Historial_Academico.calificacion) > (
                                           SELECT AVG(Historial_Academico.calificacion)
                                           FROM Historial_Academico
                                           JOIN Matriculas ON Historial_Academico.estudiante_id = Matriculas.estudiante_id
                                           WHERE Matriculas.carrera_id = Matriculas.carrera_id 
                                       )";
                            ejecutarConsulta($conn, $query3);
                            ?>
                        </div>
                    </div>
                    <hr class="my-4" />
                    
                    <!-- Subconsulta 4 -->
                    <div class="post-preview">
                        <h3>4. Profesores con cantidad de cursos asignados</h3>
                        <button class="btn btn-primary" onclick="toggleVisibility('subconsulta4')">Mostrar/Ocultar</button>
                        <div id="subconsulta4" class="hidden">
                            <?php
                            $query4 = "SELECT Profesores.profesor_id, Profesores.nombre, Profesores.apellido, COUNT(DISTINCT Horarios_Cursos.curso_id) AS cursos_asignados
                                       FROM Profesores
                                       JOIN Asignacion_Profesores ON Profesores.profesor_id = Asignacion_Profesores.profesor_id
                                       JOIN Horarios_Cursos ON Asignacion_Profesores.horario_id = Horarios_Cursos.horario_id
                                       GROUP BY Profesores.profesor_id, Profesores.nombre, Profesores.apellido";
                            ejecutarConsulta($conn, $query4);
                            ?>
                        </div>
                    </div>
                    <hr class="my-4" />
                    
                    <!-- Subconsulta 5 -->
                    <div class="post-preview">
                        <h3>5. Estudiantes que nunca han reprobado un curso</h3>
                        <button class="btn btn-primary" onclick="toggleVisibility('subconsulta5')">Mostrar/Ocultar</button>
                        <div id="subconsulta5" class="hidden">
                            <?php
                            $query5 = "SELECT Estudiantes.estudiante_id, Estudiantes.nombre, Estudiantes.apellido
                                       FROM estudiantes
                                       WHERE NOT EXISTS (
                                           SELECT 1
                                           FROM Historial_Academico
                                           WHERE Historial_Academico.estudiante_id = Estudiantes.estudiante_id AND Historial_Academico.estado = 'reprobado'
                                       )";
                            ejecutarConsulta($conn, $query5);
                            ?>
                        </div>
                    </div>
                    <hr class="my-4" />
                    
                    <!-- Subconsulta 6 -->
                    <div class="post-preview">
                        <h3>6. Cursos obligatorios no aprobados por un estudiante</h3>
                        <button class="btn btn-primary" onclick="toggleVisibility('subconsulta6')">Mostrar/Ocultar</button>
                        <div id="subconsulta6" class="hidden">
                            <?php
                            $query6 = "SELECT Cursos.curso_id, Cursos.nombre AS Nombre_Curso
                                       FROM Cursos
                                       WHERE Cursos.tipo = 'obligatorio'
                                       AND Cursos.curso_id NOT IN (
                                           SELECT historial_academico.curso_id
                                           FROM historial_academico
                                           WHERE historial_academico.estudiante_id = 1 AND historial_academico.estado = 'aprobado'
                                       )";
                            ejecutarConsulta($conn, $query6);
                            ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script>
            function toggleVisibility(id) {
                const element = document.getElementById(id);
                if (element.classList.contains('hidden')) {
                    element.classList.remove('hidden');
                } else {
                    element.classList.add('hidden');
                }
            }
        </script>
    </body>
</html>
<?php
$conn->close();
?>
