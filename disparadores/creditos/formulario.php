<?php
require_once 'procesamiento.php';
?>

<div class="card shadow p-4">
    <h2 class="mb-2">1. Inscripciones cursos</h2>
    <p class="text-muted">Este formulario permite inscribir estudiantes en cursos disponibles que tengan un horario asignado</p>
    <form action="disparadores.php" method="POST">
        <div class="mb-3">
            <label for="estudiante" class="form-label">Selecciona un estudiante:</label>
            <select name="estudiante_id" id="estudiante" class="form-select" required>
                <option value="">-- Selecciona un estudiante --</option>
                <?php while ($row = $estudiantes->fetch_assoc()): ?>
                    <option value="<?= $row['estudiante_id'] ?>"><?= $row['nombre_completo'] ?></option>
                <?php endwhile; ?>
            </select>
        </div>
        <div class="mb-3">
            <label for="curso" class="form-label">Selecciona un curso:</label>
            <select name="curso_id" id="curso" class="form-select" required>
                <option value="">-- Selecciona un curso --</option>
                <?php while ($row = $cursos->fetch_assoc()): ?>
                    <option value="<?= $row['curso_id'] ?>"><?= $row['nombre'] ?></option>
                <?php endwhile; ?>
            </select>
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-primary rounded">Inscribir</button>
        </div>
    </form>
</div>
