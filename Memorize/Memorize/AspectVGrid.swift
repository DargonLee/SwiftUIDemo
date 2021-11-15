//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Harlans on 2021/11/15.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry  in
            let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspecRatio: aspectRatio)
            LazyVGrid(columns: [adaptiveGridItem(width: width)]) {
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
            Spacer(minLength: 0)
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspecRatio: CGFloat) -> CGFloat {
        var columCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columCount)
            let itemHeight = itemWidth / itemAspecRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columCount += 1
            rowCount = (itemCount + (columCount - 1)) / columCount
        } while columCount < itemCount
        if columCount > itemCount {
            columCount = itemCount
        }
        return floor(size.width / CGFloat(columCount))
    }
}
