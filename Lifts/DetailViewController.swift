//
//  DetailViewController.swift
//  Lifts
//
//  Created by Aaron Kroupa on 11/2/16.
//  Copyright © 2016 Aaron Kroupa. All rights reserved.
//

import UIKit

protocol UpdateWorkoutDelegate {
    func updateWeight()
}

protocol AddNewExercise {
    func addExercise(_ name: String, _ numOfSets: Int, _ numOfReps: Int, _ weight: Int, _ weightUnit: Weight.WeightUnit)
}

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateWorkoutDelegate, AddNewExercise {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weightView: UIView!
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var rightButtonBarView: UIView!
    
    private var editingIndexPath: IndexPath?
    var detailItem: Workout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let detail = detailItem {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 120
            
            weightView.layer.cornerRadius = 10
            weightView.layer.masksToBounds = true
            weightView.layer.borderWidth = 1.0
            weightView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            
            weightButton.setTitle(detail.getBodyWeightString(), for: .normal)
//            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertExercise(_:)))
//            addButton.customView = rightButtonBarView
          //  self.navigationItem.rightBarButtonItem?.customView
        }
    }

    func insertExercise(_ sender: Any) {
        performSegue(withIdentifier: "newDetail", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailItem?.getExercises().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Exercise Cell", for: indexPath) as! ExerciseTableViewCell
        
        if let exercise = detailItem?.getExercises()[indexPath.row] {
            cell.exerciseLabel.text = exercise.getName()
            cell.weightButton.setTitle(exercise.getWeightString(), for: .normal)
            cell.exercise = exercise
            for i in 0..<exercise.getNumOfSets() {
                let reps = exercise.getSetReps(i)
                cell.setButtons[i].setBackgroundImage(reps == 0 ? #imageLiteral(resourceName: "grey") : #imageLiteral(resourceName: "red"), for: .normal)
                cell.setButtons[i].setTitle(reps == 0 ? "" : "\(reps)", for: .normal)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            detailItem?.removeExercise(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Body" {
            let controller = segue.destination as! PickerViewController
            controller.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.right
            controller.delegate = self
            editingIndexPath = nil
            controller.detailItem = detailItem?.getBodyWeight()
        } else if segue.identifier == "Exercise" {
            for cell in tableView.visibleCells as! [ExerciseTableViewCell] {
                if cell.weightButton.isEqual(sender) {
                    let controller = segue.destination as! PickerViewController
                    controller.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.right
                    controller.popoverPresentationController?.sourceView = cell.anchorView
                    controller.delegate = self
                    editingIndexPath = tableView.indexPath(for: cell)
                    controller.detailItem = detailItem?.getExercises()[editingIndexPath!.row].getWeight()
                }
            }
        } else if segue.identifier == "newDetail" {
            let controller = segue.destination as! NewExerciseViewController
            controller.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.right
            controller.popoverPresentationController?.sourceView = self.navigationItem.rightBarButtonItem?.customView
            controller.delegate = self
        }
    }
    
    func updateWeight() {
        if let indexPath = editingIndexPath {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            if let detail = detailItem {
                weightButton.setTitle(detail.getBodyWeightString(), for: .normal)
            }
        }
    }
    
    func addExercise(_ name: String, _ numOfSets: Int, _ numOfReps: Int, _ weight: Int, _ weightUnit: Weight.WeightUnit) {
        detailItem?.addExercise(Exercise(name: name, numOfSets: numOfSets, numOfReps: numOfReps, weight: weight, weightUnit: weightUnit))
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    @IBAction func addExerciseAction(_ sender: UIButton) {
        performSegue(withIdentifier: "newDetail", sender: self)
    }
}

