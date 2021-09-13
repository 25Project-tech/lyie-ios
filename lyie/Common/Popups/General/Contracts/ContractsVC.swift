//
//  ContractsVC.swift
//  lyie
//
//  Created by Sevcan Eşim on 8.05.2021.
//

import Foundation
import UIKit
import PDFKit
import UICheckbox_Swift

class ContractsVC: UIViewController {
    
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var checkBox: UICheckbox!
    @IBOutlet weak var approvalPrivacyPolicyLabel: UILabel!
    @IBOutlet weak var pdfView: PDFView!
    
    
    var alertContent: PopupsWithoutButtonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertTitleLabel.text = alertContent?.alertTitleText
        checkBoxConfig(radius: 10)
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: user) {
            checkBox.isSelected = newUserItem.approvedKVKK
        }
        config()
    }
    
    func checkBoxConfig(radius: Int) {
        checkBox.cornerRadius = CGFloat(radius)
        checkBox.isDividerHidden = true
        checkBox.borderWidth = 1.5
        checkBox.borderColor = StyleManager.colors.leftTitleColor
        checkBox.dividerColor = StyleManager.colors.leftTitleColor
        checkBox.tintColor = StyleManager.colors.leftTitleColor
    }
    
    @IBAction func onPrivacyTap(_ sender: Any) {
        LyieLog.mPrint("KVKKButtonTapped")
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) {
            newUserItem.approvedKVKK = !newUserItem.approvedKVKK
            NewUserProvider.update(users: newUserItem)
            checkBox.isSelected = newUserItem.approvedKVKK
//            privacyCheckBox.setSelected(newUserItem.approvedKVKK, animated: false)
        }
    }
    
    func config() {
        if let path = Bundle.main.path(forResource: "KVKK", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let pdfDocument = PDFDocument(url: url) {
                pdfView.autoScales = true
                pdfView.displayMode = .singlePageContinuous
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
                self.pdfView?.subviews[0].backgroundColor = .white
            }
        }
    }
}


