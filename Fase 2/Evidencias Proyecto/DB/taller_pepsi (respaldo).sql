-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-10-2025 a las 13:59:24
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
  `fecha_entrega` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_devolucion_esperada` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fecha_devolucion_real` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
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
  `fecha_llegada` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estado` varchar(30) DEFAULT NULL,
  `etapa_actual` varchar(100) DEFAULT NULL,
  `notas_recepcion` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `entradas_vehiculos`
--

INSERT INTO `entradas_vehiculos` (`id`, `reserva_id`, `vehiculo_id`, `taller_id`, `recibido_por`, `fecha_llegada`, `estado`, `etapa_actual`, `notas_recepcion`, `fecha_creacion`) VALUES
(3, NULL, 1, 1, 1, '2025-10-24 15:08:07', 'Activo', 'En Taller', NULL, '2025-10-24 15:08:07'),
(4, NULL, 3, 1, 4, '2025-10-27 18:44:40', 'Activo', 'En Taller', 'Prueba ingreso guardia', '2025-10-27 18:44:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evidencias`
--

CREATE TABLE `evidencias` (
  `id` int(11) NOT NULL,
  `entrada_vehiculo_id` int(11) DEFAULT NULL,
  `subido_por` int(11) DEFAULT NULL,
  `nombre_archivo` varchar(300) DEFAULT NULL,
  `ruta_archivo` text DEFAULT NULL,
  `tipo_archivo` varchar(50) DEFAULT NULL,
  `tamano_archivo` int(11) DEFAULT NULL,
  `metadatos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadatos`)),
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evidencias`
--

INSERT INTO `evidencias` (`id`, `entrada_vehiculo_id`, `subido_por`, `nombre_archivo`, `ruta_archivo`, `tipo_archivo`, `tamano_archivo`, `metadatos`, `fecha_creacion`) VALUES
(1, 4, 4, '1761590680302-243298022-vehiculochoque.jpg', 'uploads\\1761590680302-243298022-vehiculochoque.jpg', 'foto', 81444, NULL, '2025-10-27 18:44:40');

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
  `entrada_vehiculo_id` int(11) DEFAULT NULL,
  `tarea_id` int(11) DEFAULT NULL,
  `tipo` varchar(60) DEFAULT NULL,
  `canal` varchar(30) DEFAULT NULL,
  `contenido` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`contenido`)),
  `fue_enviado` tinyint(1) DEFAULT NULL,
  `fecha_envio` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_lectura` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fecha_creacion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
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
  `fecha_pausa` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_reanudacion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `duracion_segundos` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `vehiculo_id` int(11) DEFAULT NULL,
  `taller_id` int(11) DEFAULT NULL,
  `creado_por` int(11) DEFAULT NULL,
  `inicio_programado` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fin_programado` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `estado` varchar(30) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `vehiculo_id`, `taller_id`, `creado_por`, `inicio_programado`, `fin_programado`, `estado`, `notas`, `fecha_creacion`) VALUES
(1, 3, 1, 3, '2025-10-29 20:10:00', '2025-10-29 20:10:00', 'Pendiente', 'ejemplo', '2025-10-27 19:05:09'),
(2, 3, 1, 3, '2025-10-27 19:42:36', '2025-10-29 23:09:00', 'Aprobada', 'Cambiar el motor', '2025-10-27 19:05:32');

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
(2, 'Mecanico', 'Mantenciones vehiculos'),
(3, 'Chofer', 'Solicita citas y ve estado'),
(4, 'Guardia', 'Registra ingresos de vehículos'),
(5, 'Operador', 'Ejecuta tareas de taller (Mecánico)'),
(6, 'Supervisor', 'Gestiona citas y ve reportes');

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
(1, 'Taller Central Santiago', 'Av. Siempre Viva 123', 20, NULL, '2025-10-24 15:07:24');

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
  `estado` varchar(30) DEFAULT NULL,
  `prioridad` varchar(20) DEFAULT NULL,
  `horas_estimadas` decimal(10,0) DEFAULT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_completado` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fecha_creacion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`id`, `entrada_vehiculo_id`, `titulo`, `descripcion`, `creado_por`, `asignado_a`, `estado`, `prioridad`, `horas_estimadas`, `fecha_inicio`, `fecha_completado`, `fecha_creacion`) VALUES
