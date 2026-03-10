CREATE DATABASE biblioteca_untec;
USE biblioteca_untec;

CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    rut VARCHAR(12) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    carrera VARCHAR(100),
    fecha_nacimiento DATE,
    rol ENUM('ADMIN', 'USUARIO') DEFAULT 'USUARIO'
);
-- se agrega campo activo, para poder bloquear usuario en caso de atraso o algo así
ALTER TABLE usuarios ADD COLUMN activo BOOLEAN DEFAULT TRUE;

CREATE TABLE libros (
    id_libro INT PRIMARY KEY AUTO_INCREMENT,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    anio_publicacion YEAR,
    editorial VARCHAR(100),
    categoria VARCHAR(50),
    disponible BOOLEAN DEFAULT TRUE
);

CREATE TABLE prestamos (
    id_prestamo INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_limite DATE NOT NULL,
    fecha_devolucion DATE,
    estado ENUM('ACTIVO', 'DEVUELTO', 'ATRASADO') DEFAULT 'ACTIVO',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
);

INSERT INTO usuarios (nombre, rut, email, password, carrera, fecha_nacimiento, rol) VALUES
('Admin Sistema', '11111111-1', 'admin@untec.cl', 'admin123', NULL, '1990-01-01', 'ADMIN');

-- Crear usuario específico para la app
CREATE USER 'biblioteca_user'@'localhost' IDENTIFIED BY 'password123';

-- Darle SOLO los permisos que necesita
GRANT SELECT, INSERT, UPDATE, DELETE 
ON biblioteca_untec.* 
TO 'biblioteca_user'@'localhost';

FLUSH PRIVILEGES;
-- corroborar permisos usuario
SHOW GRANTS FOR 'biblioteca_user'@'localhost';

-- ingreso de password hasheada
UPDATE usuarios 
SET password = '$2a$10$8xSmJDUrZrumStkmTTU.lOfXQd3vmiE5N0MI.6GSK/jiBohosytSe' 
WHERE email = 'admin@untec.cl';
