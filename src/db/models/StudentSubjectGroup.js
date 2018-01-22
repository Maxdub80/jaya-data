module.exports = (sequelize, DataTypes) =>
  sequelize.define('StudentSubjectGroup', {
  }, {
    comment: 'Represent the student-group association',
    timestamps: false,
    freezeTableName: true
  });