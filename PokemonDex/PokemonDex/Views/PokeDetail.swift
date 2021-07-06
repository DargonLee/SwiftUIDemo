//
//  PokeDetail.swift
//  PokemonDex
//
//  Created by Harlans on 2021/7/6.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokeDetail: View {
    let poke: Pokemon
    
    var body: some View {
        let pokeVar = poke.variations[0]
        
        VStack(spacing: 20) {
            WebImage(url: pokeVar.urlImage)
                .resizable()
            Text(pokeVar.name)
                .font(.largeTitle)
                .bold()
                .shadow(radius: 20)
            Text(pokeVar.description)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                ForEach(pokeVar.types, id: \.self) { type in
                    Text(type)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
            Link("Visit", destination: URL(string: poke.link)!)
        }
    }
}
