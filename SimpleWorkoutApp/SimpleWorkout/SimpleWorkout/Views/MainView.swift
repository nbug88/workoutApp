//
//  MainView.swift
//  SimpleWorkout
//
//  Created by Akhil Naru on 3/10/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ExerciseViewModel()

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Start Chest Press Workout", destination: ExerciseView(viewModel: viewModel))
            }
            .navigationTitle("Workouts")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
