//
//  PokemonDetail.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import Foundation

// MARK: - PokemonDetail
struct PokemonDetail: Codable {
    let id: Int?
    let name: String?
    let height: Int?
    let weight: Int?
    let order: Int?
    let sprites: Sprites?
    let abilities: [Ability]?
    let stats: [Stat]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case weight, height, order
        case sprites, abilities, stats
    }
    
    var nameUppercased: String {
        return name!.capitalized
    }
    
    var index: String {
        return String(id!)
    }
}

// MARK: - Sprites
class Sprites: Codable {
    let frontDefault: String?
    let frontShiny: String?
    let backShiny: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case backShiny = "back_shiny"
    }
}
// MARK: - Ability
struct Ability: Codable {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}
// MARK: - Species
struct Species: Codable {
    let name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    var abilityNameUppercased: String {
        return name!.capitalized
    }
}
// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int?
    let stat: Species?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}
