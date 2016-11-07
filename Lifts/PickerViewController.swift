//
//  PickerViewController.swift
//  Lifts
//
//  Created by Aaron Kroupa on 11/5/16.
//  Copyright © 2016 Aaron Kroupa. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, SelectedRowDelegate {
    
    @IBOutlet weak var weightPicker: WeightPicker!
    @IBOutlet weak var weightLabel: UILabel!
    
    private var startWeight: Weight?
    
    var detailItem: Weight?
    var delegate: UpdateWorkoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightPicker.loadDefaults(self)
        
        if let detail = detailItem {
            startWeight = Weight(weight: detail.getWeight(), weightUnit: detail.getUnit())
            setWeightLabel()
            weightPicker.setSelectedNum(detail.getWeight())
            weightPicker.setSelectedWeight(detail.getUnit().rawValue)
        }
    }
    
    func selectedRow() {
        detailItem?.setWeight(weightPicker.getSlectedNum(), Weight.convertToUnit(weightPicker.getSelectedWeight()))
        setWeightLabel()
    }

    private func setWeightLabel() {
        if let detail = detailItem {
            var string = ""
            for w in Weight.WeightUnit.allValues {
                let difference = Int(detail.convertTo(w) - startWeight!.convertTo(w))
                string += (difference > 0 ? "+" : "") + "\(difference)" + w.rawValue + "/"
            }
            string.remove(at: string.index(before: string.endIndex))
            weightLabel.text = string
        }
    }
    
    @IBAction func saveWeight(_ sender: UIButton) {
        delegate?.updateWeight()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        detailItem?.setWeight(startWeight!.getWeight(), startWeight!.getUnit())
        dismiss(animated: true, completion: nil)
    }
}
