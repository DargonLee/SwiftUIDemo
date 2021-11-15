//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Harlans on 2021/11/8.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
