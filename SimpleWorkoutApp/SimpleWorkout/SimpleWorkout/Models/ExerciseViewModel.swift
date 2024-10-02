import Foundation

class ExerciseViewModel: ObservableObject {
    @Published var exercise: Exercise
    @Published var newReps: String = ""
    @Published var newWeight: String = ""
    @Published var elapsedTime: Int = 0
    @Published var isTimerRunning: Bool = false
    private var startTime: Date?
    private var timer: Timer?
    

   /* // Define the timeFormatter in the ViewModel
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter
    }()*/

    init() {
        if let loadedExercise = ExerciseDataManager.loadExerciseData() {
            self.exercise = loadedExercise
            if let lastSet = loadedExercise.sets.last {
                self.newReps = String(lastSet.reps)
                self.newWeight = String(lastSet.weight)
            } else {
                self.newReps = "10"  // Example default value
                self.newWeight = "100"  // Example default value
            }
        } else {
            self.exercise = Exercise(name: "Chest Press with Barbell", sets: [])
            self.newReps = "10"  // Recommended reps
            self.newWeight = "100"  // Recommended weight
        }
    }

    func toggleTimer() {
        if !isTimerRunning {
            // Start or resume the timer
            if startTime == nil {
                // This is a fresh start
                startTime = Date()
            } else {
                // Resuming from a pause; adjust the startTime based on elapsedTime
                startTime = Date().addingTimeInterval(-Double(elapsedTime))
            }

            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                guard let self = self, let startTime = self.startTime else { return }
                self.elapsedTime = Int(Date().timeIntervalSince(startTime))
            }
            isTimerRunning = true
        } else {
            // Pause the timer
            timer?.invalidate()
            timer = nil
            isTimerRunning = false
            // Do not reset startTime or elapsedTime here to allow for resuming
        }
    }



    func logNewSet() {
        guard let reps = Int(newReps), let weight = Double(newWeight) else {
            // Handle invalid input
            return
        }

        if isTimerRunning {
            toggleTimer() // This will stop the timer if it's running
        }

        let today = Date()
        let calendar = Calendar.current
        let setId: Int

        if let lastSet = exercise.sets.last,
           calendar.isDate(lastSet.timestamp ?? Date(), inSameDayAs: today) {
            setId = lastSet.setId + 1
        } else {
            setId = 1
        }

        let newSet = ExerciseSet(id: UUID(), setId: setId, reps: reps, weight: weight, timestamp: Date(), elapsedTime: elapsedTime)
        exercise.sets.append(newSet)

        saveExerciseData()
        
        // Reset the state for the next set
        newReps = ""
        newWeight = ""
        elapsedTime = 0

        // Start the timer again for the next set
        toggleTimer()
    }


    func saveExerciseData() {
        ExerciseDataManager.saveExerciseData(exercise: exercise)
    }

    func loadExerciseDataAndPrefill() {
        if let loadedExercise = ExerciseDataManager.loadExerciseData() {
            exercise = loadedExercise
            if let lastSet = exercise.sets.last {
                newReps = String(lastSet.reps)
                newWeight = String(lastSet.weight)
            }
        }
    }
}
