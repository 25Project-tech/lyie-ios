//
//  OnTapKeyboardHideable.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit

@objc protocol OnTapKeyboardHideable: class {
    
    @objc func hideKeyboard()
}

extension OnTapKeyboardHideable {
    
    func setupHideKeyboardOnTapRecognizer(in view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

extension OnTapKeyboardHideable where Self: UIViewController {
    
    func setupHideKeyboardOnTapRecognizer() { setupHideKeyboardOnTapRecognizer(in: view) }
}

extension UIViewController {
    
    @objc func hideKeyboard() { view.endEditing(true) }
}
