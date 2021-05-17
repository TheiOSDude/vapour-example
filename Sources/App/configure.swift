import Vapor
import Fluent
import FluentPostgresDriver
 import PostgresKit

import GraphQLKit
import GraphiQLVapor
import Vapor

extension Environment {
    
    static var databaseURL: URL {
        guard let urlString = Environment.get("DATABASE_URL"), let url = URL(string: urlString) else {
            fatalError("DATABASE_URL not configured")
        }
        return url
    }
    
    static var debugURL: URL {
        return URL(string: "postgres://leeburrows@localhost/carsOnTrack")!
    }
}

// configures your application
public func configure(_ app: Application) throws {
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    let url = app.environment.isRelease ? Environment.databaseURL : Environment.debugURL
    
    if app.environment.isRelease {
        if var postgresConfig = PostgresConfiguration(url: url) {
            postgresConfig.tlsConfiguration = .forClient(certificateVerification: .none)
            app.databases.use(.postgres(
                configuration: postgresConfig
            ), as: .psql)
        } else {
            exit(-1)
        }
    } else {
        try app.databases.use(.postgres(url: Environment.debugURL), as: .psql)
    }
 
    
    app.migrations.add(MigrateCircuits())
    try app.autoMigrate().wait()
    
    // Enable GraphiQL web page to send queries to the GraphQL endpoint.
//    if !app.environment.isRelease {
      app.enableGraphiQL()
    //}
    
    app.register(graphQLSchema: schema, withResolver: Resolver())
}
