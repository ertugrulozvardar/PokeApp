//
//  HomeAllPokemonsViewController.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import UIKit

class HomeAllPokemonsViewController: UIViewController {
    
    @IBOutlet weak var allPokemonsTableView: UITableView!
    
    private let homeAllPokemonsViewModel = HomeAllPokemonsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        setupPokemonsViewModelObserver()
        getAllPokemons()
    }
    
    fileprivate func setupPokemonsViewModelObserver() {
        homeAllPokemonsViewModel.allPokemons.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.allPokemonsTableView.reloadData()
                self?.getAllPokemonImages()
            }
        }
        
        homeAllPokemonsViewModel.pokemonDetails.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.allPokemonsTableView.reloadData()
            }
        }
        
        homeAllPokemonsViewModel.isFetching.bind { [weak self] (isFetching) in
            guard let isFetching = isFetching else { return }
            DispatchQueue.main.async {
                let loader = self?.loader()
                if isFetching {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self?.stopLoader(loader: loader!)
                    })
                }
            }
        }
    }
    
    func registerTableViewCells() {
        allPokemonsTableView.registerNib(HomeAllPokemonsTableViewCell.self, bundle: .main)
    }
    
    func getAllPokemons() {
        homeAllPokemonsViewModel.fetchAllPokemons()
    }
    
    func getAllPokemonImages() {
        homeAllPokemonsViewModel.fetchPokemonImages()
    }
}

// MARK: - UITableView Data Source & Delegate Methods
extension HomeAllPokemonsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeAllPokemonsViewModel.allPokemons.value?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: HomeAllPokemonsTableViewCell.self, indexPath: indexPath)
        if let dict = homeAllPokemonsViewModel.pokemonDetails.value, let pokemon = homeAllPokemonsViewModel.allPokemons.value?[indexPath.row], let pokemonImage = dict[pokemon.pokemonIndex]?.sprites?.frontDefault {
            cell.configure(with: pokemon, and: pokemonImage)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pokemonDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: PokemonDetailViewController.self)) as? PokemonDetailViewController {
            let pokemon = homeAllPokemonsViewModel.allPokemons.value?[indexPath.row]
            pokemonDetailVC.pokemonIndex = pokemon?.pokemonIndex
            self.navigationController?.pushViewController(pokemonDetailVC, animated: true)
        }
    }
}
