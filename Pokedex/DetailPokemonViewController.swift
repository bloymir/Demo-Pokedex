//
//  DetailPokemonViewController.swift
//  Pokedex
//
//  Created by nelson tapia on 12-07-22.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    
    //MARK: - IBOulets
    
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var descriptionPokemon: UITextView!
    @IBOutlet weak var typePokemon: UILabel!
    @IBOutlet weak var attackPokemon: UILabel!
    @IBOutlet weak var defensePokemon: UILabel!
    
    //MARK: - Variables
    
    var pokemonShow: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Imagen a Mostrar
        imagePokemon.loadFrom(URLAddres: pokemonShow?.imageUrl ?? "")
        typePokemon.text = "Tipo: \(pokemonShow?.type ?? "")"
        attackPokemon.text = "Ataque: \(pokemonShow!.attack)"
        defensePokemon.text = "Defensa: \(pokemonShow!.type)"
        descriptionPokemon.text = pokemonShow?.description ?? ""
        
        
    }
}

extension UIImageView {
    func loadFrom(URLAddres: String){
        guard let url = URL(string: URLAddres) else { return }
        
        DispatchQueue.main.async { [weak self] in
            if let imagenData = try? Data(contentsOf: url){
                if let loadedImage = UIImage(data: imagenData){
                    self?.image = loadedImage
                }
            }
        }
    }
}

