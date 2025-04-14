-- =====================================================================
-- 1. Procedimiento para registrar un nuevo estudiante
-- =====================================================================
DELIMITER //
CREATE PROCEDURE PA_registrar_estudiante(
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


-- =====================================================================
-- 2. Procedimiento para inscribir un estudiante en un curso y validar créditos
-- =====================================================================
DELIMITER //
CREATE PROCEDURE PA_inscribir_curso(
    IN p_estudiante_id INT,
    IN p_horario_id INT
)
BEGIN
    DECLARE v_error_message VARCHAR(255);
    DECLARE total_creditos INT;

    -- manda el mensaje de error al manejador de excepciones
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


-- =====================================================================
-- 3. Procedimiento para registrar un profesor y validar su correo
-- =====================================================================
DELIMITER //
CREATE PROCEDURE PA_registrar_profesor(
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


-- =====================================================================
-- 4. Procedimiento para registrar un préstamo de libro y validar disponibilidad
-- =====================================================================
DELIMITER //
CREATE PROCEDURE PA_registrar_prestamo(
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


-- =====================================================================
-- 5. Procedimiento para registrar un pago y validar matrícula activa
-- =====================================================================
DELIMITER //
CREATE PROCEDURE PA_registrar_pago(
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