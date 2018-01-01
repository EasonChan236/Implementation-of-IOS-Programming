//
//  ViewController.swift
//  Quiz
//
//  Created by EasonChan on 12/1/17.
//  Copyright © 2017 Eason Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet var questionLabelCenterConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabelCenterConstraint: NSLayoutConstraint!
    
    let questions: [String] = ["From what is congnac made?","What if 7+7","What is the capital of Vermont"]
    let answers: [String] = ["Grapes","14","Montpelier"]
    var currentQuestionIndex: Int = 0
    
    @IBAction func showNextQuestion(sender: AnyObject){
        //self.questionLabel.alpha = 0
        currentQuestionIndex = currentQuestionIndex + 1
        if currentQuestionIndex == questions.count{
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animationLabelTransitions()
    }
    
    
    @IBAction func showAnser(sender: AnyObject){
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex]
        
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel(){
        let screenWidth = view.frame.width
        nextQuestionLabelCenterConstraint.constant = -screenWidth
    }
    
    func animationLabelTransitions() {
        self.view.layoutIfNeeded()
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterConstraint.constant = 0
        self.questionLabelCenterConstraint.constant += screenWidth
        UIView.animate(withDuration: 1,
            delay : 0,
            options: [],
            //curvelinear, repeat, autoreverse
            animations: {
                self.questionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                
                self.view.layoutIfNeeded()
            },
            completion: { (Bool) -> Void in
                swap(&self.questionLabel, &self.nextQuestionLabel)
                swap(&self.questionLabelCenterConstraint, &self.nextQuestionLabelCenterConstraint)
                self.updateOffScreenLabel()
            }
        )
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }
}

