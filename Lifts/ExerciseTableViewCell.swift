//
//  ExerciseTableViewCell.swift
//  Lifts
//
//  Created by Aaron Kroupa on 11/3/16.
//  Copyright © 2016 Aaron Kroupa. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet var setButtons: [UIButton]!
    @IBOutlet weak var anchorView: UIView!
    
    var exercise: Exercise?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        for i in 0..<setButtons.count {
            setButtons[i].addTarget(self, action: #selector(pressButton(_:)), for: .touchUpInside)
        }
    }
    
    func pressButton(_ sender: UIButton) {
        if (sender.backgroundImage(for: .normal)?.isEqual(#imageLiteral(resourceName: "invalid")))! { return }
        var currentNum = (Int(sender.title(for: .normal) ?? "0") ?? 0) + 1
        if currentNum > exercise?.getNumOfReps() ?? currentNum + 1 {
            sender.setTitle("", for: .normal)
            sender.setBackgroundImage(#imageLiteral(resourceName: "grey"), for: .normal)
            currentNum = 0
        } else {
            sender.setTitle("\(currentNum)", for: .normal)
            sender.setBackgroundImage(#imageLiteral(resourceName: "red"), for: .normal)
        }
        if let ex = exercise {
            ex.setRepCount(setButtons.index(of: sender)!, currentNum)
        }
    }

}
