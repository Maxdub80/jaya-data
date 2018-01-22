module.exports = (sequelize, DataTypes) =>
  sequelize.define('Subject', {
    label: { type: DataTypes.STRING, allowNull: false },
    apogeeCode: { type: DataTypes.STRING, allowNull: false, field: 'apogee_code' },
    description: { type: DataTypes.TEXT, allowNull: false }
  }, {
    comment: 'School subjects that MIAGE offers',
    timestamps: false,
    freezeTableName: true
  });