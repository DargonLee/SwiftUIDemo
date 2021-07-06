//
//  PokemonViewModel.swift
//  PokemonDex
//
//  Created by Harlans on 2021/6/25.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    
    init() {
        self.fetchPokemons()
    }
    
    func fetchPokemons() {
        ApiService().fetchPokemons { pokemons in
            self.pokemons = pokemons
        }
    }
    
    @available(iOS 15.0, *)
    func fetchAsyncPokemons() async {
        self.pokemons = await ApiService().fetchAsyncPolemons()
    }
}
