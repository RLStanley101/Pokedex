//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Ronnie Stanley on 1/2/17.
//  Copyright © 2017 Ronnie Stanley. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name.capitalized
        let image = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = image
        currentEvoImage.image = image
        pokedexLabel.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetail {
            // This code will only be called after the network call is complete!
            self.updateUI()
            
    }
    }
    
    
    func updateUI() {
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvoId == "" {
            evoLabel.text = "No evolutions"
            nextEvoImage.isHidden = true
        } else {
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvoId)
            let string = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
            evoLabel.text = string
        }
        
        
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
   
}
