USE PROJECT_HOSPITAL;
GO;

-- Crear una función que permite saber el año actual

SELECT sysdatetime();
SELECT YEAR(sysdatetime());

CREATE FUNCTION [dbo].obtiene_current_year()
  RETURNS int AS
  begin
    declare @response int;
    set @response = YEAR(sysdatetime());
    return @response;
  end;

SELECT [dbo].obtiene_current_year();

-- Crear una función que permita sumar dos números.
-- Que esta funcion recibira 2 parametros(2 numeros)

-- Creacion de funciones
CREATE FUNCTION [dbo].suma_dos_numeros(
  @num1 int,
  @num2 int
)
  RETURNS int AS
  BEGIN
    declare @respuesta int = 0;
    set @respuesta = @num1 + @num2;

    RETURN @respuesta;
  END;

SELECT [dbo].suma_dos_numeros(5, 5);

-- Modificacion de funciones
CREATE OR ALTER FUNCTION [dbo].suma_dos_numeros(
  @num1 int,
  @num2 int
)
  RETURNS int AS
  BEGIN
    RETURN @num1 + @num2;
  END;

SELECT [dbo].suma_dos_numeros(5, 5);

-- Eliminacion de funciones
DROP FUNCTION [dbo].suma_dos_numeros;

-- Verificar si la edad a insertarse es correcto. Par poder determinar
-- si es correcto usar la fecha de nacimiento.

-- Obteniendo la gestion actual
SELECT getdate();

-- Obteniendo la cantidad de dias desde la fecha de nacimiento
SELECT DATEDIFF(day , '1988-12-10', getdate());

-- Obtieniendo la edad correcta
SELECT FLOOR(DATEDIFF(DAY, '1988-12-10', getdate()) / 365.25);

CREATE FUNCTION validate_correct_age(@birthday date, @age int)
  RETURNS bit AS
  BEGIN
    declare
      @respuesta bit,
      @cant_dias int,
      @edad_calc int;

    set @cant_dias = DATEDIFF(day , @birthday, getdate());
    set @edad_calc = FLOOR(@cant_dias / 365.25);

    if @edad_calc = @age
      set @respuesta = 1; -- 1 = true
    else
      set @respuesta = 0; --0 = false

    return @respuesta;
  END;

SELECT [dbo].validate_correct_age('1988-12-10', 33);

-- Generar un reporte en donde se muestre qué doctores están asignados
-- a los pacientes.
-- El reporte debe mostrar nombres y apellidos de los doctores y pacientes.

-- Insertando registros a la tabla: doctors_assigned_to_patients

INSERT INTO doctors_assigned_to_patients(patient_id, staff_id, date_from, date_to) VALUES
  (1, 1, '2016-12-05', '2022-06-15'),
  (2, 2, '2018-06-05', '2023-02-15');

-- Plantenado la solucion al requerimiento
SELECT doc.doctor_name,
       doc.doctor_lastname,
       pat.patient_name,
       pat.patient_lastname
FROM doctors_assigned_to_patients AS datp
  INNER JOIN doctors AS doc ON datp.staff_id = doc.staff_id
  INNER JOIN patients AS pat ON  datp.patient_id = pat.patient_id;

-- Creando la funcion
CREATE FUNCTION report_doctors_and_patients(@age int)
  RETURNS @datp_table TABLE(
    doctor_name  varchar(25),
    doctor_lastname  varchar(25),
    patient_name  varchar(25),
    patient_lastname  varchar(25)
  ) AS
  BEGIN
    INSERT INTO @datp_table
      SELECT
       doc.doctor_name,
       doc.doctor_lastname,
       pat.patient_name,
       pat.patient_lastname
      FROM doctors_assigned_to_patients AS datp
        INNER JOIN doctors AS doc ON datp.staff_id = doc.staff_id
        INNER JOIN patients AS pat ON  datp.patient_id = pat.patient_id
       WHERE doc.doctor_age < @age;

      RETURN;
  END;

SELECT *
FROM [dbo].report_doctors_and_patients(23);

-- Crear una función que permita validar que la cantidad de caracteres sea mayor a cierto número.
-- 	La función recibe 2 parámetros:
-- La cadena
-- El valor numerico

SELECT LEN('Taller de SQL Server v1');

CREATE OR ALTER FUNCTION validate_length(
  @cadena varchar(200),
  @cantidad int
)
  RETURNS bit AS
  BEGIN
    declare
      @response bit = 0,--false
      @len int = 0;

    set @len = LEN(@cadena);

    if @len > @cantidad
      set @response = 1;

    return @response;
  END;

SELECT [dbo].validate_length('Taller de SQL Server v1', 20);
















