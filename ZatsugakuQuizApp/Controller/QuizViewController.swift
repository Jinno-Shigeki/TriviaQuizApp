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
    var activityIndicatorView = UIActivityIndicatorView()
    var quizData: [QuizData] = []
    var checkView: CheckView?
    var cellTitleName = ""
    var questionNumber = 0
    var correctCount = 0
    
    @IBOutlet weak var choiceButton1: UIButton!
    @IBOutlet weak var choiceButton2: UIButton!
    @IBOutlet weak var choiceButton3: UIButton!
    @IBOutlet weak var choiceButton4: UIButton!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var QLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInterfaceArrange()
        activityIndicatorViewArrange()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        self.getData(subjectName: self.cellTitleName)
    }
    
    @IBAction func pushButton(_ sender: UIButton) {
            if sender.tag == quizData[questionNumber].answer{
                sender.backgroundColor = .systemRed
                addCheckView(answerImage: UIImage(named: "correct")!, questionNumber: questionNumber)
                correctCount += 1
            }else{
                sender.backgroundColor = .systemBlue
                addCheckView(answerImage: UIImage(named: "false")!, questionNumber: questionNumber)
            }
    }
    
    func getData(subjectName: String) {
        db.collection(subjectName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            } else {
                for document in querySnapshot!.documents {
                    let questionData = document.get("question").map(String.init(describing:)) ?? "nil"
                    let answerData = document.get("answer").flatMap { $0 as? Int } ?? 0
                    let choicesData1 = document.get("1").map(String.init(describing:)) ?? "nil"
                    let choicesData2 = document.get("2").map(String.init(describing:)) ?? "nil"
                    let choicesData3 = document.get("3").map(String.init(describing:)) ?? "nil"
                    let choicesData4 = document.get("4").map(String.init(describing:)) ?? "nil"
                    let answerText = document.get("\(answerData)").map(String.init(describing:)) ?? "nil"
                    self.quizData.append(QuizData(question: questionData, answer: answerData, choice1: choicesData1, choice2: choicesData2, choice3: choicesData3, choice4: choicesData4, answerText: answerText))
                    self.quizData.shuffled()
                    if self.quizData.count > 10 {
                        for data in 10..<self.quizData.count {
                           self.quizData.remove(at: data)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.updateView(quizData: self.quizData.first!)
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
    func updateView(quizData: QuizData) {
        questionTextView.text = quizData.question
        choiceButton1.setTitle(quizData.choice1, for: .normal)
        choiceButton2.setTitle(quizData.choice2, for: .normal)
        choiceButton3.setTitle(quizData.choice3, for: .normal)
        choiceButton4.setTitle(quizData.choice4, for: .normal)
        QLabel.text = "Q" + String(questionNumber + 1)
    }
    
    func addCheckView(answerImage: UIImage, questionNumber: Int) {
        checkView = CheckView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        checkView?.answerImage.image = answerImage
        checkView?.answerLabel.text = "A." + self.quizData[questionNumber].answerText
        checkView?.nextButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        self.view.addSubview(checkView!)
    }
    
    @objc func nextQuestion() {
           checkView?.removeFromSuperview()
           choiceButton1.backgroundColor = .systemYellow
           choiceButton2.backgroundColor = .systemYellow
           choiceButton3.backgroundColor = .systemYellow
           choiceButton4.backgroundColor = .systemYellow
           
        if questionNumber == quizData.count - 1  {
            nextScreen(correctCount: correctCount)
        }else{
            questionNumber += 1
            let nextQuestion = quizData[questionNumber]
            updateView(quizData: nextQuestion)
        }
    }

    func nextScreen(correctCount: Int) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        nextView.questionResult = correctCount
        nextView.modalPresentationStyle = .fullScreen
        self.present(nextView, animated: true, completion: nil)
    }

    func userInterfaceArrange() {
        choiceButton1.titleLabel?.numberOfLines = 0
        choiceButton2.titleLabel?.numberOfLines = 0
        choiceButton3.titleLabel?.numberOfLines = 0
        choiceButton4.titleLabel?.numberOfLines = 0
        
        choiceButton1.layer.cornerRadius = 10
        choiceButton2.layer.cornerRadius = 10
        choiceButton3.layer.cornerRadius = 10
        choiceButton4.layer.cornerRadius = 10
        questionTextView.layer.cornerRadius = 10
        QLabel.layer.cornerRadius = 5
        
        choiceButton1.contentEdgeInsets = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10)
        choiceButton2.contentEdgeInsets = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10)
        choiceButton3.contentEdgeInsets = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10)
        choiceButton4.contentEdgeInsets = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10)
        
        QLabel.frame.size = CGSize(width: 65, height: 40)
        
        /*choiceButton2.titleLabel?.adjustsFontSizeToFitWidth = true
        choiceButton2.titleLabel?.minimumScaleFactor = 0.3*/
    }
    func activityIndicatorViewArrange(){
        activityIndicatorView.style = .large
        activityIndicatorView.color = .white
        activityIndicatorView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        activityIndicatorView.center = view.center
        activityIndicatorView.backgroundColor = .darkGray
        activityIndicatorView.alpha = 0.8
        activityIndicatorView.layer.cornerRadius = 7
    }
}



