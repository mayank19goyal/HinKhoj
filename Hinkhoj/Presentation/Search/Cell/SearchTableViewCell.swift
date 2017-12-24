//
//  SearchTableViewCell.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 23/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMeaning: UILabel!
    @IBOutlet weak var lblHtraslitate: UILabel!
    @IBOutlet weak var btnSpeak: UIButton!
    @IBOutlet weak var btnSaveWord: UIButton!
    @IBOutlet weak var lblUsage: UILabel!
    @IBOutlet weak var lblUsageValue: UILabel!
    @IBOutlet weak var lblFirstWord: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
