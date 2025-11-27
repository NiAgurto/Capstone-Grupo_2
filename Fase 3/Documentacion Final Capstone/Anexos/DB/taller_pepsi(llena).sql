-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-11-2025 a las 21:24:45
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

--
-- Volcado de datos para la tabla `entradas_vehiculos`
--

INSERT INTO `entradas_vehiculos` (`id`, `reserva_id`, `vehiculo_id`, `taller_id`, `recibido_por`, `fecha_llegada`, `estado`, `etapa_actual`, `notas_recepcion`, `fecha_retiro`, `fecha_creacion`) VALUES
(13, 14, 4, 1, 5, '2025-11-26 22:35:06', 'Finalizado', 'Retirado', 'Entrada creada por Supervisor al aprobar\n\n[Notas Guardia]: ', '2025-11-26 22:41:49', '2025-11-26 22:34:02'),
(14, 15, 8, 1, 5, '2025-11-26 22:39:38', 'Finalizado', 'Retirado', 'Entrada creada por Supervisor al aprobar\n\n[Notas Guardia]: algo', '2025-11-26 23:03:49', '2025-11-26 22:38:07');

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

--
-- Volcado de datos para la tabla `evidencias`
--

INSERT INTO `evidencias` (`id`, `entrada_vehiculo_id`, `subido_por`, `ruta_archivo`, `nombre_archivo`, `tipo_archivo`, `tamano_archivo`, `notas_evidencia`, `fecha_creacion`) VALUES
(3, 13, 5, 'https://pepsi-taller-evidencias-2025.s3.us-east-2.amazonaws.com/evidencias/1764185705541-458849886.jpg', 'evidencias/1764185705541-458849886.jpg', 'foto', 6402, NULL, '2025-11-26 22:35:06'),
(4, 14, 5, 'https://pepsi-taller-evidencias-2025.s3.us-east-2.amazonaws.com/evidencias/1764185977747-570660680.png', 'evidencias/1764185977747-570660680.png', 'foto', 47511, NULL, '2025-11-26 22:39:38'),
(5, 13, 3, 'https://pepsi-taller-evidencias-2025.s3.us-east-2.amazonaws.com/evidencias/1764186039191-508227753.jpg', 'evidencias/1764186039191-508227753.jpg', 'foto', 6402, 'Foto de Tarea Completada', '2025-11-26 22:40:40'),
(6, 14, 11, 'https://pepsi-taller-evidencias-2025.s3.us-east-2.amazonaws.com/evidencias/1764187386372-702363925.jpg', 'evidencias/1764187386372-702363925.jpg', 'foto', 6402, 'Foto de Tarea Completada', '2025-11-26 23:03:07');

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
(1, 50, 0, '2025-11-12 16:42:00'),
(2, 49, 0, '2025-11-26 22:36:30'),
(3, 49, 0, '2025-11-26 22:46:04'),
(4, 30, 0, '2025-11-12 16:40:15'),
(5, 150, 0, '2025-11-12 16:40:15'),
(6, 30, 0, '2025-11-21 18:09:27'),
(7, 25, 0, '2025-11-12 16:40:15'),
(8, 20, 0, '2025-11-12 16:40:15'),
(9, 60, 0, '2025-11-12 16:40:15'),
(10, 10, 0, '2025-11-21 18:09:34');

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

--
-- Volcado de datos para la tabla `movimientos_repuestos`
--

INSERT INTO `movimientos_repuestos` (`id`, `repuesto_id`, `entrada_vehiculo_id`, `tarea_id`, `tipo_movimiento`, `cantidad`, `creado_por`, `fecha_creacion`, `notas`) VALUES
(7, 2, 13, 14, 'Uso', 1, 8, '2025-11-26 22:36:30', 'Despachado por Asistente (Sol. ID: 9)'),
(8, 3, 14, 15, 'Uso', 1, 8, '2025-11-26 22:46:04', 'Despachado por Asistente (Sol. ID: 10)');

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

--
-- Volcado de datos para la tabla `notificaciones`
--

