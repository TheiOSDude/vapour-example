//
//  File.swift
//  
//
//  Created by Lee Burrows on 17/05/2021.
//

import Fluent
import Vapor

final class Layout: Model, Content {
    static let schema = "layout"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "length")
    var length: Double
    
    @Parent(key: "circuit_id")
    var circuit: Circuit
    
    init() { }
    
    init(id: UUID? = nil, circuitID: UUID, name: String, length: Double) {
        self.id = id
        self.$circuit.id = circuitID
        self.name = name
        self.length = length
    }
}

