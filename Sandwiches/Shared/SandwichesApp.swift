//
//  SandwichesApp.swift
//  Shared
//
//  Created by Harlans on 2020/9/7.
//

import SwiftUI

@main
struct SandwichesApp: App {
    @StateObject private var store = testStore
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
