//
//  WebViewTableViewCell.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 03/01/18.
//  Copyright © 2018 Ankur Jain. All rights reserved.
//

import UIKit

class WebViewTableViewCell: UITableViewCell {

    @IBOutlet weak var webView: UIWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
