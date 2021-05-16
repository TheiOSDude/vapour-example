import Vapor
import Fluent
import FluentPostgresDriver

import GraphQLKit
import GraphiQLVapor
import Vapor

extension Application {
    static let databaseUrl = URL(string: "postgres://app_collection@localhost:5432/app_collection")!
}

// configures your application
public func configure(_ app: Application) throws {
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    try app.databases.use(.postgres(url: Application.databaseUrl), as: .psql)
    
    app.migrations.add(MigratePeople())
    try app.autoMigrate().wait()
    
    // Enable GraphiQL web page to send queries to the GraphQL endpoint.
//    if !app.environment.isRelease {
      app.enableGraphiQL()
    //}
    
    app.register(graphQLSchema: schema, withResolver: Resolver())
}
