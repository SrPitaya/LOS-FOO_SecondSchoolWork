<?php
require_once __DIR__ . '/../config/conexion.php';

// Obtener parámetros de filtrado
$tabla_filtro = $_GET['tabla'] ?? '';
$accion_filtro = $_GET['accion'] ?? '';
$pagina = isset($_GET['pagina']) ? max(1, intval($_GET['pagina'])) : 1;
$por_pagina = 10;

// Construir consulta base con conteo total
$query = "SELECT * FROM logs WHERE 1=1";
$query_count = "SELECT COUNT(*) AS total FROM logs WHERE 1=1";

// Aplicar filtros
if (!empty($tabla_filtro)) {
    $query .= " AND tabla_afectada = '$tabla_filtro'";
    $query_count .= " AND tabla_afectada = '$tabla_filtro'";
}
if (!empty($accion_filtro)) {
    $query .= " AND accion = '$accion_filtro'";
    $query_count .= " AND accion = '$accion_filtro'";
}

// Obtener total de registros
$total_resultados = $conn->query($query_count)->fetch_assoc()['total'];
$total_paginas = ceil($total_resultados / $por_pagina);

// Aplicar paginación
$offset = ($pagina - 1) * $por_pagina;
$query .= " ORDER BY fecha_creacion DESC LIMIT $offset, $por_pagina";

// Ejecutar consulta
$logs = $conn->query($query);

