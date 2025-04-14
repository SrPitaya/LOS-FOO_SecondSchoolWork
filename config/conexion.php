<?php
$conn = new mysqli("localhost", "root", "root", "universidad_db2");

if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}
?>
