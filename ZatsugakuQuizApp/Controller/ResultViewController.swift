//
//  ResultViewController.swift
//  ZatsugakuQuizApp
//
//  Created by 神野成紀 on 2020/04/21.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var kekkaLabel: UILabel!
    var questionResult: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInterfaceArrange()
        resultLabel.text = "\(questionResult!)/10"
    }
    
    @IBAction func tapHomeButton(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        let storyboard: UIStoryboard = self.storyboard!
        let HomeView = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        present(HomeView, animated: true, completion: nil)
    }
    
    func userInterfaceArrange() {
        resultLabel.layer.cornerRadius = 7
        homeButton.layer.cornerRadius = 7
        kekkaLabel.layer.cornerRadius = 7
    }
}
