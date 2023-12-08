-- --------------------------------------------------------
-- Host:                         192.168.1.129
-- Versión del servidor:         10.3.27-MariaDB-0+deb10u1 - Debian 10
-- SO del servidor:              debian-linux-gnu
-- HeidiSQL Versión:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para ejemplo
CREATE DATABASE IF NOT EXISTS `ejemplo` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ejemplo`;

-- Volcando estructura para tabla ejemplo.asignaturas
CREATE TABLE IF NOT EXISTS `asignaturas` (
  `codigo` char(5) NOT NULL DEFAULT '',
  `descripcion` varchar(35) DEFAULT NULL,
  `creditos` decimal(3,1) DEFAULT NULL,
  `creditosp` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejemplo.asignaturas: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `asignaturas` DISABLE KEYS */;
INSERT INTO `asignaturas` (`codigo`, `descripcion`, `creditos`, `creditosp`) VALUES
	('DGBD', 'DISEÑO Y GESTION DE BASES DE DATOS', 6.0, 3.0),
	('FBD', 'FUNDAMENTOS DE LAS BASES DE DATOS', 6.0, 1.5),
	('FP', 'FUNDAMENTOS DE LA PROGRAMACION', 9.0, 4.5),
	('HI', 'HISTORIA DE LA INFORMATICA', 4.5, NULL),
	('PC', 'PROGRAMACION CONCURRENTE', 6.0, 1.5),
	('t', 'tutoria', 1.0, NULL);
/*!40000 ALTER TABLE `asignaturas` ENABLE KEYS */;

-- Volcando estructura para tabla ejemplo.coordinadores
CREATE TABLE IF NOT EXISTS `coordinadores` (
  `dni` varchar(10) NOT NULL DEFAULT '',
  `nombre` varchar(40) DEFAULT NULL,
  `dpto` char(4) DEFAULT NULL,
  `asig` char(5) DEFAULT NULL,
  PRIMARY KEY (`dni`),
  KEY `fk_coor_asig` (`asig`),
  CONSTRAINT `fk_coor_asig` FOREIGN KEY (`asig`) REFERENCES `asignaturas` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejemplo.coordinadores: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `coordinadores` DISABLE KEYS */;
INSERT INTO `coordinadores` (`dni`, `nombre`, `dpto`, `asig`) VALUES
	('55777666', 'AGAPITO CIFUENTES', 'DLSI', 'FP'),
	('66555444', 'ROMUALDO GOMEZ', 'DLSI', 'HI'),
	('99222111', 'CATURLO PEREZ', 'DLSI', NULL);
/*!40000 ALTER TABLE `coordinadores` ENABLE KEYS */;

-- Volcando estructura para tabla ejemplo.imparte
CREATE TABLE IF NOT EXISTS `imparte` (
  `dni` varchar(10) NOT NULL DEFAULT '',
  `asignatura` char(5) NOT NULL DEFAULT '',
  PRIMARY KEY (`dni`,`asignatura`),
  KEY `imparte_fk_2asignatura` (`asignatura`),
  CONSTRAINT `imparte_fk_2asignatura` FOREIGN KEY (`asignatura`) REFERENCES `asignaturas` (`codigo`),
  CONSTRAINT `imparte_fk_2profesores` FOREIGN KEY (`dni`) REFERENCES `profesores` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejemplo.imparte: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `imparte` DISABLE KEYS */;
INSERT INTO `imparte` (`dni`, `asignatura`) VALUES
	('21111222', 'DGBD'),
	('21111222', 'FBD'),
	('21222333', 'HI'),
	('21222333', 'PC'),
	('21333444', 'PC');
/*!40000 ALTER TABLE `imparte` ENABLE KEYS */;

-- Volcando estructura para tabla ejemplo.prepara
CREATE TABLE IF NOT EXISTS `prepara` (
  `dni` varchar(10) NOT NULL DEFAULT '',
  `asignatura` char(5) NOT NULL DEFAULT '',
  PRIMARY KEY (`dni`,`asignatura`),
  KEY `prepara_fk_2asignatura` (`asignatura`),
  CONSTRAINT `prepara_fk_2asignatura` FOREIGN KEY (`asignatura`) REFERENCES `asignaturas` (`codigo`),
  CONSTRAINT `prepara_fk_2profesores` FOREIGN KEY (`dni`) REFERENCES `profesores` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejemplo.prepara: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `prepara` DISABLE KEYS */;
INSERT INTO `prepara` (`dni`, `asignatura`) VALUES
	('21111222', 'DGBD'),
	('21111222', 'FP'),
	('21333444', 'DGBD'),
	('21333444', 'FBD'),
	('21333444', 'FP'),
	('21333444', 'HI'),
	('21333444', 'PC');
/*!40000 ALTER TABLE `prepara` ENABLE KEYS */;

-- Volcando estructura para tabla ejemplo.profesores
CREATE TABLE IF NOT EXISTS `profesores` (
  `dni` varchar(10) NOT NULL DEFAULT '',
  `nombre` varchar(40) DEFAULT NULL,
  `categoria` char(4) DEFAULT NULL,
  `ingreso` date DEFAULT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejemplo.profesores: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `profesores` DISABLE KEYS */;
INSERT INTO `profesores` (`dni`, `nombre`, `categoria`, `ingreso`) VALUES
	('21111222', 'EVA GOMEZ', 'TEU', '1993-10-01'),
	('21222333', 'MANUEL PALOMAR', 'TEU', '1989-06-16'),
	('21333444', 'RAFAEL ROMERO', 'ASO6', '1992-06-16');
/*!40000 ALTER TABLE `profesores` ENABLE KEYS */;

-- Volcando estructura para tabla ejemplo.supervisa
CREATE TABLE IF NOT EXISTS `supervisa` (
  `dni` varchar(10) NOT NULL,
  `asig` char(5) NOT NULL,
  PRIMARY KEY (`dni`,`asig`),
  KEY `asig` (`asig`),
  CONSTRAINT `FK_supervisa_supervisores` FOREIGN KEY (`dni`) REFERENCES `supervisores` (`dni`),
  CONSTRAINT `supervisa_ibfk_1` FOREIGN KEY (`asig`) REFERENCES `asignaturas` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejemplo.supervisa: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `supervisa` DISABLE KEYS */;
INSERT INTO `supervisa` (`dni`, `asig`) VALUES
	('1', 'DGBD'),
	('1', 'FBD'),
	('1', 'FP'),
	('1', 'HI'),
	('2', 'HI');
/*!40000 ALTER TABLE `supervisa` ENABLE KEYS */;

-- Volcando estructura para tabla ejemplo.supervisores
CREATE TABLE IF NOT EXISTS `supervisores` (
  `dni` varchar(10) NOT NULL,
  `nombre` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejemplo.supervisores: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `supervisores` DISABLE KEYS */;
INSERT INTO `supervisores` (`dni`, `nombre`) VALUES
	('1', 'Pepe'),
	('2', 'Pepe'),
	('3', 'Luis');
/*!40000 ALTER TABLE `supervisores` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
