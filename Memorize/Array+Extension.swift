//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Harlans on 2020/6/4.
//  Copyright © 2020 Harlans. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable
{
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}

extension Array
{
    var only: Element? {
        count == 1 ? first : nil
    }
}

// 枚举 遵寻了 CaseIterable 协议 就有了 allCases 方法
enum TeslaModel: CaseIterable {
    case X
    case S
    case Three
    case Y
}

// TeslaModel.allCases


