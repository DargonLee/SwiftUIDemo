//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Harlans on 2020/12/15.
//

import SwiftUI


struct MeetingHeaderView: View {
    @Binding var secondsElapsed: Int
    @Binding var secondsRemaining: Int
    private var progress: Double {
        guard secondsRemaining > 0 else {
            return 1
        }
        let totalSeconds = Double(secondsElapsed + secondsRemaining)
        return Double(secondsElapsed) / totalSeconds
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    private var minutesRemainingMetric: String {
        minutesRemaining == 1 ? "minute" : "minutes"
    }
    let scrumColor: Color
    
    var body: some View {
        ProgressView(value: progress)
            .progressViewStyle(ScrumProgressViewStyle(scrumColor: scrumColor))
        HStack {
            VStack(alignment: .leading) {
                Text("Seconds Elapsed")
                    .font(.caption)
                Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(secondsRemaining)")
                    .font(.caption)
                Label("\(secondsRemaining)", systemImage: "hourglass.tophalf.fill")
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Time remaining"))
        .accessibilityValue(Text("\(minutesRemaining) \(minutesRemainingMetric)"))
        .padding([.top, .horizontal])
    }
}
