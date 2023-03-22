//
//  Pokemon.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
    let count: Int?
    let next, previous: String?
    let results: [PokemonResult]?
}

// MARK: - Result
struct PokemonResult: Codable {
    let name: String?
    let url: String?
    
    var nameUppercased: String {
        return name!.capitalized
    }
    
    var pokemonIndex: String {
        let index = String((url?.replacingOccurrences(of: "/" , with: "").suffix(2))!)
        return index
    }
}

