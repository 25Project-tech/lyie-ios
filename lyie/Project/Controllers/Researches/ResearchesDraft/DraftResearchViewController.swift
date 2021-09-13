//
//  DraftResearchViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.02.2021.
//

import UIKit
import Foundation


protocol PopupsDraftResearchViewControllerDelegate {
    func dismiss()
}

class DraftResearchViewController: UIViewController {
    
    @IBOutlet weak var textLabbel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var text3: UILabel!
    @IBOutlet weak var text4: UILabel!
    @IBOutlet weak var text5: UILabel!
    @IBOutlet weak var text6: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    var popupsDraftResearchViewControllerDelegate: PopupsDraftResearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        popupsDraftResearchViewControllerDelegate?.dismiss()
    }

    func config() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var researchItem = ResearchProvider.researchs(for: user) {
//            textLabbel.text = researchItem.text1
//            descLabel.text = researchItem.text2
//            text3.text = researchItem.text3
//            text4.text = researchItem.text4
//            text5.text = researchItem.text5
//            text6.text = researchItem.text6
        }
    }
    
}
