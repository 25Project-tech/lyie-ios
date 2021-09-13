//
//  UIViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit

extension UIViewController {
    
    func addChild(_ childController: UIViewController, to containerView: UIView) {
        guard let childView = childController.view else { return }
        addChild(childController)
        containerView.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            childView.topAnchor.constraint(equalTo: containerView.topAnchor),
            childView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            childView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        containerView.layoutIfNeeded()
        childController.didMove(toParent: self)
    }
    
    func removeFromParentFully() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func hasChild<T: UIViewController>(ofType type: T.Type) -> Bool {
        return indexOfChild(ofType: type) != nil
    }
    
    private func indexOfChild<T: UIViewController>(ofType type: T.Type) -> Int? {
        if let index = children.index(where: { $0 is T }) {
            return index
        } else {
            return nil
        }
    }
    
    func removeChild<T: UIViewController>(ofType type: T.Type) {
        if let index = indexOfChild(ofType: type) {
            children[index].removeFromParentFully()
        }
    }
    
    func BG(_ block: @escaping () -> Void) {
//        DispatchQueue.global(qos: .default).async(execute: block)
        DispatchQueue.background(delay: 0.1, background: block)
    }
    
    func UI(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }
}

// MARK: - DispatchQueue
extension DispatchQueue {
    static func background(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}


// MARK: - ONSUCCESS LOADING SPINNER
extension UIViewController {
    class func displayLayoutLoading(onView: UIView, backgroundColor: UIColor? = .clear) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = onView.backgroundColor
        let nav = UIActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        nav.style = .gray
        nav.color = StyleManager.colors.leftTitleColor
        nav.startAnimating()
        nav.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(nav)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    class func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

extension UIViewController {
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}

