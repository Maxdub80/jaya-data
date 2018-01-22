const express = require('express');
const bodyParser = require('body-parser');
const apolloServer = require('apollo-server-express');
const graphqlTools = require('graphql-tools');
const database = require('./db');
const sequelize = require('sequelize');
const logger = require('morgan');


// const resolvers = require('./graphql/resolvers');
// const typeDefs = require('./graphql/typeDefs');


// Build the GQL Schema
// const schema = makeExecutableSchema({
//     typeDefs,
//     resolvers,
// });

// Initialize the app
const app = express();
//app.use('/graphql', bodyParser.json(), apolloServer.graphqlExpress({ schema }));
app.use('/graphiql', apolloServer.graphiqlExpress({ endpointURL: '/graphql' }));
app.use(logger('tiny'));


// Test DB Connection
console.log(`/!\\ Trying to connect to the DB -> ${process.env['DATABASE_URI']}...`);

database.authenticate()
  .then(() => {
    console.log('=> DB Connected !');
    console.log(`/!\\ Trying to launch the app`);
    // Launch App
    app.listen(3000, () => {
      console.log('=> Go to http://localhost:3000/graphiql to run queries !');
    });
  })
  .catch((e) => {
    console.log('Error: DB Not connected.');
    console.error(e);
  });

