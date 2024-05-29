USE PROJECT_HOSPITAL;
GO

-- Crear un trigger  que permita mostrar un
-- mensaje cada vez que se inserte un registro en la tabla BEDS

INSERT INTO beds(bed_number, bed_location, ward_number) VALUES
  (6, 'Cama 6', 1);

-- Creando el trigger
DROP TRIGGER tr_show_messages;
CREATE OR ALTER TRIGGER tr_show_messages
  ON beds
  AFTER INSERT AS
  BEGIN

    DECLARE
      @number int,
      @location varchar(20);

    SELECT @number = ins.bed_number,
           @location = ins.bed_location
    FROM inserted AS ins;

    PRINT 'Data insertado en table:BEDS ' +
          'nro: ' + cast(@number AS varchar) + ' ' +
          'location: ' + @location;

  END;

-- Crear un trigger que valide la edad en base a la fecha de nacimiento.
  -- Si la edad es incorrecta generar un excepción
  -- Caso contrario insertar a la tabla doctors

-- trigger: TRIGGER
-- tabla: DOCTORS
-- tiempo(antes): INSTEAD OF
-- funcion a utilizar: validate_correct_age(fecha_nac, age)

INSERT INTO doctors(doctor_name, doctor_lastname, doctor_date_of_birth, doctor_age) VALUES
  ('William1', 'Barra', '1988-12-10', 33);

CREATE TRIGGER tr_validate_correct_age
  ON doctors
  INSTEAD OF INSERT AS
  BEGIN
    declare
      @validate_age bit,
      @birth date,
      @age int;

    select @birth = ins.doctor_date_of_birth,
           @age = ins.doctor_age
    from inserted as ins;

    set @validate_age = [dbo].validate_correct_age(@birth, @age);

    if @validate_age = 0
      begin
        raiserror(15600, -1, -1, 'La edad a insertarse es incorecta');
      end
    else
      begin
        INSERT INTO doctors(
              doctor_name,
              doctor_lastname,
              doctor_date_of_birth,
              doctor_age
          )
          select ins.doctor_name,
                 ins.doctor_lastname,
                 ins.doctor_date_of_birth,
                 ins.doctor_age
          from inserted as ins;
      end;

  END;

select getdate();
select system_user;

-- Triggers de auditoria
-- Crear un trigger de auditoria para la tabla BEDS

-- Crear la tabla de auditoria: audit_beds
create table audit_beds
(
  date_action date,
  system_user_action varchar(30),
  action varchar(20),
  bed_number int,
  bed_location varchar(20)
);
-- Crean el trigger de auditoria

CREATE TRIGGER tr_audit_beds
  ON beds
  FOR DELETE, UPDATE AS
  BEGIN
    declare
      @action varchar(15) = 'delete',
      @number int,
      @location varchar(20);

    select @number = del.bed_number,
           @location = del.bed_location
    from deleted as del;

    insert into audit_beds(
       date_action,
       system_user_action,
       action,
       bed_number,
       bed_location
       ) VALUES (getdate(), system_user, @action, @number, @location);

  END;
GO

-- Crear un trigger que no permita adiciones y/o modificaciones
-- de la tabla BEDS en fines de semana.

SELECT datename(weekday, current_timestamp);

CREATE OR ALTER TRIGGER tr_no_inserts_updates_beds
  ON beds
  FOR INSERT, UPDATE AS
  BEGIN
    declare @day varchar(12) = datename(weekday, current_timestamp);

    if @day in ('Saturday', 'Sunday')
    begin
      raiserror('No se permiten inserciones/modificaciones en fines de semana', 16, 1);
    end

  END;