//
//  Path.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import Foundation

enum URLPath {
    case allPokemons
    case pokemonByIndex
}

func getURLPathName(path: URLPath, index: String) -> String? {
    switch path {
    case .allPokemons:
        return "/api/v2/pokemon/"
    case .pokemonByIndex:
        return "/api/v2/pokemon/\(index)"
    }
}
