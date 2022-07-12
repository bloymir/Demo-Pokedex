//
//  CellPokemonTableViewCell.swift
//  Pokedex
//
//  Created by nelson tapia on 12-07-22.
//

import UIKit

class CellPokemonTableViewCell: UITableViewCell {
    
    //MARK: - IBOutle
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var attackPokemon: UILabel!
    @IBOutlet weak var defensePokemon: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagePokemon.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
