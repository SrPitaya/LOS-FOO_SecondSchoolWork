<?php
require_once __DIR__ . '/../../config/conexion.php';

$message = "";

// Procesar formulario de préstamo
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['realizar_prestamo'])) {
    try {
        $estudiante_id = $_POST['estudiante_id'];
        $libro_id = $_POST['libro_id'];
        $fecha_prestamo = date('Y-m-d');
        $fecha_devolucion_esperada = date('Y-m-d', strtotime('+15 days'));

        $stmt = $conn->prepare("INSERT INTO prestamos (libro_id, estudiante_id, fecha_prestamo, fecha_devolucion_esperada) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("iiss", $libro_id, $estudiante_id, $fecha_prestamo, $fecha_devolucion_esperada);
        $stmt->execute();

        $message = "Préstamo registrado con éxito. Fecha de devolución: " . $fecha_devolucion_esperada;
    } catch (mysqli_sql_exception $e) {
        if ($e->getCode() === 45000) {
            $message = "Error: " . $e->getMessage();
        } else {
            $message = "Error inesperado: " . $e->getMessage();
        }
    }
}

// Procesar devolución de libro
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['devolver_libro'])) {
    try {
        $prestamo_id = $_POST['prestamo_id'];
        $fecha_devolucion_real = date('Y-m-d');

        $stmt = $conn->prepare("UPDATE prestamos SET fecha_devolucion_real = ?, estado = 'devuelto' WHERE prestamo_id = ?");
        $stmt->bind_param("si", $fecha_devolucion_real, $prestamo_id);
        $stmt->execute();

        // Actualizar cantidad de ejemplares disponibles
        $conn->query("UPDATE libros l JOIN prestamos p ON l.libro_id = p.libro_id SET l.cantidad_ejemplares = l.cantidad_ejemplares + 1 WHERE p.prestamo_id = $prestamo_id");

        $message = "Libro devuelto con éxito.";
    } catch (mysqli_sql_exception $e) {
        $message = "Error: " . $e->getMessage();
    }
}

// Obtener lista de estudiantes
$estudiantes = $conn->query("SELECT estudiante_id, nombre, apellido FROM estudiantes ORDER BY nombre, apellido");

// Obtener lista de TODOS los libros (incluyendo los no disponibles)
$libros = $conn->query("SELECT * FROM libros ORDER BY titulo");

