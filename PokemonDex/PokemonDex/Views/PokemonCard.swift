//
//  PokemonCard.swift
//  PokemonDex
//
//  Created by Harlans on 2021/6/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonCard: View {
    let poke: Pokemon
    
    var body: some View {
        ZStack(alignment: .bottom) {
//            if #available(iOS 15.0, *) {
//                AsyncImage(url: poke.variations[0].urlImage) { image in
//                    image
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .cornerRadius(20)
//                        .shadow(radius: 20)
//                        .padding()
//                } placeholder: {
//                    Rectangle().foregroundColor(.gray.opacity(0.5))
//                }
//            }else {
                WebImage(url: poke.variations[0].urlImage)
                    .resizable()
                    .placeholder {
                        Rectangle().foregroundColor(.gray.opacity(0.5))
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .padding()
//            }
            
            if #available(iOS 15.0, *) {
                PokemonText(name: poke.name)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                    .offset(x: 0, y: -40)
            }else {
                PokemonText(name: poke.name)
            }
        }
    }
}

struct PokemonCard_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCard(poke: Pokemon(num: 1, name: "logo", variations: []))
    }
}
