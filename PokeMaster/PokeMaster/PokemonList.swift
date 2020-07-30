//
//  PokemonList.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/15.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    @EnvironmentObject var store: Store
    
    @State var expandingIndex: Int?
    @State var searchStr: String = ""
    
    var body: some View {
//        List(PokemonViewModel.all) { pokemon in
//            PokemonInfoRow(model: pokemon)
//        }
        ScrollView {
            TextField("搜索", text: $searchStr)
                .frame(height: 40)
                .padding(.horizontal, 25)
            //store.appState.pokemonList.allPokemonsByID
            ForEach(PokemonViewModel.all) { pokemon in
                PokemonInfoRow(
                    model: pokemon,
                    expanded: self.expandingIndex == pokemon.id
                ).onTapGesture {
                    if self.expandingIndex == pokemon.id {
                        self.expandingIndex = nil
                    }else {
                        self.expandingIndex = pokemon.id
                    }
                }
            }
        }
//        .overlay(
//            VStack {
//                Spacer()
//                PokemonInfoPanel(model: .sample(id: 1))
//            }.edgesIgnoringSafeArea(.bottom)
//        )
    }
}
