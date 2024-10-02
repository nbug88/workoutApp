//
//  Exercise.swift
//  SimpleWorkout
//
//  Created by Akhil Naru on 3/10/24.
//

import Foundation

struct Exercise: Identifiable, Codable {
    var id = UUID()
    var name: String
    var sets: [ExerciseSet]
}

struct ExerciseSet: Codable, Identifiable {
    var id = UUID()
    var setId: Int
    var reps: Int
    var weight: Double
    var timestamp: Date?
    var elapsedTime: Int
}


