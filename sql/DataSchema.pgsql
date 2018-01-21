-- CUSTOM TYPES
CREATE TYPE GroupType AS ENUM ('LECTURE', 'TUTORIAL');


-- SINGLE ENTITIES
CREATE TABLE IF NOT EXISTS SchoolYear (
    id SERIAL PRIMARY KEY,
    label VARCHAR(50) NOT NULL
);

COMMENT ON TABLE SchoolYear is 'A year of MIAGE Formation (M1 or M2)';
COMMENT ON COLUMN SchoolYear.id is 'The primary unique identifier for a school year';
COMMENT ON COLUMN SchoolYear.label is 'The name of the school year';

CREATE TABLE IF NOT EXISTS Skill (
    id SERIAL PRIMARY KEY,
    label VARCHAR(255) NOT NULL
);

COMMENT ON TABLE Skill is 'Given by one or many school subject. Students must have them all';
COMMENT ON COLUMN SchoolYear.id is 'The primary unique identifier for a skill';
COMMENT ON COLUMN SchoolYear.label is 'The name of the skill';

CREATE TABLE IF NOT EXISTS Semester (
    id SERIAL PRIMARY KEY,
    label VARCHAR(100) NOT NULL,
    start_at DATE NOT NULL,
    end_at DATE NOT NULL
);

COMMENT ON TABLE Semester is 'Represent the half of a school year';
COMMENT ON COLUMN Semester.id is 'The primary unique identifier for a semester';
COMMENT ON COLUMN Semester.label is 'The name of the semester';
COMMENT ON COLUMN Semester.start_at is 'When the semester starts';
COMMENT ON COLUMN Semester.end_at is 'When the semester ends';


CREATE TABLE IF NOT EXISTS Subject (
    id SERIAL PRIMARY KEY,
    label VARCHAR(255) NOT NULL,
    apogee_code VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL
);

COMMENT ON TABLE Subject is 'School subjects that MIAGE offers';
COMMENT ON COLUMN Subject.id is 'The primary unique identifier for a subject';
COMMENT ON COLUMN Subject.label is 'The name of the subject';
COMMENT ON COLUMN Subject.apogee_code is 'Apogee code for this subject';
COMMENT ON COLUMN Subject.description is 'What this subject is about';


CREATE TABLE IF NOT EXISTS Specialization (
    id SERIAL PRIMARY KEY,
    label VARCHAR(255) NOT NULL,
    acronym VARCHAR(10) NOT NULL,
    school_year_id INTEGER REFERENCES SchoolYear ON DELETE RESTRICT
);

COMMENT ON TABLE Specialization is 'The general purpose of a school year';
COMMENT ON COLUMN Specialization.id is 'The primary unique identifier for a specialization';
COMMENT ON COLUMN Specialization.label is 'The name of the specialization';
COMMENT ON COLUMN Specialization.acronym is 'The acronym of the specialiaztion (2COM, OSIE...)';
COMMENT ON COLUMN Specialization.school_year_id is 'School year related to this specialization';

CREATE TABLE IF NOT EXISTS StudentGroup (
    id SERIAL PRIMARY KEY,
    label VARCHAR(255) NOT NULL,
    type GroupType NOT NULL
);

COMMENT ON TABLE StudentGroup is 'Group of students';
COMMENT ON COLUMN StudentGroup.id is 'The primary unique identifier for a group';
COMMENT ON COLUMN StudentGroup.label is 'The name of the group';
COMMENT ON COLUMN StudentGroup.type is 'Group of lecture or tutorial';

-- ACCOUNT TABLES
CREATE TABLE IF NOT EXISTS Credentials (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    salt TEXT NOT NULL
);

COMMENT ON TABLE Credentials is 'User s credentials';
COMMENT ON COLUMN Credentials.id is 'The primary unique identifier for an user credentials';
COMMENT ON COLUMN Credentials.email is 'User login email';
COMMENT ON COLUMN Credentials.password is 'User login password';
COMMENT ON COLUMN Credentials.salt is 'Salf used for the password';

CREATE TABLE IF NOT EXISTS Admin (
    id SERIAL PRIMARY KEY,
    credentials_id INTEGER REFERENCES Credentials
);

COMMENT ON TABLE Admin is 'Admin account';
COMMENT ON COLUMN Admin.id is 'The primary unique identifier for an admin account';
COMMENT ON COLUMN Admin.credentials_id is 'Credentials linked to this account';

