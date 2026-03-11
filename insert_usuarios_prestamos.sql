
-- insert de usuarios, para no crearlos de uno por uno en la app, todos con la clave por defecto hasheada previamete "admin123"
INSERT INTO usuarios (nombre, rut, email, password, carrera, fecha_nacimiento, rol) VALUES
('María González', '12345678-9', 'maria.gonzalez@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Ingeniería Informática', '2000-03-15', 'USUARIO'),
('Carlos Pérez', '23456789-0', 'carlos.perez@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Administración', '1999-07-22', 'USUARIO'),
('Ana Martínez', '34567890-1', 'ana.martinez@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Psicología', '2001-01-10', 'USUARIO'),
('Luis Rodríguez', '45678901-2', 'luis.rodriguez@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Derecho', '2000-09-05', 'USUARIO'),
('Valentina López', '56789012-3', 'valentina.lopez@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Medicina', '1998-12-20', 'USUARIO'),
('Diego Sánchez', '67890123-4', 'diego.sanchez@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Ingeniería Civil', '2001-06-18', 'USUARIO'),
('Camila Torres', '78901234-5', 'camila.torres@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Contabilidad', '2000-04-25', 'USUARIO'),
('Sebastián Flores', '89012345-6', 'sebastian.flores@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Marketing', '1999-11-30', 'USUARIO'),
('Isabella Díaz', '90123456-7', 'isabella.diaz@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Ingeniería Informática', '2001-08-14', 'USUARIO'),
('Matías Herrera', '10234567-8', 'matias.herrera@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Administración', '2000-02-28', 'USUARIO'),
('Sofía Morales', '11234567-9', 'sofia.morales@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Psicología', '1999-05-17', 'USUARIO'),
('Benjamín Castro', '12234567-0', 'benjamin.castro@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Derecho', '2001-10-03', 'USUARIO'),
('Fernanda Rojas', '13234567-1', 'fernanda.rojas@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Medicina', '2000-07-09', 'USUARIO'),
('Nicolás Vargas', '14234567-2', 'nicolas.vargas@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Ingeniería Civil', '1998-03-21', 'USUARIO'),
('Javiera Muñoz', '15234567-3', 'javiera.munoz@untec.cl', '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe', 'Contabilidad', '2001-12-11', 'USUARIO');

SELECT id_usuario, nombre FROM usuarios WHERE rol = 'USUARIO';
SELECT id_libro, titulo FROM libros LIMIT 60;


-- inserts de préstamos
INSERT INTO prestamos (id_usuario, id_libro, fecha_prestamo, fecha_limite, fecha_devolucion, estado) VALUES
-- Préstamos ACTIVOS
(3, 7, '2026-03-03', '2026-03-12', NULL, 'ACTIVO'),
(4, 31, '2026-03-05', '2026-03-14', NULL, 'ACTIVO'),
(5, 13, '2026-03-06', '2026-03-17', NULL, 'ACTIVO'),
(6, 47, '2026-03-07', '2026-03-18', NULL, 'ACTIVO'),
(7, 9, '2026-03-08', '2026-03-19', NULL, 'ACTIVO'),
(8, 34, '2026-03-09', '2026-03-20', NULL, 'ACTIVO'),
(9, 17, '2026-03-10', '2026-03-21', NULL, 'ACTIVO'),

-- Préstamos ATRASADOS
(10, 1, '2026-02-01', '2026-02-10', NULL, 'ATRASADO'),
(11, 2, '2026-02-03', '2026-02-12', NULL, 'ATRASADO'),
(12, 8, '2026-02-05', '2026-02-14', NULL, 'ATRASADO'),
(13, 11, '2026-02-10', '2026-02-19', NULL, 'ATRASADO'),

-- Préstamos DEVUELTOS
(14, 3, '2026-01-05', '2026-01-14', '2026-01-12', 'DEVUELTO'),
(15, 4, '2026-01-08', '2026-01-17', '2026-01-15', 'DEVUELTO'),
(16, 5, '2026-01-10', '2026-01-19', '2026-01-18', 'DEVUELTO'),
(17, 10, '2026-01-15', '2026-01-24', '2026-01-22', 'DEVUELTO'),
(3, 38, '2026-02-01', '2026-02-10', '2026-02-08', 'DEVUELTO'),
(4, 44, '2026-02-05', '2026-02-14', '2026-02-13', 'DEVUELTO'),
(5, 48, '2026-02-10', '2026-02-19', '2026-02-17', 'DEVUELTO');

-- después de esos inserts de préstamos, se debe hacer este update para dejar los libros no disponibles
UPDATE libros SET disponible = FALSE 
WHERE id_libro IN (6, 7, 31, 13, 47, 9, 34, 17, 1, 2, 8, 11);