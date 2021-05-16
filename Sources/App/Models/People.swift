//
//  File.swift
//  
//
//  Created by Lee Burrows on 16/05/2021.
//

import Fluent
import Vapor

final class People: Model, Content {
    static let schema = "people"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "firstName")
    var firstName: String
    
    @Field(key: "lastName")
    var lastName: String
    
    @Field(key: "petsNames") 
    var petsNames: [String]
    
    init() { }
    
    
    init(id: UUID? = nil, firstName: String, lastName: String, petsNames: [String]) {
        self.id = id
        
        self.firstName = firstName
        self.lastName = lastName
        self.petsNames = petsNames
    }
    
}

