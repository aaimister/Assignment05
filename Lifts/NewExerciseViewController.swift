//
//  NewExerciseViewController.swift
//  Lifts
//
//  Created by Aaron Kroupa on 11/7/16.
//  Copyright © 2016 Aaron Kroupa. All rights reserved.
//

import UIKit

class NewExerciseViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var exerciseName: UITextField!
    
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var setStepper: UIStepper!
    @IBOutlet weak var repLabel: UILabel!
    @IBOutlet weak var repStepper: UIStepper!
    
    @IBOutlet weak var weightPicker: WeightPicker!
    
    var delegate: AddNewExercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exerciseName.delegate = self
        setLabel.text = "\(Int(setStepper.value))"
        setStepper.maximumValue = Double(Exercise.MAX_SET_NUM)
        repLabel.text = "\(Int(repStepper.value))"
        weightPicker.loadDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setStep(_ sender: UIStepper) {
        setLabel.text = "\(Int(sender.value))"
    }

    @IBAction func repStep(_ sender: UIStepper) {
        repLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func saveExercise(_ sender: UIButton) {
        delegate?.addExercise(exerciseName.text ?? "New Exercise", Int(setStepper.value), Int(repStepper.value), weightPicker.getSlectedNum(), Weight.convertToUnit(weightPicker.getSelectedWeight()))
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    

}
