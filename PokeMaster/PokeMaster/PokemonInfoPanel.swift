//
//  PokemonInfoPanel.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/15.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

struct PokemonInfoPanel: View {
    
    @EnvironmentObject var store: Store
    let model: PokemonViewModel
    @State var darkBlur = false
    
    var abilities: [AbilityViewModel] {
        AbilityViewModel.sample(pokemonID: model.id)
    }
    
    var topIndeicator: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 6)
            .opacity(0.2)
    }
    
    var pokemonDescription: some View {
        Text(model.descriptionText)
            .font(.callout)
            .foregroundColor(Color(hex: 0x666666))
            .fixedSize(horizontal: false, vertical: true)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                self.darkBlur.toggle()
            }) {
                Text("切换模糊效果")
            }
            topIndeicator
            Header(model: model)
            pokemonDescription
            Divider()
            AbilityList(model: model, abilityModels: abilities)
        }
        .padding(EdgeInsets(top: 12, leading: 30, bottom: 30, trailing: 30))
        //.background(Color.white)
        .blurBackground(style: darkBlur ? .systemMaterialDark : .systemMaterial)
        .cornerRadius(20)
        .fixedSize(horizontal: false, vertical: true)
    }
}

extension PokemonInfoPanel
{
    struct Header: View {
        let model: PokemonViewModel
        
        var body: some View {
            HStack {
                pokenonIcon
                nameSpecies
                verticalDivider
                VStack(spacing: 12) {
                    bodyStatus
                    typeInfo
                }
            }
        }
        
        var pokenonIcon: some View {
            Image("Pokemon-\(model.id)")
                .resizable()
                .frame(width: 68, height: 68)
        }
        var nameSpecies: some View {
            VStack {
                Text(model.name)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(model.color)
                Text(model.nameEN)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(model.color)
                    .padding(.bottom, 10)
                Text(model.genus)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
        var verticalDivider: some View {
            RoundedRectangle(cornerRadius: 1)
                .frame(width: 1, height: 44)
                .foregroundColor(Color(hex: 0x000000, alpha: 0.1))
        }
        var bodyStatus: some View {
            VStack {
                HStack {
                    Text("身高")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text(model.height)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
                HStack {
                    Text("体重")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text(model.weight)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
            }
        }
        var typeInfo: some View {
            HStack {
                ForEach(model.types) { type in
                    Text(type.name)
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .frame(width: 36, height: 14)
                        .background(type.color)
                        .cornerRadius(7)
                }
            }
        }
    }
}
