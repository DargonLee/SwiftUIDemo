//
//  PokemonList.swift
//  PokemonDex
//
//  Created by Harlans on 2021/6/24.
//

import SwiftUI

struct PokemonList: View {
    let pokemons: [Pokemon]
    
    var body: some View {
        List{
             ForEach(pokemons) { poke in
                if #available(iOS 15.0, *) {
                    PokemonCard(poke: poke)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }else {
                    PokemonCard(poke: poke)
                        .listRowBackground(Color.clear)
                }
            }
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList(pokemons: [])
    }
}
