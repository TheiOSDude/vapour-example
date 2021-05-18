//
//  File.swift
//  
//
//  Created by Lee Burrows on 17/05/2021.
//

import Foundation
import Foundation
import Fluent

struct MigrateLayouts: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("layout")
            .id()
            .field("name", .string, .required)
            .field("length", .double, .required)
            .field("circuit_id", .uuid, .required, .references("circuit", "id"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("layout").delete()
    }
}
