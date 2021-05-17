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

  Type(Circuit.self) {
    Field("id", at: \.id)
    Field("name", at: \.name)
    Field("countryCode", at: \.countryCode)
  }

  Query {
    Field("circuit", at: Resolver.getAllCircuits)
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
