//
//  TableHeaderView.swift
//  Medicare
//
//  Created by Mayank Goyal on 03/08/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

class TableHeaderView: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    
    func setFontOFTitle (fontName: String, size: Int) {
        self.lblTitle.font = UIFont(name: fontName, size: CGFloat(size))
    }
}
