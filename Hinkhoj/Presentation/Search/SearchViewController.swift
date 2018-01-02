//
//  SearchViewController.swift
//  Hinkhoj
//
//  Created by Mayank Goyal on 13/12/17.
//  Copyright © 2017 Ankur Jain. All rights reserved.
//

import UIKit

enum WordMeaningSectionType {
    case meaning
    case defination
    case sentenceExample
    case similarWords
    case oppositeWords
    
    func headerText() -> String {
        switch self {
        case .meaning:
            return "MEANING"
            
        case .defination:
            return "DEFINATION"
            
        case .sentenceExample:
            return "SENTENCE EXAMPLE"
            
        case .similarWords:
            return "SIMILAR WORDS"
            
        case .oppositeWords:
            return "OPPOSITE WORDS"
        }
    }
}

protocol ScrollHeaderDelegate: class {
    func selectedTab(sender: UIButton)
}

class SearchViewController: BaseViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, ScrollHeaderDelegate {
    
    //MARK: - IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var tblViewSearch: UITableView!
    
    //MARK: - Variable
    weak var scrollHeaderViewController: ScrollHeaderViewController?
    var navTitle = ""
    var arrWordMeanings = NSMutableArray()
    var arrDefination = NSMutableArray()
    var arrSentenceExample = NSMutableArray()
    var arrSynonym = NSMutableArray()
    var arrAntonym = NSMutableArray()
    
    var selecteTab: WordMeaningSectionType = .meaning
    var selctedIndexPaths = [IndexPath]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = navTitle + " Meaning".localize()
        scrollHeaderViewController?.designButtoninScrollView(arrButton: [WordMeaningSectionType.meaning.headerText(), WordMeaningSectionType.defination.headerText(), WordMeaningSectionType.sentenceExample.headerText(), WordMeaningSectionType.similarWords.headerText(), WordMeaningSectionType.oppositeWords.headerText()])
        txtFldSearch.text = navTitle
        tblViewSearch.separatorColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtFldSearch.becomeFirstResponder()
    }

    @IBAction func back_TouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMic_TouchUpInside(_ sender: Any) {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            self.searchByWordOffline(text)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            self.searchByWordOffline(text)
        }
    }
    
    // MARK - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLoadScrollFromSearch" {
            if let vc = segue.destination as? ScrollHeaderViewController {
                scrollHeaderViewController = vc
                scrollHeaderViewController?.headerDelegate = self
            }
        }
    }
    
    func selectedTab(sender: UIButton) {
        switch sender.tag {
        case 500:
            selecteTab = WordMeaningSectionType.meaning
            break;
        case 501:
            selecteTab = WordMeaningSectionType.defination
            break;
        case 502:
            selecteTab = WordMeaningSectionType.sentenceExample
            if let text = txtFldSearch.text {
                self.searchGetSentenceUsage(text)
            }
            break;
        case 503:
            selecteTab = WordMeaningSectionType.similarWords
            break;
        case 504:
            selecteTab = WordMeaningSectionType.oppositeWords
            break;
        default:
            break
        }
        
        self.tblViewSearch.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
