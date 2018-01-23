//
//  MyDictionaryTableViewCell.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 23/01/18.
//  Copyright © 2018 Ankur Jain. All rights reserved.
//

import UIKit

class MyDictionaryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFirstWord: UILabel!
    @IBOutlet weak var lblWord: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
