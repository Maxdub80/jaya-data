module.exports = (sequelize, DataTypes) =>
  sequelize.define('SpecializationSubject', {
  }, {
    comment: 'Represent the specialization-subject association',
    timestamps: false,
    freezeTableName: true
  });