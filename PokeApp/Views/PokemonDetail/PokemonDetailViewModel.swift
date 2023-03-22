//
//  PokemonDetailViewModel.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import Foundation

final class PokemonDetailViewModel {
    
    private var pokemonService: PokemonServiceProtocol = PokemonService()
    var pokemonDetails = Observable<PokemonDetail>()
    var isFetching = Observable<Bool>()
    
    func fetchPokemonDetail(with selectedPokemonIndex: String) {
        isFetching.value = true
        pokemonService.fetchPokemonByIndex(index: selectedPokemonIndex) { [weak self] result in
            switch result {
            case .success(let response):
                self?.pokemonDetails.value = response
                self?.isFetching.value = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

