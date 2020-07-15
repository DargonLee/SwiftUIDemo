//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Harlans on 2020/7/14.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI
import Combine

class CalculatorModel: ObservableObject {
    //let objectWillChange = PassthroughSubject<Void, Never>()
    
    /*
    var brain: CalculatorBrain = .left("0") {
        willSet {
            objectWillChange.send()
        }
    }
     */
    @Published var brain: CalculatorBrain = .left("0")
    @Published var history: [CalculatorButtonItem] = []
    
    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item)
        history.append(item)
        
        temporaryKept.removeAll()
        slidingIndex = Float(totalCount)
    }
    
    // historyDetail 将 history 数组中所记录的操作步骤的描述连接起来，作为履历的输出字符串。
    var historyDetail: String {
        history.map { $0.description }.joined()
    }
    
    // 用 temporaryKept 来暂存这些操作。
    var temporaryKept: [CalculatorButtonItem] = []
    
    var totalCount: Int {
        history.count + temporaryKept.count
    }
    
    var slidingIndex: Float = 0 {
        didSet {
            keepHistory(upTo: Int(slidingIndex))
        }
    }
    
    func keepHistory(upTo index: Int) {
        precondition(index <= totalCount, "Out of index")
        
        let total = history + temporaryKept
        
        history = Array(total[..<index])
        temporaryKept = Array(total[index...])
        
        brain = history.reduce(CalculatorBrain.left("0")) { result, item in
            result.apply(item: item)
        }
    }
}
