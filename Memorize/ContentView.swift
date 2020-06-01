//
//  ContentView.swift
//  Memorize
//
//  Created by Harlans on 2020/5/29.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            ForEach(0..<4, content: { index in
                CardView(isFaceUp: true)
            })
        }
        .padding(10)
        .font(Font.largeTitle)
        .foregroundColor(Color.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                Text("👻")
            }else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}
