-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-11-2025 a las 19:56:29
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `taller_pepsi`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control_llaves`
--

CREATE TABLE `control_llaves` (
  `id` int(11) NOT NULL,
  `vehiculo_id` int(11) DEFAULT NULL,
  `responsable_llave_id` int(11) DEFAULT NULL,
  `fecha_entrega` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_devolucion_esperada` timestamp NULL DEFAULT NULL,
  `fecha_devolucion_real` timestamp NULL DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `notas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entradas_vehiculos`
--

CREATE TABLE `entradas_vehiculos` (
  `id` int(11) NOT NULL,
  `reserva_id` int(11) DEFAULT NULL,
  `vehiculo_id` int(11) DEFAULT NULL,
  `taller_id` int(11) DEFAULT NULL,
  `recibido_por` int(11) DEFAULT NULL,
  `fecha_llegada` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` varchar(30) DEFAULT NULL,
  `etapa_actual` varchar(100) DEFAULT NULL,
  `notas_recepcion` text DEFAULT NULL,
  `fecha_retiro` timestamp NULL DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evidencias`
--

CREATE TABLE `evidencias` (
  `id` int(11) NOT NULL,
  `entrada_vehiculo_id` int(11) DEFAULT NULL,
  `subido_por` int(11) DEFAULT NULL,
  `ruta_archivo` varchar(255) NOT NULL,
  `nombre_archivo` varchar(255) DEFAULT NULL,
  `tipo_archivo` varchar(50) DEFAULT NULL,
  `tamano_archivo` int(11) DEFAULT NULL,
  `notas_evidencia` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_reportes`
--

CREATE TABLE `historial_reportes` (
  `id` int(11) NOT NULL,
  `generado_por` int(11) DEFAULT NULL,
  `tipo_reporte` varchar(150) DEFAULT NULL,
  `filtros` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`filtros`)),
  `fecha_generacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `repuesto_id` int(11) NOT NULL,
  `cantidad` decimal(10,0) DEFAULT NULL,
  `reservado` decimal(10,0) DEFAULT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`repuesto_id`, `cantidad`, `reservado`, `fecha_actualizacion`) VALUES
(1, 50, 0, '2025-11-12 13:42:00'),
(2, 50, 0, '2025-11-21 15:09:23'),
(3, 50, 0, '2025-11-12 13:42:00'),
(4, 30, 0, '2025-11-12 13:40:15'),
(5, 150, 0, '2025-11-12 13:40:15'),
(6, 30, 0, '2025-11-21 15:09:27'),
(7, 25, 0, '2025-11-12 13:40:15'),
(8, 20, 0, '2025-11-12 13:40:15'),
(9, 60, 0, '2025-11-12 13:40:15'),
(10, 10, 0, '2025-11-21 15:09:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_repuestos`
--

CREATE TABLE `movimientos_repuestos` (
  `id` int(11) NOT NULL,
  `repuesto_id` int(11) DEFAULT NULL,
  `entrada_vehiculo_id` int(11) DEFAULT NULL,
  `tarea_id` int(11) DEFAULT NULL,
  `tipo_movimiento` varchar(20) DEFAULT NULL,
  `cantidad` decimal(10,0) DEFAULT NULL,
  `creado_por` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `notas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `reserva_id` int(11) DEFAULT NULL,
  `entrada_vehiculo_id` int(11) DEFAULT NULL,
  `tarea_id` int(11) DEFAULT NULL,
  `tipo` varchar(60) DEFAULT NULL,
  `canal` varchar(30) DEFAULT NULL,
  `contenido` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`contenido`)),
  `fue_enviado` tinyint(1) DEFAULT NULL,
  `fecha_envio` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_lectura` timestamp NULL DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pausas`
--

CREATE TABLE `pausas` (
  `id` int(11) NOT NULL,
  `entrada_vehiculo_id` int(11) DEFAULT NULL,
  `pausado_por` int(11) DEFAULT NULL,
  `motivo` text DEFAULT NULL,
  `fecha_pausa` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_reanudacion` timestamp NULL DEFAULT NULL,
  `duracion_segundos` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registros_auditoria`
--

CREATE TABLE `registros_auditoria` (
  `id` int(11) NOT NULL,
  `nombre_tabla` varchar(100) DEFAULT NULL,
  `registro_id` int(11) DEFAULT NULL,
  `accion` varchar(20) DEFAULT NULL,
  `realizado_por` int(11) DEFAULT NULL,
  `fecha_realizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cambios` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`cambios`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repuestos`
--

CREATE TABLE `repuestos` (
  `id` int(11) NOT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `nombre` varchar(200) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `unidad` varchar(20) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `repuestos`
--

INSERT INTO `repuestos` (`id`, `sku`, `nombre`, `descripcion`, `unidad`, `ubicacion`, `fecha_creacion`) VALUES
(1, 'SKU-001', 'Filtro de Aceite', 'Filtro de aceite para motor Mercedes-Benz Actros', 'Unidad', 'A-01', '2025-11-09 23:23:13'),
(2, 'SKU-002', 'Aceite Motor 10W40', 'Bidón de 20L Aceite sintético', 'Litro', 'B-03', '2025-11-09 23:23:13'),
(3, 'SKU-003', 'Pastillas de Freno', 'Juego de pastillas delanteras Scania', 'Juego', 'A-02', '2025-11-09 23:23:13'),
(4, 'SKU-004', 'Filtro de Aire Motor', 'Filtro de aire para Scania Serie R', 'Unidad', 'A-04', '2025-11-12 13:40:15'),
(5, 'SKU-005', 'Ampolleta H7 24V', 'Ampolleta halógena para faro principal (24V)', 'Unidad', 'C-01', '2025-11-12 13:40:15'),
(6, 'SKU-006', 'Líquido Refrigerante', 'Bidón 5L G12 Plus (Rosa)', 'Bidón', 'B-01', '2025-11-12 13:40:15'),
(7, 'SKU-007', 'Correa de Accesorios', 'Correa Poly-V para Mercedes-Benz Actros', 'Unidad', 'A-05', '2025-11-12 13:40:15'),
(8, 'SKU-008', 'Grasa de Litio', 'Tubo 1kg Grasa multipropósito', 'Tubo', 'B-02', '2025-11-12 13:40:15'),
(9, 'SKU-009', 'Limpiaparabrisas 24\"', 'Plumilla limpiaparabrisas 24 pulgadas', 'Juego', 'C-02', '2025-11-12 13:40:15'),
(10, 'SKU-010', 'Batería 180Ah 12V', 'Batería de arranque servicio pesado', 'Unidad', 'D-01', '2025-11-12 13:40:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `vehiculo_id` int(11) DEFAULT NULL,
  `taller_id` int(11) DEFAULT NULL,
  `creado_por` int(11) DEFAULT NULL,
  `inicio_programado` timestamp NULL DEFAULT NULL,
  `fin_programado` timestamp NULL DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Administrador', 'Acceso total al sistema'),
(2, 'Supervisor', 'Gestiona citas y ve reportes'),
(3, 'Operador', 'Ejecuta tareas de taller (Mecánico)'),
(4, 'Chofer', 'Solicita citas y ve estado'),
(5, 'Guardia', 'Registra ingresos de vehículos'),
(6, 'Encargado Llaves', 'Gestiona la flota de vehículos de reemplazo'),
(7, 'Asistente de Repuestos', 'Gestiona el inventario y catálogo de repuestos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_repuestos`
--

CREATE TABLE `solicitudes_repuestos` (
  `id` int(11) NOT NULL,
  `tarea_id` int(11) NOT NULL,
  `repuesto_id` int(11) NOT NULL,
  `solicitado_por` int(11) NOT NULL COMMENT 'ID del Mecánico',
  `cantidad_solicitada` decimal(10,2) NOT NULL,
  `estado` enum('Pendiente','Aprobada por Supervisor','Aprobada por Repuestos','Rechazada','Despachada') NOT NULL DEFAULT 'Pendiente',
  `aprobado_por` int(11) DEFAULT NULL COMMENT 'ID del Asistente de Repuestos',
  `supervisor_id` int(11) DEFAULT NULL,
  `fecha_solicitud` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_aprobacion` timestamp NULL DEFAULT NULL,
  `notas_rechazo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `talleres`
--

CREATE TABLE `talleres` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `zona_horaria` varchar(50) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `talleres`
--

INSERT INTO `talleres` (`id`, `nombre`, `direccion`, `capacidad`, `zona_horaria`, `fecha_creacion`) VALUES
(1, 'Taller Cerrillos', 'Av. Ejemplos 123', 20, NULL, '2025-11-21 15:23:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `id` int(11) NOT NULL,
  `entrada_vehiculo_id` int(11) DEFAULT NULL,
  `titulo` varchar(200) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `creado_por` int(11) DEFAULT NULL,
  `asignado_a` int(11) DEFAULT NULL,
  `estado` varchar(30) DEFAULT 'Pendiente',
  `prioridad` varchar(20) DEFAULT NULL,
  `horas_estimadas` decimal(10,0) DEFAULT NULL,
  `notas_rechazo` text DEFAULT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_completado` timestamp NULL DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre_usuario` varchar(80) NOT NULL,
  `contrasena_hash` varchar(255) NOT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `nombre_completo` varchar(200) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `esta_activo` tinyint(1) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ultimo_ingreso` datetime DEFAULT NULL,
  `resetToken` varchar(255) DEFAULT NULL,
  `resetTokenExpires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre_usuario`, `contrasena_hash`, `correo`, `nombre_completo`, `rol_id`, `telefono`, `esta_activo`, `fecha_creacion`, `ultimo_ingreso`, `resetToken`, `resetTokenExpires`) VALUES
(1, 'admin', '$2b$10$c4PkDRq4xS9DDb0bCGT7CO/NCRsMg8dNFWSD4cwVwK8iSBcZbPe.K', 'je.luces@duocuc.cl', 'Admin Pepsico', 1, NULL, 1, '2025-11-09 20:29:41', NULL, NULL, NULL),
(2, 'supervisor', '$2b$10$Z1dJ/hMsT6LhvRob3/HQ/.W2Pd8MNMYqiWZ5s5oI8VYhwCUi4l3ZO', 'ni.agurtoc@duocuc.cl', 'Nicolás Agurto', 2, NULL, 1, '2025-11-09 20:30:29', NULL, NULL, NULL),
(3, 'mecanico', '$2b$10$gTGxb249ZLWuIacaZwplxeiLtJsXZncje9JPH2JfeYMv3x2hvL6Ly', 'mecanico1@pepsi.com', 'Juan Mecanico', 3, NULL, 1, '2025-11-09 20:31:41', NULL, NULL, NULL),
(4, 'chofer', '$2b$10$YKSFWG8opEiERJL1jQHG5eh4F8kKFTVm9THuoAjNc.nPmUGuC/uL6', 'chofer1@pepsi.com', 'Carlos Rivas', 4, NULL, 1, '2025-11-09 20:31:03', NULL, NULL, NULL),
(5, 'guardia', '$2b$10$f9hvZLrefxr3ikE8BINRfOJ/DU3e1mkKVBEiDJaMspe5Mfv8FvH5a', 'guardia@pepsi.com', 'Ian Guard', 5, NULL, 1, '2025-11-09 20:32:59', NULL, NULL, NULL),
(6, 'llaves', '$2b$10$7ga99Cd4iiYaVd6eVWHu7e38AFu6rkwIt0ZyG2cwhkARBEKW61XES', 'llaves@pepsi.com', 'Joaquín Llavín', 6, NULL, 1, '2025-11-09 20:31:46', NULL, NULL, NULL),
(7, 'chofer2', '$2b$10$nwn2LkXH35nh2yBrXSz7SewXUI/HMVn5902G1HXR7oWn1f/O/Qmsa', 'matia.espinozab@duocuc.cl', 'Matías Espinoza', 4, NULL, 1, '2025-11-12 13:47:53', NULL, NULL, NULL),
(8, 'repuestos', '$2b$10$QfMQ9vkeTVmSVGdj8fAUrOO6H6anqv13eLMX/xpETDMDxeqhFglme', 'repuestos@pepsi.com', 'Reul Puesto', 7, NULL, 1, '2025-11-09 20:33:52', NULL, NULL, NULL),
(9, 'mecanico2', '$2b$10$9.GWShXu/xwf66SYElOG1emwKn0rQtI7wjwJj1KkTWs0/CqXYW8KS', 'mecanico2@pepsi.com', 'Alonso Bustamante', 3, NULL, 1, '2025-11-09 20:32:20', NULL, NULL, NULL),
(11, 'mecanico3', '$2b$10$bAVozWKVjrfo/FCWQH0yp.58nGOhALOY/vqkLfOfNavsQgkekiCBG', 'mecanico3@pepsico.cl', 'Meca Nicolas', 3, NULL, 1, '2025-11-12 13:33:54', NULL, NULL, NULL),
(12, 'mecanico4', '$2b$10$ypq2Hn1CpfpKYKuwppon5.hFfXoaAtki8Tdn9Qa.YKm1afzA9bjbS', 'mecanico4@pepsico.cl', 'Cani Come', 3, NULL, 1, '2025-11-12 13:35:09', NULL, NULL, NULL),
(13, 'chofer3', '$2b$10$oGpBINMzFdRFJr9HlYzEkek0nwxDUjvWvOvyMiZrxYje43M6wBoH6', 'chofer3@pepsico.cl', 'Diego Molina', 4, NULL, 1, '2025-11-12 13:46:32', NULL, NULL, NULL),
(14, 'chofer4', '$2b$10$kom6pCWn9lo1r6hrl3gaJu2ywd9E125/HB8Nb.1kFdmVvNVXDNwHS', 'chofer4@pepsico.cl', 'Javiera Soto', 4, NULL, 1, '2025-11-12 13:46:53', NULL, NULL, NULL),
(15, 'chofer5', '$2b$10$IPHQyBvjiRNC1.qanwJA1u0nb8TelGlFCP0x2xcEGLltmuzFWbe3u', 'chofer5@pepsico.cl', 'Pedro Pascal', 4, NULL, 1, '2025-11-12 13:47:09', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE `vehiculos` (
  `id` int(11) NOT NULL,
  `patente` varchar(20) NOT NULL,
  `vin` varchar(50) DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `modelo` varchar(100) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `kilometraje_actual` int(11) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `tipo_vehiculo` enum('Flota','Reemplazo') NOT NULL DEFAULT 'Flota',
  `chofer_asignado_id` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`id`, `patente`, `vin`, `marca`, `modelo`, `ano`, `kilometraje_actual`, `estado`, `tipo_vehiculo`, `chofer_asignado_id`, `fecha_creacion`) VALUES
(4, 'RX-KD-81', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Flota', 4, '2025-11-21 15:14:24'),
(5, 'RX-KD-84', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Flota', 7, '2025-11-21 15:17:30'),
(6, 'RX-KD-85', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Flota', 11, '2025-11-21 15:17:41'),
(7, 'RX-KD-96', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Flota', 14, '2025-11-21 15:19:24'),
(8, 'RX-YF-96', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Flota', 13, '2025-11-21 15:19:27'),
(9, 'JI-CD-13', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Reemplazo', NULL, '2025-11-21 15:19:29'),
(10, 'RX-YG-18', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Reemplazo', NULL, '2025-11-21 15:19:32');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `control_llaves`
--
ALTER TABLE `control_llaves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vehiculo_id` (`vehiculo_id`),
  ADD KEY `responsable_llave_id` (`responsable_llave_id`);

--
-- Indices de la tabla `entradas_vehiculos`
--
ALTER TABLE `entradas_vehiculos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reserva_id` (`reserva_id`),
  ADD KEY `vehiculo_id` (`vehiculo_id`),
  ADD KEY `taller_id` (`taller_id`),
  ADD KEY `recibido_por` (`recibido_por`);

--
-- Indices de la tabla `evidencias`
--
ALTER TABLE `evidencias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entrada_vehiculo_id` (`entrada_vehiculo_id`),
  ADD KEY `subido_por` (`subido_por`);

--
-- Indices de la tabla `historial_reportes`
--
ALTER TABLE `historial_reportes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `generado_por` (`generado_por`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`repuesto_id`);

--
-- Indices de la tabla `movimientos_repuestos`
--
ALTER TABLE `movimientos_repuestos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `repuesto_id` (`repuesto_id`),
  ADD KEY `entrada_vehiculo_id` (`entrada_vehiculo_id`),
  ADD KEY `tarea_id` (`tarea_id`),
  ADD KEY `creado_por` (`creado_por`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `entrada_vehiculo_id` (`entrada_vehiculo_id`),
  ADD KEY `tarea_id` (`tarea_id`),
  ADD KEY `reserva_id` (`reserva_id`);

--
-- Indices de la tabla `pausas`
--
ALTER TABLE `pausas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entrada_vehiculo_id` (`entrada_vehiculo_id`),
  ADD KEY `pausado_por` (`pausado_por`);

--
-- Indices de la tabla `registros_auditoria`
--
ALTER TABLE `registros_auditoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `realizado_por` (`realizado_por`);

--
-- Indices de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vehiculo_id` (`vehiculo_id`),
  ADD KEY `taller_id` (`taller_id`),
  ADD KEY `creado_por` (`creado_por`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `solicitudes_repuestos`
--
ALTER TABLE `solicitudes_repuestos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tarea_id` (`tarea_id`),
  ADD KEY `repuesto_id` (`repuesto_id`),
  ADD KEY `solicitado_por` (`solicitado_por`),
  ADD KEY `aprobado_por` (`aprobado_por`);

--
-- Indices de la tabla `talleres`
--
ALTER TABLE `talleres`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entrada_vehiculo_id` (`entrada_vehiculo_id`),
  ADD KEY `creado_por` (`creado_por`),
  ADD KEY `asignado_a` (`asignado_a`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `patente` (`patente`),
  ADD KEY `chofer_asignado_id` (`chofer_asignado_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `control_llaves`
--
ALTER TABLE `control_llaves`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `entradas_vehiculos`
--
ALTER TABLE `entradas_vehiculos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `evidencias`
--
ALTER TABLE `evidencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `historial_reportes`
--
ALTER TABLE `historial_reportes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `movimientos_repuestos`
--
ALTER TABLE `movimientos_repuestos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT de la tabla `pausas`
--
ALTER TABLE `pausas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `registros_auditoria`
--
ALTER TABLE `registros_auditoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=277;

--
-- AUTO_INCREMENT de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `solicitudes_repuestos`
--
ALTER TABLE `solicitudes_repuestos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `talleres`
--
ALTER TABLE `talleres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `control_llaves`
--
ALTER TABLE `control_llaves`
  ADD CONSTRAINT `control_llaves_ibfk_1` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculos` (`id`),
  ADD CONSTRAINT `control_llaves_ibfk_2` FOREIGN KEY (`responsable_llave_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `entradas_vehiculos`
--
ALTER TABLE `entradas_vehiculos`
  ADD CONSTRAINT `entradas_vehiculos_ibfk_1` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`),
  ADD CONSTRAINT `entradas_vehiculos_ibfk_2` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculos` (`id`),
  ADD CONSTRAINT `entradas_vehiculos_ibfk_3` FOREIGN KEY (`taller_id`) REFERENCES `talleres` (`id`),
  ADD CONSTRAINT `entradas_vehiculos_ibfk_4` FOREIGN KEY (`recibido_por`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `evidencias`
--
ALTER TABLE `evidencias`
  ADD CONSTRAINT `evidencias_ibfk_1` FOREIGN KEY (`entrada_vehiculo_id`) REFERENCES `entradas_vehiculos` (`id`),
  ADD CONSTRAINT `evidencias_ibfk_2` FOREIGN KEY (`subido_por`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `historial_reportes`
--
ALTER TABLE `historial_reportes`
  ADD CONSTRAINT `historial_reportes_ibfk_1` FOREIGN KEY (`generado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`repuesto_id`) REFERENCES `repuestos` (`id`);

--
-- Filtros para la tabla `movimientos_repuestos`
--
ALTER TABLE `movimientos_repuestos`
  ADD CONSTRAINT `movimientos_repuestos_ibfk_1` FOREIGN KEY (`repuesto_id`) REFERENCES `repuestos` (`id`),
  ADD CONSTRAINT `movimientos_repuestos_ibfk_2` FOREIGN KEY (`entrada_vehiculo_id`) REFERENCES `entradas_vehiculos` (`id`),
  ADD CONSTRAINT `movimientos_repuestos_ibfk_3` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`id`),
  ADD CONSTRAINT `movimientos_repuestos_ibfk_4` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `notificaciones_ibfk_2` FOREIGN KEY (`entrada_vehiculo_id`) REFERENCES `entradas_vehiculos` (`id`),
  ADD CONSTRAINT `notificaciones_ibfk_3` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`id`),
  ADD CONSTRAINT `notificaciones_ibfk_4` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `pausas`
--
ALTER TABLE `pausas`
  ADD CONSTRAINT `pausas_ibfk_1` FOREIGN KEY (`entrada_vehiculo_id`) REFERENCES `entradas_vehiculos` (`id`),
  ADD CONSTRAINT `pausas_ibfk_2` FOREIGN KEY (`pausado_por`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `registros_auditoria`
--
ALTER TABLE `registros_auditoria`
  ADD CONSTRAINT `registros_auditoria_ibfk_1` FOREIGN KEY (`realizado_por`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculos` (`id`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`taller_id`) REFERENCES `talleres` (`id`),
  ADD CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `solicitudes_repuestos`
--
ALTER TABLE `solicitudes_repuestos`
  ADD CONSTRAINT `solicitudes_repuestos_ibfk_1` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`id`),
  ADD CONSTRAINT `solicitudes_repuestos_ibfk_2` FOREIGN KEY (`repuesto_id`) REFERENCES `repuestos` (`id`),
  ADD CONSTRAINT `solicitudes_repuestos_ibfk_3` FOREIGN KEY (`solicitado_por`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `solicitudes_repuestos_ibfk_4` FOREIGN KEY (`aprobado_por`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`entrada_vehiculo_id`) REFERENCES `entradas_vehiculos` (`id`),
  ADD CONSTRAINT `tareas_ibfk_2` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `tareas_ibfk_3` FOREIGN KEY (`asignado_a`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD CONSTRAINT `vehiculos_ibfk_1` FOREIGN KEY (`chofer_asignado_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
