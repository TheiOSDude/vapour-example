import Fluent
import FluentSQLiteDriver
import GraphQLKit
import GraphiQLVapor
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    app.databases.use(.sqlite(.memory), as: .sqlite)
    
    app.http.server.configuration.port = 8081
    app.migrations.add(MigratePeople())
    try app.autoMigrate().wait()
    
    // Enable GraphiQL web page to send queries to the GraphQL endpoint.
    if !app.environment.isRelease {
      app.enableGraphiQL()
    }
    
    app.register(graphQLSchema: schema, withResolver: Resolver())
}