// Obtener préstamos activos
$prestamos = $conn->query("
    SELECT p.prestamo_id, p.fecha_prestamo, p.fecha_devolucion_esperada, 
           CONCAT(e.nombre, ' ', e.apellido) AS estudiante, 
           l.titulo AS libro, l.autor
    FROM prestamos p
    JOIN estudiantes e ON p.estudiante_id = e.estudiante_id
    JOIN libros l ON p.libro_id = l.libro_id
    WHERE p.estado = 'activo'
    ORDER BY p.fecha_devolucion_esperada
");
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Préstamos de Libros</title>
    <link rel="icon" type="image/x-icon" href="../../assets/favicon.ico" />
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="../../css/styles.css" rel="stylesheet" />
    <style>
        .book-card {
            transition: transform 0.2s;
            cursor: pointer;
        }
        .book-card:hover {
            transform: scale(1.03);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .book-card.selected {
            border: 3px solid #0d6efd;
            background-color: #f8f9fa;
        }
        .loan-card {
            border-left: 4px solid #0d6efd;
        }
        .overdue {
            border-left: 4px solid #dc3545;
        }
    </style>
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
                        <h1>PRÉSTAMOS DE LIBROS</h1>
                        <span class="subheading">Gestión de Préstamos Bibliotecarios</span>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div class="container py-5">
        <!-- Formulario para realizar préstamo -->
        <div class="row justify-content-center mb-5">
            <div class="col">
                <div class="card shadow p-4">
                    <h2 class="mb-4">Nuevo Préstamo</h2>
                    <form method="POST" id="prestamoForm">
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label for="estudiante_id" class="form-label">Seleccionar Estudiante</label>
                                <select class="form-select" id="estudiante_id" name="estudiante_id" required>
                                    <option value="">-- Seleccione un estudiante --</option>
                                    <?php while ($estudiante = $estudiantes->fetch_assoc()): ?>
                                        <option value="<?= $estudiante['estudiante_id'] ?>">
                                            <?= $estudiante['nombre'] . ' ' . $estudiante['apellido'] ?>
                                        </option>
                                    <?php endwhile; ?>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label class="form-label">Fecha Préstamo</label>
                                        <input type="text" class="form-control" value="<?= date('d/m/Y') ?>" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Fecha Devolución</label>
                                        <input type="text" class="form-control" value="<?= date('d/m/Y', strtotime('+15 days')) ?>" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <h5 class="mb-3">Seleccionar Libro</h5>
                        <div class="row g-3" id="librosContainer">
                            <?php if ($libros->num_rows > 0): ?>
                                <?php while ($libro = $libros->fetch_assoc()): 
                                    $disponible = $libro['cantidad_ejemplares'] > 0;
                                ?>
                                    <div class="col-md-4">
                                        <div class="card book-card h-100 <?= $disponible ? '' : 'text-muted' ?>" 
                                             onclick="selectBook(this, <?= $libro['libro_id'] ?>, <?= $disponible ? 'true' : 'false' ?>)">
                                            <div class="card-body">
                                                <h5 class="card-title"><?= $libro['titulo'] ?></h5>
                                                <h6 class="card-subtitle mb-2 text-muted"><?= $libro['autor'] ?></h6>
                                                <p class="card-text">
                                                    <small class="text-muted">Editorial: <?= $libro['editorial'] ?></small><br>
                                                    <small class="text-muted">ISBN: <?= $libro['ISBN'] ?></small><br>
                                                    <small class="<?= $disponible ? 'text-success' : 'text-danger' ?>">
                                                        <?= $disponible ? 'Disponible ('.$libro['cantidad_ejemplares'].')' : 'Agotado' ?>
                                                    </small>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                <?php endwhile; ?>
                            <?php else: ?>
                                <div class="col-12">
                                    <div class="alert alert-warning">No hay libros registrados en el sistema.</div>
                                </div>
                            <?php endif; ?>
                        </div>
                        
                        <input type="hidden" id="libro_id" name="libro_id" required>
                        
                        <div class="mt-4">
                            <button type="submit" class="btn btn-primary rounded" name="realizar_prestamo" id="submitBtn">
                                <i class="fas fa-book me-2"></i> Registrar Préstamo
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Lista de préstamos activos -->
        <div class="row justify-content-center">
            <div class="col">
                <div class="card shadow p-4">
                    <h2 class="mb-4">Préstamos Activos</h2>
                    
                    <?php if ($prestamos->num_rows > 0): ?>
                        <div class="row g-3">
                            <?php while ($prestamo = $prestamos->fetch_assoc()): 
                                $isOverdue = strtotime($prestamo['fecha_devolucion_esperada']) < time();
                            ?>
                                <div class="col-md-6">
                                    <div class="card loan-card h-100 <?= $isOverdue ? 'overdue' : '' ?>">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <h5 class="card-title"><?= $prestamo['libro'] ?></h5>
                                                    <h6 class="card-subtitle mb-2 text-muted"><?= $prestamo['autor'] ?></h6>
                                                </div>
                                                <span class="badge bg-<?= $isOverdue ? 'danger' : 'primary' ?> rounded-pill">
                                                    <?= $isOverdue ? 'Atrasado' : 'Activo' ?>
                                                </span>
                                            </div>
                                            
                                            <p class="card-text mt-3">
                                                <strong>Estudiante:</strong> <?= $prestamo['estudiante'] ?><br>
                                                <strong>Préstamo:</strong> <?= date('d/m/Y', strtotime($prestamo['fecha_prestamo'])) ?><br>
                                                <strong>Devolución:</strong> <?= date('d/m/Y', strtotime($prestamo['fecha_devolucion_esperada'])) ?>
                                            </p>
                                            
                                            <form method="POST" class="mt-2">
                                                <input type="hidden" name="prestamo_id" value="<?= $prestamo['prestamo_id'] ?>">
                                                <button type="submit" class="btn btn-sm btn-success rounded" name="devolver_libro">
                                                    <i class="fas fa-book me-1"></i> Registrar Devolución
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            <?php endwhile; ?>
                        </div>
                    <?php else: ?>
                        <div class="alert alert-info">No hay préstamos activos en este momento.</div>
                    <?php endif; ?>
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
    <script>
        // Selección de libro
        function selectBook(element, libroId, disponible) {
            // Remover selección previa
            document.querySelectorAll('.book-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            // Seleccionar nuevo libro
            element.classList.add('selected');
            document.getElementById('libro_id').value = libroId;
        }
    </script>

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