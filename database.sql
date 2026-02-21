CREATE DATABASE IF NOT EXISTS universidad;
USE universidad;

-- Tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de estudiantes
CREATE TABLE estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_estudiante VARCHAR(20) NOT NULL UNIQUE,
    nombres VARCHAR(150) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    fecha_nacimiento DATE,
    programa_academico VARCHAR(100),
    semestre INT,
    email_institucional VARCHAR(100),
    celular VARCHAR(15),
    ciudad_origen VARCHAR(50)
);

-- Tabla de cursos
CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_curso VARCHAR(20) NOT NULL UNIQUE,
    nombre_asignatura VARCHAR(150) NOT NULL,
    area_conocimiento VARCHAR(100),
    numero_creditos INT,
    horas_semanales INT,
    docente_titular VARCHAR(150),
    departamento VARCHAR(100)
);

-- Tabla de notas
CREATE TABLE notas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT,
    curso_id INT,
    corte1 DECIMAL(3,2),
    corte2 DECIMAL(3,2),
    corte3 DECIMAL(3,2),
    nota_final DECIMAL(3,2),
    periodo_academico VARCHAR(20),
    estado VARCHAR(20),
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

-- Datos de ejemplo
INSERT INTO usuarios (username, password, email) VALUES
('alejo', 'alejo123', 'alejo@universidad.com'),
('admin', 'admin456', 'admin@umariana.edu.co'),
('docente1', 'doc789', 'docente1@umariana.edu.co');

INSERT INTO estudiantes (codigo_estudiante, nombres, apellidos, fecha_nacimiento, programa_academico, semestre, email_institucional, celular, ciudad_origen) VALUES
('2021115001', 'Camila Andrea', 'Rodríguez Benavides', '2003-05-12', 'Ingeniería de Sistemas', 6, 'camila.rodriguez@umariana.edu.co', '3124567890', 'Pasto'),
('2021115002', 'Andrés Felipe', 'Muñoz Guerrero', '2004-08-23', 'Ingeniería de Sistemas', 4, 'andres.munoz@umariana.edu.co', '3157891234', 'Ipiales'),
('2020215003', 'Valentina', 'Castro Delgado', '2002-11-30', 'Administración de Empresas', 7, 'valentina.castro@umariana.edu.co', '3182345678', 'Tumaco'),
('2021315004', 'Santiago José', 'Herrera Pantoja', '2003-02-17', 'Contaduría Pública', 5, 'santiago.herrera@umariana.edu.co', '3205678901', 'Pasto'),
('2022115005', 'Isabella María', 'Gómez Rosero', '2004-06-08', 'Ingeniería de Sistemas', 3, 'isabella.gomez@umariana.edu.co', '3118901234', 'Túquerres'),
('2020115006', 'Mateo Alejandro', 'Vargas Chaves', '2002-09-25', 'Ingeniería de Sistemas', 8, 'mateo.vargas@umariana.edu.co', '3143456789', 'Pasto'),
('2021415007', 'Sofía Valentina', 'Ortiz Moncayo', '2003-12-14', 'Psicología', 6, 'sofia.ortiz@umariana.edu.co', '3166789012', 'Samaniego'),
('2021115008', 'Nicolás David', 'Pérez Burbano', '2003-03-21', 'Ingeniería de Sistemas', 6, 'nicolas.perez@umariana.edu.co', '3199012345', 'La Cruz');

INSERT INTO cursos (codigo_curso, nombre_asignatura, area_conocimiento, numero_creditos, horas_semanales, docente_titular, departamento) VALUES
('SIS301', 'Desarrollo de Aplicaciones Web', 'Ingeniería de Software', 4, 6, 'Ing. Carlos Andrés Mendoza', 'Ingeniería de Sistemas'),
('SIS302', 'Gestión de Bases de Datos Avanzadas', 'Bases de Datos', 5, 8, 'Ing. María Fernanda López', 'Ingeniería de Sistemas'),
('SIS303', 'Arquitectura de Redes y Telecomunicaciones', 'Redes y Comunicaciones', 4, 6, 'Ing. Roberto Silva Martínez', 'Ingeniería de Sistemas'),
('SIS401', 'Metodologías Ágiles y DevOps', 'Gestión de Proyectos', 3, 4, 'Ing. Patricia Ruiz Gómez', 'Ingeniería de Sistemas'),
('SIS402', 'Machine Learning y Ciencia de Datos', 'Inteligencia Artificial', 5, 8, 'Dr. Luis Alberto Martínez', 'Ingeniería de Sistemas');

INSERT INTO notas (estudiante_id, curso_id, corte1, corte2, corte3, nota_final, periodo_academico, estado) VALUES
(1, 1, 4.5, 4.3, 4.6, 4.47, '2025-1', 'Aprobado'),
(1, 2, 4.2, 4.0, 4.4, 4.20, '2025-1', 'Aprobado'),
(2, 1, 3.8, 3.9, 4.0, 3.90, '2025-1', 'Aprobado'),
(2, 3, 4.0, 4.2, 3.8, 4.00, '2025-1', 'Aprobado'),
(3, 2, 4.7, 4.8, 4.6, 4.70, '2025-1', 'Aprobado'),
(3, 4, 4.3, 4.5, 4.4, 4.40, '2025-1', 'Aprobado'),
(4, 1, 3.5, 3.7, 3.6, 3.60, '2025-1', 'Aprobado'),
(4, 5, 4.1, 4.3, 4.0, 4.13, '2025-1', 'Aprobado'),
(5, 3, 4.8, 4.9, 4.7, 4.80, '2025-1', 'Aprobado'),
(5, 4, 4.6, 4.5, 4.7, 4.60, '2025-1', 'Aprobado'),
(6, 2, 3.9, 4.1, 4.0, 4.00, '2025-1', 'Aprobado'),
(6, 5, 4.4, 4.6, 4.5, 4.50, '2025-1', 'Aprobado'),
(7, 1, 4.0, 4.2, 3.9, 4.03, '2025-1', 'Aprobado'),
(7, 3, 3.7, 3.8, 3.9, 3.80, '2025-1', 'Aprobado'),
(8, 4, 4.5, 4.6, 4.4, 4.50, '2025-1', 'Aprobado'),
(8, 5, 4.9, 5.0, 4.8, 4.90, '2025-1', 'Aprobado');
