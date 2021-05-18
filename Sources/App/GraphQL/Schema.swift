//
//  File.swift
//  
//
//  Created by Lee Burrows on 16/05/2021.
//

import Graphiti
import Vapor

let schema = try! Schema<Resolver, Request> {
    Scalar(UUID.self)
    
    Type(Layout.self) {
        Field("id", at: \.id)
        Field("length", at: \.length)
        Field("name", at: \.name)
    }
    
    Type(Circuit.self) {
        Field("id", at: \.id)
        Field("name", at: \.name)
        Field("countryCode", at: \.countryCode)
        
        Field("layouts", at: Circuit.getLayouts) {
          Argument("limit", at: \.limit)
          Argument("offset", at: \.offset)
        }
    }
    
    Query {
        Field("circuit", at: Resolver.getAllCircuits) {
            Argument("limit", at: \.limit)
            Argument("offset", at: \.offset)
        }
        
        Field("layout", at: Resolver.getAllLayouts) {
          Argument("limit", at: \.limit)
          Argument("offset", at: \.offset)
        }

    }
    Mutation {
        Field("createCircuit", at: Resolver.createCircuit) {
            Argument("name", at: \.name)
            Argument("countryCode", at: \.countryCode)
        }
        
        Field("deleteCircuit", at: Resolver.deleteCircuit) {
            Argument("id", at: \.id)
        }
    }

}
