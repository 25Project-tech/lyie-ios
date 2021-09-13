//
//  CommonPopupAlert.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.12.2020.
//

import UIKit
  
protocol AlertPopupViewDelegate {
    func alertAccept()
    func alertCancel()
    func firstTapped()
    func secondTapped()
    func thirdTapped()
    func closeTapped()
}
 
class AlertPopupView {
    var title: String
    var description: String
    var alertIcon: UIImage
    var cancelBtnTitle: String
    var acceptBtnTitel: String
    var cancelBtnBackColor: UIColor
    var acceptBtnBackColor: UIColor
    var alertBackViewColor: UIColor
    
    required init(title: String, description: String, alertIcon: UIImage, cancelBtnTitle: String, acceptBtnTitel: String, cancelBtnBackColor: UIColor, acceptBtnBackColor: UIColor, alertBackViewColor: UIColor) {
        self.title = title
        self.description = description
        self.alertIcon = alertIcon
        self.cancelBtnTitle = cancelBtnTitle
        self.acceptBtnTitel = acceptBtnTitel
        self.cancelBtnBackColor = cancelBtnBackColor
        self.acceptBtnBackColor = acceptBtnBackColor
        self.alertBackViewColor = alertBackViewColor
    }
}
