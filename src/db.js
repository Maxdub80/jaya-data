const Sequelize = require('sequelize');
const dbURI = process.env['DATABASE_URI'];

module.exports = new Sequelize(dbURI);