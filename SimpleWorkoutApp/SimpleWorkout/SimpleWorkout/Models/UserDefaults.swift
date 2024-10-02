//
//  UserDefaults.swift
//  SimpleWorkout
//
//  Created by Akhil Naru on 3/10/24.
//

import Foundation

class ExerciseDataManager {
    static func saveExerciseData(exercise: Exercise) {
        let userDefaults = UserDefaults.standard
        do {
            let encodedData = try JSONEncoder().encode(exercise)
            userDefaults.set(encodedData, forKey: "LastExerciseData")
        } catch {
            print("Failed to save exercise data: \(error)")
        }
    }

    static func loadExerciseData() -> Exercise? {
        let userDefaults = UserDefaults.standard
        guard let savedExerciseData = userDefaults.object(forKey: "LastExerciseData") as? Data else {
            return nil
        }
        do {
            return try JSONDecoder().decode(Exercise.self, from: savedExerciseData)
        } catch {
            print("Failed to load exercise data: \(error)")
            return nil
        }
    }
}

