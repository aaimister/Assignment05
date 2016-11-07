//
//  Workout.swift
//  Lifts
//
//  Created by Aaron Kroupa on 11/2/16.
//  Copyright © 2016 Aaron Kroupa. All rights reserved.
//

import Foundation
import UIKit

class Workout: NSObject {
    
    private let workoutNum: Int
    private var exercises = [Exercise]()
    private var bodyWeight: Weight
    
    init(workoutNum: Int, bodyWeight: Int) {
        self.workoutNum = workoutNum
        self.bodyWeight = Weight(weight: bodyWeight)
        exercises = [Exercise(name: "SQUAT", numOfSets: 5, numOfReps: 5, weight: 215, weightUnit: Weight.WeightUnit.LB),
                     Exercise(name: "BENCH", numOfSets: 3, numOfReps: 5, weight: 135, weightUnit: Weight.WeightUnit.LB),
                     Exercise(name: "DEADLIFT", numOfSets: 1, numOfReps: 5, weight: 250, weightUnit: Weight.WeightUnit.LB) ]
    }
    
    init(workoutNum: Int, workout: Workout) {
        self.workoutNum = workoutNum
        bodyWeight = workout.getBodyWeight().copy()
        for exe in workout.getExercises() {
            exercises.append(exe.copy())
        }
    }
    
    func addExercise(_ exercise: Exercise) {
        exercises.insert(exercise, at: 0)
    }
    
    func removeExercise(_ at: Int) -> Exercise {
        return exercises.remove(at: at)
    }
    
    func getWorkoutNum() -> Int {
        return workoutNum
    }
    
    func getBodyWeight() -> Weight {
        return bodyWeight
    }
    
    func getBodyWeightString() -> String {
        return bodyWeight.toString()
    }
    
    func getSetsString() -> String {
        if exercises.count <= 0 { return "Add" }
        var string = ""
        for e in exercises {
            string.append(e.getSetString() + "\n")
        }
        return string.substring(to: string.index(before: string.endIndex))
    }
    
    func getWeightString() -> String {
        if exercises.count <= 0 { return "Exercises" }
        var string = ""
        for e in exercises {
            string.append(e.getWeightString() + "\n")
        }
        return string.substring(to: string.index(before: string.endIndex))
    }
    
    func getExercises() -> [Exercise] {
        return exercises
    }
    
    func setBodyWeight(_ weight: Int, _ weightUnit: Weight.WeightUnit) {
        bodyWeight.setWeight(weight, weightUnit)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? Workout else { return false }
        return workoutNum == other.getWorkoutNum()
    }
    
}
