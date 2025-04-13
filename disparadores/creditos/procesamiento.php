<?php
require_once __DIR__ . '/../../config/conexion.php';

$estudiantes = $conn->query("SELECT estudiante_id, CONCAT(nombre, ' ', apellido) AS nombre_completo FROM estudiantes");
$cursos = $conn->query("SELECT curso_id, nombre FROM cursos");

$message = "";
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $estudiante_id = $_POST['estudiante_id'];
    $curso_id = $_POST['curso_id'];

    $query_horario = $conn->query("SELECT horario_id FROM horarios_cursos WHERE curso_id = $curso_id LIMIT 1");
    $horario = $query_horario->fetch_assoc();

    if (!$horario) {
        $message = "Error: No se encontró un horario para el curso seleccionado.";
    } else {
        $horario_id = $horario['horario_id'];

        try {
            $stmt = $conn->prepare("INSERT INTO inscripciones_cursos (estudiante_id, horario_id) VALUES (?, ?)");
            $stmt->bind_param("ii", $estudiante_id, $horario_id);
            $stmt->execute();

            $message = "Inscripción realizada con éxito.";
        } catch (mysqli_sql_exception $e) {
            if ($e->getCode() === 45000) {
                $message = "Error: " . $e->getMessage();
            } else {
                $message = "Error inesperado: " . $e->getMessage();
            }
        }
    }
}
?>
