module.exports = (sequelize, DataTypes) =>
  sequelize.define('SchoolYear', {
    label: { type: DataTypes.STRING, allowNull: false }
  }, {
    comment: 'A year of MIAGE Formation (M1 or M2)',
    timestamps: false,
    freezeTableName: true
  });