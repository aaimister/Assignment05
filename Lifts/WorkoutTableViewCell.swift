//
//  WorkoutTableViewCell.swift
//  Lifts
//
//  Created by Aaron Kroupa on 11/2/16.
//  Copyright © 2016 Aaron Kroupa. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var setInfo: UILabel!
    @IBOutlet weak var weightInfo: UILabel!
    @IBOutlet weak var workoutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
