//
//  ResearchesDraftThirdStepController.swift
//  lyie
//
//  Created by Sevcan Eşim on 20.02.2021.
//

import UIKit

class ResearchesDraftThirdStepController: ResearchesBaseController, Localizable, OnTapKeyboardHideable {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    
    func applyLanguage() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingLanguage()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UINib(nibName: "EducationCellForQuestion", bundle: nil), forCellReuseIdentifier: "EducationCellForQuestion")
//        keyboardHandler = KeyboardHandler(with: scrollView, responders: [scrollView.subviews.first!])
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
        registerWizardListenerForProfileUpdate.onNextStage()
    }
    
    func newInstance(registerWizardListenerForProfileUpdate: RegisterWizardListenerForProfileUpdate) {
        self.registerWizardListenerForProfileUpdate = registerWizardListenerForProfileUpdate
    }
}


extension ResearchesDraftThirdStepController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EducationCellForQuestion = tableView.dequeueReusableCell(at: indexPath) as EducationCellForQuestion
        cell.config(Education: .inovation, CellNumber: indexPath.row, currentData: 100, goalData: 100, percentViewActive: true, completed: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
        
    }
    
}


