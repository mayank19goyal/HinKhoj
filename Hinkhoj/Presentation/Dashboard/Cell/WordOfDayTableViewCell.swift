//
//  WordOfDayTableViewCell.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 24/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

class WordOfDayTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblEngWord: UILabel!
    @IBOutlet weak var lblHindWord: UILabel!
    @IBOutlet weak var lblFullDate: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnReadMore: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblDate.layer.cornerRadius = lblDate.frame.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
