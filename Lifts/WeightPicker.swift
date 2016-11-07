//
//  WeightPicker.swift
//  Lifts
//
//  Created by Aaron Kroupa on 11/7/16.
//  Copyright © 2016 Aaron Kroupa. All rights reserved.
//

import UIKit

protocol SelectedRowDelegate {
    func selectedRow()
}

class WeightPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    static let STRIDE = 5
    static let MAX_PICKER_NUM = 1000
    
    private var pickerData = (nums: [Int](), weight: [String]())
    
    var selectedRowDelegate: SelectedRowDelegate?
    
    func loadDefaults(_ selectedRowDelegate: SelectedRowDelegate) {
        self.selectedRowDelegate = selectedRowDelegate
        loadDefaults()
    }
    
    func loadDefaults() {
        dataSource = self
        delegate = self
        for i in stride(from: 0, to: WeightPicker.MAX_PICKER_NUM, by: WeightPicker.STRIDE) {
            addPickerNum(WeightPicker.MAX_PICKER_NUM - i)
        }
        for w in Weight.WeightUnit.allValues {
            addPickerWeight(w.rawValue)
        }
        setSelectedNum(200)
    }

    
    func addPickerNum(_ num: Int) {
        pickerData.nums.append(num)
    }
    
    func loadPickerNums(_ data: [Int]) {
        pickerData.nums.append(contentsOf: data)
    }
    
    func addPickerWeight(_ weight: String) {
        pickerData.weight.append(weight)
    }
    
    func loadPickerWeights(_ data: [Int]) {
        pickerData.nums.append(contentsOf: data)
    }
    
    func getSlectedNum() -> Int {
        return pickerData.nums[selectedRow(inComponent: 0)]
    }
    
    func getSelectedWeight() -> String {
        return pickerData.weight[selectedRow(inComponent: 1)]
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component) {
        case 0:
            return pickerData.nums.count
        case 1:
            return pickerData.weight.count
        default:
            return 0
        }
    }
    
    // The data to return for the row and componenet (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(component) {
        case 0:
            return String(pickerData.nums[row])
        case 1:
            return pickerData.weight[row]
        default:
            return nil
        }
    }
    
    func setSelectedNum(_ num: Int) {
        selectRow(pickerData.nums.index(of: num) ?? 0, inComponent: 0, animated: true)
    }
    
    func setSelectedWeight( _ weight: String) {
        selectRow(pickerData.weight.index(of: weight) ?? 0, inComponent: 1, animated: true)

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRowDelegate?.selectedRow()
    }
    
}
