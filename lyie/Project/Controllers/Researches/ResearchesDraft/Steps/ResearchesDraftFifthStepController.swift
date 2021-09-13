//
//  ResearchesDraftFifthStepController.swift
//  lyie
//
//  Created by Sevcan Eşim on 20.02.2021.
//

import UIKit

class ResearchesDraftFifthStepController: ResearchesBaseController, Localizable, OnTapKeyboardHideable {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tvFirstView: UIView!
    @IBOutlet weak var firstTV: UITextView!
    
    private var keyboardHandler: KeyboardHandler?
    
    func applyLanguage() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingLanguage()
//        keyboardHandler = KeyboardHandler(with: scrollView, responders: [scrollView.subviews.first!])
        tvFirstView.borderColor = StyleManager.colors.borderColorBlue
        tvFirstView.borderWidth = 1.0
        tvFirstView.cornerRadius = 10.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BG {
            self.UI {
                self.setupHideKeyboardOnTapRecognizer()
            }
        }
    }

    @IBAction func continueButtonTapped(_ sender: Any) {
        if (firstTV.text != "") {
//            if let user = UserDefaults.standard.string(forKey: currentUserKey), var researchItem = ResearchProvider.researchs(for: user) {
//                researchItem.text5 = firstTV.text
//                ResearchProvider.update(researchs: researchItem)
//            }
            registerWizardListenerForProfileUpdate.onNextStage()
        } else {
            self.errorWarning(titleText: "Hata", des: "Alanlar boş bırakılamaz.")
        }
    }
    
    func newInstance(registerWizardListenerForProfileUpdate: RegisterWizardListenerForProfileUpdate) {
        self.registerWizardListenerForProfileUpdate = registerWizardListenerForProfileUpdate
    }
    
    func errorWarning(titleText: String, des: String) {
        self.UI {
            AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: titleText, desc: des, vc: self)
        }
    }
}


extension ResearchesDraftFifthStepController {
    
}




