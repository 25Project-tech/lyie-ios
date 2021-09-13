//
//  AlertModel.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import PopupDialog
import UIKit

class AlertModelAPI {
    
    static var popup: PopupDialog?
    
    public static func showPopupsTwoButton(model: PopupsModel, vc: UIViewController, tapGestureDismissal: Bool) {
        let customVC: PopupsTwoButtonViewController = UIStoryboard.popups.instantiateViewController()
        customVC.alertContent = model
        customVC.popupsTwoButtonDelegate = vc as? PopupsTwoButtonViewControllerDelegate
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: tapGestureDismissal)
        vc.present(popup!, animated: true, completion: nil)
    }
    
    public static func showPopupsSingleButton(model: PopupsSingleButtonModel, vc: UIViewController, tapGestureDismissal: Bool) {
        let customVC: PopupsSingleButtonViewController = UIStoryboard.popups.instantiateViewController()
        customVC.alertContent = model
        customVC.popupsSingleButtonDelegate = vc as? PopupsSingleButtonViewControllerDelegate
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: tapGestureDismissal)
        vc.present(popup!, animated: true, completion: nil)
    }
    
    public static func showPopupsTitleOneButton(model: PopupsTitleOneButtonModel, vc: UIViewController, tapGestureDismissal: Bool) {
        let customVC: PopupsTitleOneButtonViewController = UIStoryboard.popups.instantiateViewController()
        customVC.alertContent = model
        customVC.popupsTitleOneButtonDelegate = vc as? PopupsTitleOneButtonViewControllerDelegate
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: tapGestureDismissal)
        vc.present(popup!, animated: true, completion: nil)
    }

    public static func showPopupsWithoutButton(model: PopupsWithoutButtonModel, vc: UIViewController, tapGestureDismissal: Bool) {
        let customVC: WithoutButtonVC = UIStoryboard.popups.instantiateViewController()
        customVC.alertContent = model
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: tapGestureDismissal)
        vc.present(popup!, animated: true, completion: nil)
    }
    
    public static func showPopupsKVKK(model: PopupsWithoutButtonModel, vc: UIViewController, tapGestureDismissal: Bool) {
        let customVC: ContractsVC = UIStoryboard.popups.instantiateViewController()
        customVC.alertContent = model
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: tapGestureDismissal)
        vc.present(popup!, animated: true, completion: nil)
    }
    
    public static func dismissPupup() {
        DispatchQueue.main.async(execute: {
            popup?.dismiss()
        })
    }
    
    public static func dismissPopups() {
        popup?.dismiss()
    }
    
    class func withoutButtonAlert(imageString: String, title: String, desc: String, vc: UIViewController) {
        AlertModelAPI.showPopupsWithoutButton(model: PopupsWithoutButtonModel(alertIcon: imageString, alertTitleText: title, alertDesc: desc), vc: vc, tapGestureDismissal: true)
    }

    class func oneButtonWithIconAlert(imageString: String, title: String, desc: String, buttonTitle: String, vc: UIViewController) {
        AlertModelAPI.showPopupsTitleOneButton(model: PopupsTitleOneButtonModel(alertIcon: imageString, alertTitleText: title, alertDesc: desc, alertButtonTitle: buttonTitle), vc: vc, tapGestureDismissal: true)
    }
    
    class func oneButtonAlert(title: String, desc: String, buttonTitle: String, vc: UIViewController) {
        AlertModelAPI.showPopupsSingleButton(model: PopupsSingleButtonModel(alertTitleText: title, alertButtonTitle: buttonTitle), vc: vc, tapGestureDismissal: true)
    }
    
    class func twoButtonAlert(image: UIImage, title: String, desc: String, acceptButtonTitle: String, cancelButtonTitle: String, vc: UIViewController) {
        AlertModelAPI.showPopupsTwoButton(model: PopupsModel(alertIcon: image, alertTitleText: title, alertDetailText: desc, alertAcceptButtonTitle: acceptButtonTitle, alertCancelButtonTitle: cancelButtonTitle), vc: vc, tapGestureDismissal: true)
    }
    
    class func kvkkAlert(imageString: String, title: String, desc: String, vc: UIViewController) {
        AlertModelAPI.showPopupsKVKK(model: PopupsWithoutButtonModel(alertIcon: imageString, alertTitleText: title, alertDesc: desc), vc: vc, tapGestureDismissal: true)
    }

}

