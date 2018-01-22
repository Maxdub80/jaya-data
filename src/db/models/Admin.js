module.exports = (sequelize, DataTypes) =>
  sequelize.define('Admin', {
  }, {
    comment: 'Admin account',
    timestamps: false,
    freezeTableName: true
  });