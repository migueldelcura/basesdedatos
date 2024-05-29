DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
GO

USE hospital;
GO

DROP TABLE IF EXISTS [dbo].doctors;
GO
CREATE TABLE [dbo].doctors
(
  staff_id             INTEGER IDENTITY PRIMARY KEY NOT NULL,
  doctor_name          VARCHAR(25)                  NOT NULL,
  doctor_lastname      VARCHAR(25)                  NOT NULL,
  doctor_date_of_birth DATE                         NOT NULL,
  doctor_age           INTEGER
);
GO

DROP TABLE IF EXISTS [dbo].patients;
GO
CREATE TABLE [dbo].patients
(
  patient_id            INTEGER PRIMARY KEY IDENTITY NOT NULL,
  patient_gender        CHAR(1)                      NOT NULL,
  patient_date_of_birth DATE                         NOT NULL,
  patient_name          VARCHAR(25)                  NOT NULL,
  patient_lastname      VARCHAR(25)                  NOT NULL,
  patient_height        INTEGER                      NOT NULL,
  patient_weight        INTEGER                      NOT NULL,
  patient_cellphone     VARCHAR(15)                  NOT NULL
);
GO

DROP TABLE IF EXISTS [dbo].doctors_assigned_to_patients;
GO
CREATE TABLE [dbo].doctors_assigned_to_patients
(
  da_to_patients_id INTEGER IDENTITY PRIMARY KEY NOT NULL,
  patient_id        INTEGER                      NOT NULL,
  staff_id          INTEGER                      NOT NULL,
  date_from         DATE                         NOT NULL,
  date_to           DATE                         NOT NULL,
  FOREIGN KEY (staff_id) REFERENCES doctors (staff_id),
  FOREIGN KEY (patient_id) REFERENCES patients (patient_id)
);
GO

DROP TABLE IF EXISTS [dbo].patient_records;
GO
CREATE TABLE [dbo].patient_records
(
  patient_record_id  INTEGER IDENTITY NOT NULL,
  billable_item_code VARCHAR(10)      NOT NULL,
  component_code     VARCHAR(10)      NOT NULL,
  update_by_staff_id VARCHAR(10)      NOT NULL,
  updated_date       DATE             NOT NULL,
  admission_datetime DATETIME         NOT NULL,
  medical_condition  VARCHAR(20)      NOT NULL,
  patient_id         INTEGER          NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients (patient_id)
);
GO

DROP TABLE IF EXISTS [dbo].diagnoses;
GO
CREATE TABLE [dbo].diagnoses
(
  diagnosis_id           INTEGER IDENTITY PRIMARY KEY NOT NULL,
  patient_id             INTEGER          NOT NULL,
  diagnosis_by_doctor_id INTEGER          NOT NULL,
  diagnosis_details VARCHAR(200)          NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
  FOREIGN KEY (diagnosis_by_doctor_id) REFERENCES doctors (staff_id)
);
GO

DROP TABLE IF EXISTS [dbo].ref_drug_categories;
GO
CREATE TABLE [dbo].ref_drug_categories
(
  drug_category_code        INTEGER IDENTITY PRIMARY KEY NOT NULL,
  drug_category_description VARCHAR(200)          NOT NULL
);
GO

DROP TABLE IF EXISTS [dbo].drugs;
GO
CREATE TABLE [dbo].drugs
(
  drug_id            INTEGER IDENTITY PRIMARY KEY NOT NULL,
  drug_name          VARCHAR(20)                  NOT NULL,
  drug_description   VARCHAR(20)                  NOT NULL,
  drug_cost          INTEGER                      NOT NULL,
  drug_cost_unit     VARCHAR(2)                   NOT NULL,
  other_details      VARCHAR(50)                  NOT NULL,
  drug_category_code INTEGER                      NOT NULL,
  FOREIGN KEY (drug_category_code) REFERENCES ref_drug_categories (drug_category_code)
);
GO

DROP TABLE IF EXISTS [dbo].patient_drugs_treatments;
GO
CREATE TABLE [dbo].patient_drugs_treatments
(
  pd_treatments INTEGER IDENTITY PRIMARY KEY NOT NULL,
  date_administered DATE NOT NULL,
  comments          VARCHAR(100)     NOT NULL,
  patient_id        INTEGER          NOT NULL,
  diagnosis_id      INTEGER          NOT NULL,
  drug_id           INTEGER          NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
  FOREIGN KEY (drug_id) REFERENCES drugs (drug_id),
  FOREIGN KEY (diagnosis_id) REFERENCES diagnoses (diagnosis_id)
);
GO

DROP TABLE IF EXISTS [dbo].wards;
GO
CREATE TABLE [dbo].wards
(
  ward_number      INTEGER IDENTITY PRIMARY KEY NOT NULL,
  ward_name        VARCHAR(20)                  NOT NULL,
  ward_location    VARCHAR(20)                  NOT NULL,
  ward_description VARCHAR(100)                 NOT NULL
);
GO

DROP TABLE IF EXISTS [dbo].beds;
GO
CREATE TABLE [dbo].beds
(
  bed_id       INTEGER IDENTITY PRIMARY KEY NOT NULL,
  bed_number   INTEGER                      NOT NULL,
  bed_location VARCHAR(20)                  NOT NULL,
  ward_number  INTEGER                      NOT NULL,
  FOREIGN KEY (ward_number) REFERENCES wards (ward_number)
);
GO

DROP TABLE IF EXISTS [dbo].patients_in_beds;
GO
CREATE TABLE [dbo].patients_in_beds
(
  pb_id INTEGER IDENTITY PRIMARY KEY NOT NULL,
  date_from  DATE NOT NULL,
  bed_id     INTEGER          NOT NULL,
  patient_id INTEGER          NOT NULL,
  date_to    DATE             NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
  FOREIGN KEY (bed_id) REFERENCES beds (bed_id)
);
GO

INSERT INTO [dbo].doctors (doctor_name, doctor_lastname, doctor_date_of_birth, doctor_age) VALUES
    ('Joel', 'Smith', '1988-12-10', 33),
    ('Saul', 'Fuentes', '1995-12-10', 25),
    ('Ana', 'Marga', '1975-12-10', 38);
GO

INSERT INTO [dbo].patients (patient_gender, patient_date_of_birth, patient_name, patient_lastname, patient_height, patient_weight, patient_cellphone) VALUES
  ('m', '1988-12-10', 'Carlos', 'Almada', 170, 63, '+591 76567575'),
  ('f', '1991-11-10', 'Ana', 'Soliz', 159, 55, '+51 45128526'),
  ('m', '2000-06-10', 'Carlos', 'Almada', 180, 75, '+52 765675754');
GO