//
//  QuizViewController.swift
//  ZatsugakuQuizApp
//
//  Created by 神野成紀 on 2020/04/12.
//  Copyright © 2020 神野成紀. All rights reserved.
//

import UIKit
import Firebase

class QuizViewController: UIViewController {
    
    let db = Firestore.firestore()
    var quizData: [QuizData] = []
    var cellTitleName = ""
    
    @IBOutlet weak var choiceButton1: UIButton!
    @IBOutlet weak var choiceButton2: UIButton!
    @IBOutlet weak var choiceButton3: UIButton!
    @IBOutlet weak var choiceButton4: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(subjectName: cellTitleName)
    
    }
    
    @IBAction func pushButton(_ sender: UIButton) {
        print(sender.tag)
    }
    
    func getData(subjectName: String) {
        db.collection(subjectName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            } else {
                for document in querySnapshot!.documents {
                    let questionData = document.get("question").map(String.init(describing:)) ?? "nil"
                    let answerData = document.get("answer").map(String.init(describing:)) ?? "nil"
                    let choicesData1 = document.get("1").map(String.init(describing:)) ?? "nil"
                    let choicesData2 = document.get("2").map(String.init(describing:)) ?? "nil"
                    let choicesData3 = document.get("3").map(String.init(describing:)) ?? "nil"
                    let choicesData4 = document.get("4").map(String.init(describing:)) ?? "nil"
                    print("\(choicesData1)\(choicesData2)\(choicesData3)\(choicesData4)")
                    print("\(answerData)")
                    print("\(questionData)")
                    self.quizData.append(QuizData(question: questionData, answer: answerData, choice1: choicesData1, choice2: choicesData2, choice3: choicesData3, choice4: choicesData4))
                }
                DispatchQueue.main.async {
                    let firstQuestion = self.quizData.randomElement()
                    self.questionTextView.text = firstQuestion?.question
                    self.choiceButton1.setTitle(firstQuestion?.choice1, for: .normal)
                    self.choiceButton2.setTitle(firstQuestion?.choice2, for: .normal)
                    self.choiceButton3.setTitle(firstQuestion?.choice3, for: .normal)
                    self.choiceButton4.setTitle(firstQuestion?.choice4, for: .normal)
                }
            }
        }
    }
}


