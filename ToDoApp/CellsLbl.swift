//
//  CellsLbl.swift
//  ToDoApp
//
//  Created by Yan on 2018-01-11.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit

class CellsLbl: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var notesLbl: UILabel!
    @IBAction func switchBtn(_ sender: UISwitch) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
