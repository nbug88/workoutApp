//
//  ExerciseView.swift
//  SimpleWorkout
//
//  Created by Akhil Naru on 3/10/24.
//

import SwiftUI

struct ExerciseView: View {
    @ObservedObject var viewModel: ExerciseViewModel
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
            
            VStack {
                Text(viewModel.exercise.name)
                    .font(.title)
                    .padding()
                
                let columns: [GridItem] = [
                    GridItem(.flexible(), spacing: 5),
                    GridItem(.flexible(), spacing: 5),
                    GridItem(.flexible(), spacing: 10),
                    GridItem(.flexible(), spacing: 10)
                ]
                
                LazyVGrid(columns: columns, alignment: .leading) {
                    Text("Set").font(.headline)
                    Text("Reps").font(.headline)
                    Text("Weight").font(.headline)
                    Text("Time").font(.headline)
                    
                    ForEach(viewModel.exercise.sets.indices, id: \.self) { index in
                        let set = viewModel.exercise.sets[index]
                        Text("\(set.setId)")
                        Text("\(set.reps)")
                        Text("\(set.weight, specifier: set.weight.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f") lbs")
                        Text("\(set.elapsedTime / 60)m \(set.elapsedTime % 60)s")
                    }
                }
                .padding()
                
                TextField("Reps", text: $viewModel.newReps)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isInputFocused)
                    .padding()

                TextField("Weight", text: $viewModel.newWeight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isInputFocused)
                    .padding()

                
                Button("Log New Set") {
                    isInputFocused = false  // Dismiss the keyboard
                    viewModel.logNewSet()
                    if !viewModel.isTimerRunning {
                        viewModel.toggleTimer()
                    }
                }
                .padding()
                
                TimerView(viewModel: viewModel) // Corrected to use the existing viewModel
                
            
        }
            .onTapGesture {
                     // This will dismiss the keyboard by removing the focus when the VStack background is tapped
                     isInputFocused = false
                 }
        .onAppear {
            viewModel.loadExerciseDataAndPrefill()
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(viewModel: ExerciseViewModel())
    }
}
