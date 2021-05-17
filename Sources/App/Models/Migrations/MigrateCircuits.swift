//
//  File.swift
//  
//
//  Created by Lee Burrows on 16/05/2021.
//

import Foundation
import Fluent

struct MigrateCircuits: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("circuit")
            .id()
            .field("name", .string, .required)
            .field("countryCode", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("circuit").delete()
    }
}
