module.exports = (sequelize, DataTypes) =>
  sequelize.define('Student', {
    firstName: { type: DataTypes.STRING, allowNull: false, field: 'first_name' },
    lastName: { type: DataTypes.STRING, allowNull: false, field: 'last_name' },
    studentNumber: { type: DataTypes.STRING(30), allowNull: false, field: 'student_number' },
  }, {
    comment: 'Student account',
    timestamps: false,
    freezeTableName: true
  });