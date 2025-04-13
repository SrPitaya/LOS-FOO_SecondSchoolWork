<?php
require_once __DIR__ . '/../../config/conexion.php';

$message = "";

// Procesar formulario de agregar estudiante
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['agregar_estudiante'])) {
    try {
        $nombre = $_POST['nombre'];
        $apellido = $_POST['apellido'];
        $fecha_nacimiento = $_POST['fecha_nacimiento'];
        $genero = $_POST['genero'];
        $direccion = $_POST['direccion'];
        $telefono = $_POST['telefono'];
        $email = $_POST['email'];
        $fecha_ingreso = $_POST['fecha_ingreso'];
        $estado = $_POST['estado'];

        $stmt = $conn->prepare("INSERT INTO estudiantes (nombre, apellido, fecha_nacimiento, genero, direccion, telefono, email, fecha_ingreso, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssssssss", $nombre, $apellido, $fecha_nacimiento, $genero, $direccion, $telefono, $email, $fecha_ingreso, $estado);
        $stmt->execute();

        $message = "Estudiante agregado con éxito.";
    } catch (mysqli_sql_exception $e) {
        if ($e->getCode() === 45000) {
            $message = "Error: " . $e->getMessage();
        } else {
            $message = "Error inesperado: " . $e->getMessage();
        }
    }
}

// Procesar actualización de estudiante
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['actualizar_estudiante'])) {
    try {
        $estudiante_id = $_POST['estudiante_id'];
        $nombre = $_POST['nombre'];
        $apellido = $_POST['apellido'];
        $fecha_nacimiento = $_POST['fecha_nacimiento'];
        $genero = $_POST['genero'];
        $direccion = $_POST['direccion'];
        $telefono = $_POST['telefono'];
        $email = $_POST['email'];
        $fecha_ingreso = $_POST['fecha_ingreso'];
        $estado = $_POST['estado'];

        $stmt = $conn->prepare("UPDATE estudiantes SET nombre=?, apellido=?, fecha_nacimiento=?, genero=?, direccion=?, telefono=?, email=?, fecha_ingreso=?, estado=? WHERE estudiante_id=?");
        $stmt->bind_param("sssssssssi", $nombre, $apellido, $fecha_nacimiento, $genero, $direccion, $telefono, $email, $fecha_ingreso, $estado, $estudiante_id);
        $stmt->execute();

        $message = "Estudiante actualizado con éxito.";
    } catch (mysqli_sql_exception $e) {
        if ($e->getCode() === 45000) {
            $message = "Error: " . $e->getMessage();
        } else {
            $message = "Error inesperado: " . $e->getMessage();
        }
    }
}

