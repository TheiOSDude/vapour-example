//
//  File.swift
//  
//
//  Created by Lee Burrows on 16/05/2021.
//

import Graphiti
import Vapor

struct PaginationArguments: Codable {
    let limit: Int
    let offset: Int
}

final class Resolver {
    
    func getAllCircuits(
        request: Request,
        arguments: PaginationArguments
    ) throws -> EventLoopFuture<[Circuit]> {
        Circuit.query(on: request.db)
            .limit(arguments.limit)
            .offset(arguments.offset)
            .all()
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
    
    func getAllLayouts(
        request: Request,
        arguments: PaginationArguments
    ) throws -> EventLoopFuture<[Layout]> {
        Layout.query(on: request.db)
            .limit(arguments.limit)
            .offset(arguments.offset)
            .all()
    }
    
    struct CreateLayoutArguments: Codable {
        let circuitID: UUID
        let name: String
        let length: Double
    }
    
    func createLayout(
        request: Request,
        arguments: CreateLayoutArguments
    ) throws -> EventLoopFuture<Layout> {
        let layout = Layout(
            circuitID: arguments.circuitID, name: arguments.name, length: arguments.length)
        return layout.create(on: request.db).map { layout }
    }
}
