//
//  File.swift
//  
//
//  Created by Lee Burrows on 16/05/2021.
//

import Graphiti
import Vapor

final class Resolver {
    func getAllCircuits(
        request: Request,
        arguments: NoArguments
    ) throws -> EventLoopFuture<[Circuit]> {
        Circuit.query(on: request.db).all()
    }
    
    struct CreateCircuitArguments: Codable {
        let name: String
        let countryCode: String
    }
    
    func createCircuit(
        request: Request,
        arguments: CreateCircuitArguments
    ) throws -> EventLoopFuture<Circuit> {
        let circuit = Circuit(
            name: arguments.name,
            countryCode: arguments.countryCode
        )
        return circuit.create(on: request.db).map { circuit }
    }
    
    struct DeleteCircuitArguments: Codable {
        let id: UUID
    }
    
    func deleteCircuit(
        request: Request,
        arguments: DeleteCircuitArguments
    ) -> EventLoopFuture<Bool> {
        Circuit.find(arguments.id, on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: true)
    }
}
