//
//  Pokemon.swift
//  PokemonDex
//
//  Created by Harlans on 2021/6/25.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    var id: UUID {
        get {
            UUID()
        }
    }
    let num: Int
    let name: String
    let variations: [PokeVariation]
}

struct PokeVariation: Codable {
    let name: String
    let description: String
    let image: String
    let types: [String]
    
    var urlImage: URL {
        get {
            URL(string: "\(baseUrl)/master/public/\(image)")!
        }
    }
}