INSERT INTO `notificaciones` (`id`, `usuario_id`, `reserva_id`, `entrada_vehiculo_id`, `tarea_id`, `tipo`, `canal`, `contenido`, `fue_enviado`, `fecha_envio`, `fecha_lectura`, `fecha_creacion`) VALUES
(63, 2, 14, NULL, NULL, 'Nueva Solicitud', 'App', '{\"mensaje\":\"Nueva solicitud de cita para el vehículo RX-KD-81.\",\"patente\":\"RX-KD-81\",\"motivo\":\"Falla motor\"}', NULL, '2025-11-26 22:33:34', '2025-11-26 22:33:34', '2025-11-26 22:33:23'),
(64, 8, NULL, NULL, 14, 'Reserva Supervisor', 'App', '{\"mensaje\":\"Nicolás Agurto reservó 1 tipo(s) de repuesto(s) para la nueva tarea \\\"Revisión Vehículo\\\". (Patente: RX-KD-81)\",\"tarea_id\":14}', NULL, '2025-11-26 22:36:33', '2025-11-26 22:36:33', '2025-11-26 22:34:02'),
(65, 4, 14, NULL, NULL, 'Cita Aprobada', 'App', '{\"mensaje\":\"Tu cita para RX-KD-81 fue APROBADA para el 26-11-2025, 4:34:00 p. m..\",\"reserva_id\":\"14\",\"patente\":\"RX-KD-81\"}', NULL, '2025-11-26 22:34:18', '2025-11-26 22:34:18', '2025-11-26 22:34:02'),
(66, 3, NULL, NULL, 14, 'Tarea Asignada', 'App', '{\"mensaje\":\"Se te asignó la tarea: \\\"Revisión Vehículo\\\" (Patente: RX-KD-81)\",\"tarea_id\":14,\"patente\":\"RX-KD-81\"}', NULL, '2025-11-26 22:34:33', '2025-11-26 22:34:33', '2025-11-26 22:34:02'),
(67, 4, NULL, NULL, 14, 'Cita Confirmada', 'App', '{\"mensaje\":\"Tu cita para RX-KD-81 fue ACEPTADA por el mecánico Juan Mecanico. Ya puedes llevar tu vehículo al taller.\",\"patente\":\"RX-KD-81\"}', NULL, '2025-11-26 22:40:51', '2025-11-26 22:40:51', '2025-11-26 22:34:29'),
(68, 2, NULL, NULL, 14, 'Tarea Aceptada', 'App', '{\"mensaje\":\"Juan Mecanico aceptó la tarea \\\"Revisión Vehículo\\\" (Patente: RX-KD-81).\",\"tarea_id\":\"14\"}', NULL, '2025-11-26 22:36:22', '2025-11-26 22:36:22', '2025-11-26 22:34:29'),
(69, 3, NULL, NULL, 14, 'Repuesto Despachado', 'App', '{\"mensaje\":\"Tu solicitud de 1.00 de Aceite Motor 10W40 fue DESPACHADA.\",\"tarea_id\":14}', NULL, '2025-11-26 22:36:44', '2025-11-26 22:36:44', '2025-11-26 22:36:30'),
(70, 2, 15, NULL, NULL, 'Nueva Solicitud', 'App', '{\"mensaje\":\"Nueva solicitud de cita para el vehículo RX-YF-96.\",\"patente\":\"RX-YF-96\",\"motivo\":\"frenos\"}', NULL, '2025-11-26 22:37:39', '2025-11-26 22:37:39', '2025-11-26 22:37:28'),
(71, 8, NULL, NULL, 15, 'Reserva Supervisor', 'App', '{\"mensaje\":\"Nicolás Agurto reservó 1 tipo(s) de repuesto(s) para la nueva tarea \\\"Revisión Vehículo\\\". (Patente: RX-YF-96)\",\"tarea_id\":15}', NULL, '2025-11-26 22:42:52', '2025-11-26 22:42:52', '2025-11-26 22:38:07'),
(72, 13, 15, NULL, NULL, 'Cita Aprobada', 'App', '{\"mensaje\":\"Tu cita para RX-YF-96 fue APROBADA para el 26-11-2025, 4:40:00 p. m..\",\"reserva_id\":\"15\",\"patente\":\"RX-YF-96\"}', NULL, '2025-11-26 22:41:01', '2025-11-26 22:41:01', '2025-11-26 22:38:07'),
(73, 11, NULL, NULL, 15, 'Tarea Asignada', 'App', '{\"mensaje\":\"Se te asignó la tarea: \\\"Revisión Vehículo\\\" (Patente: RX-YF-96)\",\"tarea_id\":15,\"patente\":\"RX-YF-96\"}', NULL, '2025-11-26 22:39:03', '2025-11-26 22:39:03', '2025-11-26 22:38:07'),
(74, 13, NULL, NULL, 15, 'Cita Confirmada', 'App', '{\"mensaje\":\"Tu cita para RX-YF-96 fue ACEPTADA por el mecánico Meca Nicolas. Ya puedes llevar tu vehículo al taller.\",\"patente\":\"RX-YF-96\"}', NULL, '2025-11-26 22:41:02', '2025-11-26 22:41:02', '2025-11-26 22:38:59'),
(75, 2, NULL, NULL, 15, 'Tarea Aceptada', 'App', '{\"mensaje\":\"Meca Nicolas aceptó la tarea \\\"Revisión Vehículo\\\" (Patente: RX-YF-96).\",\"tarea_id\":\"15\"}', NULL, '2025-11-26 22:40:09', '2025-11-26 22:40:09', '2025-11-26 22:38:59'),
(76, 2, NULL, NULL, 14, 'Tarea Completada', 'App', '{\"mensaje\":\"El mecánico completó la tarea: \\\"Revisión Vehículo\\\" (Patente: RX-KD-81). Requiere tu revisión.\",\"tarea_id\":\"14\",\"patente\":\"RX-KD-81\"}', NULL, '2025-11-26 22:41:31', '2025-11-26 22:41:31', '2025-11-26 22:40:40'),
(77, 4, 14, NULL, NULL, 'Vehículo Listo', 'App', '{\"mensaje\":\"Tu vehículo (Patente: RX-KD-81) está listo para ser retirado del taller.\",\"reserva_id\":14,\"patente\":\"RX-KD-81\"}', NULL, '2025-11-26 22:41:40', '2025-11-26 22:41:40', '2025-11-26 22:41:23'),
(78, 11, NULL, NULL, 15, 'Repuesto Despachado', 'App', '{\"mensaje\":\"Tu solicitud de 1.00 de Pastillas de Freno fue DESPACHADA.\",\"tarea_id\":15}', NULL, '2025-11-26 22:47:58', '2025-11-26 22:47:58', '2025-11-26 22:46:04'),
(79, 2, NULL, NULL, 15, 'Tarea Completada', 'App', '{\"mensaje\":\"El mecánico completó la tarea: \\\"Revisión Vehículo\\\" (Patente: RX-YF-96). Requiere tu revisión.\",\"tarea_id\":\"15\",\"patente\":\"RX-YF-96\"}', NULL, '2025-11-26 23:03:39', '2025-11-26 23:03:39', '2025-11-26 23:03:07'),
(80, 13, 15, NULL, NULL, 'Vehículo Listo', 'App', '{\"mensaje\":\"Tu vehículo (Patente: RX-YF-96) está listo para ser retirado del taller.\",\"reserva_id\":15,\"patente\":\"RX-YF-96\"}', NULL, '2025-11-26 23:03:59', '2025-11-26 23:03:59', '2025-11-26 23:03:34');

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