// Procesar eliminación de estudiante
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['eliminar_estudiante'])) {
    try {
        $estudiante_id = $_POST['estudiante_id'];

        $stmt = $conn->prepare("DELETE FROM estudiantes WHERE estudiante_id=?");
        $stmt->bind_param("i", $estudiante_id);
        $stmt->execute();

        $message = "Estudiante eliminado con éxito.";
    } catch (mysqli_sql_exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Obtener el número total de estudiantes
$total_estudiantes = $conn->query("SELECT COUNT(*) AS total FROM estudiantes")->fetch_assoc()['total'];
$estudiantes_por_pagina = 10;
$total_paginas = ceil($total_estudiantes / $estudiantes_por_pagina);

// Obtener la página actual
$pagina_actual = isset($_GET['pagina']) ? (int)$_GET['pagina'] : 1;
$pagina_actual = max(1, min($pagina_actual, $total_paginas));
$offset = ($pagina_actual - 1) * $estudiantes_por_pagina;

// Obtener lista de estudiantes con paginación
$estudiantes = $conn->query("SELECT * FROM estudiantes ORDER BY estudiante_id DESC LIMIT $offset, $estudiantes_por_pagina");
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Estudiantes</title>
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
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../../rutinas/rutinas.php">Rutinas</a></li>
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../../subconsultas/subconsultas.php">Subconsultas</a></li>
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../disparadores.php">Disparadores</a></li>
                    <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../../auditorias/auditorias.php">Auditorias</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="masthead" style="background-image: url('../../assets/img/home-bg.jpg')">
        <div class="container position-relative px-4 px-lg-5">
            <div class="row gx-4 gx-lg-5 justify-content-center">
                <div class="col-md-10 col-lg-8 col-xl-7">
                    <div class="site-heading">
                        <h1>ESTUDIANTES</h1>
                        <span class="subheading">Gestión de Estudiantes</span>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div class="container py-5">
        <!-- Formulario para agregar estudiante -->
        <div class="row justify-content-center mb-5">
            <div class="col">
                <div class="card shadow p-4">
                    <h2 class="mb-4">Agregar Nuevo Estudiante</h2>
                    <form method="POST">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="apellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="apellido" name="apellido" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="fecha_nacimiento" class="form-label">Fecha de Nacimiento</label>
                                <input type="date" class="form-control" id="fecha_nacimiento" name="fecha_nacimiento">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="genero" class="form-label">Género</label>
                                <select class="form-select" id="genero" name="genero">
                                    <option value="M">Masculino</option>
                                    <option value="F">Femenino</option>
                                    <option value="O">Otro</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="direccion" class="form-label">Dirección</label>
                            <input type="text" class="form-control" id="direccion" name="direccion">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="text" class="form-control" id="telefono" name="telefono">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email Institucional</label>
                                <input type="email" class="form-control" id="email" name="email" required placeholder="usuario@valladolid.tecnm.com.mx">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="fecha_ingreso" class="form-label">Fecha de Ingreso</label>
                                <input type="date" class="form-control" id="fecha_ingreso" name="fecha_ingreso">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="estado" class="form-label">Estado</label>
                                <select class="form-select" id="estado" name="estado">
                                    <option value="activo">Activo</option>
                                    <option value="graduado">Graduado</option>
                                    <option value="retirado">Retirado</option>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary rounded" name="agregar_estudiante">Agregar Estudiante</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Tabla de estudiantes -->
        <div class="row justify-content-center">
            <div class="col">
                <div class="card shadow p-4">
                    <h2 class="mb-4">Lista de Estudiantes</h2>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>Email</th>
                                    <th>Fecha Ingreso</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php while ($estudiante = $estudiantes->fetch_assoc()): ?>
                                    <tr>
                                        <td><?= $estudiante['estudiante_id'] ?></td>
                                        <td><?= $estudiante['nombre'] ?></td>
                                        <td><?= $estudiante['apellido'] ?></td>
                                        <td><?= $estudiante['email'] ?></td>
                                        <td><?= $estudiante['fecha_ingreso'] ?></td>
                                        <td><?= ucfirst($estudiante['estado']) ?></td>
                                        <td>
                                            <!-- Botón para editar (modal) -->
                                            <button type="button" class="btn btn-sm btn-warning rounded" data-bs-toggle="modal" data-bs-target="#editarEstudianteModal<?= $estudiante['estudiante_id'] ?>">
                                                <i class="fas fa-edit"></i>
                                            </button>

                                            <!-- Formulario para eliminar -->
                                            <form method="POST" style="display: inline;">
                                                <input type="hidden" name="estudiante_id" value="<?= $estudiante['estudiante_id'] ?>">
                                                <button type="submit" class="btn btn-sm btn-danger rounded" name="eliminar_estudiante" onclick="return confirm('¿Estás seguro de eliminar este estudiante?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>

                                    <!-- Modal para editar estudiante -->
                                    <div class="modal fade" id="editarEstudianteModal<?= $estudiante['estudiante_id'] ?>" tabindex="-1" aria-labelledby="editarEstudianteModalLabel<?= $estudiante['estudiante_id'] ?>" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header bg-warning text-white">
                                                    <h5 class="modal-title" id="editarEstudianteModalLabel<?= $estudiante['estudiante_id'] ?>">Editar Estudiante</h5>
                                                    <button type="button" class="btn-close btn-close-white rounded" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <form method="POST">
                                                    <div class="modal-body">
                                                        <input type="hidden" name="estudiante_id" value="<?= $estudiante['estudiante_id'] ?>">
                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <label for="nombre_edit_<?= $estudiante['estudiante_id'] ?>" class="form-label">Nombre</label>
                                                                <input type="text" class="form-control" id="nombre_edit_<?= $estudiante['estudiante_id'] ?>" name="nombre" value="<?= $estudiante['nombre'] ?>" required>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label for="apellido_edit_<?= $estudiante['estudiante_id'] ?>" class="form-label">Apellido</label>
                                                                <input type="text" class="form-control" id="apellido_edit_<?= $estudiante['estudiante_id'] ?>" name="apellido" value="<?= $estudiante['apellido'] ?>" required>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <label for="fecha_nacimiento_edit_<?= $estudiante['estudiante_id'] ?>" class="form-label">Fecha de Nacimiento</label>
                                                                <input type="date" class="form-control" id="fecha_nacimiento_edit_<?= $estudiante['estudiante_id'] ?>" name="fecha_nacimiento" value="<?= $estudiante['fecha_nacimiento'] ?>">
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label for="genero_edit_<?= $estudiante['estudiante_id'] ?>" class="form-label">Género</label>
                                                                <select class="form-select" id="genero_edit_<?= $estudiante['estudiante_id'] ?>" name="genero">
                                                                    <option value="M" <?= $estudiante['genero'] == 'M' ? 'selected' : '' ?>>Masculino</option>
                                                                    <option value="F" <?= $estudiante['genero'] == 'F' ? 'selected' : '' ?>>Femenino</option>
                                                                    <option value="O" <?= $estudiante['genero'] == 'O' ? 'selected' : '' ?>>Otro</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label for="direccion_edit_<?= $estudiante['estudiante_id'] ?>" class="form-label">Dirección</label>
                                                            <input type="text" class="form-control" id="direccion_edit_<?= $estudiante['estudiante_id'] ?>" name="direccion" value="<?= $estudiante['direccion'] ?>">
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <label for="telefono_edit_<?= $estudiante['estudiante_id'] ?>" class="form-label">Teléfono</label>
                                                                <input type="text" class="form-control" id="telefono_edit_<?= $estudiante['estudiante_id'] ?>" name="telefono" value="<?= $estudiante['telefono'] ?>">
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label for="email_edit_<?= $estudiante['estudiante_id'] ?>" class="form-label">Email Institucional</label>
                                                                <input type="email" class="form-control" id="email_edit_<?= $estudiante['estudiante_id'] ?>" name="email" value="<?= $estudiante['email'] ?>" required placeholder="usuario@valladolid.tecnm.com.mx">
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6 mb-3">
                                                                <label for="fecha_ingreso_edit_<?= $estudiante['estudiante_id'] ?>" class="form-label">Fecha de Ingreso</label>
                                                                <input type="date" class="form-control" id="fecha_ingreso_edit_<?= $estudiante['estudiante_id'] ?>" name="fecha_ingreso" value="<?= $estudiante['fecha_ingreso'] ?>">
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label for="estado_edit_<?= $estudiante['estudiante_id'] ?>" class="form-label">Estado</label>
                                                                <select class="form-select" id="estado_edit_<?= $estudiante['estudiante_id'] ?>" name="estado">
                                                                    <option value="activo" <?= $estudiante['estado'] == 'activo' ? 'selected' : '' ?>>Activo</option>
                                                                    <option value="graduado" <?= $estudiante['estado'] == 'graduado' ? 'selected' : '' ?>>Graduado</option>
                                                                    <option value="retirado" <?= $estudiante['estado'] == 'retirado' ? 'selected' : '' ?>>Retirado</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary rounded" data-bs-dismiss="modal">Cancelar</button>
                                                        <button type="submit" class="btn btn-primary rounded" name="actualizar_estudiante">Guardar Cambios</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                <?php endwhile; ?>
                            </tbody>
                        </table>
                    </div>

                    <!-- Paginación -->
                    <nav>
                        <ul class="pagination justify-content-center">
                            <?php if ($pagina_actual > 1): ?>
                                <li class="page-item">
                                    <a class="page-link" href="?pagina=<?= $pagina_actual - 1 ?>">Anterior</a>
                                </li>
                            <?php endif; ?>

                            <?php for ($i = 1; $i <= $total_paginas; $i++): ?>
                                <li class="page-item <?= $i === $pagina_actual ? 'active' : '' ?>">
                                    <a class="page-link" href="?pagina=<?= $i ?>"><?= $i ?></a>
                                </li>
                            <?php endfor; ?>

                            <?php if ($pagina_actual < $total_paginas): ?>
                                <li class="page-item">
                                    <a class="page-link" href="?pagina=<?= $pagina_actual + 1 ?>">Siguiente</a>
                                </li>
                            <?php endif; ?>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para mensajes -->
    <div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="messageModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <?php
                $isError = isset($message) && str_contains($message, 'Error');
                $headerClass = $isError ? 'bg-danger text-white' : 'bg-success text-white';
                $modalTitle = $isError ? 'Error' : 'Éxito';
                $buttonClass = $isError ? 'btn-outline-light rounded' : 'btn-outline-success rounded';
                ?>
                <div class="modal-header <?= $headerClass ?>">
                    <h5 class="modal-title" id="messageModalLabel"><?= $modalTitle ?></h5>
                    <button type="button" class="btn-close btn-close-white rounded" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <?= $message ?? '' ?>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn <?= $buttonClass ?> rounded" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/scripts.js"></script>

    <?php if (!empty($message)): ?>
        <script>
            var messageModal = new bootstrap.Modal(document.getElementById('messageModal'));
            window.addEventListener('load', () => {
                messageModal.show();
            });
        </script>
    <?php endif; ?>

</body>

</html>