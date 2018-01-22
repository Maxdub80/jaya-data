module.exports = (sequelize, DataTypes) =>
  sequelize.define('Skill', {
    label: { type: DataTypes.STRING, allowNull: false }
  }, {
    comment: 'Represent a set of capabilities given by one or many school subject. Students must have them all',
    timestamps: false,
    freezeTableName: true
  });