CREATE TABLE IF NOT EXISTS Student (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    student_number varchar(25) NOT NULL,
    credentials_id INTEGER REFERENCES Credentials ON DELETE CASCADE,
    specialization_id INTEGER REFERENCES Specialization ON DELETE SET NULL
);

COMMENT ON TABLE Student is 'Student account';
COMMENT ON COLUMN Student.id is 'The primary unique identifier for an student account';
COMMENT ON COLUMN Student.first_name is 'Student first name';
COMMENT ON COLUMN Student.last_name is 'Student last name';
COMMENT ON COLUMN Student.student_number is 'UPJV Student number';
COMMENT ON COLUMN Student.credentials_id is 'Credentials linked to this account';
COMMENT ON COLUMN Student.specialization_id is 'Student specialization this year';

CREATE TABLE IF NOT EXISTS Profesor (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    credentials_id INTEGER REFERENCES Credentials ON DELETE CASCADE
);

COMMENT ON TABLE Profesor is 'Profesor account';
COMMENT ON COLUMN Profesor.id is 'The primary unique identifier for an profesor account';
COMMENT ON COLUMN Profesor.first_name is 'Profesor first name';
COMMENT ON COLUMN Profesor.last_name is 'Profesor last name';
COMMENT ON COLUMN Profesor.credentials_id is 'Credentials linked to this account';

-- DEEPLY LINKED TABLES
CREATE TABLE IF NOT EXISTS StudentGroup (
    group_id INTEGER REFERENCES StudentGroup ON DELETE CASCADE,
    student_id INTEGER REFERENCES Student ON DELETE CASCADE,
    PRIMARY KEY(group_id, student_id)
);

COMMENT ON TABLE StudentGroup is 'Represent the student-group association';
COMMENT ON COLUMN StudentGroup.group_id is 'The group id';
COMMENT ON COLUMN StudentGroup.student_id is 'The student id';

CREATE TABLE IF NOT EXISTS SpecializationSubject (
    specialization_id INTEGER REFERENCES Specialization ON DELETE CASCADE,
    skill_id INTEGER REFERENCES Skill ON DELETE SET NULL,
    semester_id INTEGER REFERENCES Semester ON DELETE SET NULL,
    subject_id INTEGER REFERENCES Subject ON DELETE CASCADE,
    PRIMARY KEY(specialization_id, subject_id)
);

COMMENT ON TABLE SpecializationSubject is 'Represent the specialization-subject association';
COMMENT ON COLUMN SpecializationSubject.specialization_id is 'The specialization id';
COMMENT ON COLUMN SpecializationSubject.skill_id is 'The skill linked to this association';
COMMENT ON COLUMN SpecializationSubject.semester_id is 'The semester concerned';
COMMENT ON COLUMN SpecializationSubject.subject_id is 'The subject id';

CREATE TABLE IF NOT EXISTS SpecializationSkill (
    specialization_id INTEGER REFERENCES Specialization ON DELETE CASCADE,
    skill_id INTEGER REFERENCES Skill ON DELETE CASCADE,
    min_nb_subject SMALLINT NOT NULL,
    PRIMARY KEY(skill_id, specialization_id)
);

COMMENT ON TABLE SpecializationSubject is 'Represent the specialization-subject association';
COMMENT ON COLUMN SpecializationSubject.specialization_id is 'The specialization id';
COMMENT ON COLUMN SpecializationSubject.skill_id is 'The skill linked to this association';
COMMENT ON COLUMN SpecializationSubject.semester_id is 'The semester concerned';
COMMENT ON COLUMN SpecializationSubject.subject_id is 'The subject id';

CREATE TABLE IF NOT EXISTS ProfesorSubject(
    profesor_id INTEGER REFERENCES Profesor ON DELETE CASCADE,
    subject_id INTEGER REFERENCES Subject ON DELETE CASCADE,
    tutorial_hours_per_group SMALLINT NOT NULL,
    lecture_hours SMALLINT NOT NULL,
    PRIMARY KEY(profesor_id, subject_id)
);

COMMENT ON TABLE ProfesorSubject is 'Represent the profesor-subject association';
COMMENT ON COLUMN ProfesorSubject.profesor_id is 'The profesor id';
COMMENT ON COLUMN ProfesorSubject.subject_id is 'The subject id';
COMMENT ON COLUMN ProfesorSubject.tutorial_hours_per_group is 'The number of tutorial hours / groupe for this profesor';
COMMENT ON COLUMN ProfesorSubject.lecture_hours is 'The number of lecture hours for this profesor';