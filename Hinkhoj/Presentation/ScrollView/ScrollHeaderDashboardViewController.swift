//
//  ScrollHeaderDashboardViewController.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 23/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

class ScrollHeaderDashboardViewController: UIViewController {
    
    @IBOutlet weak var scrlButton: UIScrollView!
    var arrButtonScroll: [String]?
    
    weak var headerDelegate: ScrollHeaderDashboardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func designButtoninScrollView(arrButton: [String]) {
        self.arrButtonScroll = arrButton
        var XCord: CGFloat = 20.0
        for i in 0..<arrButton.count {
            let btnScrl = UIButton()
            btnScrl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            let frame: CGRect = self.labelSize(for: arrButton[i], font: UIFont.boldSystemFont(ofSize: 16), maxWidth: CGFloat(99999), numberOfLines: 1)
            btnScrl.setTitle(arrButton[i], for: .normal)
            btnScrl.frame = CGRect(x: XCord, y: 0, width: frame.size.width, height: scrlButton.frame.size.height)
            btnScrl.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
            btnScrl.setTitleColor(UIColor.white, for: .selected)
            btnScrl.tag = 500 + i
            if i == 0 {
                btnScrl.isSelected = true
            }
            btnScrl.addTarget(self, action: #selector(ScrollHeaderViewController.btnScrl_TouchUpInside), for: .touchUpInside)
            self.scrlButton.addSubview(btnScrl)
            XCord += frame.size.width + 20
        }
        
        scrlButton.contentSize = CGSize(width: XCord, height: 0)
    }
    
    @objc func btnScrl_TouchUpInside(sender: UIButton) {
        if let arr = self.arrButtonScroll {
            for i in 0..<arr.count {
                if let btn = self.scrlButton.viewWithTag(500 + i) as? UIButton {
                    btn.isSelected = false
                }
            }
        }
        
        sender.isSelected = true
        headerDelegate?.selectedTab(sender: sender)
    }
    
    func labelSize(for text: String, font: UIFont, maxWidth : CGFloat,numberOfLines: Int) -> CGRect{
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: maxWidth, height: CGFloat.leastNonzeroMagnitude))
        label.numberOfLines = numberOfLines
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
