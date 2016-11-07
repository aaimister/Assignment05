//
//  Exercise.swift
//  Lifts
//
//  Created by Aaron Kroupa on 11/2/16.
//  Copyright © 2016 Aaron Kroupa. All rights reserved.
//

import Foundation
import UIKit

internal class Exercise {
    
    static let MAX_SET_NUM = 5
    static let WEIGHT_INCREMENT = 5
    
    private let name: String
    private let numOfSets: Int
    private var sets: [Int]
    private var numOfReps: Int
    private var weight: Weight
    
    init(name: String, numOfSets: Int, numOfReps: Int, weight: Int, weightUnit: Weight.WeightUnit) {
        self.name = name
        self.numOfSets = numOfSets > Exercise.MAX_SET_NUM ? Exercise.MAX_SET_NUM : numOfSets
        sets = [Int](repeating: 0, count: numOfSets)
        self.numOfReps = numOfReps
        self.weight = Weight(weight: weight, weightUnit: weightUnit)
    }
    
    func getName() -> String {
        return name
    }
    
    func getNumOfSets() -> Int {
        return numOfSets
    }
    
    func getNumOfReps() -> Int {
        return numOfReps
    }
    
    func getSetString() -> String {
        var string = ""
        var shorten = true
        for s in sets {
            if s != numOfReps { shorten = false }
            string.append((s == 0 ? "-" : String(s)) + "/")
        }
        if shorten {
            string = "\(numOfSets)x\(numOfReps)"
        } else {
            string.remove(at: string.index(before: string.endIndex))
        }
        return string
    }
    
    func getSets() -> [Int] {
        return sets
    }
    
    func getSetReps(_ set: Int) -> Int {
        return sets[set]
    }
    
    func getWeight() -> Weight {
        return weight
    }
    
    func getWeightString() -> String {
        return weight.toString()
    }
    
    func copy() -> Exercise {
        return Exercise(name: name, numOfSets: numOfSets, numOfReps: numOfReps, weight: (completed() ? weight.getWeight() + Exercise.WEIGHT_INCREMENT : weight.getWeight()), weightUnit: weight.getUnit())
    }
    
    func completed() -> Bool {
        for n in sets {
            if n != numOfReps { return false }
        }
        return true
    }
    
    func setWeight(_ weight: Int, _ weightUnit: Weight.WeightUnit) {
        self.weight.setWeight(weight, weightUnit)
    }
    
    func setRepCount(_ set: Int, _ repCount: Int) {
        if set >= sets.count || repCount > numOfReps { return }
        sets[set] = repCount
    }
    
    func incrementSet(_ set: Int) {
        if set >= sets.count { return }
        let count = sets[set]
        sets[set] = count + 1 > Exercise.MAX_SET_NUM ? 0 : count + 1
    }
    
}
