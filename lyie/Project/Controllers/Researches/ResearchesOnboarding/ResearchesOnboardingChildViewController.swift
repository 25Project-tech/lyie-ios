//
//  ResearchesOnboardingChildViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.02.2021.
//

import UIKit

class ResearchesOnboardingChildViewController: UIViewController {
    
    @IBOutlet weak var onboardingTitle: UILabel!
    @IBOutlet weak var onboardingDescription: UILabel!
    @IBOutlet weak var onboardIcon: UIImageView!
    @IBOutlet weak var tappedSkipButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var index = 0
    var researchStep = [ResearchType]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        tappedSkipButton.setTitle("ATLA", for: .normal)
        finishButton.setTitle("TAMAM", for: .normal)
        self.researchStep = [.step1, .step2, .step3, .step4, .step5, .step6]
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func skipButton(_ sender: Any) {
        let controller: ResearchesDraftPagerController = UIStoryboard.researches.instantiateViewController()
        controller.configureResearchDraft(with: self.researchStep)
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @IBAction func tappedFinishButton(_ sender: Any) {
        let controller: ResearchesDraftPagerController = UIStoryboard.researches.instantiateViewController()
        controller.configureResearchDraft(with: self.researchStep)
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
}

//MARK: - HELPER METHODS
extension ResearchesOnboardingChildViewController {
    
    private func configViews() {
        var title = ""
        var desc = ""
        var image: UIImage!
        switch index {
        case 0:
            finishButton.isHidden = true
            image = UIImage(named: "Researches/research")
            title = "ADIM 1"
            desc = "AÇIKLAMA"
        case 1:
            finishButton.isHidden = true
            image = UIImage(named: "Researches/research")
            title = "ADIM 2"
            desc = "AÇIKLAMA"
        case 2:
            finishButton.isHidden = true
            image = UIImage(named: "Researches/research")
            title = "ADIM 3"
            desc = "AÇIKLAMA"
        case 3:
            finishButton.isHidden = true
            image = UIImage(named: "Researches/research")
            title = "ADIM 4"
            desc = "AÇIKLAMA"
        case 4:
            finishButton.isHidden = true
            image = UIImage(named: "Researches/research")
            title = "ADIM 5"
            desc = "AÇIKLAMA"
        case 5:
            finishButton.isHidden = false
            image = UIImage(named: "Researches/research")
            title = "ADIM 6"
            desc = "AÇIKLAMA"
        default:
            print("default")
        }
        onboardIcon.image = image
        onboardingTitle.text = title
        onboardingDescription.text = desc
    }
    
    private func proceedToScale() {
        UserDefaults.standard.set(true, forKey: "isScaleOnboardShown")
        self.dismiss(animated: true, completion: nil)
    }
}


