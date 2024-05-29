-- manejo de cursores
USE PROJECT_HOSPITAL;
GO

-- Crear un reporte de la tabla doctors(name, lastname and age).

select doc.doctor_name,
       doc.doctor_lastname,
       doc.doctor_age
from doctors AS doc;

DECLARE cur_doctors CURSOR
  FOR select doc.doctor_name,
       doc.doctor_lastname,
       doc.doctor_age
      from doctors AS doc               -- Declarar el cursor
  OPEN cur_doctors                      -- Abrir cursor
    FETCH NEXT FROM cur_doctors         -- Accediendo a la informacion
  CLOSE cur_doctors                     -- Cerrar cursor
  DEALLOCATE cur_doctors;               -- Eliminar cursor

-- Agregar un campo a la tabla doctors de nombre password.
-- El campo password debe generarse de la concatenación de los dos primeros caracteres del nombre y lastname.
-- Ejm:
-- name: William,
-- lastname: Barra,
-- resultado: wiba

-- Solucion 1
-- Modificando la tabla doctors
alter table doctors add password2 varchar(10);

-- Como modificamos una tabla?

-- update doctors set password = 'wiba' where staff_id = 1;

-- Como obtenemos los dos primeros caracteres de un texo
select lower(substring('William', 1, 2));

select * from doctors;

-- empezando a resolver con cursores
DECLARE
  @id int,
  @name varchar(25),
  @lastname varchar(25);

DECLARE cur_doctors CURSOR
  FOR select doc.staff_id,
             doc.doctor_name,
             doc.doctor_lastname
      from doctors AS doc
  OPEN cur_doctors
    FETCH cur_doctors INTO @id, @name, @lastname
    WHILE @@FETCH_STATUS = 0
      BEGIN
        declare @name_text varchar(2), @lastname_text varchar(2);

        set @name_text = lower(substring(@name, 1, 2));
        set @lastname_text = lower(substring(@lastname, 1, 2));

        update doctors
          set password = concat(@name_text, @lastname_text)
          where staff_id = @id;

        FETCH cur_doctors INTO @id, @name, @lastname
      END
  CLOSE cur_doctors
  DEALLOCATE cur_doctors;

-- solucion 2 (refactoring)
-- Agregar un campo a la tabla doctors de nombre password2.
-- El campo password debe generarse de la concatenación de los dos primeros caracteres del nombre y lastname.
-- Ejm:
-- name: William,
-- lastname: Barra,
-- resultado: wiba

-- Creando el SP
-- paso 1
CREATE PROCEDURE sp_cursor_for_doctors
  @cursor_doctors CURSOR VARYING OUTPUT
  AS
  BEGIN
      set @cursor_doctors = cursor
      for
        select doc.staff_id,
               doc.doctor_name,
               doc.doctor_lastname
        from doctors AS doc;

      open @cursor_doctors;
  END;

--   paso 2
DECLARE
  @id int,
  @name varchar(25),
  @lastname varchar(25);

DECLARE @cur_doctors CURSOR;
EXECUTE sp_cursor_for_doctors @cursor_doctors = @cur_doctors OUTPUT;
FETCH @cur_doctors INTO @id, @name, @lastname
  WHILE @@FETCH_STATUS = 0
    BEGIN

      update doctors
      set password2 = lower(concat(
          'abc-',
          substring(@name, 1, 2),
          substring(@lastname, 1, 2)
        ))
      where staff_id = @id;

      FETCH @cur_doctors INTO @id, @name, @lastname;
    END;
  CLOSE @cur_doctors;
  DEALLOCATE @cur_doctors;


--   Cursores staticos
DECLARE
  @id int,
  @name varchar(25),
  @lastname varchar(25);

DECLARE static_cursor_for_doctors CURSOR STATIC
  FOR
    select doc.staff_id,
           doc.doctor_name,
           doc.doctor_lastname
    from doctors AS doc
  OPEN static_cursor_for_doctors
  BEGIN
    FETCH NEXT FROM static_cursor_for_doctors INTO @id, @name, @lastname
    WHILE @@FETCH_STATUS = 0
      BEGIN

        PRINT '-> Name : ' + @name + ', Lastname : ' + @lastname
        FETCH NEXT FROM static_cursor_for_doctors INTO @id, @name, @lastname

      END
  END
  CLOSE static_cursor_for_doctors
  DEALLOCATE static_cursor_for_doctors

-- Cursores dinamicos
DECLARE
  @id int,
  @name varchar(25),
  @lastname varchar(25);

DECLARE
  dynamic_cursor_for_doctors CURSOR DYNAMIC
    FOR
      select doc.staff_id,
             doc.doctor_name,
             doc.doctor_lastname
      from doctors AS doc
  OPEN dynamic_cursor_for_doctors
    BEGIN
      FETCH NEXT FROM dynamic_cursor_for_doctors INTO @id, @name, @lastname
      WHILE @@Fetch_status = 0
        BEGIN
          update doctors
          set password2 = lower(concat(
              'dy-',
              substring(@name, 1, 2),
              substring(@lastname, 1, 2)
            ))
          where staff_id = @id;

          FETCH NEXT FROM dynamic_cursor_for_doctors INTO @id, @name, @lastname
        END
    END
  CLOSE dynamic_cursor_for_doctors
  DEALLOCATE dynamic_cursor_for_doctors

-- Cursores Forward Only
DECLARE
  @id int,
  @name varchar(25),
  @lastname varchar(25);
  
DECLARE
  forward_cursor_for_doctors CURSOR FORWARD_ONLY
    FOR
     select doc.staff_id,
           doc.doctor_name,
           doc.doctor_lastname
      from doctors AS doc
  OPEN forward_cursor_for_doctors
    BEGIN
      FETCH NEXT FROM forward_cursor_for_doctors INTO @id, @name, @lastname
      WHILE @@FETCH_STATUS = 0
        BEGIN
          update doctors
          set password2 = lower(concat(
              'fw-',
              substring(@name, 1, 2),
              substring(@lastname, 1, 2)
            ))
          where staff_id = @id;

          FETCH NEXT FROM forward_cursor_for_doctors INTO @id, @name, @lastname
        END
    END
  CLOSE forward_cursor_for_doctors
  DEALLOCATE forward_cursor_for_doctors;

  select * from doctors;
