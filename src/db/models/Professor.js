module.exports = (sequelize, DataTypes) =>
  sequelize.define('Professor', {
    firstName: { type: DataTypes.STRING, allowNull: false, field: 'first_name' },
    lastName: { type: DataTypes.STRING, allowNull: false, field: 'last_name' },
  }, {
    comment: 'Professor account',
    timestamps: false,
    freezeTableName: true
  });