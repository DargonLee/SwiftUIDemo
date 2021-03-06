//
//  PokemonInfoRow.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/15.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

struct PokemonInfoRow: View {
    @EnvironmentObject var store: Store
    
    //let model = PokemonViewModel.sample(id: 1)
    let model: PokemonViewModel
    let expanded: Bool
    //@State var expanded: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image("Pokemon-\(model.id)")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
//                KFImage(model.iconImageURL)
//                      .resizable()
//                      .frame(width: 50, height: 50)
//                      .aspectRatio(contentMode: .fit)
//                      .shadow(radius: 4)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(model.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(model.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }.padding(.top, 12)
            Spacer()
            HStack(spacing: expanded ? 20 : -30) {
                Spacer()
                Button(action: {
                    print("Fav")
                    self.store.dispatch(.toggleFavorite(index: self.model.id))
                }) {
                    Image(systemName: "star")
                        .modifier(ToolButtonModifier())
                }.alert(item: self.$store.appState.pokemonList.favoriteError) { error in
                    Alert(
                        title: Text(error.localizedDescription),
                        primaryButton: .cancel(),
                        secondaryButton: .default(Text("登录")) {
                            self.store.dispatch(.switchTab(index: .settings))
                        }
                    )
                }
                Button(action: {
                    print("Panel")
                    let target = !self.store.appState.pokemonList.selectionState.panelPresented
                    self.store.dispatch(.togglePanelPresenting(presenting: target))
                }) {
                    Image(systemName: "chart.bar")
                        .modifier(ToolButtonModifier())
                }
                NavigationLink(
                    destination:
                    SafariView(url: model.detailPageURL) {
                        self.store.dispatch(.closeSafariView)
                    }
                        .navigationBarTitle(
                            Text(model.name),
                            displayMode: .inline
                        ),
                    isActive: expanded ?
                        $store.appState.pokemonList.isSFViewActive :
                        .constant(false),
                    label: {
                        Image(systemName: "info.circle")
                            .modifier(ToolButtonModifier())
                    }
                )
            }
            .padding(.bottom, 12)
            .opacity(expanded ? 1.0 : 0.0)
            .frame(maxHeight: expanded ? .infinity : 0)
        }
        .frame(height: expanded ? 120 : 80)
        .padding(.leading, 23)
        .padding(.trailing, 15)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(model.color, style: StrokeStyle(lineWidth: 4))
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.white, model.color]),
                            startPoint: .leading,
                            endPoint: .trailing
                    )
                )
            }
        ).padding(.horizontal)
         .animation(
            .spring(response: 0.55, dampingFraction: 0.425, blendDuration: 0)
        )
//         .onTapGesture {
//            self.expanded.toggle()
//        }
    }
}

struct ToolButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
    }
}
