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

  Type(People.self) {
    Field("id", at: \.id)
    Field("firstName", at: \.firstName)
    Field("lastName", at: \.lastName)
    Field("petsNames", at: \.petsNames)
  }

  Query {
    Field("people", at: Resolver.getAllPeople)
  }
    Mutation {
      Field("createPeople", at: Resolver.createPerson) {
        Argument("firstName", at: \.firstName)
        Argument("lastName", at: \.lastName)
        Argument("petsNames", at: \.petsNames)
      }

      Field("deletePerson", at: Resolver.deletePerson) {
        Argument("id", at: \.id)
      }
    }

}
