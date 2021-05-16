//
//  File.swift
//  
//
//  Created by Lee Burrows on 16/05/2021.
//

import Graphiti
import Vapor

final class Resolver {
    func getAllPeople(
        request: Request,
        arguments: NoArguments
    ) throws -> EventLoopFuture<[People]> {
        People.query(on: request.db).all()
    }
    
    struct CreatePersonArguments: Codable {
        let firstName: String
        let lastName: String
        let petsNames: [String]
    }
    
    func createPerson(
        request: Request,
        arguments: CreatePersonArguments
    ) throws -> EventLoopFuture<People> {
        let person = People(
            firstName: arguments.firstName,
            lastName: arguments.lastName,
            petsNames: arguments.petsNames
        )
        return person.create(on: request.db).map { person }
    }
    
    struct DeletePersonArguments: Codable {
        let id: UUID
    }
    
    func deletePerson(
        request: Request,
        arguments: DeletePersonArguments
    ) -> EventLoopFuture<Bool> {
        People.find(arguments.id, on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: true)
    }
}
