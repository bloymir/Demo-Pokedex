//
//  DataPokemon.swift
//  Pokedex
//
//  Created by nelson tapia on 12-07-22.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let attack: Int
    let defense: Int
    let name: String
    let imageUrl: String
    let description: String
    let type: String
}