--
-- Volcado de datos para la tabla `pausas`
--

INSERT INTO `pausas` (`id`, `entrada_vehiculo_id`, `pausado_por`, `motivo`, `fecha_pausa`, `fecha_reanudacion`, `duracion_segundos`, `fecha_creacion`) VALUES
(13, 13, 3, 'Esperando Repuesto', '2025-11-26 22:36:17', '2025-11-26 22:36:52', NULL, '2025-11-26 22:36:17'),
(14, 14, 11, 'Esperando Repuesto', '2025-11-26 22:42:48', '2025-11-26 22:46:23', NULL, '2025-11-26 22:42:48');

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

--
-- Volcado de datos para la tabla `registros_auditoria`
--

INSERT INTO `registros_auditoria` (`id`, `nombre_tabla`, `registro_id`, `accion`, `realizado_por`, `fecha_realizacion`, `cambios`) VALUES
(277, 'usuarios', 11, 'Cierre de Sesión', 11, '2025-11-26 22:28:52', NULL),
(278, 'usuarios', 4, 'Inicio de Sesión', 4, '2025-11-26 22:32:47', NULL),
(279, 'reservas', 14, 'Solicitar Cita Talle', 4, '2025-11-26 22:33:23', '{\"vehiculo_id\":\"4\",\"motivo\":\"Falla motor\"}'),
(280, 'reservas', 14, 'Aprobar/Asignar Cita', 2, '2025-11-26 22:34:02', '{\"inicio\":\"2025-11-26T16:34\",\"mecanico_id\":\"3\",\"tarea_id\":14,\"repuestos_reservados\":1}'),
(281, 'usuarios', 4, 'Cierre de Sesión', 4, '2025-11-26 22:34:20', NULL),
(282, 'usuarios', 3, 'Inicio de Sesión', 3, '2025-11-26 22:34:24', NULL),
(283, 'tareas', 14, 'Aceptar Tarea', 3, '2025-11-26 22:34:29', NULL),
(284, 'usuarios', 3, 'Cierre de Sesión', 3, '2025-11-26 22:34:35', NULL),
(285, 'usuarios', 5, 'Inicio de Sesión', 5, '2025-11-26 22:34:38', NULL),
(286, 'entradas_vehiculos', 13, 'Registrar Ingreso (O', 5, '2025-11-26 22:35:06', '{\"reserva_id\":\"14\"}'),
(287, 'usuarios', 5, 'Cierre de Sesión', 5, '2025-11-26 22:35:19', NULL),
(288, 'usuarios', 3, 'Inicio de Sesión', 3, '2025-11-26 22:35:21', NULL),
(289, 'tareas', 14, 'Iniciar Tarea', 3, '2025-11-26 22:36:07', NULL),
(290, 'tareas', 14, 'Pausar Tarea', 3, '2025-11-26 22:36:17', '{\"motivo\":\"Esperando Repuesto\"}'),
(291, 'usuarios', 2, 'Cierre de Sesión', 2, '2025-11-26 22:36:24', NULL),
(292, 'usuarios', 8, 'Inicio de Sesión', 8, '2025-11-26 22:36:27', NULL),
(293, 'solicitudes_repuestos', 9, 'Despachar Repuesto', 8, '2025-11-26 22:36:30', '{\"estado\":\"Despachada\",\"repuesto_id\":2,\"cantidad\":\"1.00\"}'),
(294, 'usuarios', 8, 'Cierre de Sesión', 8, '2025-11-26 22:36:35', NULL),
(295, 'tareas', 14, 'Iniciar Tarea', 3, '2025-11-26 22:36:52', NULL),
(296, 'usuarios', 2, 'Inicio de Sesión', 2, '2025-11-26 22:37:01', NULL),
(297, 'usuarios', 2, 'Cierre de Sesión', 2, '2025-11-26 22:37:13', NULL),
(298, 'usuarios', 13, 'Inicio de Sesión', 13, '2025-11-26 22:37:21', NULL),
(299, 'reservas', 15, 'Solicitar Cita Talle', 13, '2025-11-26 22:37:28', '{\"vehiculo_id\":\"8\",\"motivo\":\"frenos\"}'),
(300, 'usuarios', 13, 'Cierre de Sesión', 13, '2025-11-26 22:37:32', NULL),
(301, 'usuarios', 2, 'Inicio de Sesión', 2, '2025-11-26 22:37:35', NULL),
(302, 'reservas', 15, 'Aprobar/Asignar Cita', 2, '2025-11-26 22:38:07', '{\"inicio\":\"2025-11-26T16:40\",\"mecanico_id\":\"11\",\"tarea_id\":15,\"repuestos_reservados\":1}'),
(303, 'usuarios', 2, 'Cierre de Sesión', 2, '2025-11-26 22:38:47', NULL),
(304, 'usuarios', 11, 'Inicio de Sesión', 11, '2025-11-26 22:38:51', NULL),
(305, 'tareas', 15, 'Aceptar Tarea', 11, '2025-11-26 22:38:59', NULL),
(306, 'usuarios', 11, 'Cierre de Sesión', 11, '2025-11-26 22:39:07', NULL),
(307, 'usuarios', 5, 'Inicio de Sesión', 5, '2025-11-26 22:39:11', NULL),
(308, 'entradas_vehiculos', 14, 'Registrar Ingreso (O', 5, '2025-11-26 22:39:38', '{\"reserva_id\":\"15\"}'),
(309, 'usuarios', 5, 'Cierre de Sesión', 5, '2025-11-26 22:39:59', NULL),
(310, 'usuarios', 2, 'Inicio de Sesión', 2, '2025-11-26 22:40:05', NULL),
(311, 'usuarios', 2, 'Cierre de Sesión', 2, '2025-11-26 22:40:10', NULL),
(312, 'usuarios', 11, 'Inicio de Sesión', 11, '2025-11-26 22:40:13', NULL),
(313, 'tareas', 15, 'Iniciar Tarea', 11, '2025-11-26 22:40:15', NULL),
(314, 'tareas', 14, 'Completar Tarea (con', 3, '2025-11-26 22:40:40', '{\"archivo\":\"evidencias/1764186039191-508227753.jpg\"}'),
(315, 'usuarios', 3, 'Cierre de Sesión', 3, '2025-11-26 22:40:46', NULL),
(316, 'usuarios', 4, 'Inicio de Sesión', 4, '2025-11-26 22:40:48', NULL),
(317, 'usuarios', 4, 'Cierre de Sesión', 4, '2025-11-26 22:40:53', NULL),
(318, 'usuarios', 13, 'Inicio de Sesión', 13, '2025-11-26 22:40:59', NULL),
(319, 'usuarios', 13, 'Cierre de Sesión', 13, '2025-11-26 22:41:04', NULL),
(320, 'usuarios', 4, 'Inicio de Sesión', 4, '2025-11-26 22:41:07', NULL),
(321, 'usuarios', 4, 'Cierre de Sesión', 4, '2025-11-26 22:41:10', NULL),
(322, 'usuarios', 2, 'Inicio de Sesión', 2, '2025-11-26 22:41:13', NULL),
(323, 'entradas_vehiculos', 13, 'Finalizar OT', 2, '2025-11-26 22:41:23', '{\"estado\":\"Finalizado\"}'),
(324, 'usuarios', 2, 'Cierre de Sesión', 2, '2025-11-26 22:41:32', NULL),
(325, 'usuarios', 4, 'Inicio de Sesión', 4, '2025-11-26 22:41:35', NULL),
(326, 'entradas_vehiculos', 13, 'Aceptar Retiro Vehíc', 4, '2025-11-26 22:41:37', '{\"etapa_actual\":\"Retirado\"}'),
(327, 'usuarios', 4, 'Cierre de Sesión', 4, '2025-11-26 22:41:42', NULL),
(328, 'usuarios', 5, 'Inicio de Sesión', 5, '2025-11-26 22:41:44', NULL),
(329, 'entradas_vehiculos', 13, 'Registrar Salida', 5, '2025-11-26 22:41:49', '{\"patente\":\"RX-KD-81\"}'),
(330, 'usuarios', 5, 'Cierre de Sesión', 5, '2025-11-26 22:41:55', NULL),
(331, 'usuarios', 2, 'Inicio de Sesión', 2, '2025-11-26 22:41:58', NULL),
(332, 'usuarios', 2, 'Cierre de Sesión', 2, '2025-11-26 22:42:40', NULL),
(333, 'usuarios', 8, 'Inicio de Sesión', 8, '2025-11-26 22:42:43', NULL),
(334, 'tareas', 15, 'Pausar Tarea', 11, '2025-11-26 22:42:48', '{\"motivo\":\"Esperando Repuesto\"}'),
(335, 'solicitudes_repuestos', 10, 'Despachar Repuesto', 8, '2025-11-26 22:46:04', '{\"estado\":\"Despachada\",\"repuesto_id\":3,\"cantidad\":\"1.00\"}'),
(336, 'tareas', 15, 'Iniciar Tarea', 11, '2025-11-26 22:46:23', NULL),
(337, 'usuarios', 8, 'Cierre de Sesión', 8, '2025-11-26 22:46:33', NULL),
(338, 'usuarios', 2, 'Inicio de Sesión', 2, '2025-11-26 22:46:37', NULL),
(339, 'usuarios', 2, 'Cierre de Sesión', 2, '2025-11-26 22:47:31', NULL),
(340, 'usuarios', 5, 'Inicio de Sesión', 5, '2025-11-26 22:47:34', NULL),
(341, 'usuarios', 5, 'Cierre de Sesión', 5, '2025-11-26 22:47:42', NULL),
(342, 'usuarios', 11, 'Inicio de Sesión', 11, '2025-11-26 22:47:45', NULL),
(343, 'usuarios', 11, 'Cierre de Sesión', 11, '2025-11-26 22:48:00', NULL),
(344, 'usuarios', 4, 'Inicio de Sesión', 4, '2025-11-26 22:48:03', NULL),
(345, 'usuarios', 4, 'Cierre de Sesión', 4, '2025-11-26 22:48:06', NULL),
(346, 'usuarios', 13, 'Inicio de Sesión', 13, '2025-11-26 22:48:09', NULL),
(347, 'usuarios', 13, 'Cierre de Sesión', 13, '2025-11-26 22:48:18', NULL),
(348, 'usuarios', 1, 'Inicio de Sesión', 1, '2025-11-26 22:48:20', NULL),
(349, 'usuarios', 1, 'Cierre de Sesión', 1, '2025-11-26 22:48:52', NULL),
(350, 'usuarios', 8, 'Inicio de Sesión', 8, '2025-11-26 22:49:28', NULL),
(351, 'usuarios', 8, 'Cierre de Sesión', 8, '2025-11-26 22:49:48', NULL),
(352, 'usuarios', 6, 'Inicio de Sesión', 6, '2025-11-26 22:49:52', NULL),
(353, 'usuarios', 6, 'Cierre de Sesión', 6, '2025-11-26 22:50:16', NULL),
(354, 'usuarios', 2, 'Inicio de Sesión', 2, '2025-11-26 22:50:21', NULL),
(355, 'tareas', 15, 'Completar Tarea (con', 11, '2025-11-26 23:03:07', '{\"archivo\":\"evidencias/1764187386372-702363925.jpg\"}'),
(356, 'entradas_vehiculos', 14, 'Finalizar OT', 2, '2025-11-26 23:03:34', '{\"estado\":\"Finalizado\"}'),
(357, 'usuarios', 2, 'Cierre de Sesión', 2, '2025-11-26 23:03:41', NULL),
(358, 'usuarios', 5, 'Inicio de Sesión', 5, '2025-11-26 23:03:44', NULL),
(359, 'entradas_vehiculos', 14, 'Registrar Salida', 5, '2025-11-26 23:03:49', '{\"patente\":\"RX-YF-96\"}'),
(360, 'usuarios', 5, 'Cierre de Sesión', 5, '2025-11-26 23:03:52', NULL),
(361, 'usuarios', 13, 'Inicio de Sesión', 13, '2025-11-26 23:03:55', NULL),
(362, 'usuarios', 13, 'Cierre de Sesión', 13, '2025-11-26 23:04:03', NULL),
(363, 'usuarios', 2, 'Inicio de Sesión', 2, '2025-11-26 23:04:12', NULL);

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
(1, 'SKU-001', 'Filtro de Aceite', 'Filtro de aceite para motor Mercedes-Benz Actros', 'Unidad', 'A-01', '2025-11-10 02:23:13'),
(2, 'SKU-002', 'Aceite Motor 10W40', 'Bidón de 20L Aceite sintético', 'Litro', 'B-03', '2025-11-10 02:23:13'),
(3, 'SKU-003', 'Pastillas de Freno', 'Juego de pastillas delanteras Scania', 'Juego', 'A-02', '2025-11-10 02:23:13'),
(4, 'SKU-004', 'Filtro de Aire Motor', 'Filtro de aire para Scania Serie R', 'Unidad', 'A-04', '2025-11-12 16:40:15'),
(5, 'SKU-005', 'Ampolleta H7 24V', 'Ampolleta halógena para faro principal (24V)', 'Unidad', 'C-01', '2025-11-12 16:40:15'),
(6, 'SKU-006', 'Líquido Refrigerante', 'Bidón 5L G12 Plus (Rosa)', 'Bidón', 'B-01', '2025-11-12 16:40:15'),
(7, 'SKU-007', 'Correa de Accesorios', 'Correa Poly-V para Mercedes-Benz Actros', 'Unidad', 'A-05', '2025-11-12 16:40:15'),
(8, 'SKU-008', 'Grasa de Litio', 'Tubo 1kg Grasa multipropósito', 'Tubo', 'B-02', '2025-11-12 16:40:15'),
(9, 'SKU-009', 'Limpiaparabrisas 24\"', 'Plumilla limpiaparabrisas 24 pulgadas', 'Juego', 'C-02', '2025-11-12 16:40:15'),
(10, 'SKU-010', 'Batería 180Ah 12V', 'Batería de arranque servicio pesado', 'Unidad', 'D-01', '2025-11-12 16:40:15');

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

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `vehiculo_id`, `taller_id`, `creado_por`, `inicio_programado`, `fin_programado`, `estado`, `notas`, `fecha_creacion`) VALUES
(14, 4, 1, 4, '2025-11-26 22:34:00', '2025-11-26 22:34:00', 'Utilizada', 'Falla motor', '2025-11-26 22:33:23'),
(15, 8, 1, 13, '2025-11-26 22:40:00', '2025-11-26 22:40:00', 'Utilizada', 'frenos', '2025-11-26 22:37:28');

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

