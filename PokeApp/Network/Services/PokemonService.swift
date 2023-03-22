//
//  PokemonService.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import Foundation

protocol PokemonServiceProtocol {
    mutating func fetchAllPokemons(completion: @escaping (Result<Pokemon, NetworkError>) -> Void)
    mutating func fetchPokemonByIndex(index: String, completion: @escaping (Result<PokemonDetail, NetworkError>) -> Void)
}

struct PokemonService: PokemonServiceProtocol {
    private let network = Network()
    
    mutating func fetchAllPokemons(completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        network.performRequest(request: PokemonRequest.fetchAllPokemons, completion: completion)
    }
    
    mutating func fetchPokemonByIndex(index: String, completion: @escaping (Result<PokemonDetail, NetworkError>) -> Void) {
        network.performRequest(request: PokemonRequest.fetchPokemonByIndex(pokemonIndex: index), completion: completion)
    }
}
