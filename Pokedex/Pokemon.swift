//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ronnie Stanley on 1/1/17.
//  Copyright © 2017 Ronnie Stanley. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoText: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLevel: String!
    private var _pokemonURL: String!
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    var nextEvoLevel: String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    var nextEvoName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoText: String {
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }

    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                    
                }
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                if let descripArr = dict["descriptions"] as? [Dictionary<String, String>] , descripArr.count > 0 {
                    if let url = descripArr[0]["resource_uri"] {
                        let descripURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descripURL).responseJSON(completionHandler: { (response) in
                            if let descripDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descripDict["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                    print(newDescription)
                                }
                            }
                            completed()
                        })
                    }
                    
                } else {
                    self._description = ""
                }
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvoName = nextEvo
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newString.replacingOccurrences(of: "/", with: "")
                                self._nextEvoId = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvoLevel = "\(lvl)"
                                    }
                                } else {
                                    self._nextEvoLevel = ""
                                }
                            }
                        }
                    }
                    print(self.nextEvoLevel)
                    print(self.nextEvoName)
                    print(self.nextEvoId)
                }
            }
            completed()
        }
    
}
}
