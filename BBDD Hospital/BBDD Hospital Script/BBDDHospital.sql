-- Volcando estructura de base de datos para hospital
DROP DATABASE IF EXISTS hospital;
CREATE DATABASE IF NOT EXISTS hospital /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci */;
USE hospital;


-- Volcando estructura para tabla hospital.area
DROP TABLE IF EXISTS `area`;
CREATE TABLE IF NOT EXISTS `area` (
  `id` int(11) NOT NULL DEFAULT '0',
  `tipo` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `orientacion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.


-- Volcando estructura para tabla hospital.trabajador
DROP TABLE IF EXISTS `trabajador`;
CREATE TABLE IF NOT EXISTS `trabajador` (
  `colegiado` varchar(9) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `nif` varchar(9) CHARACTER SET latin1 NOT NULL,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  `apellidos` varchar(50) CHARACTER SET latin1 NOT NULL,
  `telefono` varchar(9) CHARACTER SET latin1 DEFAULT NULL,
  `direccion` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `nacionalidad` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `provincia` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `ciudad` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `sexo` varchar(1) CHARACTER SET latin1 DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  `foto` longblob,
  `idArea` int(11) DEFAULT NULL,
  `passw` varchar(9) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`colegiado`),
  KEY `idArea` (`idArea`),
  KEY `colegiado` (`colegiado`),
  CONSTRAINT `trabajador_ibfk_1` FOREIGN KEY (`idArea`) REFERENCES `area` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.tipoturno
DROP TABLE IF EXISTS `tipoturno`;
CREATE TABLE IF NOT EXISTS `tipoturno` (
  `tipo` varchar(50) NOT NULL DEFAULT '',
  `horaentrada` time DEFAULT NULL,
  `horasalida` time DEFAULT NULL,
  PRIMARY KEY (`tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.turno
DROP TABLE IF EXISTS `turno`;
CREATE TABLE IF NOT EXISTS `turno` (
  `id` int(11) NOT NULL DEFAULT '0',
  `fechainicio` date DEFAULT NULL,
  `fechafin` date DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo` (`tipo`),
  CONSTRAINT `turno_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `tipoturno` (`tipo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.admin
DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `usuario` varchar(9) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `passw` varchar(9) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `foto` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.




-- Volcando estructura para tabla hospital.asignado
DROP TABLE IF EXISTS `asignado`;
CREATE TABLE IF NOT EXISTS `asignado` (
  `idTrabajador` varchar(9) NOT NULL DEFAULT '',
  `idTurno` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idTrabajador`,`idTurno`),
  KEY `idTurno` (`idTurno`),
  CONSTRAINT `asignado_ibfk_1` FOREIGN KEY (`idTrabajador`) REFERENCES `trabajador` (`colegiado`) ON DELETE CASCADE,
  CONSTRAINT `asignado_ibfk_2` FOREIGN KEY (`idTurno`) REFERENCES `turno` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.historial
DROP TABLE IF EXISTS `historial`;
CREATE TABLE IF NOT EXISTS `historial` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `grupo_sanguineo` varchar(3) NOT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  `vacunas` varchar(100) DEFAULT NULL,
  `alergias` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.especialidad
DROP TABLE IF EXISTS `especialidad`;
CREATE TABLE IF NOT EXISTS `especialidad` (
  `id` int(10) NOT NULL DEFAULT '0',
  `tipo` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.medico
DROP TABLE IF EXISTS `medico`;
CREATE TABLE IF NOT EXISTS `medico` (
  `colegiado` varchar(9) NOT NULL DEFAULT '',
  `idEspecialidad` int(10) NOT NULL,
  PRIMARY KEY (`colegiado`),
  KEY `idEspecialidad` (`idEspecialidad`),
  KEY `colegiado` (`colegiado`),
  CONSTRAINT `medico_ibfk_1` FOREIGN KEY (`idEspecialidad`) REFERENCES `especialidad` (`id`),
  CONSTRAINT `medico_ibfk_2` FOREIGN KEY (`colegiado`) REFERENCES `trabajador` (`colegiado`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.


-- Volcando estructura para tabla hospital.linea_historial
DROP TABLE IF EXISTS `linea_historial`;
CREATE TABLE IF NOT EXISTS `linea_historial` (
  `id` int(10) NOT NULL,
  `fecha` date NOT NULL,
  `idHistorial` int(10) NOT NULL,
  `idMedico` varchar(9) NOT NULL,
  PRIMARY KEY (`id`,`idHistorial`),
  KEY `idHistorial` (`idHistorial`),
  KEY `idMedico` (`idMedico`),
  KEY `id` (`id`,`idHistorial`),
  CONSTRAINT `linea_historial_ibfk_1` FOREIGN KEY (`idHistorial`) REFERENCES `historial` (`id`),
  CONSTRAINT `linea_historial_ibfk_2` FOREIGN KEY (`idMedico`) REFERENCES `medico` (`colegiado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.diagnostico
DROP TABLE IF EXISTS `diagnostico`;
CREATE TABLE IF NOT EXISTS `diagnostico` (
  `idH` int(10) NOT NULL DEFAULT '0',
  `idL` int(10) NOT NULL DEFAULT '0',
  `descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idH`,`idL`),
  KEY `fk_diagnosticolineahistorial` (`idL`,`idH`),
  CONSTRAINT `fk_diagnosticolineahistorial` FOREIGN KEY (`idL`, `idH`) REFERENCES `linea_historial` (`id`, `idHistorial`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.


-- Volcando estructura para tabla hospital.enfermero
DROP TABLE IF EXISTS `enfermero`;
CREATE TABLE IF NOT EXISTS `enfermero` (
  `colegiado` varchar(9) NOT NULL DEFAULT '',
  PRIMARY KEY (`colegiado`),
  CONSTRAINT `enfermero_ibfk_1` FOREIGN KEY (`colegiado`) REFERENCES `trabajador` (`colegiado`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.





-- Volcando estructura para tabla hospital.habitacion
DROP TABLE IF EXISTS `habitacion`;
CREATE TABLE IF NOT EXISTS `habitacion` (
  `id` int(11) NOT NULL DEFAULT '0',
  `dimension` int(11) DEFAULT NULL,
  `ocupado` tinyint(1) DEFAULT NULL,
  `idArea` int(11) NOT NULL,
  PRIMARY KEY (`id`,`idArea`),
  KEY `idArea` (`idArea`),
  CONSTRAINT `habitacion_ibfk_1` FOREIGN KEY (`idArea`) REFERENCES `area` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.






-- Volcando estructura para tabla hospital.ingreso
DROP TABLE IF EXISTS `ingreso`;
CREATE TABLE IF NOT EXISTS `ingreso` (
  `idH` int(10) NOT NULL DEFAULT '0',
  `idL` int(10) NOT NULL DEFAULT '0',
  `fechaAlta` date DEFAULT NULL,
  `idHabitacion` int(11) DEFAULT NULL,
  `idArea` int(11) DEFAULT NULL,
  PRIMARY KEY (`idH`,`idL`),
  KEY `INGRESO_ibfk_2` (`idL`,`idH`),
  KEY `INGRESO_ibfk_1` (`idHabitacion`),
  KEY `idIngreso` (`idHabitacion`,`idArea`),
  CONSTRAINT `ingreso_ibfk_3` FOREIGN KEY (`idHabitacion`, `idArea`) REFERENCES `habitacion` (`id`, `idArea`),
  CONSTRAINT `ingreso_ibfk_2` FOREIGN KEY (`idL`, `idH`) REFERENCES `linea_historial` (`id`, `idHistorial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- La exportación de datos fue deseleccionada.


-- Volcando estructura para tabla hospital.intervencion
DROP TABLE IF EXISTS `intervencion`;
CREATE TABLE IF NOT EXISTS `intervencion` (
  `idH` int(11) NOT NULL DEFAULT '0',
  `idL` int(11) NOT NULL DEFAULT '0',
  `descripcion` varchar(200) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  PRIMARY KEY (`idH`,`idL`),
  KEY `idL` (`idL`,`idH`),
  CONSTRAINT `intervencion_ibfk_1` FOREIGN KEY (`idL`, `idH`) REFERENCES `linea_historial` (`id`, `idHistorial`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.





-- Volcando estructura para tabla hospital.LOGS
DROP TABLE IF EXISTS `LOGS`;
CREATE TABLE IF NOT EXISTS `LOGS` (
  `Fecha` date NOT NULL,
  `AreaMayorOcupada` int(11) NOT NULL,
  `AreaMenorOcupada` int(11) NOT NULL,
  `UmbralMAX` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `UmbralMIN` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- La exportación de datos fue deseleccionada.




-- Volcando estructura para tabla hospital.paciente
DROP TABLE IF EXISTS `paciente`;
CREATE TABLE IF NOT EXISTS `paciente` (
  `sip` varchar(7) NOT NULL DEFAULT '',
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `fecha_nacimiento` varchar(50) NOT NULL,
  `sexo` varchar(1) NOT NULL,
  `telefono` varchar(9) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `nacionalidad` varchar(50) DEFAULT NULL,
  `provincia` varchar(50) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`sip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.


-- Volcando estructura para tabla hospital.pruebas
DROP TABLE IF EXISTS `pruebas`;
CREATE TABLE IF NOT EXISTS `pruebas` (
  `idH` int(11) NOT NULL DEFAULT '0',
  `idL` int(11) NOT NULL DEFAULT '0',
  `tipo` varchar(50) NOT NULL,
  `imagenes` longblob,
  PRIMARY KEY (`idH`,`idL`),
  KEY `idL` (`idL`,`idH`),
  CONSTRAINT `pruebas_ibfk_1` FOREIGN KEY (`idL`, `idH`) REFERENCES `linea_historial` (`id`, `idHistorial`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.


-- Volcando estructura para tabla hospital.tiene_un
DROP TABLE IF EXISTS `tiene_un`;
CREATE TABLE IF NOT EXISTS `tiene_un` (
  `idhistorial` int(11) NOT NULL DEFAULT '0',
  `idpaciente` varchar(7) NOT NULL,
  PRIMARY KEY (`idhistorial`),
  UNIQUE KEY `idpaciente` (`idpaciente`),
  CONSTRAINT `tiene_un_ibfk_1` FOREIGN KEY (`idhistorial`) REFERENCES `historial` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tiene_un_ibfk_2` FOREIGN KEY (`idpaciente`) REFERENCES `paciente` (`sip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.tratamiento
DROP TABLE IF EXISTS `tratamiento`;
CREATE TABLE IF NOT EXISTS `tratamiento` (
  `idH` int(10) NOT NULL DEFAULT '0',
  `idL` int(10) NOT NULL DEFAULT '0',
  `medicacion` varchar(200) NOT NULL,
  PRIMARY KEY (`idH`,`idL`),
  KEY `fk_tratamientolineahistorial` (`idL`,`idH`),
  CONSTRAINT `fk_tratamientolineahistorial` FOREIGN KEY (`idL`, `idH`) REFERENCES `linea_historial` (`id`, `idHistorial`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.


