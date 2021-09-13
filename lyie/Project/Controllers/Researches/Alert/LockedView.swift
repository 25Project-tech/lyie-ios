//
//  LockedView.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.12.2020.
//

import UIKit
import PopupDialog

class LockedView: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var lockedButton: UIButton!
    
    var text1: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        text1 = "Bu eğitimler kilitli. 1500 PUAN karşılığında"
        textLabel.attributedText = text1.setAttributedString(changeText: "1500 PUAN", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
        buttonView.backgroundColor = .red
        buttonView.cornerRadius = 10.0
        lockedButton.setTitle("Şimdi Aç", for: .normal)
    }

    @objc func endEditing() {
        view.endEditing(true)
    }
    
    @IBAction func tappedButton(_ sender: Any) {
    }
    
}

