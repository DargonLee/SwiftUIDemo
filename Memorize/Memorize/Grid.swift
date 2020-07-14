//
//  Grid.swift
//  Memorize
//
//  Created by Harlans on 2020/6/4.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

/// 这个尖括号告诉 Swift 那个 Item 是 结构体 Grid 中一个占位类型名，因此 Swift 不会去查找名为 Item 的实际类型

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
//        return Group {
//            if index != nil {
//                viewForItem(item)
//                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
//                .position(layout.location(ofItemAt: index!))
//            }
//        }
    }
}

