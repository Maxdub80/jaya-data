const Sequelize = require('../db');

console.log('=> Trying to sync the database with new models');
console.log('==============================================');
console.log('');

// Test the DB authentication
Sequelize.authenticate()
  .then(() => {
    // Import all the models
    const SchoolYear = Sequelize.import(`${__dirname}/../db/models/SchoolYear`);
    const Skill = Sequelize.import(`${__dirname}/../db/models/Skill`);
    const Semester = Sequelize.import(`${__dirname}/../db/models/Semester`);
    const Subject = Sequelize.import(`${__dirname}/../db/models/Subject`);
    const Specialization = Sequelize.import(`${__dirname}/../db/models/Specialization`);
    const SubjectGroup = Sequelize.import(`${__dirname}/../db/models/SubjectGroup`);
    const Credentials = Sequelize.import(`${__dirname}/../db/models/Credentials`);
    const Admin = Sequelize.import(`${__dirname}/../db/models/Admin`);
    const Student = Sequelize.import(`${__dirname}/../db/models/Student`);
    const Professor = Sequelize.import(`${__dirname}/../db/models/Professor`);
    const StudentSubjectGroup = Sequelize.import(`${__dirname}/../db/models/StudentSubjectGroup`);
    const SpecializationSubject = Sequelize.import(`${__dirname}/../db/models/SpecializationSubject`);
    const SpecializationSkill = Sequelize.import(`${__dirname}/../db/models/SpecializationSkill`);
    const ProfessorSubject = Sequelize.import(`${__dirname}/../db/models/ProfessorSubject`);

    // Associations
    Specialization.belongsTo(SchoolYear, { as: 'SchoolYear', foreignKey: 'school_year_id', onDelete: 'RESTRICT' });
    SubjectGroup.belongsTo(Subject, { as: 'Subject', foreignKey: 'subject_id', onDelete: 'CASCADE' });
    Admin.belongsTo(Credentials, { as: 'Credentials', foreignKey: 'credentials_id', onDelete: 'CASCADE' });
    Student.belongsTo(Credentials, { as: 'Credentials', foreignKey: 'credentials_id', onDelete: 'CASCADE' });
    Student.belongsTo(Specialization, { as: 'Specialization', foreignKey: 'specialization_id', onDelete: 'SET NULL' });
    Professor.belongsTo(Credentials, { as: 'Credentials', foreignKey: 'credentials_id', onDelete: 'CASCADE' });
    
    Student.belongsToMany(SubjectGroup, {
      as: 'Groups',
      through: StudentSubjectGroup,
      foreignKey: 'student_id',
      timestamps: false,
      onDelete: 'CASCADE'
    });
    SubjectGroup.belongsToMany(Student, { 
      as: 'Students', 
      through: StudentSubjectGroup, 
      foreignKey: 'group_id', 
      timestamps: false,
      onDelete: 'CASCADE'
    });

    Subject.belongsToMany(Specialization, {
      as: 'Specialization',
      through: SpecializationSubject,
      foreignKey: 'subject_id',
      timestamps: false,
      onDelete: 'CASCADE'
    });
    Specialization.belongsToMany(Subject, {
      as: 'Subject',
      through: SpecializationSubject,
      foreignKey: 'specialization_id',
      timestamps: false,
      onDelete: 'CASCADE'
    });
    SpecializationSubject.belongsTo(Semester, { as: 'Semester', foreignKey: 'semester_id', onDelete: 'SET NULL' });
    SpecializationSubject.belongsTo(Skill, { as: 'Skill', foreignKey: 'skill_id', onDelete: 'SET NULL' });

    Specialization.belongsToMany(Skill, { 
      as: 'Skill',
      through: SpecializationSkill,
      foreignKey: 'specialization_id',
      timestamps: false,
      onDelete: 'CASCADE'
    });
    Skill.belongsToMany(Specialization, { 
      as: 'Specialization',
      through: SpecializationSkill,
      foreignKey: 'skill_id',
      timestamps: false,
      onDelete: 'CASCADE'
    });

    Professor.belongsToMany(Subject, {
      as: 'Subject',
      through: ProfessorSubject,
      foreignKey: 'professor_id',
      timestamps: false,
      onDelete: 'CASCADE'
    });

    Subject.belongsToMany(Professor, {
      as: 'Professor',
      through: ProfessorSubject,
      foreignKey: 'subject_id',
      timestamps: false,
      onDelete: 'CASCADE'
    });

    return Sequelize.sync();
  })
  .then(() => {
    console.log('=> Sync done.');
    process.exit(0);
  })
  .catch((e) => {
    // If authentication rejected
    console.error('/!\\ Cannot perform sync operation :(...')
    console.error(e.message);
    process.exit(1);
  })