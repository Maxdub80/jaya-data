module.exports = (sequelize, DataTypes) =>
  sequelize.define('SubjectGroup', {
    label: { type: DataTypes.STRING, allowNull: false },
    type: { type: DataTypes.ENUM, values: ['LECTURE', 'TUTORIAL'] }
  }, {
    comment: 'Group about a subject',
    timestamps: false,
    freezeTableName: true
  });