<?php
require_once '../../config/conexion.php';
$message = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $estudiante_id = $_POST['estudiante_id'];
    $monto = $_POST['monto'];
    $concepto = $_POST['concepto'];
    $metodo_pago = $_POST['metodo_pago'];
    $semestre_id = $_POST['semestre_id'];

    try {
        $stmt = $conn->prepare("CALL PA_registrar_pago(?, ?, ?, ?, ?)");
        $stmt->bind_param("idssi", $estudiante_id, $monto, $concepto, $metodo_pago, $semestre_id);
        $stmt->execute();
        $message = "Pago registrado con éxito.";
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
        <title>Registrar Pago</title>
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
                            <h1>Registrar Pago</h1>
                            <span class="subheading">Formulario para registrar un nuevo pago</span>
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
                        <h2 class="mb-2">Registrar Pago</h2>
                        <form method="POST">
                            <div class="mb-3">
                                <label for="estudiante_id" class="form-label">Estudiante</label>
                                <select name="estudiante_id" id="estudiante_id" class="form-select" required>
                                    <option value="">-- Seleccione un estudiante --</option>
                                    <?php
                                    $estudiantes = $conn->query("SELECT estudiante_id, CONCAT(nombre, ' ', apellido) AS nombre_completo FROM estudiantes");
                                    while ($row = $estudiantes->fetch_assoc()) {
                                        echo "<option value='{$row['estudiante_id']}'>{$row['nombre_completo']}</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="monto" class="form-label">Monto</label>
                                <input type="number" step="0.01" name="monto" id="monto" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="concepto" class="form-label">Concepto</label>
                                <select name="concepto" id="concepto" class="form-select" required>
                                    <option value="matricula">Matrícula</option>
                                    <option value="mensualidad">Mensualidad</option>
                                    <option value="otros">Otros</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="metodo_pago" class="form-label">Método de Pago</label>
                                <select name="metodo_pago" id="metodo_pago" class="form-select" required>
                                    <option value="efectivo">Efectivo</option>
                                    <option value="tarjeta">Tarjeta</option>
                                    <option value="transferencia">Transferencia</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="semestre_id" class="form-label">Semestre</label>
                                <select name="semestre_id" id="semestre_id" class="form-select" required>
                                    <option value="">-- Seleccione un semestre --</option>
                                    <?php
                                    $semestres = $conn->query("SELECT semestre_id, nombre FROM semestres WHERE estado IN ('en_curso', 'planificacion')");
                                    while ($row = $semestres->fetch_assoc()) {
                                        echo "<option value='{$row['semestre_id']}'>{$row['nombre']}</option>";
                                    }
                                    ?>
                                </select>
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