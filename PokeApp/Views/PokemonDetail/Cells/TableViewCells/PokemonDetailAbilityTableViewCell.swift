//
//  PokemonDetailAbilityTableViewCell.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 21.03.2023.
//

import UIKit

class PokemonDetailAbilityTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonAbilityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with ability: String?) {
        pokemonAbilityNameLabel.text = ability
    }
}
