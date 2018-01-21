const express = require('express');
const bodyParser = require('body-parser');
const apolloServer = require('apollo-server-express');
const graphqlTools = require('graphql-tools');

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

app.listen(3000, () => {
    console.log('Go to http://localhost:3000/graphiql to run queries!');
})