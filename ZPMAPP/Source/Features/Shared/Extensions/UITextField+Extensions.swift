//
//  UITextField+Extensions.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 27/09/21.
//

import Foundation
import UIKit


extension UITextField{
    
    @IBInspectable var doneAccessory: Bool {
        get {
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone {
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }

    func addBackButtonOnKeyboard() {
        let backToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        backToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let back: UIBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, back]
        backToolbar.items = items
        backToolbar.sizeToFit()

        self.inputAccessoryView = backToolbar
    }

    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
    
    func shakeAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func isEmail() -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text)
    }
    
    func isEmpty() -> Bool {
        return self.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    func invalidField() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
        self.textColor = .red
        self.shakeAnimation()
    }
    
    func validField() {
        self.textColor = .black
        self.layer.borderWidth = 0
    }
    
    func min(qty: Int) -> Bool {
        if let text = self.text {
            return text.count >= qty
        }
        
        return false
    }
    
    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: self.text)
    }
}
