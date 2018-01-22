module.exports = (sequelize, DataTypes) =>
  sequelize.define('Semester', {
    label: { type: DataTypes.STRING, allowNull: false },
    startAt: { type: DataTypes.DATEONLY, allowNull: false, field: 'start_at' },
    endAt: { type: DataTypes.DATEONLY, allowNull: false, field: 'end_at' }
  }, {
    comment: 'Represent the half of a school year',
    timestamps: false,
    freezeTableName: true,
  });