//
//  Weight.swift
//  Lifts
//
//  Created by Aaron Kroupa on 11/2/16.
//  Copyright © 2016 Aaron Kroupa. All rights reserved.
//

import Foundation

internal class Weight {
    
    public enum WeightUnit: String {
        case LB, KG
        
        static let allValues = [LB, KG]
    }
    
    static func convertToUnit(_ unit: String) -> WeightUnit {
        switch(unit) {
        case "LB":
            return WeightUnit.LB
        case "KG":
            return WeightUnit.KG
        default:
            return WeightUnit.LB
        }
    }
    
    private var weightUnit: WeightUnit
    private var weight: Int
    
    convenience init(weight: Int) {
        self.init(weight: weight, weightUnit: .LB)
    }
    
    init(weight: Int, weightUnit: WeightUnit) {
        self.weightUnit = weightUnit
        self.weight = weight
    }
    
    func convertTo(_ to: WeightUnit) -> Int {
        switch(weightUnit) {
        case .LB:
            switch(to) {
            case .KG:
                return Int(Double(weight) * 0.45359237)
            default:
                return weight
            }
        case .KG:
            switch(to) {
            case .LB:
                return Int(Double(weight) / 0.45359237)
            default:
                return weight
            }
        }
    }
    
    func getWeight() -> Int {
        return weight
    }
    
    func getUnit() -> WeightUnit {
        return weightUnit
    }
    
    func copy() -> Weight {
        return Weight(weight: weight, weightUnit: weightUnit)
    }
    
    func setWeight(_ weight: Int, _ weightUnit: WeightUnit) {
        self.weightUnit = weightUnit
        self.weight = weight
    }
    
    func toString() -> String {
        return "\(getWeight())" + weightUnit.rawValue
    }
}
