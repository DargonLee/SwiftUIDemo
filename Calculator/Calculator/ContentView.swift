//
//  ContentView.swift
//  Calculator
//
//  Created by Harlans on 2020/7/14.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //@State private var brain: CalculatorBrain = .left("0")
    //@ObservedObject var model = CalculatorModel()
    @EnvironmentObject var model: CalculatorModel
    let scale: CGFloat = UIScreen.main.bounds.width / 414
    @State private var editingHistory = false
    
    var body: some View {
        /*
         VStack { // 竖直布局排列
             CalculatorButtonRow(row: [.command(.clear), .command(.flip),.command(.percent), .op(.divide)])
             CalculatorButtonRow(row: [.digit(7), .digit(8), .digit(9), .op(.multiply)])
             CalculatorButtonRow(row: [.digit(4), .digit(5), .digit(6), .op(.minus)])
             CalculatorButtonRow(row: [.digit(1), .digit(2), .digit(3), .op(.plus)])
         }
         */
        VStack(spacing: 12) {
            Spacer() // “它会尝试将可占据的空间全部填满”
            Button("操作履历: \(model.history.count)") {
                self.editingHistory = true
                  print(self.model.history)
            }
            .sheet(isPresented: self.$editingHistory) {
                HistoryView(model: self.model)
            }
            Text(model.brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24 * scale)
                .lineLimit(1)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .alert(isPresented: self.$editingHistory, content: { () -> Alert in
                    Alert(
                        title: Text(self.model.brain.output),
                        message: Text(self.model.historyDetail),
                        dismissButton: .default(Text("OK"))
                    )
                })
//            Button("Test") {
//                self.brain = .left("1.23")
//            }
            //CalculatorButtonPad(brain: $model.brain)
            //CalculatorButtonPad(model: model)
            CalculatorButtonPad()
                .padding(.bottom)
        }.scaleEffect(scale)
    }
}

struct HistoryView: View {
    @ObservedObject var model: CalculatorModel
    
    var body: some View {
        VStack {
            if model.totalCount == 0 {
                Text("没有履历")
            }else {
                HStack {
                    Text("履历").font(.headline)
                    Text("\(model.historyDetail)").lineLimit(nil)
                }
                HStack {
                    Text("显示").font(.headline)
                    Text("\(model.brain.output)")
                }
                Slider(value: $model.slidingIndex, in: 0...Float(model.totalCount), step: 1)
            }
        }.padding()
    }
}

struct CalculatorButtonPad: View {
    //@Binding var brain: CalculatorBrain
    //var model: CalculatorModel
    
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip),.command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)]
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id: \.self) { row in
                //CalculatorButtonRow(row: row, model: self.model)
                CalculatorButtonRow(row: row)
            }
        }
    }
}

struct CalculatorButtonRow: View {
    let row: [CalculatorButtonItem]
    //@Binding var brain: CalculatorBrain
    //var model: CalculatorModel
    @EnvironmentObject var model: CalculatorModel
    var body: some View {
        HStack { // 水平布局排列
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title, size: item.size, backgroundColorName: item.backgroundColorName) {
                    //self.brain = self.brain.apply(item: item)
                    self.model.apply(item)
                    print("Button \(item.title)")
                }
            }
        }
    }
}

struct CalculatorButton: View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
           Text(title)
            .font(.system(size: fontSize))
            .foregroundColor(.white)
            .frame(width: size.width, height: size.height)
            .background(Color(backgroundColorName))
            .cornerRadius(size.width/2)
//            ZStack {
//                Circle()
//                    .foregroundColor(Color(backgroundColorName))
//                Text(title)
//                    .font(.system(size: fontSize))
//                    .foregroundColor(.white)
//                    .frame(width: size.width, height: size.height)
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
//            ContentView().previewDevice("iPhone SE")
        }
    }
}
