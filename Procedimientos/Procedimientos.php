<?php
require_once __DIR__ . '/../config/conexion.php'; // Asegúrate de incluir tu archivo de conexión

$message = "";

// Procesar la ejecución de un procedimiento almacenado
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['ejecutar_procedimiento'])) {
    $procedimiento = $_POST['procedimiento'];
    $parametros = $_POST['parametros'];

    try {
        // Preparar la llamada al procedimiento
        $stmt = $conn->prepare("CALL $procedimiento($parametros)");
        $stmt->execute();
        $message = "Procedimiento ejecutado con éxito.";
    } catch (mysqli_sql_exception $e) {
        $message = "Error al ejecutar el procedimiento: " . $e->getMessage();
    }
}

// Obtener la lista de procedimientos almacenados
$procedimientos = $conn->query("SHOW PROCEDURE STATUS WHERE Db = 'universidad_db2'");
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Procedimientos Almacenados</title>
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
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="procedimientos.php">Procedimientos</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../subconsultas/subconsultas.php">Subconsultas</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../disparadores/disparadores.php">Disparadores</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../auditorias/auditorias.php">Auditorias</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Page Header-->
        <header class="masthead" style="background-image: url('../assets/img/home-bg.jpg')">
            <div class="container position-relative px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <div class="site-heading">
                            <h1>Procedimientos Almacenados</h1>
                            <span class="subheading">Gestión de Procedimientos desde la Web</span>
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
                        <h2 class="mb-4">Gestión de Procedimientos Almacenados</h2>
                        <ul>
                            <li><a href="PA/inscribir_curso.php">Inscribir Curso</a></li>
                            <li><a href="PA/registrar_estudiante.php">Registrar Estudiante</a></li>
                            <li><a href="PA/registrar_pago.php">Registrar Pago</a></li>
                            <li><a href="PA/resgistrar_prestamo.php">Registrar Préstamo</a></li>
                            <li><a href="PA/registrar_profesor.php">Registrar Profesor</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function setParametros(procedimiento) {
                const parametros = document.getElementById(`parametros_${procedimiento}`).value;
                document.getElementById(`parametros_input_${procedimiento}`).value = parametros;
            }
        </script>

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="../js/scripts.js"></script>
    </body>
</html>
