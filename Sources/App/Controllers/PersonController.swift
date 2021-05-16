//
//  File.swift
//  
//
//  Created by Lee Burrows on 16/05/2021.
//

import Vapor

struct Person: Content {
    let firstName: String
    let lastName: String
    let favouriteFood: String
    let petsNames: [String]
}

struct PersonController {
    
    static func somePeople() -> [Person] {
        return [
            .init(firstName: "Lee", lastName: "Burrows", favouriteFood: "Curry", petsNames: ["Oscar"]),
                .init(firstName: "Dolly", lastName: "Burrows", favouriteFood: "Potato", petsNames: ["Oscar"])
        ]
    }
}
