//
//  PokemonRootView.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/15.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

struct PokemonRootView: View {
    //@EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            PokemonList().navigationBarTitle("宝可梦列表")
//            if store.appState.pokemonList.pokemons == nil {
//                Text("Loading...").onAppear {
//                    self.store.dispatch(.loadPokemons)
//                }
//            }else {
//                PokemonList().navigationBarTitle("宝可梦列表")
//            }
            
        }
    }
}

struct PokemonRootView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRootView()
    }
}
