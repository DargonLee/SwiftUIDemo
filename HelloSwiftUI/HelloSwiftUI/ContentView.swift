//
//  ContentView.swift
//  HelloSwiftUI
//
//  Created by Harlans on 2020/12/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Hello")
                    .font(.system(size: 48, weight: .semibold))
                    .padding(.bottom)
                Spacer()
                
                NavigationLink( destination: LanguageView() ) {
                    Text("Get Started")
                        .font(.headline)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
