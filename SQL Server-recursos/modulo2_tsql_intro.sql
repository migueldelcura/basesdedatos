USE PROJECT_HOSPITAL;
GO

-- Manejo de DECLARE

-- Mostrar todos los doctores(nombres, apellidos y edad)
-- en donde la edad sea mayor que 30

DECLARE @age INTEGER = 30;

SELECT doc.doctor_name, doc.doctor_lastname, doc.doctor_age
FROM doctors AS doc
WHERE doc.doctor_age > @age;

-- Mostrar todos los doctores(nombres, apellidos y edad)
-- en donde la edad sea mayor que 30 y el nombre sea Joel

DECLARE
  @age INTEGER = 30,
  @name varchar(25) = 'Joel';

SELECT doc.doctor_name, doc.doctor_lastname, doc.doctor_age
FROM doctors AS doc
WHERE doc.doctor_age > @age AND doc.doctor_name = @name;

-- Manejo de SET

-- Mostrar todos los doctores(nombres, apellidos y edad)
-- en donde la edad sea mayor que 30 y el nombre sea Joel

DECLARE
  @age INTEGER = 20,
  @name varchar(25) = 'Joel';

SET @age = 30;
SET @name = 'Joel';

SELECT doc.doctor_name, doc.doctor_lastname, doc.doctor_age
FROM doctors AS doc
WHERE doc.doctor_age > @age AND doc.doctor_name = @name;

-- Manejo de INTO

-- Mostrar todos los pacientes (nombres, apellidos, genero y el peso)

SELECT pa.patient_name,
       pa.patient_lastname,
       pa.patient_gender,
       pa.patient_weight
INTO patients_report
FROM patients AS pa;

SELECT *
FROM patients_report;

-- Creando un primary key

DROP TABLE patients_report;

SELECT identity(integer, 1, 1) AS patient_id,
       pa.patient_name,
       pa.patient_lastname,
       pa.patient_gender,
       pa.patient_weight
INTO patients_report
FROM patients AS pa;

-- Salvando la respuesta en una variable
-- Determinar cuantos registros tiene la tabla patients_report

DECLARE @response integer = 0;

SELECT @response = COUNT(pr.patient_id)
FROM patients_report AS pr;

SELECT @response AS cc;

-- Menejo IF/ELSE
-- Determinar si estamos en un dia laborable o estamos en fin de semana

SELECT DATENAME(weekday, getdate());
DECLARE @diaDelaSemana VARCHAR(12) = '';
SELECT @diaDelaSemana = DATENAME(weekday, getdate());

IF @diaDelaSemana IN ('Saturday', 'Sunday')
  SELECT 'Fin de semana';
ELSE
  SELECT 'Dia laboral';

-- Si el promedio de las edades es par
-- Por verdad mostrar todos los doctores
-- Caso contrario mostrar un mensaje igual a "Se requiere contratar mas doctores"

DECLARE @promedioEdades INTEGER = 0;
SELECT @promedioEdades = AVG(doc.doctor_age)
FROM doctors AS doc;

IF @promedioEdades % 2 = 0
  SELECT doc.*
  FROM doctors AS doc;
ELSE
  PRINT 'Message: Se requiere contratar mas doctores';

-- Manejo WHEN/CASE

SELECT pa.patient_name,
       pa.patient_lastname,
       patient_gender_c =
       CASE
         WHEN pa.patient_gender = 'm' THEN 'Masculino'
         WHEN pa.patient_gender = 'f' THEN 'Femenino'
         ELSE 'Otro'
       END
FROM patients AS pa;














