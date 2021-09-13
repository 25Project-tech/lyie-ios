//
//  ResearchesDraftFirstStepController.swift
//  lyie
//
//  Created by Sevcan Eşim on 20.02.2021.
//

import UIKit

class ResearchesDraftFirstStepController: ResearchesBaseController, Localizable, OnTapKeyboardHideable {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tvFirstView: UIView!
    @IBOutlet weak var firstTV: UITextView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var tvSecondView: UIView!
    @IBOutlet weak var secondTV: UITextView!
    
    private var keyboardHandler: KeyboardHandler?
    
    func applyLanguage() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingLanguage()
//        keyboardHandler = KeyboardHandler(with: scrollView, responders: [scrollView.subviews.first!])
        tvFirstView.borderColor = StyleManager.colors.borderColorBlue
        tvFirstView.borderWidth = 1.0
        tvFirstView.cornerRadius = 10.0
        tvSecondView.borderColor = StyleManager.colors.borderColorBlue
        tvSecondView.borderWidth = 1.0
        tvSecondView.cornerRadius = 10.0
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
        if (firstTV.text != "" && secondTV.text != "") {
//            if let user = UserDefaults.standard.string(forKey: currentUserKey) {
//                ResearchProvider.create(with: user)
//                if var researchItem = ResearchProvider.researchs(for: user) {
//                    researchItem.text1 = firstTV.text
//                    researchItem.text2 = secondTV.text
//                    ResearchProvider.update(researchs: researchItem)
//                }
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


extension ResearchesDraftFirstStepController {
    
}

