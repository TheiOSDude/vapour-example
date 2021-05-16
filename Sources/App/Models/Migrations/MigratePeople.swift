//
//  File.swift
//  
//
//  Created by Lee Burrows on 16/05/2021.
//

import Foundation
import Fluent

struct MigratePeople: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("people")
            .id()
            .field("firstName", .string, .required)
            .field("lastName", .string, .required)
            .field("petsNames", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("reviews").delete()
    }
}
