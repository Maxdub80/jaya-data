-- CUSTOM TYPES
CREATE TYPE GroupType AS ENUM ('LECTURE', 'TUTORIAL');


-- SINGLE ENTITIES
CREATE TABLE IF NOT EXISTS SchoolYear (
    id SERIAL PRIMARY KEY,
    label VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Skill (
    id SERIAL PRIMARY KEY,
    label VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Semester (
    id SERIAL PRIMARY KEY,
    label VARCHAR(100) NOT NULL,
    start_at DATE NOT NULL,
    end_at DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Subject (
    id SERIAL PRIMARY KEY,
    label VARCHAR(255) NOT NULL,
    apogee_code VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Specialization (
    id SERIAL PRIMARY KEY,
    label VARCHAR(255) NOT NULL,
    acronym VARCHAR(10) NOT NULL,
    school_year_id INTEGER REFERENCES SchoolYear ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS StudentGroup (
    id SERIAL PRIMARY KEY,
    label VARCHAR(255) NOT NULL,
    type GroupType NOT NULL
);

-- ACCOUNT TABLES
CREATE TABLE IF NOT EXISTS Credentials (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Admin (
    id SERIAL PRIMARY KEY,
    credentials_id INTEGER REFERENCES Credentials
);

CREATE TABLE IF NOT EXISTS Student (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    student_number varchar(25) NOT NULL,
    credentials_id INTEGER REFERENCES Credentials ON DELETE CASCADE,
    specialization_id INTEGER REFERENCES Specialization ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Profesor (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    credentials_id INTEGER REFERENCES Credentials ON DELETE CASCADE
);

-- DEEPLY LINKED TABLES
CREATE TABLE IF NOT EXISTS StudentGroup (
    group_id INTEGER REFERENCES StudentGroup ON DELETE CASCADE,
    student_id INTEGER REFERENCES Student ON DELETE CASCADE,
    PRIMARY KEY(group_id, student_id)
);

CREATE TABLE IF NOT EXISTS SpecializationSubject (
    specialization_id INTEGER REFERENCES Specialization ON DELETE CASCADE,
    skill_id INTEGER REFERENCES Skill ON DELETE SET NULL,
    semester_id INTEGER REFERENCES Semester ON DELETE SET NULL,
    subject_id INTEGER REFERENCES Subject ON DELETE CASCADE,
    PRIMARY KEY(specialization_id, subject_id)
);

CREATE TABLE IF NOT EXISTS SpecializationSkill (
    specialization_id INTEGER REFERENCES Specialization ON DELETE CASCADE,
    skill_id INTEGER REFERENCES Skill ON DELETE CASCADE,
    min_nb_subject SMALLINT NOT NULL,
    PRIMARY KEY(skill_id, specialization_id)
);

CREATE TABLE IF NOT EXISTS ProfesorSubject(
    profesor_id INTEGER REFERENCES Profesor ON DELETE CASCADE,
    subject_id INTEGER REFERENCES Subject ON DELETE CASCADE,
    tutorial_hours_per_group SMALLINT NOT NULL,
    lecture_hours SMALLINT NOT NULL,
    PRIMARY KEY(profesor_id, subject_id)
);