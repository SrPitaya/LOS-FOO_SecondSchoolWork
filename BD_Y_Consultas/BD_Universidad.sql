-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.41 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para universidad_db2
CREATE DATABASE IF NOT EXISTS `universidad_db2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `universidad_db2`;

-- Volcando estructura para tabla universidad_db2.actividades
CREATE TABLE IF NOT EXISTS `actividades` (
  `actividad_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `tipo` enum('deportiva','cultural','academica') NOT NULL,
  `responsable_id` int DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `cupo_maximo` int DEFAULT NULL,
  `creditos_otorgados` int DEFAULT '0',
  PRIMARY KEY (`actividad_id`),
  KEY `responsable_id` (`responsable_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.actividades: 10 rows
/*!40000 ALTER TABLE `actividades` DISABLE KEYS */;
INSERT INTO `actividades` (`actividad_id`, `nombre`, `descripcion`, `tipo`, `responsable_id`, `fecha_inicio`, `fecha_fin`, `cupo_maximo`, `creditos_otorgados`) VALUES
	(1, 'Club de Programación', 'Reuniones semanales para resolver problemas de programación', 'academica', 1, '2020-02-10', '2020-11-30', 30, 1),
	(2, 'Equipo de Fútbol', 'Entrenamientos y partidos de fútbol universitario', 'deportiva', 3, '2020-02-15', '2020-12-15', 25, 1),
	(3, 'Taller de Escritura Creativa', 'Taller para desarrollar habilidades de escritura', 'cultural', 7, '2020-03-01', '2020-10-30', 20, 2),
	(4, 'Grupo de Investigación en IA', 'Investigación aplicada en inteligencia artificial', 'academica', 2, '2020-03-15', '2020-12-15', 15, 3),
	(5, 'Orquesta Universitaria', 'Grupo musical para estudiantes con conocimientos de instrumentos', 'cultural', 19, '2020-04-01', '2020-11-30', 40, 1),
	(6, 'Voluntariado Social', 'Actividades de apoyo a comunidades necesitadas', 'cultural', 5, '2020-04-15', '2020-12-15', 50, 2),
	(7, 'Club de Debate', 'Debates sobre temas de actualidad y política', 'academica', 9, '2020-05-01', '2020-11-30', 20, 1),
	(8, 'Equipo de Baloncesto', 'Entrenamientos y partidos de baloncesto', 'deportiva', 15, '2020-05-15', '2020-12-15', 15, 1),
	(9, 'Taller de Teatro', 'Montaje de obras teatrales estudiantiles', 'cultural', 7, '2020-06-01', '2020-10-30', 25, 2),
	(10, 'Grupo de Robótica', 'Diseño y construcción de robots para competencias', 'academica', 1, '2020-06-15', '2020-12-15', 20, 2);
/*!40000 ALTER TABLE `actividades` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.asignacion_profesores
CREATE TABLE IF NOT EXISTS `asignacion_profesores` (
  `asignacion_id` int NOT NULL AUTO_INCREMENT,
  `profesor_id` int NOT NULL,
  `horario_id` int NOT NULL,
  PRIMARY KEY (`asignacion_id`),
  KEY `profesor_id` (`profesor_id`),
  KEY `horario_id` (`horario_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.asignacion_profesores: 24 rows
/*!40000 ALTER TABLE `asignacion_profesores` DISABLE KEYS */;
INSERT INTO `asignacion_profesores` (`asignacion_id`, `profesor_id`, `horario_id`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 13, 3),
	(4, 13, 4),
	(5, 3, 5),
	(6, 3, 6),
	(7, 15, 7),
	(8, 15, 8),
	(9, 5, 9),
	(10, 5, 10),
	(11, 5, 11),
	(12, 17, 12),
	(13, 17, 13),
	(14, 7, 14),
	(15, 7, 15),
	(16, 19, 16),
	(17, 19, 17),
	(18, 9, 18),
	(19, 9, 19),
	(20, 1, 3),
	(21, 1, 4),
	(22, 1, 5),
	(23, 1, 7),
	(24, 1, 8);
/*!40000 ALTER TABLE `asignacion_profesores` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.aulas
CREATE TABLE IF NOT EXISTS `aulas` (
  `aula_id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `edificio` varchar(50) NOT NULL,
  `capacidad` int NOT NULL,
  `tipo` enum('normal','laboratorio','auditorio') DEFAULT 'normal',
  `recursos_disponibles` text,
  PRIMARY KEY (`aula_id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.aulas: 16 rows
/*!40000 ALTER TABLE `aulas` DISABLE KEYS */;
INSERT INTO `aulas` (`aula_id`, `codigo`, `edificio`, `capacidad`, `tipo`, `recursos_disponibles`) VALUES
	(1, 'A-101', 'Edificio Principal', 30, 'normal', 'Proyector, pizarra acrílica'),
	(2, 'A-102', 'Edificio Principal', 30, 'normal', 'Pizarra acrílica'),
	(3, 'A-201', 'Edificio Principal', 40, 'normal', 'Proyector, pantalla, pizarra'),
	(4, 'A-202', 'Edificio Principal', 40, 'normal', 'Pizarra, TV'),
	(5, 'B-101', 'Edificio Ciencias', 25, 'laboratorio', 'Computadores, proyector'),
	(6, 'B-102', 'Edificio Ciencias', 25, 'laboratorio', 'Computadores, pizarra interactiva'),
	(7, 'B-201', 'Edificio Ciencias', 20, 'laboratorio', 'Microscopios, equipos de laboratorio'),
	(8, 'B-202', 'Edificio Ciencias', 20, 'laboratorio', 'Equipos de química'),
	(9, 'C-101', 'Edificio Ingeniería', 50, 'normal', 'Proyector, pizarra grande'),
	(10, 'C-102', 'Edificio Ingeniería', 50, 'normal', 'Pizarra, sistema de audio'),
	(11, 'D-101', 'Auditorio Central', 150, 'auditorio', 'Proyector HD, sonido, micrófonos'),
	(12, 'D-201', 'Auditorio Pequeño', 80, 'auditorio', 'Proyector, sistema de audio'),
	(13, 'E-101', 'Edificio Humanidades', 35, 'normal', 'Pizarra, reproductor multimedia'),
	(14, 'E-102', 'Edificio Humanidades', 35, 'normal', 'Pizarra, TV'),
	(15, 'F-101', 'Edificio Medicina', 30, 'laboratorio', 'Maniquíes, equipos médicos'),
	(16, 'F-102', 'Edificio Medicina', 30, 'laboratorio', 'Equipos de anatomía');
/*!40000 ALTER TABLE `aulas` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.carreras
CREATE TABLE IF NOT EXISTS `carreras` (
  `carrera_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `duracion_semestres` int DEFAULT NULL,
  `creditos_totales` int DEFAULT NULL,
  `facultad_id` int DEFAULT NULL,
  `plan_estudio_id` int DEFAULT NULL,
  PRIMARY KEY (`carrera_id`),
  KEY `facultad_id` (`facultad_id`),
  KEY `plan_estudio_id` (`plan_estudio_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.carreras: 9 rows
/*!40000 ALTER TABLE `carreras` DISABLE KEYS */;
INSERT INTO `carreras` (`carrera_id`, `nombre`, `descripcion`, `duracion_semestres`, `creditos_totales`, `facultad_id`, `plan_estudio_id`) VALUES
	(1, 'Ingeniería de Sistemas', 'Formación en desarrollo de software y sistemas informáticos', 10, 160, 1, 2),
	(2, 'Ingeniería Civil', 'Formación en diseño y construcción de infraestructura', 10, 165, 1, 4),
	(3, 'Medicina', 'Formación médica general con enfoque clínico', 12, 210, 2, 6),
	(4, 'Enfermería', 'Formación en cuidado y atención de pacientes', 8, 140, 2, NULL),
	(5, 'Literatura', 'Estudio de obras literarias y teoría crítica', 8, 130, 3, 8),
	(6, 'Historia', 'Estudio de procesos históricos y análisis social', 8, 135, 3, NULL),
	(7, 'Economía', 'Formación en teoría y política económica', 8, 145, 4, 10),
	(8, 'Administración de Empresas', 'Formación en gestión organizacional', 8, 150, 4, NULL),
	(9, 'Derecho', 'Formación en ciencias jurídicas y legislación', 10, 170, 5, 12);
/*!40000 ALTER TABLE `carreras` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.categorias_libros
CREATE TABLE IF NOT EXISTS `categorias_libros` (
  `categoria_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`categoria_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.categorias_libros: 10 rows
/*!40000 ALTER TABLE `categorias_libros` DISABLE KEYS */;
INSERT INTO `categorias_libros` (`categoria_id`, `nombre`, `descripcion`) VALUES
	(1, 'Ciencias de la Computación', 'Libros sobre programación, algoritmos y teoría computacional'),
	(2, 'Ingeniería Civil', 'Libros sobre construcción, estructuras y materiales'),
	(3, 'Medicina', 'Libros de texto médicos y guías clínicas'),
	(4, 'Literatura', 'Obras literarias de ficción y no ficción'),
	(5, 'Economía', 'Libros sobre teoría económica y finanzas'),
	(6, 'Derecho', 'Textos jurídicos y códigos legales'),
	(7, 'Matemáticas', 'Libros de matemáticas puras y aplicadas'),
	(8, 'Historia', 'Libros sobre eventos y períodos históricos'),
	(9, 'Ciencias Naturales', 'Libros de biología, química y física'),
	(10, 'Arte y Diseño', 'Libros sobre teoría del arte y diseño');
/*!40000 ALTER TABLE `categorias_libros` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.cursos
CREATE TABLE IF NOT EXISTS `cursos` (
  `curso_id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `creditos` int NOT NULL,
  `horas_semanales` int DEFAULT NULL,
  `departamento_id` int DEFAULT NULL,
  `semestre_recomendado` int DEFAULT NULL,
  `tipo` enum('obligatorio','electivo') DEFAULT 'obligatorio',
  PRIMARY KEY (`curso_id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `departamento_id` (`departamento_id`)
) ENGINE=MyISAM AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.cursos: 60 rows
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
INSERT INTO `cursos` (`curso_id`, `codigo`, `nombre`, `descripcion`, `creditos`, `horas_semanales`, `departamento_id`, `semestre_recomendado`, `tipo`) VALUES
	(1, 'IS-101', 'Introducción a la Programación', 'Fundamentos de programación con Python', 4, 5, 1, 1, 'obligatorio'),
	(2, 'IS-102', 'Estructuras de Datos', 'Listas, pilas, colas, árboles y grafos', 4, 5, 1, 2, 'obligatorio'),
	(3, 'IS-201', 'Bases de Datos I', 'Modelado y SQL básico', 4, 5, 1, 3, 'obligatorio'),
	(4, 'IS-202', 'Bases de Datos II', 'SQL avanzado y normalización', 4, 5, 1, 4, 'obligatorio'),
	(5, 'IS-301', 'Ingeniería de Software', 'Procesos y metodologías de desarrollo', 4, 5, 1, 5, 'obligatorio'),
	(6, 'IS-302', 'Arquitectura de Software', 'Patrones y estilos arquitectónicos', 4, 5, 1, 6, 'obligatorio'),
	(7, 'IS-401', 'Sistemas Operativos', 'Fundamentos de sistemas operativos', 4, 5, 1, 7, 'obligatorio'),
	(8, 'IS-402', 'Redes de Computadores', 'Protocolos y arquitecturas de red', 4, 5, 1, 8, 'obligatorio'),
	(9, 'IS-501', 'Inteligencia Artificial', 'Fundamentos de IA y machine learning', 4, 5, 1, 9, 'electivo'),
	(10, 'IS-502', 'Desarrollo Web Avanzado', 'Frameworks modernos para web', 4, 5, 1, 10, 'electivo'),
	(11, 'IC-101', 'Introducción a la Ingeniería Civil', 'Historia y campos de aplicación', 3, 4, 2, 1, 'obligatorio'),
	(12, 'IC-102', 'Dibujo Técnico', 'Técnicas de representación gráfica', 3, 4, 2, 1, 'obligatorio'),
	(13, 'IC-201', 'Mecánica de Materiales', 'Comportamiento de materiales bajo carga', 4, 5, 2, 3, 'obligatorio'),
	(14, 'IC-202', 'Hidráulica', 'Principios de flujo de fluidos', 4, 5, 2, 4, 'obligatorio'),
	(15, 'IC-301', 'Estructuras de Concreto', 'Diseño de elementos de concreto', 4, 5, 2, 5, 'obligatorio'),
	(16, 'IC-302', 'Geotecnia', 'Mecánica de suelos y cimentaciones', 4, 5, 2, 6, 'obligatorio'),
	(17, 'IC-401', 'Vías y Transporte', 'Diseño de infraestructura vial', 4, 5, 2, 7, 'obligatorio'),
	(18, 'IC-402', 'Construcción Sostenible', 'Técnicas de construcción ecológica', 3, 4, 2, 8, 'electivo'),
	(19, 'IC-501', 'Ingeniería Sísmica', 'Diseño antisísmico de estructuras', 4, 5, 2, 9, 'electivo'),
	(20, 'IC-502', 'Gestión de Proyectos', 'Metodologías PMI y ágiles', 3, 4, 2, 10, 'electivo'),
	(21, 'MED-101', 'Anatomía Humana', 'Estructura del cuerpo humano', 6, 8, 4, 1, 'obligatorio'),
	(22, 'MED-102', 'Bioquímica Médica', 'Fundamentos moleculares de la medicina', 5, 7, 4, 1, 'obligatorio'),
	(23, 'MED-201', 'Fisiología', 'Funcionamiento de sistemas corporales', 6, 8, 4, 3, 'obligatorio'),
	(24, 'MED-202', 'Microbiología', 'Microorganismos y enfermedades', 5, 7, 4, 4, 'obligatorio'),
	(25, 'MED-301', 'Patología', 'Estudio de enfermedades', 6, 8, 4, 5, 'obligatorio'),
	(26, 'MED-302', 'Farmacología', 'Fármacos y su mecanismo de acción', 5, 7, 4, 6, 'obligatorio'),
	(27, 'MED-401', 'Medicina Interna', 'Diagnóstico y tratamiento médico', 6, 8, 4, 7, 'obligatorio'),
	(28, 'MED-402', 'Cirugía General', 'Principios quirúrgicos básicos', 6, 8, 4, 8, 'obligatorio'),
	(29, 'MED-501', 'Pediatría', 'Medicina para niños y adolescentes', 5, 7, 4, 9, 'electivo'),
	(30, 'MED-502', 'Neurología', 'Sistema nervioso y sus enfermedades', 5, 7, 4, 10, 'electivo'),
	(31, 'LIT-101', 'Introducción a la Literatura', 'Géneros y análisis literario', 3, 4, 6, 1, 'obligatorio'),
	(32, 'LIT-102', 'Literatura Universal', 'Obras fundamentales de la literatura mundial', 3, 4, 6, 1, 'obligatorio'),
	(33, 'LIT-201', 'Literatura Latinoamericana', 'Autores y movimientos latinoamericanos', 4, 5, 6, 3, 'obligatorio'),
	(34, 'LIT-202', 'Literatura Española', 'Desde el Cantar del Mío Cid hasta el siglo XX', 4, 5, 6, 4, 'obligatorio'),
	(35, 'LIT-301', 'Teoría Literaria', 'Corrientes críticas y análisis textual', 4, 5, 6, 5, 'obligatorio'),
	(36, 'LIT-302', 'Literatura Contemporánea', 'Tendencias actuales en literatura', 4, 5, 6, 6, 'obligatorio'),
	(37, 'LIT-401', 'Taller de Creación Literaria', 'Escritura de cuento y poesía', 3, 4, 6, 7, 'electivo'),
	(38, 'LIT-402', 'Literatura y Cine', 'Adaptaciones cinematográficas de obras literarias', 3, 4, 6, 8, 'electivo'),
	(39, 'LIT-501', 'Literatura Fantástica', 'Análisis del género fantástico', 3, 4, 6, 9, 'electivo'),
	(40, 'LIT-502', 'Crítica Literaria', 'Enfoques para la evaluación de obras', 3, 4, 6, 10, 'electivo'),
	(41, 'ECO-101', 'Principios de Economía', 'Conceptos básicos de micro y macroeconomía', 4, 5, 8, 1, 'obligatorio'),
	(42, 'ECO-102', 'Matemáticas para Economistas', 'Herramientas matemáticas aplicadas', 4, 5, 8, 1, 'obligatorio'),
	(43, 'ECO-201', 'Microeconomía Intermedia', 'Teoría del consumidor y productor', 4, 5, 8, 3, 'obligatorio'),
	(44, 'ECO-202', 'Macroeconomía Intermedia', 'Modelos macroeconómicos básicos', 4, 5, 8, 4, 'obligatorio'),
	(45, 'ECO-301', 'Econometría', 'Análisis estadístico de datos económicos', 4, 5, 8, 5, 'obligatorio'),
	(46, 'ECO-302', 'Economía Internacional', 'Comercio y finanzas internacionales', 4, 5, 8, 6, 'obligatorio'),
	(47, 'ECO-401', 'Política Económica', 'Diseño y evaluación de políticas', 4, 5, 8, 7, 'obligatorio'),
	(48, 'ECO-402', 'Historia Económica', 'Desarrollo económico a través del tiempo', 3, 4, 8, 8, 'electivo'),
	(49, 'ECO-501', 'Economía Ambiental', 'Recursos naturales y desarrollo sostenible', 3, 4, 8, 9, 'electivo'),
	(50, 'ECO-502', 'Economía del Comportamiento', 'Psicología en la toma de decisiones económicas', 3, 4, 8, 10, 'electivo'),
	(51, 'DER-101', 'Introducción al Derecho', 'Conceptos jurídicos fundamentales', 4, 5, 10, 1, 'obligatorio'),
	(52, 'DER-102', 'Derecho Romano', 'Fundamentos históricos del derecho', 3, 4, 10, 1, 'obligatorio'),
	(53, 'DER-201', 'Derecho Civil I', 'Personas y familia', 4, 5, 11, 3, 'obligatorio'),
	(54, 'DER-202', 'Derecho Penal I', 'Teoría del delito', 4, 5, 10, 4, 'obligatorio'),
	(55, 'DER-301', 'Derecho Comercial', 'Sociedades y contratos mercantiles', 4, 5, 11, 5, 'obligatorio'),
	(56, 'DER-302', 'Derecho Laboral', 'Relaciones individuales y colectivas de trabajo', 4, 5, 10, 6, 'obligatorio'),
	(57, 'DER-401', 'Derecho Constitucional', 'Teoría de la constitución y control de constitucionalidad', 4, 5, 10, 7, 'obligatorio'),
	(58, 'DER-402', 'Derecho Internacional Público', 'Sujetos y fuentes del derecho internacional', 3, 4, 10, 8, 'electivo'),
	(59, 'DER-501', 'Derecho Ambiental', 'Protección jurídica del medio ambiente', 3, 4, 11, 9, 'electivo'),
	(60, 'DER-502', 'Derechos Humanos', 'Sistema internacional de protección', 3, 4, 10, 10, 'electivo');
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.departamentos
CREATE TABLE IF NOT EXISTS `departamentos` (
  `departamento_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `facultad_id` int NOT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `jefe_departamento_id` int DEFAULT NULL,
  PRIMARY KEY (`departamento_id`),
  KEY `facultad_id` (`facultad_id`),
  KEY `jefe_departamento_id` (`jefe_departamento_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.departamentos: 11 rows
/*!40000 ALTER TABLE `departamentos` DISABLE KEYS */;
INSERT INTO `departamentos` (`departamento_id`, `nombre`, `facultad_id`, `fecha_creacion`, `jefe_departamento_id`) VALUES
	(1, 'Ingeniería de Sistemas', 1, '1982-06-15', 1),
	(2, 'Ingeniería Civil', 1, '1980-05-20', 3),
	(3, 'Matemáticas', 1, '1978-09-12', 4),
	(4, 'Medicina', 2, '1975-04-01', 5),
	(5, 'Enfermería', 2, '1977-03-15', 6),
	(6, 'Literatura', 3, '1969-01-20', 7),
	(7, 'Historia', 3, '1970-05-30', 8),
	(8, 'Economía', 4, '1985-12-01', 9),
	(9, 'Administración', 4, '1986-02-15', 10),
	(10, 'Derecho Penal', 5, '1972-03-01', 11),
	(11, 'Derecho Civil', 5, '1973-04-15', 12);
/*!40000 ALTER TABLE `departamentos` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.estudiantes
CREATE TABLE IF NOT EXISTS `estudiantes` (
  `estudiante_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero` enum('M','F','O') DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `estado` enum('activo','graduado','retirado') DEFAULT 'activo',
  PRIMARY KEY (`estudiante_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.estudiantes: 21 rows
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
INSERT INTO `estudiantes` (`estudiante_id`, `nombre`, `apellido`, `fecha_nacimiento`, `genero`, `direccion`, `telefono`, `email`, `fecha_ingreso`, `estado`) VALUES
	(1, 'Juan', 'Pérez', '1998-05-15', 'M', 'Calle 123 #45-67', '3101111111', 'juan.perez@estudiantes.edu', '2020-01-20', 'activo'),
	(2, 'María', 'Gómez', '1999-03-22', 'F', 'Av. Principal #12-34', '3152222222', 'maria.gomez@estudiantes.edu', '2020-01-20', 'activo'),
	(3, 'Carlos', 'Rodríguez', '1997-11-10', 'M', 'Carrera 56 #78-90', '3203333333', 'carlos.rodriguez@estudiantes.edu', '2019-08-12', 'activo'),
	(4, 'Ana', 'López', '2000-07-30', 'F', 'Diagonal 23 #45-67', '3174444444', 'ana.lopez@estudiantes.edu', '2021-01-25', 'activo'),
	(5, 'Luis', 'Martínez', '1998-09-18', 'M', 'Calle 78 #90-12', '3135555555', 'luis.martinez@estudiantes.edu', '2020-08-10', 'activo'),
	(6, 'Laura', 'Díaz', '1999-02-05', 'F', 'Av. Siempre Viva #123', '3186666666', 'laura.diaz@estudiantes.edu', '2021-01-25', 'activo'),
	(7, 'Pedro', 'Hernández', '1997-12-28', 'M', 'Carrera 34 #56-78', '3147777777', 'pedro.hernandez@estudiantes.edu', '2019-08-12', 'graduado'),
	(8, 'Sofía', 'García', '2000-04-15', 'F', 'Calle 90 #12-34', '3198888888', 'sofia.garcia@estudiantes.edu', '2021-08-09', 'activo'),
	(9, 'Jorge', 'Sánchez', '1998-08-20', 'M', 'Av. Central #45-67', '3129999999', 'jorge.sanchez@estudiantes.edu', '2020-01-20', 'activo'),
	(10, 'Diana', 'Ramírez', '1999-06-12', 'F', 'Diagonal 56 #78-90', '3161010101', 'diana.ramirez@estudiantes.edu', '2021-01-25', 'activo'),
	(11, 'Miguel', 'Torres', '1997-10-05', 'M', 'Calle 34 #56-78', '3111111111', 'miguel.torres@estudiantes.edu', '2019-08-12', 'graduado'),
	(12, 'Alejandra', 'Vargas', '2000-01-30', 'F', 'Carrera 12 #34-56', '3171212121', 'alejandra.vargas@estudiantes.edu', '2021-08-09', 'activo'),
	(13, 'Andrés', 'Castro', '1998-03-25', 'M', 'Av. Norte #67-89', '3131313131', 'andres.castro@estudiantes.edu', '2020-01-20', 'activo'),
	(14, 'Carmen', 'Ortiz', '1999-07-03', 'F', 'Calle 45 #67-89', '3181414141', 'carmen.ortiz@estudiantes.edu', '2021-01-25', 'activo'),
	(15, 'Oscar', 'Mendoza', '1997-09-11', 'M', 'Carrera 78 #90-12', '3141515151', 'oscar.mendoza@estudiantes.edu', '2019-08-12', 'retirado'),
	(16, 'Tatiana', 'Rojas', '2000-04-05', 'F', 'Diagonal 12 #34-56', '3191616161', 'tatiana.rojas@estudiantes.edu', '2021-08-09', 'activo'),
	(17, 'Pablo', 'Gutiérrez', '1998-11-28', 'M', 'Av. Sur #23-45', '3151717171', 'pablo.gutierrez@estudiantes.edu', '2020-01-20', 'activo'),
	(18, 'Claudia', 'Silva', '1999-08-14', 'F', 'Calle 67 #89-01', '3111818181', 'claudia.silva@estudiantes.edu', '2021-01-25', 'activo'),
	(19, 'Fernando', 'Morales', '1997-01-20', 'M', 'Carrera 45 #67-89', '3171919191', 'fernando.morales@estudiantes.edu', '2019-08-12', 'graduado'),
	(20, 'Lucía', 'Fernández', '2000-06-07', 'F', 'Av. Oriental #34-56', '3132020202', 'lucia.fernandez@estudiantes.edu', '2021-08-09', 'activo'),
	(24, 'Carlos', 'Ramírez', '2002-03-15', 'M', 'Calle Principal #123', '3105551234', 'carlos.ramirez@valladolid.tecnm.com.mx', '2025-01-10', 'activo');
/*!40000 ALTER TABLE `estudiantes` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.eventos
CREATE TABLE IF NOT EXISTS `eventos` (
  `evento_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `tipo` enum('conferencia','taller','exposicion','seminario') NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time DEFAULT NULL,
  `lugar` varchar(100) NOT NULL,
  `facultad_id` int DEFAULT NULL,
  `departamento_id` int DEFAULT NULL,
  `publico_objetivo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`evento_id`),
  KEY `facultad_id` (`facultad_id`),
  KEY `departamento_id` (`departamento_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.eventos: 10 rows
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` (`evento_id`, `nombre`, `descripcion`, `tipo`, `fecha`, `hora_inicio`, `hora_fin`, `lugar`, `facultad_id`, `departamento_id`, `publico_objetivo`) VALUES
	(1, 'Conferencia de Inteligencia Artificial', 'Avances recientes en IA y machine learning', 'conferencia', '2020-03-15', '10:00:00', '12:00:00', 'Auditorio Central', 1, 1, 'Estudiantes de ingeniería'),
	(2, 'Taller de Escritura Académica', 'Técnicas para mejorar la redacción de artículos científicos', 'taller', '2020-04-05', '14:00:00', '17:00:00', 'Aula B-101', 3, 6, 'Estudiantes de posgrado'),
	(3, 'Exposición de Arte Contemporáneo', 'Obras de artistas emergentes de la región', 'exposicion', '2020-05-20', '09:00:00', '18:00:00', 'Galería Universitaria', 3, NULL, 'Comunidad universitaria'),
	(4, 'Seminario de Derechos Humanos', 'Discusión sobre los desafíos actuales de los DDHH', 'seminario', '2020-06-10', '08:30:00', '13:00:00', 'Auditorio Pequeño', 5, 10, 'Estudiantes de derecho y público general'),
	(5, 'Feria de Empleo', 'Oportunidades laborales para egresados', 'taller', '2020-08-25', '09:00:00', '16:00:00', 'Plaza Central', 4, NULL, 'Estudiantes próximos a graduarse'),
	(6, 'Concierto de la Orquesta Universitaria', 'Presentación de repertorio clásico y contemporáneo', 'conferencia', '2020-09-15', '19:00:00', '21:00:00', 'Auditorio Central', 3, NULL, 'Comunidad universitaria y público general'),
	(7, 'Charla sobre Emprendimiento', 'Experiencias de emprendedores exitosos', 'conferencia', '2020-10-08', '16:00:00', '18:00:00', 'Aula C-101', 4, 9, 'Estudiantes de administración y economía'),
	(8, 'Exposición de Proyectos de Ingeniería', 'Presentación de trabajos finales de estudiantes', 'exposicion', '2020-11-20', '10:00:00', '16:00:00', 'Edificio Ingeniería', 1, NULL, 'Comunidad universitaria y empresas'),
	(9, 'Taller de Primeros Auxilios', 'Capacitación básica en atención de emergencias', 'taller', '2020-12-05', '08:00:00', '12:00:00', 'Aula F-101', 2, 5, 'Estudiantes y personal universitario'),
	(10, 'Seminario de Literatura Contemporánea', 'Análisis de tendencias en la literatura actual', 'seminario', '2021-03-10', '09:00:00', '13:00:00', 'Auditorio Pequeño', 3, 6, 'Estudiantes de humanidades');
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.facultades
CREATE TABLE IF NOT EXISTS `facultades` (
  `facultad_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `fecha_creacion` date DEFAULT NULL,
  `decano_id` int DEFAULT NULL,
  PRIMARY KEY (`facultad_id`),
  KEY `decano_id` (`decano_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.facultades: 5 rows
/*!40000 ALTER TABLE `facultades` DISABLE KEYS */;
INSERT INTO `facultades` (`facultad_id`, `nombre`, `descripcion`, `fecha_creacion`, `decano_id`) VALUES
	(1, 'Ingeniería', 'Facultad de Ingeniería y Ciencias Básicas', '1980-05-15', 1),
	(2, 'Ciencias de la Salud', 'Facultad de Medicina, Enfermería y Ciencias de la Salud', '1975-03-20', 5),
	(3, 'Humanidades', 'Facultad de Artes y Humanidades', '1968-08-10', 7),
	(4, 'Ciencias Económicas', 'Facultad de Economía y Administración', '1985-11-25', 9),
	(5, 'Derecho', 'Facultad de Derecho y Ciencias Políticas', '1972-02-18', 11);
/*!40000 ALTER TABLE `facultades` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.historial_academico
CREATE TABLE IF NOT EXISTS `historial_academico` (
  `historial_id` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int NOT NULL,
  `curso_id` int NOT NULL,
  `semestre_id` int NOT NULL,
  `calificacion` decimal(3,1) DEFAULT NULL,
  `estado` enum('aprobado','reprobado') DEFAULT NULL,
  PRIMARY KEY (`historial_id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `curso_id` (`curso_id`),
  KEY `semestre_id` (`semestre_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.historial_academico: 20 rows
/*!40000 ALTER TABLE `historial_academico` DISABLE KEYS */;
INSERT INTO `historial_academico` (`historial_id`, `estudiante_id`, `curso_id`, `semestre_id`, `calificacion`, `estado`) VALUES
	(1, 1, 1, 1, 4.5, 'aprobado'),
	(2, 1, 2, 1, 3.8, 'aprobado'),
	(3, 1, 3, 2, 4.2, 'aprobado'),
	(4, 1, 4, 2, 4.0, 'aprobado'),
	(5, 1, 5, 3, 3.9, 'aprobado'),
	(6, 1, 6, 3, 4.1, 'aprobado'),
	(7, 1, 7, 4, 4.3, 'aprobado'),
	(8, 1, 8, 4, 3.7, 'aprobado'),
	(9, 2, 1, 1, 4.2, 'aprobado'),
	(10, 2, 2, 1, 4.0, 'aprobado'),
	(11, 2, 3, 2, 3.9, 'aprobado'),
	(12, 2, 4, 2, 4.1, 'aprobado'),
	(13, 2, 5, 3, 4.5, 'aprobado'),
	(14, 2, 6, 3, 3.8, 'aprobado'),
	(15, 3, 11, 1, 4.0, 'aprobado'),
	(16, 3, 12, 1, 3.2, 'aprobado'),
	(17, 3, 13, 2, 3.8, 'aprobado'),
	(18, 3, 14, 2, 4.2, 'aprobado'),
	(19, 3, 15, 3, 3.5, 'aprobado'),
	(20, 3, 16, 3, 4.0, 'aprobado');
/*!40000 ALTER TABLE `historial_academico` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.horarios_cursos
CREATE TABLE IF NOT EXISTS `horarios_cursos` (
  `horario_id` int NOT NULL AUTO_INCREMENT,
  `curso_id` int NOT NULL,
  `semestre_id` int NOT NULL,
  `dia_semana` enum('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado') NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `aula_id` int DEFAULT NULL,
  PRIMARY KEY (`horario_id`),
  KEY `curso_id` (`curso_id`),
  KEY `semestre_id` (`semestre_id`),
  KEY `aula_id` (`aula_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.horarios_cursos: 19 rows
/*!40000 ALTER TABLE `horarios_cursos` DISABLE KEYS */;
INSERT INTO `horarios_cursos` (`horario_id`, `curso_id`, `semestre_id`, `dia_semana`, `hora_inicio`, `hora_fin`, `aula_id`) VALUES
	(1, 1, 1, 'Lunes', '08:00:00', '10:00:00', 1),
	(2, 1, 1, 'Miércoles', '08:00:00', '10:00:00', 1),
	(3, 2, 1, 'Martes', '10:00:00', '12:00:00', 2),
	(4, 2, 1, 'Jueves', '10:00:00', '12:00:00', 2),
	(5, 11, 1, 'Lunes', '14:00:00', '16:00:00', 9),
	(6, 11, 1, 'Viernes', '14:00:00', '16:00:00', 9),
	(7, 12, 1, 'Martes', '16:00:00', '18:00:00', 10),
	(8, 12, 1, 'Jueves', '16:00:00', '18:00:00', 10),
	(9, 21, 1, 'Lunes', '07:00:00', '09:00:00', 15),
	(10, 21, 1, 'Miércoles', '07:00:00', '09:00:00', 15),
	(11, 21, 1, 'Viernes', '07:00:00', '09:00:00', 15),
	(12, 22, 1, 'Martes', '09:00:00', '11:00:00', 16),
	(13, 22, 1, 'Jueves', '09:00:00', '11:00:00', 16),
	(14, 31, 1, 'Lunes', '18:00:00', '20:00:00', 13),
	(15, 31, 1, 'Miércoles', '18:00:00', '20:00:00', 13),
	(16, 41, 1, 'Martes', '14:00:00', '16:00:00', 3),
	(17, 41, 1, 'Jueves', '14:00:00', '16:00:00', 3),
	(18, 51, 1, 'Lunes', '16:00:00', '18:00:00', 4),
	(19, 51, 1, 'Miércoles', '16:00:00', '18:00:00', 4);
/*!40000 ALTER TABLE `horarios_cursos` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.inscripciones_actividades
CREATE TABLE IF NOT EXISTS `inscripciones_actividades` (
  `inscripcion_id` int NOT NULL AUTO_INCREMENT,
  `actividad_id` int NOT NULL,
  `estudiante_id` int NOT NULL,
  `fecha_inscripcion` date NOT NULL,
  `asistencia_total` int DEFAULT '0',
  `estado` enum('activo','completado','retirado') DEFAULT 'activo',
  `calificacion` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`inscripcion_id`),
  KEY `actividad_id` (`actividad_id`),
  KEY `estudiante_id` (`estudiante_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.inscripciones_actividades: 20 rows
/*!40000 ALTER TABLE `inscripciones_actividades` DISABLE KEYS */;
INSERT INTO `inscripciones_actividades` (`inscripcion_id`, `actividad_id`, `estudiante_id`, `fecha_inscripcion`, `asistencia_total`, `estado`, `calificacion`) VALUES
	(1, 1, 1, '2020-02-05', 25, 'completado', 'A'),
	(2, 1, 2, '2020-02-05', 20, 'completado', 'B'),
	(3, 1, 10, '2020-02-05', 15, 'completado', 'C'),
	(4, 2, 3, '2020-02-10', 30, 'completado', 'A'),
	(5, 2, 16, '2020-02-10', 25, 'completado', 'B'),
	(6, 3, 4, '2020-02-25', 18, 'completado', 'A'),
	(7, 3, 18, '2020-02-25', 12, 'retirado', NULL),
	(8, 4, 1, '2020-03-10', 35, 'completado', 'A'),
	(9, 4, 2, '2020-03-10', 30, 'completado', 'A'),
	(10, 5, 5, '2020-03-20', 20, 'completado', 'B'),
	(11, 5, 19, '2020-03-20', 15, 'completado', 'C'),
	(12, 6, 6, '2020-04-05', 25, 'completado', 'A'),
	(13, 6, 20, '2020-04-05', 20, 'completado', 'B'),
	(14, 7, 7, '2020-04-20', 18, 'completado', 'A'),
	(15, 7, 14, '2020-04-20', 10, 'retirado', NULL),
	(16, 8, 8, '2020-05-05', 30, 'completado', 'B'),
	(17, 8, 17, '2020-05-05', 25, 'completado', 'A'),
	(18, 9, 9, '2020-05-20', 15, 'completado', 'A'),
	(19, 9, 12, '2020-05-20', 10, 'completado', 'C'),
	(20, 10, 10, '2020-06-10', 20, 'activo', NULL);
/*!40000 ALTER TABLE `inscripciones_actividades` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.inscripciones_cursos
CREATE TABLE IF NOT EXISTS `inscripciones_cursos` (
  `inscripcion_id` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int NOT NULL,
  `horario_id` int NOT NULL,
  `calificacion_final` decimal(3,1) DEFAULT NULL,
  `estado` enum('en_curso','aprobado','reprobado','retirado') DEFAULT 'en_curso',
  PRIMARY KEY (`inscripcion_id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `horario_id` (`horario_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.inscripciones_cursos: 17 rows
/*!40000 ALTER TABLE `inscripciones_cursos` DISABLE KEYS */;
INSERT INTO `inscripciones_cursos` (`inscripcion_id`, `estudiante_id`, `horario_id`, `calificacion_final`, `estado`) VALUES
	(1, 1, 1, 4.5, 'aprobado'),
	(2, 1, 3, 3.8, 'aprobado'),
	(3, 2, 1, 4.2, 'aprobado'),
	(4, 2, 3, 4.0, 'aprobado'),
	(5, 10, 1, 3.5, 'aprobado'),
	(6, 10, 3, 2.8, 'reprobado'),
	(7, 3, 5, 4.0, 'aprobado'),
	(8, 3, 7, 3.2, 'aprobado'),
	(9, 16, 5, 2.5, 'reprobado'),
	(10, 16, 7, 3.0, 'aprobado'),
	(11, 4, 9, 4.8, 'aprobado'),
	(12, 4, 11, 4.5, 'aprobado'),
	(13, 4, 12, 4.2, 'aprobado'),
	(14, 18, 9, 3.9, 'aprobado'),
	(15, 18, 11, 3.5, 'aprobado'),
	(16, 18, 12, 2.9, 'reprobado'),
	(19, 1, 5, NULL, 'en_curso');
/*!40000 ALTER TABLE `inscripciones_cursos` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.libros
CREATE TABLE IF NOT EXISTS `libros` (
  `libro_id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `autor` varchar(100) NOT NULL,
  `editorial` varchar(100) DEFAULT NULL,
  `año_publicacion` int DEFAULT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `edicion` varchar(20) DEFAULT NULL,
  `categoria_id` int DEFAULT NULL,
  `cantidad_ejemplares` int DEFAULT '1',
  `ubicacion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`libro_id`),
  UNIQUE KEY `ISBN` (`ISBN`),
  KEY `categoria_id` (`categoria_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.libros: 20 rows
/*!40000 ALTER TABLE `libros` DISABLE KEYS */;
INSERT INTO `libros` (`libro_id`, `titulo`, `autor`, `editorial`, `año_publicacion`, `ISBN`, `edicion`, `categoria_id`, `cantidad_ejemplares`, `ubicacion`) VALUES
	(1, 'Introducción a los Algoritmos', 'Thomas H. Cormen', 'MIT Press', 2009, '9780262033848', '3ra', 1, -1, 'Estante A1'),
	(2, 'Clean Code', 'Robert C. Martin', 'Prentice Hall', 2008, '9780132350884', '1ra', 1, 3, 'Estante A2'),
	(3, 'Diseño de Estructuras de Concreto', 'Arthur H. Nilson', 'McGraw-Hill', 2010, '9786071505314', '14ta', 2, 2, 'Estante B1'),
	(4, 'Mecánica de Materiales', 'Russell C. Hibbeler', 'Pearson', 2011, '9786074425610', '7ma', 2, 4, 'Estante B2'),
	(5, 'Anatomía de Gray', 'Henry Gray', 'Elsevier', 2015, '9788491130418', '41ra', 3, 3, 'Estante C1'),
	(6, 'Harrison. Principios de Medicina Interna', 'Dennis L. Kasper', 'McGraw-Hill', 2016, '9786071513937', '19na', 3, 2, 'Estante C2'),
	(7, 'Cien Años de Soledad', 'Gabriel García Márquez', 'Sudamericana', 1967, '9780307474728', '1ra', 4, 5, 'Estante D1'),
	(8, 'La Ciudad y los Perros', 'Mario Vargas Llosa', 'Alfaguara', 1963, '9788420471839', '1ra', 4, 4, 'Estante D2'),
	(9, 'Principios de Economía', 'N. Gregory Mankiw', 'Cengage', 2012, '9786074817797', '6ta', 5, 5, 'Estante E1'),
	(10, 'Freakonomics', 'Steven D. Levitt', 'Ediciones B', 2005, '9788466621092', '1ra', 5, 3, 'Estante E2'),
	(11, 'Código Civil', 'Varios Autores', 'Editorial Legis', 2020, '9789587674782', 'Actualizada', 6, 2, 'Estante F1'),
	(12, 'Manual de Derecho Penal', 'Claus Roxin', 'Civitas', 2015, '9788447046763', '4ta', 6, 2, 'Estante F2'),
	(13, 'Cálculo de una Variable', 'James Stewart', 'Cengage', 2012, '9786074813065', '7ma', 7, 4, 'Estante G1'),
	(14, 'Álgebra Lineal', 'Stanley I. Grossman', 'McGraw-Hill', 2012, '9786071503051', '7ma', 7, 3, 'Estante G2'),
	(15, 'Breve Historia del Mundo', 'Ernst H. Gombrich', 'Península', 1999, '9788483077102', '1ra', 8, 2, 'Estante H1'),
	(16, 'Sapiens', 'Yuval Noah Harari', 'Debate', 2014, '9788499926223', '1ra', 8, 3, 'Estante H2'),
	(17, 'El Gen Egoísta', 'Richard Dawkins', 'Salvat', 2000, '9788434509303', '1ra', 9, 2, 'Estante I1'),
	(18, 'Breves Respuestas a las Grandes Preguntas', 'Stephen Hawking', 'Crítica', 2018, '9788491990446', '1ra', 9, 2, 'Estante I2'),
	(19, 'Historia del Arte', 'E. H. Gombrich', 'Phaidon', 2006, '9780714898704', '16ta', 10, 3, 'Estante J1'),
	(20, 'Los Elementos del Estilo Tipográfico', 'Robert Bringhurst', 'Fondo de Cultura Económica', 2008, '9789685374399', '3ra', 10, 2, 'Estante J2');
/*!40000 ALTER TABLE `libros` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.logs
CREATE TABLE IF NOT EXISTS `logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `tabla_afectada` varchar(50) NOT NULL,
  `registro_id` int NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `accion` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `detalles` text,
  PRIMARY KEY (`log_id`),
  KEY `tabla_afectada` (`tabla_afectada`),
  KEY `registro_id` (`registro_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.logs: 7 rows
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` (`log_id`, `tabla_afectada`, `registro_id`, `nombre_completo`, `accion`, `fecha_creacion`, `detalles`) VALUES
	(3, 'estudiantes', 23, 'Carlos Ramírez', 'INSERT', '2025-04-13 15:09:03', 'Nuevo estudiante registrado: carlos.ramirez@valladolid.tecnm.com.mx'),
	(4, 'estudiantes', 21, 'Miguel Hernández', 'DELETE', '2025-04-13 15:10:00', 'Estudiante eliminado. Correo: miguelpoc.hernandez@valladolid.tecnm.com.mx'),
	(5, 'profesores', 37, 'Ana Gómez', 'INSERT', '2025-04-13 15:12:16', 'Nuevo profesor registrado: ana.gomez@valladolid.tecnm.mx'),
	(6, 'estudiantes', 23, 'Carlos Ramírez', 'DELETE', '2025-04-13 15:20:28', 'Estudiante eliminado. Correo: carlos.ramirez@valladolid.tecnm.com.mx'),
	(7, 'profesores', 37, 'Ana Gómez', 'DELETE', '2025-04-13 15:21:56', 'Profesor eliminado. Correo: ana.gomez@valladolid.tecnm.mx'),
	(8, 'estudiantes', 24, 'Carlos Ramírez', 'INSERT', '2025-04-13 15:30:36', 'Nuevo estudiante registrado: carlos.ramirez@valladolid.tecnm.com.mx'),
	(9, 'profesores', 38, 'Ana Gómez', 'INSERT', '2025-04-13 15:33:13', 'Nuevo profesor registrado: ana.gomez@valladolid.tecnm.mx');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.matriculas
CREATE TABLE IF NOT EXISTS `matriculas` (
  `matricula_id` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int NOT NULL,
  `carrera_id` int NOT NULL,
  `fecha_matricula` date NOT NULL,
  `semestre_id` int NOT NULL,
  `estado` enum('activa','congelada','finalizada') DEFAULT 'activa',
  PRIMARY KEY (`matricula_id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `carrera_id` (`carrera_id`),
  KEY `semestre_id` (`semestre_id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.matriculas: 30 rows
/*!40000 ALTER TABLE `matriculas` DISABLE KEYS */;
INSERT INTO `matriculas` (`matricula_id`, `estudiante_id`, `carrera_id`, `fecha_matricula`, `semestre_id`, `estado`) VALUES
	(1, 1, 1, '2020-01-15', 1, 'finalizada'),
	(2, 1, 1, '2020-07-30', 2, 'finalizada'),
	(3, 1, 1, '2021-01-10', 3, 'finalizada'),
	(4, 1, 1, '2021-07-25', 4, 'finalizada'),
	(5, 1, 1, '2022-01-12', 5, 'finalizada'),
	(6, 1, 1, '2022-07-28', 6, 'finalizada'),
	(7, 1, 1, '2023-01-15', 7, 'finalizada'),
	(8, 1, 1, '2023-07-30', 8, 'finalizada'),
	(9, 1, 1, '2024-01-10', 9, 'activa'),
	(10, 2, 1, '2020-01-15', 1, 'finalizada'),
	(11, 2, 1, '2020-07-30', 2, 'finalizada'),
	(12, 2, 1, '2021-01-10', 3, 'finalizada'),
	(13, 2, 1, '2021-07-25', 4, 'finalizada'),
	(14, 2, 1, '2022-01-12', 5, 'finalizada'),
	(15, 2, 1, '2022-07-28', 6, 'finalizada'),
	(16, 2, 1, '2023-01-15', 7, 'finalizada'),
	(17, 2, 1, '2023-07-30', 8, 'finalizada'),
	(18, 2, 1, '2024-01-10', 9, 'activa'),
	(19, 3, 2, '2019-08-05', 1, 'finalizada'),
	(20, 3, 2, '2020-01-15', 2, 'finalizada'),
	(21, 3, 2, '2020-07-30', 3, 'finalizada'),
	(22, 3, 2, '2021-01-10', 4, 'finalizada'),
	(23, 3, 2, '2021-07-25', 5, 'finalizada'),
	(24, 3, 2, '2022-01-12', 6, 'finalizada'),
	(25, 3, 2, '2022-07-28', 7, 'finalizada'),
	(26, 3, 2, '2023-01-15', 8, 'finalizada'),
	(27, 3, 2, '2023-07-30', 9, 'activa'),
	(28, 4, 3, '2021-01-15', 3, 'finalizada'),
	(29, 4, 3, '2021-07-30', 4, 'finalizada'),
	(30, 4, 3, '2022-01-10', 5, 'finalizada');
/*!40000 ALTER TABLE `matriculas` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.pagos
CREATE TABLE IF NOT EXISTS `pagos` (
  `pago_id` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `concepto` enum('matricula','mensualidad','otros') NOT NULL,
  `metodo_pago` enum('efectivo','tarjeta','transferencia') NOT NULL,
  `estado` enum('completo','pendiente','atrasado') DEFAULT 'pendiente',
  `semestre_id` int DEFAULT NULL,
  PRIMARY KEY (`pago_id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `semestre_id` (`semestre_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.pagos: 22 rows
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` (`pago_id`, `estudiante_id`, `monto`, `fecha_pago`, `concepto`, `metodo_pago`, `estado`, `semestre_id`) VALUES
	(1, 1, 2500000.00, '2020-01-10', 'matricula', 'transferencia', 'completo', 1),
	(2, 1, 1500000.00, '2020-02-05', 'mensualidad', 'tarjeta', 'completo', 1),
	(3, 1, 1500000.00, '2020-03-05', 'mensualidad', 'tarjeta', 'completo', 1),
	(4, 1, 1500000.00, '2020-04-05', 'mensualidad', 'tarjeta', 'completo', 1),
	(5, 1, 2500000.00, '2020-07-25', 'matricula', 'transferencia', 'completo', 2),
	(6, 1, 1500000.00, '2020-08-05', 'mensualidad', 'tarjeta', 'completo', 2),
	(7, 2, 2500000.00, '2020-01-10', 'matricula', 'efectivo', 'completo', 1),
	(8, 2, 1500000.00, '2020-02-05', 'mensualidad', 'transferencia', 'completo', 1),
	(9, 3, 2800000.00, '2019-08-01', 'matricula', 'tarjeta', 'completo', 1),
	(10, 3, 1600000.00, '2019-09-05', 'mensualidad', 'tarjeta', 'completo', 1),
	(11, 4, 3500000.00, '2021-01-10', 'matricula', 'transferencia', 'completo', 3),
	(12, 4, 2000000.00, '2021-02-05', 'mensualidad', 'tarjeta', 'completo', 3),
	(13, 5, 2500000.00, '2020-08-01', 'matricula', 'efectivo', 'completo', 2),
	(14, 5, 1500000.00, '2020-09-05', 'mensualidad', 'transferencia', 'completo', 2),
	(15, 6, 2500000.00, '2021-01-12', 'matricula', 'tarjeta', 'completo', 3),
	(16, 6, 1500000.00, '2021-02-10', 'mensualidad', 'tarjeta', 'completo', 3),
	(17, 7, 2500000.00, '2019-08-02', 'matricula', 'transferencia', 'completo', 1),
	(18, 7, 1500000.00, '2019-09-10', 'mensualidad', 'efectivo', 'completo', 1),
	(19, 8, 2500000.00, '2021-08-05', 'matricula', 'tarjeta', 'completo', 4),
	(20, 8, 1500000.00, '2021-09-05', 'mensualidad', 'transferencia', 'completo', 4),
	(21, 1, 2500.00, NULL, 'matricula', 'tarjeta', 'completo', 9),
	(22, 1, 2500.00, NULL, 'matricula', 'tarjeta', 'completo', 9);
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.participantes_eventos
CREATE TABLE IF NOT EXISTS `participantes_eventos` (
  `participacion_id` int NOT NULL AUTO_INCREMENT,
  `evento_id` int NOT NULL,
  `estudiante_id` int DEFAULT NULL,
  `profesor_id` int DEFAULT NULL,
  `rol` enum('asistente','ponente','organizador') NOT NULL,
  `certificado` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`participacion_id`),
  KEY `evento_id` (`evento_id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `profesor_id` (`profesor_id`),
  CONSTRAINT `participantes_eventos_chk_1` CHECK (((`estudiante_id` is not null) or (`profesor_id` is not null)))
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.participantes_eventos: 20 rows
/*!40000 ALTER TABLE `participantes_eventos` DISABLE KEYS */;
INSERT INTO `participantes_eventos` (`participacion_id`, `evento_id`, `estudiante_id`, `profesor_id`, `rol`, `certificado`) VALUES
	(1, 1, 1, NULL, 'asistente', 1),
	(2, 1, 2, NULL, 'asistente', 1),
	(3, 1, NULL, 1, 'ponente', 1),
	(4, 1, NULL, 2, 'organizador', 1),
	(5, 2, 4, NULL, 'asistente', 1),
	(6, 2, NULL, 7, 'ponente', 1),
	(7, 2, NULL, 19, 'organizador', 1),
	(8, 3, 5, NULL, 'asistente', 0),
	(9, 3, 6, NULL, 'asistente', 0),
	(10, 3, NULL, 7, 'organizador', 1),
	(11, 4, 8, NULL, 'asistente', 1),
	(12, 4, NULL, 11, 'ponente', 1),
	(13, 4, NULL, 12, 'ponente', 1),
	(14, 5, 10, NULL, 'asistente', 0),
	(15, 5, 12, NULL, 'asistente', 0),
	(16, 5, NULL, 9, 'organizador', 1),
	(17, 6, 14, NULL, 'asistente', 0),
	(18, 6, 15, NULL, 'asistente', 0),
	(19, 6, NULL, 19, 'organizador', 1),
	(20, 7, 16, NULL, 'asistente', 1);
/*!40000 ALTER TABLE `participantes_eventos` ENABLE KEYS */;

-- Volcando estructura para procedimiento universidad_db2.PA_inscribir_curso
DELIMITER //
CREATE PROCEDURE `PA_inscribir_curso`(
    IN p_estudiante_id INT,
    IN p_horario_id INT
)
BEGIN
    DECLARE v_error_message VARCHAR(255);
    DECLARE total_creditos INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END;

    START TRANSACTION;

    -- Validar que el estudiante no esté inscrito en el mismo curso en el semestre actual
    IF EXISTS (
        SELECT 1
        FROM inscripciones_cursos ic
        JOIN horarios_cursos hc ON ic.horario_id = hc.horario_id
        WHERE ic.estudiante_id = p_estudiante_id
        AND hc.curso_id = (SELECT curso_id FROM horarios_cursos WHERE horario_id = p_horario_id)
        AND hc.semestre_id = (SELECT semestre_id FROM horarios_cursos WHERE horario_id = p_horario_id)
    ) THEN
        SET v_error_message = 'El estudiante ya está inscrito en este curso para el semestre actual';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Calcular los créditos actuales del estudiante en el semestre
    SELECT IFNULL(SUM(c.creditos), 0) INTO total_creditos
    FROM inscripciones_cursos ic
    JOIN horarios_cursos hc ON ic.horario_id = hc.horario_id
    JOIN cursos c ON hc.curso_id = c.curso_id
    WHERE ic.estudiante_id = p_estudiante_id
    AND hc.semestre_id = (SELECT semestre_id FROM horarios_cursos WHERE horario_id = p_horario_id);

    -- Validar que no exceda los 20 créditos
    SELECT total_creditos + c.creditos INTO total_creditos
    FROM cursos c
    JOIN horarios_cursos hc ON c.curso_id = hc.curso_id
    WHERE hc.horario_id = p_horario_id;

    IF total_creditos > 20 THEN
        SET v_error_message = 'No puedes inscribirte a más de 20 créditos en este semestre';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Insertar la inscripción
    INSERT INTO inscripciones_cursos (estudiante_id, horario_id)
    VALUES (p_estudiante_id, p_horario_id);

    COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento universidad_db2.PA_registrar_estudiante
DELIMITER //
CREATE PROCEDURE `PA_registrar_estudiante`(
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_fecha_nacimiento DATE,
    IN p_genero ENUM('M','F','O'),
    IN p_direccion VARCHAR(200),
    IN p_telefono VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_fecha_ingreso DATE
)
BEGIN
    DECLARE v_error_message VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END;

    START TRANSACTION;

    -- Validar que el correo tenga el dominio correcto
    IF p_email NOT LIKE '%@valladolid.tecnm.com.mx' THEN
        SET v_error_message = 'El email debe tener el dominio @valladolid.tecnm.com.mx';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Validar que el correo no esté registrado
    IF EXISTS (SELECT 1 FROM estudiantes WHERE email = p_email) THEN
        SET v_error_message = 'El correo ya está registrado';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Insertar el estudiante
    INSERT INTO estudiantes (nombre, apellido, fecha_nacimiento, genero, direccion, telefono, email, fecha_ingreso)
    VALUES (p_nombre, p_apellido, p_fecha_nacimiento, p_genero, p_direccion, p_telefono, p_email, p_fecha_ingreso);

    COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento universidad_db2.PA_registrar_pago
DELIMITER //
CREATE PROCEDURE `PA_registrar_pago`(
    IN p_estudiante_id INT,
    IN p_monto DECIMAL(10,2),
    IN p_concepto ENUM('matricula','mensualidad','otros'),
    IN p_metodo_pago ENUM('efectivo','tarjeta','transferencia'),
    IN p_semestre_id INT
)
BEGIN
    DECLARE v_error_message VARCHAR(255);
    DECLARE matricula_activa INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END;

    START TRANSACTION;

    -- Validar que el estudiante tenga matrícula activa
    SELECT COUNT(*) INTO matricula_activa
    FROM matriculas
    WHERE estudiante_id = p_estudiante_id
    AND semestre_id = p_semestre_id
    AND estado = 'activa';

    IF matricula_activa = 0 THEN
        SET v_error_message = 'El estudiante no tiene matrícula activa en este semestre';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Validar que el semestre sea válido
    IF NOT EXISTS (
        SELECT 1
        FROM semestres
        WHERE semestre_id = p_semestre_id
        AND estado IN ('en_curso', 'planificacion')
    ) THEN
        SET v_error_message = 'El semestre especificado no es válido';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Registrar el pago
    INSERT INTO pagos (estudiante_id, monto, concepto, metodo_pago, semestre_id, estado)
    VALUES (p_estudiante_id, p_monto, p_concepto, p_metodo_pago, p_semestre_id, 'completo');

    COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento universidad_db2.PA_registrar_prestamo
DELIMITER //
CREATE PROCEDURE `PA_registrar_prestamo`(
    IN p_libro_id INT,
    IN p_estudiante_id INT,
    IN p_profesor_id INT,
    IN p_fecha_prestamo DATE,
    IN p_fecha_devolucion_esperada DATE
)
BEGIN
    DECLARE v_error_message VARCHAR(255);
    DECLARE disponibles INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END;

    START TRANSACTION;

    -- Validar que el libro exista
    IF NOT EXISTS (SELECT 1 FROM libros WHERE libro_id = p_libro_id) THEN
        SET v_error_message = 'El libro especificado no existe';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Validar disponibilidad del libro
    SELECT cantidad_ejemplares INTO disponibles
    FROM libros
    WHERE libro_id = p_libro_id;

    IF disponibles <= 0 THEN
        SET v_error_message = 'No hay ejemplares disponibles para préstamo';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Validar que el libro no esté reservado por otro usuario
    IF EXISTS (
        SELECT 1
        FROM reservas
        WHERE libro_id = p_libro_id
        AND estado = 'activa'
        AND (estudiante_id IS NULL OR estudiante_id != p_estudiante_id)
        AND (profesor_id IS NULL OR profesor_id != p_profesor_id)
    ) THEN
        SET v_error_message = 'El libro está reservado por otro usuario';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Registrar el préstamo
    INSERT INTO prestamos (libro_id, estudiante_id, profesor_id, fecha_prestamo, fecha_devolucion_esperada)
    VALUES (p_libro_id, p_estudiante_id, p_profesor_id, p_fecha_prestamo, p_fecha_devolucion_esperada);

    -- Actualizar la cantidad de ejemplares
    UPDATE libros
    SET cantidad_ejemplares = cantidad_ejemplares - 1
    WHERE libro_id = p_libro_id;

    COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento universidad_db2.PA_registrar_profesor
DELIMITER //
CREATE PROCEDURE `PA_registrar_profesor`(
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_departamento_id INT
)
BEGIN
    DECLARE v_error_message VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END;

    START TRANSACTION;

    -- Validar que el correo sea institucional
    IF p_email NOT LIKE '%@valladolid.tecnm.mx' THEN
        SET v_error_message = 'El correo del profesor debe ser institucional (@valladolid.tecnm.mx)';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Validar que el departamento exista
    IF NOT EXISTS (SELECT 1 FROM departamentos WHERE departamento_id = p_departamento_id) THEN
        SET v_error_message = 'El departamento especificado no existe';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Insertar el profesor
    INSERT INTO profesores (nombre, apellido, email, departamento_id)
    VALUES (p_nombre, p_apellido, p_email, p_departamento_id);

    COMMIT;
END//
DELIMITER ;

-- Volcando estructura para tabla universidad_db2.planes_estudio
CREATE TABLE IF NOT EXISTS `planes_estudio` (
  `plan_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `año_implementacion` int NOT NULL,
  `vigente` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`plan_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.planes_estudio: 12 rows
/*!40000 ALTER TABLE `planes_estudio` DISABLE KEYS */;
INSERT INTO `planes_estudio` (`plan_id`, `nombre`, `año_implementacion`, `vigente`) VALUES
	(1, 'Plan 2010 Ingeniería de Sistemas', 2010, 1),
	(2, 'Plan 2018 Ingeniería de Sistemas', 2018, 1),
	(3, 'Plan 2005 Ingeniería Civil', 2005, 0),
	(4, 'Plan 2015 Ingeniería Civil', 2015, 1),
	(5, 'Plan 2000 Medicina', 2000, 0),
	(6, 'Plan 2012 Medicina', 2012, 1),
	(7, 'Plan 1998 Literatura', 1998, 0),
	(8, 'Plan 2016 Literatura', 2016, 1),
	(9, 'Plan 2008 Economía', 2008, 1),
	(10, 'Plan 2020 Economía', 2020, 1),
	(11, 'Plan 1995 Derecho', 1995, 0),
	(12, 'Plan 2017 Derecho', 2017, 1);
/*!40000 ALTER TABLE `planes_estudio` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.prerequisitos
CREATE TABLE IF NOT EXISTS `prerequisitos` (
  `prerequisito_id` int NOT NULL AUTO_INCREMENT,
  `curso_id` int NOT NULL,
  `curso_requerido_id` int NOT NULL,
  PRIMARY KEY (`prerequisito_id`),
  KEY `curso_id` (`curso_id`),
  KEY `curso_requerido_id` (`curso_requerido_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.prerequisitos: 20 rows
/*!40000 ALTER TABLE `prerequisitos` DISABLE KEYS */;
INSERT INTO `prerequisitos` (`prerequisito_id`, `curso_id`, `curso_requerido_id`) VALUES
	(1, 2, 1),
	(2, 4, 3),
	(3, 6, 5),
	(4, 8, 7),
	(5, 12, 11),
	(6, 14, 13),
	(7, 16, 15),
	(8, 18, 17),
	(9, 22, 21),
	(10, 24, 23),
	(11, 26, 25),
	(12, 28, 27),
	(13, 32, 31),
	(14, 34, 33),
	(15, 36, 35),
	(16, 42, 41),
	(17, 44, 43),
	(18, 46, 45),
	(19, 52, 51),
	(20, 54, 53);
/*!40000 ALTER TABLE `prerequisitos` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.prestamos
CREATE TABLE IF NOT EXISTS `prestamos` (
  `prestamo_id` int NOT NULL AUTO_INCREMENT,
  `libro_id` int NOT NULL,
  `estudiante_id` int DEFAULT NULL,
  `profesor_id` int DEFAULT NULL,
  `fecha_prestamo` date NOT NULL,
  `fecha_devolucion_esperada` date NOT NULL,
  `fecha_devolucion_real` date DEFAULT NULL,
  `estado` enum('activo','devuelto','atrasado') DEFAULT 'activo',
  `multa` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`prestamo_id`),
  KEY `libro_id` (`libro_id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `profesor_id` (`profesor_id`),
  CONSTRAINT `prestamos_chk_1` CHECK (((`estudiante_id` is not null) or (`profesor_id` is not null)))
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.prestamos: 15 rows
/*!40000 ALTER TABLE `prestamos` DISABLE KEYS */;
INSERT INTO `prestamos` (`prestamo_id`, `libro_id`, `estudiante_id`, `profesor_id`, `fecha_prestamo`, `fecha_devolucion_esperada`, `fecha_devolucion_real`, `estado`, `multa`) VALUES
	(1, 1, 1, NULL, '2020-02-10', '2020-03-10', '2020-03-05', 'devuelto', 0.00),
	(2, 2, 2, NULL, '2020-02-15', '2020-03-15', '2020-03-20', 'devuelto', 5000.00),
	(3, 3, NULL, 3, '2020-03-01', '2020-04-01', '2020-04-05', 'devuelto', 4000.00),
	(4, 4, 4, NULL, '2020-03-10', '2020-04-10', NULL, 'atrasado', 15000.00),
	(5, 5, 5, NULL, '2020-04-05', '2020-05-05', '2020-05-01', 'devuelto', 0.00),
	(6, 6, NULL, 5, '2020-04-15', '2020-05-15', '2020-05-10', 'devuelto', 0.00),
	(7, 7, 7, NULL, '2020-05-01', '2020-06-01', '2020-06-05', 'devuelto', 5000.00),
	(8, 8, 8, NULL, '2020-05-10', '2020-06-10', NULL, 'activo', 0.00),
	(9, 9, NULL, 9, '2020-06-01', '2020-07-01', '2020-07-05', 'devuelto', 4000.00),
	(10, 10, 10, NULL, '2020-06-15', '2020-07-15', '2020-07-10', 'devuelto', 0.00),
	(11, 1, 1, NULL, '2025-04-13', '2025-05-13', NULL, 'activo', 0.00),
	(12, 999, 1, NULL, '2025-04-13', '2025-05-13', NULL, 'activo', 0.00),
	(14, 1, 1, NULL, '2025-04-13', '2025-05-13', NULL, 'activo', 0.00),
	(15, 999, 1, NULL, '2025-04-13', '2025-05-13', NULL, 'activo', 0.00),
	(16, 999, 1, NULL, '2025-04-13', '2025-05-13', NULL, 'activo', 0.00);
/*!40000 ALTER TABLE `prestamos` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.profesores
CREATE TABLE IF NOT EXISTS `profesores` (
  `profesor_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero` enum('M','F','O') DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `titulo_academico` varchar(100) DEFAULT NULL,
  `departamento_id` int DEFAULT NULL,
  PRIMARY KEY (`profesor_id`),
  UNIQUE KEY `email` (`email`),
  KEY `departamento_id` (`departamento_id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.profesores: 37 rows
/*!40000 ALTER TABLE `profesores` DISABLE KEYS */;
INSERT INTO `profesores` (`profesor_id`, `nombre`, `apellido`, `fecha_nacimiento`, `genero`, `direccion`, `telefono`, `email`, `fecha_contratacion`, `especialidad`, `titulo_academico`, `departamento_id`) VALUES
	(1, 'Carlos', 'Martínez', '1965-04-12', 'M', 'Calle 123 #45-67', '3101234567', 'carlos.martinez@universidad.edu', '1990-08-15', 'Sistemas Distribuidos', 'PhD en Ciencias de la Computación', 1),
	(2, 'Ana', 'Gómez', '1972-11-25', 'F', 'Av. Principal #78-90', '3152345678', 'ana.gomez@universidad.edu', '1995-03-20', 'Inteligencia Artificial', 'MSc en Ingeniería de Sistemas', 1),
	(3, 'Luis', 'Rodríguez', '1968-07-30', 'M', 'Carrera 56 #12-34', '3203456789', 'luis.rodriguez@universidad.edu', '1992-09-10', 'Estructuras', 'PhD en Ingeniería Civil', 2),
	(4, 'María', 'López', '1975-09-15', 'F', 'Diagonal 23 #45-67', '3174567890', 'maria.lopez@universidad.edu', '2000-02-18', 'Análisis Numérico', 'PhD en Matemáticas', 3),
	(5, 'Jorge', 'Hernández', '1960-12-05', 'M', 'Calle 78 #90-12', '3135678901', 'jorge.hernandez@universidad.edu', '1985-07-22', 'Cardiología', 'MD, PhD en Medicina', 4),
	(6, 'Patricia', 'Díaz', '1978-03-28', 'F', 'Av. Siempre Viva #123', '3186789012', 'patricia.diaz@universidad.edu', '2005-08-30', 'Enfermería Oncológica', 'MSc en Enfermería', 5),
	(7, 'Ricardo', 'Pérez', '1973-06-17', 'M', 'Carrera 34 #56-78', '3147890123', 'ricardo.perez@universidad.edu', '1998-11-15', 'Literatura Latinoamericana', 'PhD en Literatura', 6),
	(8, 'Sofía', 'García', '1967-08-22', 'F', 'Calle 90 #12-34', '3198901234', 'sofia.garcia@universidad.edu', '1993-04-05', 'Historia Moderna', 'PhD en Historia', 7),
	(9, 'Fernando', 'Sánchez', '1970-01-30', 'M', 'Av. Central #45-67', '3129012345', 'fernando.sanchez@universidad.edu', '1996-09-18', 'Macroeconomía', 'PhD en Economía', 8),
	(10, 'Laura', 'Ramírez', '1980-05-14', 'F', 'Diagonal 56 #78-90', '3160123456', 'laura.ramirez@universidad.edu', '2008-02-22', 'Gestión Empresarial', 'MBA', 9),
	(11, 'Miguel', 'Torres', '1963-10-08', 'M', 'Calle 34 #56-78', '3111234567', 'miguel.torres@universidad.edu', '1988-07-30', 'Derecho Penal', 'PhD en Derecho', 10),
	(12, 'Alejandra', 'Vargas', '1976-12-19', 'F', 'Carrera 12 #34-56', '3172345678', 'alejandra.vargas@universidad.edu', '2002-03-15', 'Derecho Civil', 'PhD en Derecho', 11),
	(13, 'Juan', 'Castro', '1971-02-25', 'M', 'Av. Norte #67-89', '3133456789', 'juan.castro@universidad.edu', '1997-10-12', 'Bases de Datos', 'MSc en Ciencias de la Computación', 1),
	(14, 'Carmen', 'Ortiz', '1969-07-03', 'F', 'Calle 45 #67-89', '3184567890', 'carmen.ortiz@universidad.edu', '1994-05-20', 'Ingeniería de Software', 'PhD en Ingeniería de Sistemas', 1),
	(15, 'Oscar', 'Mendoza', '1974-09-11', 'M', 'Carrera 78 #90-12', '3145678901', 'oscar.mendoza@universidad.edu', '2001-08-15', 'Geotecnia', 'PhD en Ingeniería Civil', 2),
	(16, 'Diana', 'Rojas', '1979-04-05', 'F', 'Diagonal 12 #34-56', '3196789012', 'diana.rojas@universidad.edu', '2006-01-30', 'Álgebra Abstracta', 'PhD en Matemáticas', 3),
	(17, 'Pablo', 'Gutiérrez', '1966-11-28', 'M', 'Av. Sur #23-45', '3157890123', 'pablo.gutierrez@universidad.edu', '1991-06-22', 'Neurología', 'MD, PhD en Medicina', 4),
	(18, 'Tatiana', 'Silva', '1982-08-14', 'F', 'Calle 67 #89-01', '3118901234', 'tatiana.silva@universidad.edu', '2010-03-18', 'Enfermería Pediátrica', 'MSc in Enfermería', 5),
	(19, 'Andrés', 'Morales', '1977-01-20', 'M', 'Carrera 45 #67-89', '3179012345', 'andres.morales@universidad.edu', '2003-09-25', 'Literatura Española', 'PhD en Literatura', 6),
	(20, 'Claudia', 'Fernández', '1964-06-07', 'F', 'Av. Oriental #34-56', '3130123456', 'claudia.fernandez@universidad.edu', '1989-04-15', 'Historia Antigua', 'PhD en Historia', 7),
	(21, 'Hernán', 'González', '1972-03-12', 'M', 'Calle 89 #01-23', '3181234567', 'hernan.gonzalez@universidad.edu', '1999-11-30', 'Microeconomía', 'PhD en Economía', 8),
	(22, 'Lucía', 'Herrera', '1981-10-25', 'F', 'Diagonal 78 #90-12', '3142345678', 'lucia.herrera@universidad.edu', '2009-05-22', 'Marketing', 'MBA', 9),
	(23, 'Felipe', 'Jiménez', '1967-05-18', 'M', 'Carrera 23 #45-67', '3103456789', 'felipe.jimenez@universidad.edu', '1992-12-10', 'Derecho Laboral', 'PhD en Derecho', 10),
	(24, 'Mariana', 'Ruiz', '1975-12-30', 'F', 'Av. Occidental #56-78', '3164567890', 'mariana.ruiz@universidad.edu', '2000-07-15', 'Derecho Comercial', 'PhD en Derecho', 11),
	(25, 'Gabriel', 'Moreno', '1978-07-22', 'M', 'Calle 12 #34-56', '3125678901', 'gabriel.moreno@universidad.edu', '2004-02-28', 'Redes de Computadores', 'MSc en Ingeniería de Sistemas', 1),
	(26, 'Adriana', 'Paredes', '1973-04-15', 'F', 'Carrera 90 #12-34', '3186789012', 'adriana.paredes@universidad.edu', '1998-10-05', 'Sistemas Operativos', 'PhD en Ciencias de la Computación', 1),
	(27, 'Raúl', 'Cordero', '1969-09-08', 'M', 'Av. Circunvalar #45-67', '3147890123', 'raul.cordero@universidad.edu', '1995-03-20', 'Hidráulica', 'PhD en Ingeniería Civil', 2),
	(28, 'Verónica', 'Molina', '1980-02-28', 'F', 'Diagonal 34 #56-78', '3108901234', 'veronica.molina@universidad.edu', '2007-08-12', 'Cálculo Diferencial', 'PhD en Matemáticas', 3),
	(29, 'Alberto', 'Ríos', '1965-11-10', 'M', 'Calle 56 #78-90', '3169012345', 'alberto.rios@universidad.edu', '1990-05-25', 'Pediatría', 'MD, PhD en Medicina', 4),
	(30, 'Isabel', 'Campos', '1976-08-03', 'F', 'Carrera 67 #89-01', '3120123456', 'isabel.campos@universidad.edu', '2002-01-18', 'Enfermería Geriátrica', 'MSc en Enfermería', 5),
	(31, 'Juan', 'Pérez', NULL, NULL, NULL, NULL, 'juan.perez@nuevo.edu', '2025-04-03', NULL, NULL, 1),
	(32, 'Juan', 'Diego', NULL, NULL, NULL, NULL, 'juanwero.perez@nuevo.edu', '2025-04-03', NULL, NULL, 2),
	(33, 'Juan', 'Diego', NULL, NULL, NULL, NULL, 'juanwerasdao.perez@nuevo.edu', '2025-04-03', NULL, NULL, 1),
	(34, 'Juan', 'Diego', NULL, NULL, NULL, NULL, 'juannegro.perez@nuevo.edu', '2025-04-03', NULL, NULL, 3),
	(35, 'Juan', 'Pérez', NULL, NULL, NULL, NULL, 'juan2.perez@nuevo.edu', '2025-04-03', NULL, NULL, 2),
	(36, 'Juan', 'Pérez', NULL, NULL, NULL, NULL, 'juan5.perez@nuevo.edu', '2025-04-03', NULL, NULL, 1),
	(38, 'Ana', 'Gómez', NULL, NULL, NULL, NULL, 'ana.gomez@valladolid.tecnm.mx', NULL, NULL, NULL, 2);
/*!40000 ALTER TABLE `profesores` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.reservas
CREATE TABLE IF NOT EXISTS `reservas` (
  `reserva_id` int NOT NULL AUTO_INCREMENT,
  `libro_id` int NOT NULL,
  `estudiante_id` int DEFAULT NULL,
  `profesor_id` int DEFAULT NULL,
  `fecha_reserva` date NOT NULL,
  `fecha_vencimiento_reserva` date NOT NULL,
  `estado` enum('activa','cumplida','cancelada') DEFAULT 'activa',
  PRIMARY KEY (`reserva_id`),
  KEY `libro_id` (`libro_id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `profesor_id` (`profesor_id`),
  CONSTRAINT `reservas_chk_1` CHECK (((`estudiante_id` is not null) or (`profesor_id` is not null)))
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.reservas: 10 rows
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
INSERT INTO `reservas` (`reserva_id`, `libro_id`, `estudiante_id`, `profesor_id`, `fecha_reserva`, `fecha_vencimiento_reserva`, `estado`) VALUES
	(1, 1, NULL, 1, '2020-03-01', '2020-03-08', 'cumplida'),
	(2, 2, 2, NULL, '2020-03-05', '2020-03-12', 'cumplida'),
	(3, 3, NULL, 3, '2020-04-01', '2020-04-08', 'cumplida'),
	(4, 4, 4, NULL, '2020-04-10', '2020-04-17', 'cancelada'),
	(5, 5, 5, NULL, '2020-05-05', '2020-05-12', 'cumplida'),
	(6, 6, NULL, 5, '2020-05-15', '2020-05-22', 'cumplida'),
	(7, 7, 7, NULL, '2020-06-01', '2020-06-08', 'cumplida'),
	(8, 8, 8, NULL, '2020-06-10', '2020-06-17', 'activa'),
	(9, 9, NULL, 9, '2020-07-01', '2020-07-08', 'cumplida'),
	(10, 10, 10, NULL, '2020-07-15', '2020-07-22', 'cumplida');
/*!40000 ALTER TABLE `reservas` ENABLE KEYS */;

-- Volcando estructura para tabla universidad_db2.semestres
CREATE TABLE IF NOT EXISTS `semestres` (
  `semestre_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado` enum('planificacion','en_curso','finalizado') DEFAULT 'planificacion',
  PRIMARY KEY (`semestre_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla universidad_db2.semestres: 10 rows
/*!40000 ALTER TABLE `semestres` DISABLE KEYS */;
INSERT INTO `semestres` (`semestre_id`, `nombre`, `fecha_inicio`, `fecha_fin`, `estado`) VALUES
	(1, '2020-1', '2020-01-20', '2020-05-30', 'finalizado'),
	(2, '2020-2', '2020-08-10', '2020-12-15', 'finalizado'),
	(3, '2021-1', '2021-01-25', '2021-06-05', 'finalizado'),
	(4, '2021-2', '2021-08-09', '2021-12-17', 'finalizado'),
	(5, '2022-1', '2022-01-24', '2022-06-03', 'finalizado'),
	(6, '2022-2', '2022-08-08', '2022-12-16', 'finalizado'),
	(7, '2023-1', '2023-01-23', '2023-06-02', 'finalizado'),
	(8, '2023-2', '2023-08-07', '2023-12-15', 'finalizado'),
	(9, '2024-1', '2024-01-22', '2024-05-31', 'en_curso'),
	(10, '2024-2', '2024-08-05', '2024-12-13', 'planificacion');
/*!40000 ALTER TABLE `semestres` ENABLE KEYS */;

-- Volcando estructura para disparador universidad_db2.log_estudiante_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `log_estudiante_delete` AFTER DELETE ON `estudiantes` FOR EACH ROW BEGIN
    INSERT INTO logs (tabla_afectada, registro_id, nombre_completo, accion, detalles)
    VALUES ('estudiantes', OLD.estudiante_id, CONCAT(OLD.nombre, ' ', OLD.apellido), 'DELETE', 
           CONCAT('Estudiante eliminado. Correo: ', OLD.email));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador universidad_db2.log_estudiante_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `log_estudiante_insert` AFTER INSERT ON `estudiantes` FOR EACH ROW BEGIN
    INSERT INTO logs (tabla_afectada, registro_id, nombre_completo, accion, detalles)
    VALUES ('estudiantes', NEW.estudiante_id, CONCAT(NEW.nombre, ' ', NEW.apellido), 'INSERT', 
           CONCAT('Nuevo estudiante registrado: ', NEW.email));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador universidad_db2.log_estudiante_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `log_estudiante_update` AFTER UPDATE ON `estudiantes` FOR EACH ROW BEGIN
    INSERT INTO logs (tabla_afectada, registro_id, nombre_completo, accion, detalles)
    VALUES ('estudiantes', NEW.estudiante_id, CONCAT(NEW.nombre, ' ', NEW.apellido), 'UPDATE', 
           CONCAT('Datos actualizados. Correo: ', NEW.email));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador universidad_db2.log_profesor_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `log_profesor_delete` AFTER DELETE ON `profesores` FOR EACH ROW BEGIN
    INSERT INTO logs (tabla_afectada, registro_id, nombre_completo, accion, detalles)
    VALUES ('profesores', OLD.profesor_id, CONCAT(OLD.nombre, ' ', OLD.apellido), 'DELETE', 
           CONCAT('Profesor eliminado. Correo: ', OLD.email));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador universidad_db2.log_profesor_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `log_profesor_insert` AFTER INSERT ON `profesores` FOR EACH ROW BEGIN
    INSERT INTO logs (tabla_afectada, registro_id, nombre_completo, accion, detalles)
    VALUES ('profesores', NEW.profesor_id, CONCAT(NEW.nombre, ' ', NEW.apellido), 'INSERT', 
           CONCAT('Nuevo profesor registrado: ', NEW.email));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador universidad_db2.log_profesor_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `log_profesor_update` AFTER UPDATE ON `profesores` FOR EACH ROW BEGIN
    INSERT INTO logs (tabla_afectada, registro_id, nombre_completo, accion, detalles)
    VALUES ('profesores', NEW.profesor_id, CONCAT(NEW.nombre, ' ', NEW.apellido), 'UPDATE', 
           CONCAT('Datos actualizados. Correo: ', NEW.email));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador universidad_db2.validar_cambios_estudiante_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `validar_cambios_estudiante_update` BEFORE UPDATE ON `estudiantes` FOR EACH ROW BEGIN
    -- Verificar si el estudiante está graduado
    IF OLD.estado = 'graduado' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Este estudiante ya está graduado, no se pueden modificar sus datos';
    END IF;
    
    -- Verificar el dominio del correo si se está modificando
    IF NEW.email IS NOT NULL AND NEW.email != OLD.email AND NEW.email NOT LIKE '%@valladolid.tecnm.com.mx' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El email debe tener el dominio @valladolid.tecnm.com.mx';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador universidad_db2.validar_correo_estudiante_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `validar_correo_estudiante_insert` BEFORE INSERT ON `estudiantes` FOR EACH ROW BEGIN
    IF NEW.email NOT LIKE '%@valladolid.tecnm.com.mx' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El email debe tener el dominio @valladolid.tecnm.com.mx';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador universidad_db2.validar_correo_profesor_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `validar_correo_profesor_insert` BEFORE INSERT ON `profesores` FOR EACH ROW BEGIN
    IF NEW.email NOT LIKE '%@valladolid.tecnm.mx' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo del profesor debe ser institucional (@valladolid.tecnm.mx)';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador universidad_db2.validar_correo_profesor_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `validar_correo_profesor_update` BEFORE UPDATE ON `profesores` FOR EACH ROW BEGIN
    IF NEW.email NOT LIKE '%@valladolid.tecnm.mx' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El correo del profesor debe ser institucional (@valladolid.tecnm.mx)';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador universidad_db2.validar_creditos_inscripcion
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `validar_creditos_inscripcion` BEFORE INSERT ON `inscripciones_cursos` FOR EACH ROW BEGIN
    DECLARE total_creditos INT;
    
    SELECT IFNULL(SUM(c.creditos), 0) INTO total_creditos
    FROM inscripciones_cursos ic
    JOIN horarios_cursos hc ON ic.horario_id = hc.horario_id
    JOIN cursos c ON hc.curso_id = c.curso_id
    WHERE ic.estudiante_id = NEW.estudiante_id
    AND hc.semestre_id = (SELECT semestre_id FROM horarios_cursos WHERE horario_id = NEW.horario_id);
    
    SELECT total_creditos + c.creditos INTO total_creditos
    FROM cursos c
    JOIN horarios_cursos hc ON c.curso_id = hc.curso_id
    WHERE hc.horario_id = NEW.horario_id;
    
    IF total_creditos > 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No puedes inscribirte a más de 20 créditos en este semestre';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador universidad_db2.validar_prestamo_libro
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `validar_prestamo_libro` BEFORE INSERT ON `prestamos` FOR EACH ROW BEGIN
    DECLARE disponibles INT;
    
    SELECT cantidad_ejemplares INTO disponibles
    FROM libros
    WHERE libro_id = NEW.libro_id;
    
    IF disponibles <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay ejemplares disponibles para préstamo';
    ELSE
        UPDATE libros
        SET cantidad_ejemplares = cantidad_ejemplares - 1
        WHERE libro_id = NEW.libro_id;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
