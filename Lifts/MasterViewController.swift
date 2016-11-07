//
//  MasterViewController.swift
//  Lifts
//
//  Created by Aaron Kroupa on 11/2/16.
//  Copyright © 2016 Aaron Kroupa. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    private var detailViewController: DetailViewController? = nil
    private var objects = [Workout]()
    private var workoutCount = 1
    private var currentPresentingObject: Workout?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            performSegue(withIdentifier: "showDefault", sender: self)
        }
        
        // Allows the table to autoresize based on the height of the cells
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        // Reload the workout that was selected (if any)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        super.viewWillAppear(animated)
    }

    func insertNewObject(_ sender: Any) {
        objects.insert(objects.count == 0 ? Workout(workoutNum: workoutCount, bodyWeight: 150) : Workout(workoutNum: workoutCount, workout: objects.first!), at: 0)
        workoutCount += 1
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.title = "Workout \(object.getWorkoutNum())"
                currentPresentingObject = object
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Workout Cell", for: indexPath) as! WorkoutTableViewCell

        let object = objects[indexPath.row]
        cell.setInfo.text = object.getSetsString()
        cell.weightInfo.text = object.getWeightString()
        cell.workoutLabel.text = "Workout \(object.getWorkoutNum())"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = objects[indexPath.row]
            if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad && object.isEqual(currentPresentingObject) {
                performSegue(withIdentifier: "showDefault", sender: self)
            }
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }

}