(2, 3, 'Diagnóstico de falla de motor', 'Cliente reporta ruidos extraños', 1, 2, 'Completado', 'Alta', NULL, '2025-10-27 15:37:40', '2025-10-27 15:37:40', '2025-10-24 15:10:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre_usuario` varchar(80) NOT NULL,
  `contrasena_hash` varchar(255) NOT NULL,
  `correo_electronico` varchar(200) DEFAULT NULL,
  `nombre_completo` varchar(200) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `esta_activo` tinyint(1) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ultimo_ingreso` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre_usuario`, `contrasena_hash`, `correo_electronico`, `nombre_completo`, `rol_id`, `telefono`, `esta_activo`, `fecha_creacion`, `ultimo_ingreso`) VALUES
(1, 'admin', '$2b$10$aNJ0ssIRvJ2FgbSqH88z2eSxHnkHf/qXD43YTRJ8KUzP33gtxE5RW', 'admin@pepsi.com', 'Usuario Administrador', 1, NULL, 1, '2025-10-24 12:29:27', '0000-00-00 00:00:00'),
(2, 'mecanico1', '$2b$10$ps12qEfLOVywczYYmEmBeekYF/SBN62CPvWW4f1WXyWudhu6s9S9q', 'mecanico1@pepsico.com', 'Juan Mecanico', 5, NULL, 1, '2025-10-24 14:41:26', '0000-00-00 00:00:00'),
(3, 'chofer1', '$2b$10$eV1kN1dSYZPls2Q4Ge8FIOsTGHQ4s6BykScYg3RWOdsgabEYC/6R.', 'chofer1@pepsi.com', 'Carlos Rivas', 3, NULL, 1, '2025-10-27 13:06:59', '0000-00-00 00:00:00'),
(4, 'guardia1', '$2b$10$NHWWGU4IQUtyqm2ML4ygZ.IeibQ1pykbD5bKNSdyGampHQ4FJW7k6', 'guardia1@pepsi.com', 'Miguel Torres', 4, NULL, 1, '2025-10-27 18:33:12', '0000-00-00 00:00:00'),
(5, 'supervisor1', '$2b$10$gAUhcz9MaLDnzLHgpGdcuuGht2UnZ1xkwROnKYz9QPb8VPuMxcFFm', 'supervisor1@pepsi.com', 'Ana Lopez', 6, NULL, 1, '2025-10-27 19:37:12', '0000-00-00 00:00:00'),
(7, 'fenia', '$2b$10$vswzf76614aN912IIjEg/eV/NrneFIWxDglbFeMkK9BqlqEVES7ne', NULL, 'Fernandito', 4, NULL, 1, '2025-10-27 19:37:26', '0000-00-00 00:00:00');

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
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`id`, `patente`, `vin`, `marca`, `modelo`, `ano`, `kilometraje_actual`, `estado`, `fecha_creacion`) VALUES
(1, 'ABCD-01', NULL, 'Test-Truck', 'Modelo-Prueba', 2020, NULL, 'En Taller', '2025-10-24 15:03:56'),
(3, 'XYZ-789', NULL, NULL, NULL, NULL, 50000, 'En Taller', '2025-10-27 18:44:40');

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
  ADD KEY `tarea_id` (`tarea_id`);

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
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `patente` (`patente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `control_llaves`
--
ALTER TABLE `control_llaves`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entradas_vehiculos`
--
ALTER TABLE `entradas_vehiculos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `evidencias`
--
ALTER TABLE `evidencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `movimientos_repuestos`
--
ALTER TABLE `movimientos_repuestos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pausas`
--
ALTER TABLE `pausas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registros_auditoria`
--
ALTER TABLE `registros_auditoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `talleres`
--
ALTER TABLE `talleres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  ADD CONSTRAINT `notificaciones_ibfk_3` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`id`);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
