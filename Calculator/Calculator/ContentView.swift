//
//  ContentView.swift
//  Calculator
//
//  Created by Harlans on 2020/7/14.
//  Copyright © 2020 Harlans. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let scale: CGFloat = UIScreen.main.bounds.width / 414
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
            Text("0")
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .lineLimit(1)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            CalculatorButtonPad()
                .padding(.bottom)
        }.scaleEffect(scale)
    }
}

struct CalculatorButtonPad: View {
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
                CalculatorButtonRow(row: row)
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

struct CalculatorButtonRow: View {
    let row: [CalculatorButtonItem]
    var body: some View {
        HStack { // 水平布局排列
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title, size: item.size, backgroundColorName: item.backgroundColorName) {
                    print("Button \(item.title)")
                }
            }
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
