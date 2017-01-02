//
//  PokeCell.swift
//  Pokedex
//
//  Created by Ronnie Stanley on 1/1/17.
//  Copyright © 2017 Ronnie Stanley. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        thumImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
