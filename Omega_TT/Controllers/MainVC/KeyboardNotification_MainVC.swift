//
//  KeyboardNotification.swift
//  Omega_TT
//
//  Created by Oleg on 11.02.2022.
//

import UIKit


extension MainVC {
    
     func registeredKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHideShow),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func remoteKeyboardNitification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight.height / 2)
    }
    
    @objc private func keyboardHideShow() {
        scrollView.contentOffset = CGPoint.zero
    }
    
}

//MARK: Remove keyboard
extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
    
}
