//
//  ViewController.swift
//  Pokedex
//
//  Created by nelson tapia on 12-07-22.
//

import UIKit

class ListPokemonViewController: UIViewController {

    //MARK: - IBoutlets
    @IBOutlet weak var tablePokemon: UITableView!
    @IBOutlet weak var searchBarPokemon: UISearchBar!
    
    //MARK: - Variables
    var pokemonManager = PokemonManager()
    var pokemons: [Pokemon] = []
    var selectedPokemon: Pokemon?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registrar nueva Celda
        tablePokemon.register(UINib(nibName: "CellPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
       
        
        pokemonManager.delegate = self
        tablePokemon.delegate = self
        tablePokemon.dataSource = self
        
        //Metodos de busqueda en la API
        pokemonManager.getPokemon()
    }


}

//MARK: - Delegado Pokemon
extension ListPokemonViewController: pokemonManagerDelegado {
    func getListPokemon(lista: [Pokemon]) {
        pokemons = lista
        
        DispatchQueue.main.async {
            self.tablePokemon.reloadData()
        }
    }
    
    
}

//MARK: - Tabla
extension ListPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablePokemon.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellPokemonTableViewCell
        
        cell.namePokemon.text = pokemons[indexPath.row].name
        cell.attackPokemon.text = "Ataque: \(pokemons[indexPath.row].attack)"
        cell.defensePokemon.text = "Defensa: \(pokemons[indexPath.row].defense)"
        
        //Celda imagen URL
        if let urlString = pokemons[indexPath.row].imageUrl as? String {
            if let imageURL = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imageURL) else { return }
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        cell.imagePokemon.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = pokemons[indexPath.row]
        
        //Navegacion
        performSegue(withIdentifier: "detailPokemon", sender: self)
        
        
        //Deseleccionar la celda
        tablePokemon.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPokemon" {
            let showPokemon = segue.destination as! DetailPokemonViewController
            showPokemon.pokemonShow = selectedPokemon
        }
    }
    
    
}