// Obtener tablas únicas para el filtro
$tablas = $conn->query("SELECT DISTINCT tabla_afectada FROM logs ORDER BY tabla_afectada");
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Auditorias</title>
        <link rel="icon" type="image/x-icon" href="../assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
        <style>
            .badge-insert { background-color: #28a745; border-radius: 0.25rem; }
            .badge-update { background-color: #ffc107; color: #212529; border-radius: 0.25rem; }
            .badge-delete { background-color: #dc3545; border-radius: 0.25rem; }
            .log-card { transition: all 0.3s; }
            .log-card:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
            .filter-section { background-color: #f8f9fa; border-radius: 5px; }
            .pagination .page-item.active .page-link { background-color: #6c757d; border-color: #6c757d; }
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
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../rutinas/rutinas.php">Rutinas</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../subconsultas/subconsultas.php">Subconsultas</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="../disparadores/disparadores.php">Disparadores</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="auditorias.php">Auditorias</a></li>
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
                            <h1>AUDITORIAS</h1>
                            <span class="subheading">Registro de cambios en el sistema</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Main Content-->
        <div class="container px-4 px-lg-5 py-5">
            <div class="row gx-4 gx-lg-5 justify-content-center">
                <div class="col-lg-10">
                    <!-- Filtros -->
                    <div class="card mb-4 filter-section">
                        <div class="card-body">
                            <h5 class="card-title">Filtrar registros</h5>
                            <form method="get" class="row g-3">
                                <div class="col-md-5">
                                    <label for="tabla" class="form-label">Tabla afectada</label>
                                    <select id="tabla" name="tabla" class="form-select">
                                        <option value="">Todas las tablas</option>
                                        <?php while ($tabla = $tablas->fetch_assoc()): ?>
                                            <option value="<?= $tabla['tabla_afectada'] ?>" <?= $tabla['tabla_afectada'] == $tabla_filtro ? 'selected' : '' ?>>
                                                <?= ucfirst($tabla['tabla_afectada']) ?>
                                            </option>
                                        <?php endwhile; ?>
                                    </select>
                                </div>
                                <div class="col-md-5">
                                    <label for="accion" class="form-label">Acción</label>
                                    <select id="accion" name="accion" class="form-select">
                                        <option value="">Todas las acciones</option>
                                        <option value="INSERT" <?= $accion_filtro == 'INSERT' ? 'selected' : '' ?>>Creaciones (INSERT)</option>
                                        <option value="UPDATE" <?= $accion_filtro == 'UPDATE' ? 'selected' : '' ?>>Actualizaciones (UPDATE)</option>
                                        <option value="DELETE" <?= $accion_filtro == 'DELETE' ? 'selected' : '' ?>>Eliminaciones (DELETE)</option>
                                    </select>
                                </div>
                                <div class="col-md-2 d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary w-100 rounded">Filtrar</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Resumen -->
                    <div class="alert alert-info mb-4 rounded">
                        Mostrando <?= ($offset + 1) ?> a <?= min($offset + $por_pagina, $total_resultados) ?> de <?= $total_resultados ?> registros
                    </div>

                    <!-- Lista de logs -->
                    <?php if ($logs->num_rows > 0): ?>
                        <?php while ($log = $logs->fetch_assoc()): ?>
                            <div class="card mb-3 log-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <h5 class="card-title">
                                            <?= ucfirst($log['tabla_afectada']) ?> #<?= $log['registro_id'] ?>
                                        </h5>
                                        <span class="badge <?= $log['accion'] == 'INSERT' ? 'badge-insert' : ($log['accion'] == 'UPDATE' ? 'badge-update' : 'badge-delete') ?>">
                                            <?= $log['accion'] ?>
                                        </span>
                                    </div>
                                    <h6 class="card-subtitle mb-2 text-muted">
                                        <?= $log['nombre_completo'] ?>
                                    </h6>
                                    <p class="card-text"><?= $log['detalles'] ?></p>
                                    <div class="d-flex justify-content-between">
                                        <small class="text-muted">
                                            <?= date('d/m/Y H:i:s', strtotime($log['fecha_creacion'])) ?>
                                        </small>
                                        <small>
                                            <a href="#" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#logDetailsModal<?= $log['log_id'] ?>">
                                                Ver detalles
                                            </a>
                                        </small>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal para detalles completos -->
                            <div class="modal fade" id="logDetailsModal<?= $log['log_id'] ?>" tabindex="-1" aria-labelledby="logDetailsModalLabel<?= $log['log_id'] ?>" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="logDetailsModalLabel<?= $log['log_id'] ?>">
                                                Detalles del registro de auditoría
                                            </h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <ul class="list-group">
                                                <li class="list-group-item"><strong>ID del Log:</strong> <?= $log['log_id'] ?></li>
                                                <li class="list-group-item"><strong>Tabla afectada:</strong> <?= ucfirst($log['tabla_afectada']) ?></li>
                                                <li class="list-group-item"><strong>ID del Registro:</strong> <?= $log['registro_id'] ?></li>
                                                <li class="list-group-item"><strong>Usuario:</strong> <?= $log['nombre_completo'] ?></li>
                                                <li class="list-group-item"><strong>Acción:</strong> 
                                                    <span class="badge <?= $log['accion'] == 'INSERT' ? 'badge-insert' : ($log['accion'] == 'UPDATE' ? 'badge-update' : 'badge-delete') ?>">
                                                        <?= $log['accion'] ?>
                                                    </span>
                                                </li>
                                                <li class="list-group-item"><strong>Fecha y hora:</strong> <?= date('d/m/Y H:i:s', strtotime($log['fecha_creacion'])) ?></li>
                                                <li class="list-group-item"><strong>Detalles:</strong> 
                                                    <div class="p-3 bg-light rounded"><?= $log['detalles'] ?></div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary rounded" data-bs-dismiss="modal">Cerrar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <?php endwhile; ?>
                    <?php else: ?>
                        <div class="alert alert-warning">No se encontraron registros de auditoría con los filtros seleccionados.</div>
                    <?php endif; ?>

                    <!-- Paginación -->
                    <?php if ($total_paginas > 1): ?>
                        <nav aria-label="Paginación de logs">
                            <ul class="pagination justify-content-center mt-4">
                                <?php if ($pagina > 1): ?>
                                    <li class="page-item">
                                        <a class="page-link" href="?pagina=<?= $pagina-1 ?>&tabla=<?= $tabla_filtro ?>&accion=<?= $accion_filtro ?>">Anterior</a>
                                    </li>
                                <?php endif; ?>

                                <?php for ($i = 1; $i <= $total_paginas; $i++): ?>
                                    <li class="page-item <?= $i == $pagina ? 'active' : '' ?>">
                                        <a class="page-link" href="?pagina=<?= $i ?>&tabla=<?= $tabla_filtro ?>&accion=<?= $accion_filtro ?>"><?= $i ?></a>
                                    </li>
                                <?php endfor; ?>

                                <?php if ($pagina < $total_paginas): ?>
                                    <li class="page-item">
                                        <a class="page-link" href="?pagina=<?= $pagina+1 ?>&tabla=<?= $tabla_filtro ?>&accion=<?= $accion_filtro ?>">Siguiente</a>
                                    </li>
                                <?php endif; ?>
                            </ul>
                        </nav>
                    <?php endif; ?>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="../js/scripts.js"></script>
    </body>
</html>