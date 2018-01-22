module.exports = (sequelize, DataTypes) =>
  sequelize.define('SpecializationSkill', {
    minNbSubject: { type: DataTypes.INTEGER, allowNull: false, field: 'min_nb_subject' }
  }, {
    comment: 'Represent the specialization-skill association',
    timestamps: false,
    freezeTableName: true
  });