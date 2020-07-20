//
//  ContentView.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/15.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PokemonRootView()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar")
                        Text("宝可梦")
                    }
            }
            SettingRootView()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar")
                        Text("设置")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
