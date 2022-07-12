//
//  PokemonManager.swift
//  Pokedex
//
//  Created by nelson tapia on 12-07-22.
//

import Foundation

protocol pokemonManagerDelegado {
    func getListPokemon(lista: [Pokemon])
}


struct PokemonManager {
    var delegate: pokemonManagerDelegado?
    
    func getPokemon(){
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print("Error al obtener datos de la apo: ", error?.localizedDescription)
                }
                
                if let dataSecure = data?.parseData(quitarString: "null,"){
                    if let listaPokemon = self.parsearJSON(dataPokemon: dataSecure){
                        
                        delegate?.getListPokemon(lista: listaPokemon)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parsearJSON(dataPokemon: Data) -> [Pokemon]? {
        let decodificador = JSONDecoder()
        do {
            
            let decodedData = try decodificador.decode([Pokemon].self, from: dataPokemon)
            
            return decodedData
            
        } catch  {
            print("Error al decodificar: ", error.localizedDescription)
            return nil
        }
    }
}


extension Data{
    func parseData(quitarString palabra: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: palabra, with: "")
        
        guard let data = parseDataString?.data(using: .utf8) else { return nil}
        return data
    }
}
