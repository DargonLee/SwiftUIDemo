//
//  WiFiPasswordView.swift
//  HelloSwiftUI
//
//  Created by Harlans on 2020/12/7.
//

import SwiftUI

struct WiFiPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var password = ""
    
    var body: some View {
        NavigationView {
            Form {
                SecureField("Password", text: $password)
            }
            .navigationBarTitle("Enter Password", displayMode: .inline)
            .navigationBarItems(leading: Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                Text("Cancel")
                    .font(.body)
            }, trailing: Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                Text("Join")
            })
        }
    }
}

struct WiFiPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        WiFiPasswordView()
    }
}
