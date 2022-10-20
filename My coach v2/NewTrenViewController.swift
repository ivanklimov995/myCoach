//
//  NewTrenViewController.swift
//  My coach v2
//
//  Created by Иван Климов on 18.10.2022.
//

import UIKit

class NewTrenViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    //MARK: не работает изменение сохраненного упражнения
    
    var newTren = Training()
    var repeatedTren = Training()
    
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameExercise: UITextField!
    @IBOutlet weak var weightExercise: UITextField!
    @IBOutlet weak var approachesExercise: UITextField!
    @IBOutlet weak var allExerciesTextField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allExerciesTextField.delegate = self
        for exercises in repeatedTren.exercises {
            allExerciesTextField.text += "\(exercises.nameExercise) \(exercises.weightExercise) \(exercises.approachesExercise) \n"
            registerForKeyboardNotifications()
        }
        warnLabel.alpha = 0
    }
    
    func displayWarning(text: String){
        warnLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,
                animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }, completion: {  [weak self] complete in
            self?.warnLabel.alpha = 0
        })
    }

    @IBAction func addButton(_ sender: UIButton) {
        guard nameExercise.text != nil else {return}
        guard let weight = Int(weightExercise.text!) else {
            displayWarning(text: "Вес указан с ошибкой")
            return
        }
        guard let approaches = Int(approachesExercise.text!) else {
            displayWarning(text: "Повторы указаны с ошибкой")
            return
        }
        
        let newExers = Exercise()
        
        newExers.nameExercise = nameExercise.text!
        newExers.weightExercise = weight
        newExers.approachesExercise = approaches
        newTren.exercises.append(newExers)
        
        allExerciesTextField.text += newExers.nameExercise
        allExerciesTextField.text += " \(newExers.weightExercise)"
        allExerciesTextField.text += " \(newExers.approachesExercise) \n"
        
        nameExercise.text = nil
        weightExercise.text = nil
        approachesExercise.text = nil
        
        nameExercise.resignFirstResponder()
        weightExercise.resignFirstResponder()
        approachesExercise.resignFirstResponder()
       
    }
    
    
    //MARK: перемотка контента при вызове клавиатуры
    deinit{
        removeKeyboardNotifications()
    }

    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
        //skrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)//мб не над
        //tableView.reloadData()
    }
    
    @objc func keyboardWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
}
