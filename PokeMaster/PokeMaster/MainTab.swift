//
//  MainTab.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/27.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

struct MainTab: View {
    @EnvironmentObject var store: Store

    private var pokemonList: AppState.PokemonList {
        store.appState.pokemonList
    }
    private var pokemonListBinding: Binding<AppState.PokemonList> {
        $store.appState.pokemonList
    }

    private var selectedPanelIndex: Int? {
        pokemonList.selectionState.panelIndex
    }
    
    var body: some View {
        TabView(selection: $store.appState.mainTab.selection) {
            PokemonRootView().tabItem {
                Image(systemName: "list.bullet.below.rectangle")
                Text("列表")
            }.tag(AppState.MainTab.Index.list)
            SettingRootView().tabItem {
                Image(systemName: "gear")
                Text("设置")
            }.tag(AppState.MainTab.Index.settings)
        }
        .overlaySheet(isPresented: pokemonListBinding.selectionState.panelPresented) {
            PokemonInfoPanel(model: .sample(id: 1))
        }
    }
}
