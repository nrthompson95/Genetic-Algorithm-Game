//
//  GATableViewCell.swift
//  Genetic Algorithm Game
//
//  Created by Nick Thompson on 8/15/16.
//  Copyright © 2016 Nick Thompson. All rights reserved.
//

import UIKit

class GATableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var fitnessTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
    }
}
