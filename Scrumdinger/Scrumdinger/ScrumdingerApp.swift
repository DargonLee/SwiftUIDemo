//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Harlans on 2020/12/15.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    //@State private var scrums = DailyScrum.data
    @ObservedObject private var data = ScrumData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $data.scrums) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
