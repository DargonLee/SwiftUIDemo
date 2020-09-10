//
//  SandwichStore.swift
//  Sandwiches
//
//  Created by Harlans on 2020/9/7.
//

import Foundation


class SandwichStore: ObservableObject {
    @Published var sandwiches: [Sandwich]
    
    init(sandwiches: [Sandwich]) {
        self.sandwiches = sandwiches
    }
}

let testStore = SandwichStore(sandwiches: testData)
