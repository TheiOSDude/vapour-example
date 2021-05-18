//
//  File.swift
//
//
//  Created by Lee Burrows on 16/05/2021.
//

import Fluent
import Vapor

final class Circuit: Model, Content {
    static let schema = "circuit"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "countryCode")
    var countryCode: String
    
    @Children(for: \.$circuit)
    var layouts: [Layout]
    
    init() { }
    
    init(id: UUID? = nil, name: String, countryCode: String) {
        self.id = id
        self.name = name
        self.countryCode = countryCode
    }
}

extension Circuit {
  func getLayouts(
    request: Request,
    arguments: PaginationArguments
  ) throws -> EventLoopFuture<[Layout]> {
    $layouts.query(on: request.db)
      .limit(arguments.limit)
      .offset(arguments.offset)
      .all()
  }
}


