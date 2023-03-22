//
//  HomeAllPokemonsViewModel.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import Foundation

final class HomeAllPokemonsViewModel {
    
    private var pokemonService: PokemonServiceProtocol = PokemonService()
    var allPokemons = Observable<[PokemonResult]>()
    var pokemonDetails = Observable<[String: PokemonDetail]>()
    var isFetching = Observable<Bool>()
    
    func fetchAllPokemons() {
        isFetching.value = true
        pokemonService.fetchAllPokemons { [weak self] result in
            switch result {
            case .success(let response):
                self?.allPokemons.value = response.results
                self?.isFetching.value = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPokemonImages() {
        self.pokemonDetails.value = [:]
        if let pokemons = allPokemons.value {
            for pokemon in pokemons {
                isFetching.value = true
                pokemonService.fetchPokemonByIndex(index: pokemon.pokemonIndex) { [weak self] result in
                    switch result {
                    case .success(let response):
                        self?.pokemonDetails.value?[pokemon.pokemonIndex] = response
                        self?.isFetching.value = false
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
