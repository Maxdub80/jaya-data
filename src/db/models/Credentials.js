module.exports = (sequelize, DataTypes) =>
  sequelize.define('Credentials', {
    email: { type: DataTypes.STRING, allowNull: false },
    password: { type: DataTypes.STRING , allowNull: false },
    salt: { type: DataTypes.TEXT, allowNull: false }
  }, {
    comment: 'User s credentials',
    timestamps: false,
    freezeTableName: true
  });