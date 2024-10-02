//
//  TimerView.swift
//  SimpleWorkout
//
//  Created by Akhil Naru on 3/21/24.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: ExerciseViewModel

    private let maxTime: CGFloat = 180 // 3 minutes in seconds

    var body: some View {
        VStack {
            HStack {
                // Timer display
                Text("\(viewModel.elapsedTime / 60):\(String(format: "%02d", viewModel.elapsedTime % 60))")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Play/Pause button
                Button(action: {
                    viewModel.toggleTimer()
                }) {
                    Image(systemName: viewModel.isTimerRunning ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                
            }
            .padding()
            
            // Progress bar
            ProgressBar(value: min(CGFloat(viewModel.elapsedTime) / maxTime, 1))
                .frame(height: 10)
                .padding()
            
        }
    }
}

// Define a ProgressBar view
struct ProgressBar: View {
    var value: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))

                Rectangle().frame(width: min(CGFloat(value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear, value: value)
            }
            .cornerRadius(45.0)
        }
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: ExerciseViewModel())
    }
}


