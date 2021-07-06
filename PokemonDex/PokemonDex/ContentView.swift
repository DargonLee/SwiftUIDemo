//
//  ContentView.swift
//  PokemonDex
//
//  Created by Harlans on 2021/6/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var pokemonVM: PokemonViewModel = PokemonViewModel()
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                PokemonList(pokemons: filteredPokemons)
                    .task {
                        await pokemonVM.fetchAsyncPokemons()
                    }
                    .searchable(text: $searchText)
                    .navigationTitle("Pokemons")
            } else {
                PokemonList(pokemons: filteredPokemons)
                    .navigationTitle("Pokemons")
            }
                
        }
    }
    
    var filteredPokemons: [Pokemon] {
        if searchText.isEmpty {
            return pokemonVM.pokemons
        }
        return pokemonVM.pokemons.filter{
            $0.name.contains(searchText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
