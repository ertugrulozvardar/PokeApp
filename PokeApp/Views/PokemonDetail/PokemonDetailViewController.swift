//
//  PokemonDetailViewController.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import UIKit
import UIImageColors

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonHealthLabel: UILabel!
    @IBOutlet weak var pokemonAttackLabel: UILabel!
    @IBOutlet weak var pokemonDefenceLabel: UILabel!
    @IBOutlet weak var pokemonSpecialAttackLabel: UILabel!
    @IBOutlet weak var pokemonSpecialDefenceLabel: UILabel!
    @IBOutlet weak var pokemonOrderLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesTableView: UITableView!
    @IBOutlet weak var pokemonCharacterBackgroundView: UIView! {
        didSet {
            pokemonCharacterBackgroundView.layer.cornerRadius = 16
            pokemonCharacterBackgroundView.clipsToBounds = true
            pokemonCharacterBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    @IBOutlet weak var pokemonStatsStackView: UIStackView! {
        didSet {
            pokemonStatsStackView.layer.cornerRadius = 16
            pokemonStatsStackView.clipsToBounds = true
        }
    }
    
    private let pokemonDetailViewModel = PokemonDetailViewModel()
    var pokemonIndex: String?
    var isFrontImage: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        setupImageViewAction(imageView: pokemonImageView)
        setupPokemonDetailViewModelObserver()
        getPokemonByIndex(pokemonIndex: pokemonIndex)
    }
    
    fileprivate func setupPokemonDetailViewModelObserver() {
        pokemonDetailViewModel.pokemonDetails.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.updateUIElements(with: self?.pokemonDetailViewModel.pokemonDetails)
                self?.pokemonAbilitiesTableView.reloadData()
            }
        }
        
        pokemonDetailViewModel.isFetching.bind { [weak self] (isFetching) in
            guard let isFetching = isFetching else { return }
            DispatchQueue.main.async {
                let loader = self?.loader()
                if isFetching {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self?.stopLoader(loader: loader!)
                    })
                }
            }
        }
    }
    
    fileprivate func setupImageViewAction(imageView: UIImageView?) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        imageView?.addGestureRecognizer(tapGesture)
        imageView?.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        guard let frontShinyImageURL = pokemonDetailViewModel.pokemonDetails.value?.sprites?.frontShiny, let backShinyImageURL = pokemonDetailViewModel.pokemonDetails.value?.sprites?.backShiny else { return }
        if (gesture.view as? UIImageView) != nil {
            if isFrontImage == true {
                pokemonImageView.kf.setImage(with: URL(string: backShinyImageURL))
                isFrontImage = false
            } else {
                pokemonImageView.kf.setImage(with: URL(string: frontShinyImageURL))
                isFrontImage = true
            }
        }
    }
    
    func registerTableViewCells() {
        pokemonAbilitiesTableView.registerNib(PokemonDetailAbilityTableViewCell.self, bundle: .main)
    }
    
    func getPokemonByIndex(pokemonIndex: String?) {
        if let index = pokemonIndex {
            pokemonDetailViewModel.fetchPokemonDetail(with: index)
        }
    }
    
    func updateUIElements(with pokemon: Observable<PokemonDetail>?) {
        if let specificPokemon = pokemon {
            pokemonNameLabel.text = specificPokemon.value?.nameUppercased
            pokemonImageView.kf.indicatorType = .activity
            guard let frontImageURL = specificPokemon.value?.sprites?.frontShiny else { return }
            pokemonImageView.kf.setImage(with: URL(string: frontImageURL))
            if let weight = specificPokemon.value?.weight, let height = specificPokemon.value?.height {
                pokemonWeightLabel.text = String(weight) + " KG"
                pokemonHeightLabel.text = String(height) + " M"
            }
            pokemonHealthLabel.text = String(specificPokemon.value?.stats?[0].baseStat ?? 0)
            pokemonAttackLabel.text = String(specificPokemon.value?.stats?[1].baseStat ?? 0)
            pokemonDefenceLabel.text = String(specificPokemon.value?.stats?[2].baseStat ?? 0)
            pokemonSpecialAttackLabel.text = String(specificPokemon.value?.stats?[3].baseStat ?? 0)
            pokemonSpecialDefenceLabel.text = String(specificPokemon.value?.stats?[4].baseStat ?? 0)
            pokemonOrderLabel.text = String(specificPokemon.value?.order ?? 1)
        }
    }
}
// MARK: - UITableView Data Source & Delegate Methods
extension PokemonDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonDetailViewModel.pokemonDetails.value?.abilities?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: PokemonDetailAbilityTableViewCell.self, indexPath: indexPath)
        let ability = pokemonDetailViewModel.pokemonDetails.value?.abilities?[indexPath.row].ability?.abilityNameUppercased
        cell.configure(with: ability)
        return cell
    }
}
