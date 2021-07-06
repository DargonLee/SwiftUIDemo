//
//  ApiService.swift
//  PokemonDex
//
//  Created by Harlans on 2021/6/25.
//

import Foundation

let baseUrl: String = "https://raw.githubusercontent.com/robert-z/simple-pokemon-json-api"

class ApiService {
    func fetchPokemons(completion: @escaping ([Pokemon]) -> ()) {
        let url = URL(string: "\(baseUrl)/master/data/pokemon.json")
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                let pokemons = try! JSONDecoder().decode([Pokemon].self, from: data)
                print(pokemons)
                completion(pokemons)
            }
        }.resume()
    }
    
    @available(iOS 15.0, *)
    func fetchAsyncPolemons() async -> [Pokemon] {
        let url = URL(string: "\(baseUrl)/master/data/pokemon.json")
        let (data, _) = try! await URLSession.shared.data(from: url!)
        let pokemons = try! JSONDecoder().decode([Pokemon].self, from: data)
        print(pokemons)
        return pokemons
    }
}
