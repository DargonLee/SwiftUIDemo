//
//  PokemonList.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/15.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    @State var expandingIndex: Int?
    @State var searchStr: String = ""
    var body: some View {
//        List(PokemonViewModel.all) { pokemon in
//            PokemonInfoRow(model: pokemon)
//        }
        ScrollView {
            HStack {
                TextField("搜索", text: $searchStr, onEditingChanged: { changed in
                    print("onEditing: \(changed)")
                }) {
                    print("userName: \(self.searchStr)")
                }
                .font(.system(size: 15))
                .padding(6)
            }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 1))
                )
                .padding()
            
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
        }.overlay(
            VStack {
                Spacer()
                PokemonInfoPanel(model: .sample(id: 1))
            }.edgesIgnoringSafeArea(.bottom)
        )
    }
}
