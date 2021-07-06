//
//  PokemonTest.swift
//  PokemonDex
//
//  Created by Harlans on 2021/6/25.
//

import SwiftUI

struct PokemonText: View {
    let name: String
    
    var body: some View {
        Text(name)
            .font(.largeTitle)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .shadow(radius: 20)
            .padding()
    }
}

struct PokemonTest_Previews: PreviewProvider {
    static var previews: some View {
        PokemonText(name: "Pikachu")
    }
}
