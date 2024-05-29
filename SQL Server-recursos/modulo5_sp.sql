USE PROJECT_HOSPITAL;
go

-- Crear un SP que permita sumar dos números.
DROP PROCEDURE sp_suma_dos_numeros;

CREATE OR ALTER PROCEDURE sp_suma_dos_numeros
  @num1 int,
  @num2 int

  AS
  BEGIN
    declare @response int = 0;
    set @response = @num1 + @num2;
    select @response;
  END;
GO

EXECUTE sp_suma_dos_numeros @num1=5.6, @num2=5.4;

-- Se requiere determinar cuántos pacientes son mayores a 32 años.
-- Este valor es necesario para proceder con el proceso de vacunación contra el COVID-19

CREATE FUNCTION get_age(@birthday date)
  RETURNS int AS
  BEGIN
    declare
      @cant_dias int,
      @edad_calc int;

    set @cant_dias = DATEDIFF(day , @birthday, getdate());
    set @edad_calc = FLOOR(@cant_dias / 365.25);

    return @edad_calc;

  END;

SELECT pat.patient_name,
       pat.patient_lastname,
       dbo.get_age(pat.patient_date_of_birth)
FROM patients AS pat
WHERE dbo.get_age(pat.patient_date_of_birth) > 32;

CREATE OR ALTER PROCEDURE count_patients_32 AS
    SELECT count(pat.patient_id) as 'cantidad de pacientes mayores a 32'
    FROM patients AS pat
    WHERE dbo.get_age(pat.patient_date_of_birth) > 32;

exec count_patients_32;

-- Determinar cuántos pacientes y doctores están entre un rango de edad.
-- Ejemplo, mayores a 18 y menores que 30 años.
-- Notas: El procedimiento almacenado SP tiene 4 parámetros
-- 2 parámetros de salida y 2 parámetros de entrada
-- Los dos parámetros de entrada son los  datos del rango de edad
-- Los dos parámetros de salida representan la cantidad de pacientes y doctores

-- Pacientes
select pat.patient_name,
       pat.patient_lastname,
       dbo.get_age(pat.patient_date_of_birth)
from patients as pat
where dbo.get_age(pat.patient_date_of_birth) between 18 and 30;

select doc.doctor_name,
       doc.doctor_lastname,
       doc.doctor_age
from doctors as doc
where doc.doctor_age between 18 and 30;

CREATE OR ALTER PROCEDURE count_doctors_and_patients_by_age
  @age1 int, --18
  @age2 int, --30
  @count_doctors int output, --variable de salida 1
  @count_patients int output --variable de salida 2
  AS
  BEGIN
    select @count_patients = count(pat.patient_id)
    from patients as pat
    where dbo.get_age(pat.patient_date_of_birth) between @age1 and @age2;

    select @count_doctors = count(doc.staff_id)
    from doctors as doc
    where doc.doctor_age between @age1 and @age2;
  END;

declare @doctors int = 0;
declare @patients int = 0;
execute count_doctors_and_patients_by_age 18, 30, @doctors OUTPUT , @patients OUTPUT;
select @doctors as 'Doctors', @patients AS 'patients';

-- Crear un SP que permita insertar datos a la tabla BEDS.
-- Debe de crear dos procedimientos almacenados.
-- Un SP que permita insertar datos a la tabla beds.
-- Un SP que llame al SP que inserta datos.

-- Un SP que permita insertar datos a la tabla beds.

CREATE PROCEDURE sp_insert_to_beds
  @number int,
  @location varchar(20),
  @ward int
  AS
  BEGIN
    insert into beds(bed_number, bed_location, ward_number) VALUES
      (@number, @location, @ward);

    select bed.bed_number, bed.bed_location, bed.ward_number
    from beds as bed;
  END;

-- Un SP que llame al SP que inserta datos.
create procedure sp_call_insert
  @number int,
  @location varchar(20),
  @ward int
  AS
  BEGIN
    -- validaciones
    print 'Gestion actual: ' + cast(dbo.obtiene_current_year() AS varchar);
    execute sp_insert_to_beds @number=@number, @location=@location, @ward=@ward;
  END;

--   Verificando el correcto comportamiento
execute sp_call_insert 10, 'Cama 10', 1;