--
-- Volcado de datos para la tabla `solicitudes_repuestos`
--

INSERT INTO `solicitudes_repuestos` (`id`, `tarea_id`, `repuesto_id`, `solicitado_por`, `cantidad_solicitada`, `estado`, `aprobado_por`, `supervisor_id`, `fecha_solicitud`, `fecha_aprobacion`, `notas_rechazo`) VALUES
(9, 14, 2, 3, 1.00, 'Despachada', 8, 2, '2025-11-26 22:34:02', '2025-11-26 22:36:30', NULL),
(10, 15, 3, 11, 1.00, 'Despachada', 8, 2, '2025-11-26 22:38:07', '2025-11-26 22:46:04', NULL);

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
(1, 'Taller Cerrillos', 'Av. Ejemplos 123', 20, NULL, '2025-11-21 18:23:12');

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

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`id`, `entrada_vehiculo_id`, `titulo`, `descripcion`, `creado_por`, `asignado_a`, `estado`, `prioridad`, `horas_estimadas`, `notas_rechazo`, `fecha_inicio`, `fecha_completado`, `fecha_creacion`) VALUES
(14, 13, 'Revisión Vehículo', NULL, 2, 3, 'Completado', 'Media', NULL, NULL, '2025-11-26 22:34:02', '2025-11-26 22:40:40', '2025-11-26 22:34:02'),
(15, 14, 'Revisión Vehículo', NULL, 2, 11, 'Completado', 'Media', NULL, NULL, '2025-11-26 22:38:07', '2025-11-26 23:03:07', '2025-11-26 22:38:07');

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
(1, 'admin', '$2b$10$c4PkDRq4xS9DDb0bCGT7CO/NCRsMg8dNFWSD4cwVwK8iSBcZbPe.K', 'je.luces@duocuc.cl', 'Admin Pepsico', 1, NULL, 1, '2025-11-09 23:29:41', NULL, NULL, NULL),
(2, 'supervisor', '$2b$10$Z1dJ/hMsT6LhvRob3/HQ/.W2Pd8MNMYqiWZ5s5oI8VYhwCUi4l3ZO', 'ni.agurtoc@duocuc.cl', 'Nicolás Agurto', 2, NULL, 1, '2025-11-09 23:30:29', NULL, NULL, NULL),
(3, 'mecanico', '$2b$10$gTGxb249ZLWuIacaZwplxeiLtJsXZncje9JPH2JfeYMv3x2hvL6Ly', 'mecanico1@pepsi.com', 'Juan Mecanico', 3, NULL, 1, '2025-11-09 23:31:41', NULL, NULL, NULL),
(4, 'chofer', '$2b$10$YKSFWG8opEiERJL1jQHG5eh4F8kKFTVm9THuoAjNc.nPmUGuC/uL6', 'chofer1@pepsi.com', 'Carlos Rivas', 4, NULL, 1, '2025-11-09 23:31:03', NULL, NULL, NULL),
(5, 'guardia', '$2b$10$f9hvZLrefxr3ikE8BINRfOJ/DU3e1mkKVBEiDJaMspe5Mfv8FvH5a', 'guardia@pepsi.com', 'Ian Guard', 5, NULL, 1, '2025-11-09 23:32:59', NULL, NULL, NULL),
(6, 'llaves', '$2b$10$7ga99Cd4iiYaVd6eVWHu7e38AFu6rkwIt0ZyG2cwhkARBEKW61XES', 'llaves@pepsi.com', 'Joaquín Llavín', 6, NULL, 1, '2025-11-09 23:31:46', NULL, NULL, NULL),
(7, 'chofer2', '$2b$10$nwn2LkXH35nh2yBrXSz7SewXUI/HMVn5902G1HXR7oWn1f/O/Qmsa', 'matia.espinozab@duocuc.cl', 'Matías Espinoza', 4, NULL, 1, '2025-11-12 16:47:53', NULL, NULL, NULL),
(8, 'repuestos', '$2b$10$QfMQ9vkeTVmSVGdj8fAUrOO6H6anqv13eLMX/xpETDMDxeqhFglme', 'repuestos@pepsi.com', 'Reul Puesto', 7, NULL, 1, '2025-11-09 23:33:52', NULL, NULL, NULL),
(9, 'mecanico2', '$2b$10$9.GWShXu/xwf66SYElOG1emwKn0rQtI7wjwJj1KkTWs0/CqXYW8KS', 'mecanico2@pepsi.com', 'Alonso Bustamante', 3, NULL, 1, '2025-11-09 23:32:20', NULL, NULL, NULL),
(11, 'mecanico3', '$2b$10$bAVozWKVjrfo/FCWQH0yp.58nGOhALOY/vqkLfOfNavsQgkekiCBG', 'mecanico3@pepsico.cl', 'Meca Nicolas', 3, NULL, 1, '2025-11-12 16:33:54', NULL, NULL, NULL),
(12, 'mecanico4', '$2b$10$ypq2Hn1CpfpKYKuwppon5.hFfXoaAtki8Tdn9Qa.YKm1afzA9bjbS', 'mecanico4@pepsico.cl', 'Cani Come', 3, NULL, 1, '2025-11-12 16:35:09', NULL, NULL, NULL),
(13, 'chofer3', '$2b$10$oGpBINMzFdRFJr9HlYzEkek0nwxDUjvWvOvyMiZrxYje43M6wBoH6', 'chofer3@pepsico.cl', 'Diego Molina', 4, NULL, 1, '2025-11-12 16:46:32', NULL, NULL, NULL),
(14, 'chofer4', '$2b$10$kom6pCWn9lo1r6hrl3gaJu2ywd9E125/HB8Nb.1kFdmVvNVXDNwHS', 'chofer4@pepsico.cl', 'Javiera Soto', 4, NULL, 1, '2025-11-12 16:46:53', NULL, NULL, NULL),
(15, 'chofer5', '$2b$10$IPHQyBvjiRNC1.qanwJA1u0nb8TelGlFCP0x2xcEGLltmuzFWbe3u', 'chofer5@pepsico.cl', 'Pedro Pascal', 4, NULL, 1, '2025-11-12 16:47:09', NULL, NULL, NULL);

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
(4, 'RX-KD-81', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Flota', 4, '2025-11-21 18:14:24'),
(5, 'RX-KD-84', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Flota', 7, '2025-11-21 18:17:30'),
(6, 'RX-KD-85', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Flota', 11, '2025-11-21 18:17:41'),
(7, 'RX-KD-96', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Flota', 14, '2025-11-21 18:19:24'),
(8, 'RX-YF-96', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Flota', 13, '2025-11-21 18:19:27'),
(9, 'JI-CD-13', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Reemplazo', NULL, '2025-11-21 18:19:29'),
(10, 'RX-YG-18', NULL, 'Ram', 'Van 700', 2022, NULL, 'Activo', 'Reemplazo', NULL, '2025-11-21 18:19:32');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `evidencias`
--
ALTER TABLE `evidencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `historial_reportes`
--
ALTER TABLE `historial_reportes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `movimientos_repuestos`
--
ALTER TABLE `movimientos_repuestos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de la tabla `pausas`
--
ALTER TABLE `pausas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `registros_auditoria`
--
ALTER TABLE `registros_auditoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=364;

--
-- AUTO_INCREMENT de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `solicitudes_repuestos`
--
ALTER TABLE `solicitudes_repuestos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `talleres`
--
ALTER TABLE `talleres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
