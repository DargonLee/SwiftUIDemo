//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Harlans on 2021/11/8.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
