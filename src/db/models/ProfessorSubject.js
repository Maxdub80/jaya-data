module.exports = (sequelize, DataTypes) =>
  sequelize.define('ProfessorSubject', {
    tutorialHoursPerGroup: { type: DataTypes.INTEGER, allowNull: false, field: 'tutorial_hours_per_group' },
    lectureHours: { type: DataTypes.INTEGER, allowNull: false, field: 'lecture_hours' },
  }, {
    comment: 'Represent the professor-subject association',
    timestamps: false,
    freezeTableName: true
  });