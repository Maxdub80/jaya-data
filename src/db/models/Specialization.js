module.exports = (sequelize, DataTypes) =>
  sequelize.define('Specialization', {
    label: { type: DataTypes.STRING, allowNull: false },
    acronym: { type: DataTypes.STRING(15), allowNull: false },
  }, {
    comment: 'The general purpose of a school year',
    timestamps: false,
    freezeTableName: true
  });