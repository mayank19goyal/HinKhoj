//
//  WODFirstTableViewCell.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 25/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

class WODFirstTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCharacter: UILabel!
    @IBOutlet weak var lblENgWord: UILabel!
    @IBOutlet weak var lblPronunciation: UILabel!
    @IBOutlet weak var btnSpeakEng: UIButton!
    @IBOutlet weak var btnSaveEng: UIButton!
    
    @IBOutlet weak var lblHindiMeaning: UILabel!
    @IBOutlet weak var btnSpeakHind: UIButton!
    @IBOutlet weak var btnSaveHind: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
