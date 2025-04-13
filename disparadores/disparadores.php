<?php
require_once 'creditos/procesamiento.php';
?>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Disparadores</title>
        <link rel="icon" type="image/x-icon" href="../assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
</head>

<body>
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
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../rutinas/rutinas.php">Rutinas</a></li>
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../subconsultas/subconsultas.php">Subconsultas</a></li>
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="disparadores.php">Disparadores</a></li>
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../auditorias/auditorias.php">Auditorias</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="masthead" style="background-image: url('../assets/img/home-bg.jpg')">
        <div class="container position-relative px-4 px-lg-5">
            <div class="row gx-4 gx-lg-5 justify-content-center">
                <div class="col-md-10 col-lg-8 col-xl-7">
                    <div class="site-heading">
                        <h1>DISPARADORES</h1>
                        <span class="subheading">Practica para Programación avanzada de base de datos</span>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <?php include 'creditos/formulario.php'; ?>
            </div>
        </div>
        <div class="row justify-content-center mt-5">
            <div class="col-md-10">
                <div class="card shadow p-4">
                    <h2 class="mb-2">2-3. Gestion de profesores y estudiantes</h2>
                    <p class="text-muted">Este módulo incluye validaciones para asegurar que los correos electrónicos sean únicos y válidos, además de restricciones para evitar la actualización de registros de alumnos que ya se han graduado.</p>
                    <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                        <a href="estudiantes_profesores/estudiantes.php" class="btn btn-primary me-md-2 rounded">CRUD Estudiantes</a>
                        <a href="estudiantes_profesores/profesores.php" class="btn btn-primary rounded">CRUD Profesores</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row justify-content-center mt-5">
            <div class="col-md-10">
                <div class="card shadow p-4">
                    <h2 class="mb-2">4. Prestamos de libros</h2>
                    <p class="text-muted">Este módulo valida que no se puedan realizar préstamos si no hay ejemplares disponibles y reduce la cantidad de libros al registrar un préstamo exitoso.</p>
                    <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                        <a href="prestamos/prestamos.php" class="btn btn-primary me-md-2 rounded">Prestamos de libros</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Bootstrap -->
    <div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="messageModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header <?= (str_contains($message, 'Error')) ? 'bg-danger text-white' : 'bg-success text-white' ?>">
                    <h5 class="modal-title" id="messageModalLabel"><?= (str_contains($message, 'Error')) ? 'Error' : 'Éxito' ?></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <?= $message ?>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn <?= (str_contains($message, 'Error')) ? 'btn-outline-light' : 'btn-outline-success' ?>" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/scripts.js"></script>

    <?php if ($message): ?>
        <script>
            var messageModal = new bootstrap.Modal(document.getElementById('messageModal'));
            window.addEventListener('load', () => {
                messageModal.show();
            });
        </script>
    <?php endif; ?>

</body>

</html>