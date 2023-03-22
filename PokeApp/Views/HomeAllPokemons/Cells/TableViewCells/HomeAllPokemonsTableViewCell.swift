//
//  HomeAllPokemonsTableViewCell.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import UIKit
import Kingfisher

class HomeAllPokemonsTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with pokemon: PokemonResult?, and pokemonImageURL: String?) {
        pokemonNameLabel.text = pokemon?.nameUppercased
        pokemonImage.kf.indicatorType = .activity
        if let imageURL = pokemonImageURL {
            pokemonImage.kf.setImage(with: URL(string: imageURL)!)
        }
    }
}
