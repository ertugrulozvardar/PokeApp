//
//  PokemonRequest.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import Foundation

enum PokemonRequest {
    case fetchAllPokemons
    case fetchPokemonByIndex(pokemonIndex: String)
}

extension PokemonRequest: Requestable {
    var URLpath: String {
        var urlComponents = URLComponents(string: baseURL)!
        switch self {
        case .fetchAllPokemons:
            urlComponents.path = getURLPathName(path: .allPokemons, index: "") ?? "/api/v2/pokemon/?"
            urlComponents.queryItems = [
                URLQueryItem(name: "offset", value: "20"),
                URLQueryItem(name: "limit", value: "35")
            ]
            return urlComponents.string!
        case .fetchPokemonByIndex(pokemonIndex: let pokemonIndex):
            urlComponents.path = getURLPathName(path: .pokemonByIndex, index: pokemonIndex) ?? "/api/v2/pokemon/?"
            return urlComponents.string!
        }
    }
    
    var URLparameters: Data? {
        switch self {
        case .fetchAllPokemons,
                .fetchPokemonByIndex:
            return nil
        }
    }
}
