//
//  ContentView.swift
//  PokemonDex
//
//  Created by Harlans on 2021/6/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var pokemonVM: PokemonViewModel = PokemonViewModel()
    
    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                PokemonList(pokemons: pokemonVM.pokemons)
                    .task {
                        await pokemonVM.fetchAsyncPokemons()
                    }
                    .navigationTitle("Pokemons")
            } else {
                PokemonList(pokemons: pokemonVM.pokemons)
                    .navigationTitle("Pokemons")
            }
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
