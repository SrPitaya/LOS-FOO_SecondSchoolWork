<?php
require_once '../../config/conexion.php';
$message = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $libro_id = $_POST['libro_id'];
    $estudiante_id = $_POST['estudiante_id'];
    $profesor_id = $_POST['profesor_id'];
    $fecha_prestamo = $_POST['fecha_prestamo'];
    $fecha_devolucion_esperada = $_POST['fecha_devolucion_esperada'];

    try {
        $stmt = $conn->prepare("CALL PA_registrar_prestamo(?, ?, ?, ?, ?)");
        $stmt->bind_param("iiiss", $libro_id, $estudiante_id, $profesor_id, $fecha_prestamo, $fecha_devolucion_esperada);
        $stmt->execute();
        $message = "Préstamo registrado con éxito.";
    } catch (mysqli_sql_exception $e) {
        $message = "Error: " . $e->getMessage();
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
        <title>Registrar Préstamo</title>
        <link rel="icon" type="image/x-icon" href="../../assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../../css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="../../index.php">LOS FOO 🤡</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../../index.php">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../Procedimientos.php">Procedimientos</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../../subconsultas/subconsultas.php">Subconsultas</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../../disparadores/disparadores.php">Disparadores</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../../auditorias/auditorias.php">Auditorias</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Page Header-->
        <header class="masthead" style="background-image: url('../../assets/img/home-bg.jpg')">
            <div class="container position-relative px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <div class="site-heading">
                            <h1>Registrar Préstamo</h1>
                            <span class="subheading">Formulario para registrar un nuevo préstamo</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Main Content-->
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <?php if (!empty($message)): ?>
                        <div class="alert alert-info"><?= $message ?></div>
                    <?php endif; ?>

                    <div class="card shadow p-4">
                        <h2 class="mb-2">Registrar Préstamo</h2>
                        <form method="POST">
                            <div class="mb-3">
                                <label for="libro_id" class="form-label">Libro</label>
                                <select name="libro_id" id="libro_id" class="form-select" required>
                                    <option value="">-- Seleccione un libro --</option>
                                    <?php
                                    $libros = $conn->query("SELECT libro_id, titulo FROM libros WHERE cantidad_ejemplares > 0");
                                    while ($row = $libros->fetch_assoc()) {
                                        echo "<option value='{$row['libro_id']}'>{$row['titulo']}</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="estudiante_id" class="form-label">Estudiante</label>
                                <select name="estudiante_id" id="estudiante_id" class="form-select">
                                    <option value="">-- Seleccione un estudiante (opcional) --</option>
                                    <?php
                                    $estudiantes = $conn->query("SELECT estudiante_id, CONCAT(nombre, ' ', apellido) AS nombre_completo FROM estudiantes");
                                    while ($row = $estudiantes->fetch_assoc()) {
                                        echo "<option value='{$row['estudiante_id']}'>{$row['nombre_completo']}</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="profesor_id" class="form-label">Profesor</label>
                                <select name="profesor_id" id="profesor_id" class="form-select">
                                    <option value="">-- Seleccione un profesor (opcional) --</option>
                                    <?php
                                    $profesores = $conn->query("SELECT profesor_id, CONCAT(nombre, ' ', apellido) AS nombre_completo FROM profesores");
                                    while ($row = $profesores->fetch_assoc()) {
                                        echo "<option value='{$row['profesor_id']}'>{$row['nombre_completo']}</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="fecha_prestamo" class="form-label">Fecha de Préstamo</label>
                                <input type="date" name="fecha_prestamo" id="fecha_prestamo" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="fecha_devolucion_esperada" class="form-label">Fecha de Devolución Esperada</label>
                                <input type="date" name="fecha_devolucion_esperada" id="fecha_devolucion_esperada" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Registrar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="../../js/scripts.js"></script>
    </body>
</html>