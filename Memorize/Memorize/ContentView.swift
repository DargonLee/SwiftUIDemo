//
//  ContentView.swift
//  Memorize
//
//  Created by Harlans on 2021/11/8.
//

import SwiftUI

struct ContentView: View {
    var emojies = ["😀","😁","😍","🥰","🤪","😚","😎","😭","😰","🤬","🙄","😈","🤐","😮‍💨","🎃","😬","😬","🤖","👻","🤖","👻","🤖","👻",]
    @State private var emojiCounter = 5
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]) {
                    ForEach(emojies[0..<emojiCounter], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button {
            print("--")
            if emojiCounter > 1 {
                emojiCounter -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
    var add: some View {
        Button {
            print("++")
            if emojiCounter < emojies.count {
                emojiCounter += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }

}

struct CardView: View {
    var content: String
    @State var isFaceUp = false
            
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            }else {
                shape.fill(.red)
            }
        }
        .onTapGesture {
            withAnimation {
                isFaceUp = !isFaceUp;
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
