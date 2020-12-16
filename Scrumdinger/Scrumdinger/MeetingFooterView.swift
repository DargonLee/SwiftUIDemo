//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Harlans on 2020/12/15.
//

import SwiftUI

struct MeetingFooterView: View {
    @Binding var speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else {
            return nil
        }
        return index + 1
    }
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy{ $0.isCompleted }
    }
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else {
            return "No more speakers"
        }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                }else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibility(label: Text("Next speaker"))
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}
