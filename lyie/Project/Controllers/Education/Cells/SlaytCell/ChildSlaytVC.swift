//
//  ChildSlaytVC.swift
//  lyie
//
//  Created by Sevcan Eşim on 31.03.2021.
//

import UIKit

class ChildSlaytVC: UIViewController {
    
    @IBOutlet weak var educationImage: UIImageView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    var pageIndex = 0
    var i = 0
    var childEducationIndex = 0
    var isHiddenValue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews(isHidden: isHiddenValue)
    }
    
    @IBAction func tappedFinishButton(_ sender: Any) {
        EducationController.studentEducationUpdate()
        buttonView.isHidden = true
        finishButton.isUserInteractionEnabled = false
        buttonView.isUserInteractionEnabled =  false
    }
    
}

//MARK: - HELPER METHODS
extension ChildSlaytVC {
    private func configViews(isHidden: Bool) {
        finishButton.setTitle("Devam Et", for: .normal)
        buttonView.backgroundColor = StyleManager.colors.leftTitleColor
        buttonView.cornerRadius = 10.0
        switch pageIndex {
        case i - 1:
            buttonView.isHidden = isHidden
            finishButton.isHidden = isHidden
            let x = i - 1
            getImage(x: x)
            
        default:
            buttonView.isHidden = true
            finishButton.isHidden = true
            let x = pageIndex
            getImage(x: x)
        }
    }
    
    func getImage(x: Int) {
        switch x {
        case 0:
            LyieUtils.loadImage(resource: educationImage, imageURL: EducationChildLessonsProvider.educationChildLessons().sorted(by: { $0.childId < $1.childId })[childEducationIndex].educationImageURL0, placeHolder: UIImage(named: "backgroundEdu"), isCircle: false)
        case 1:
            LyieUtils.loadImage(resource: educationImage, imageURL: EducationChildLessonsProvider.educationChildLessons().sorted(by: { $0.childId < $1.childId })[childEducationIndex].educationImageURL1, placeHolder: UIImage(named: "backgroundEdu"), isCircle: false)
        case 2:
            LyieUtils.loadImage(resource: educationImage, imageURL: EducationChildLessonsProvider.educationChildLessons().sorted(by: { $0.childId < $1.childId })[childEducationIndex].educationImageURL2, placeHolder: UIImage(named: "backgroundEdu"), isCircle: false)
        case 3:
            LyieUtils.loadImage(resource: educationImage, imageURL: EducationChildLessonsProvider.educationChildLessons().sorted(by: { $0.childId < $1.childId })[childEducationIndex].educationImageURL3, placeHolder: UIImage(named: "backgroundEdu"), isCircle: false)
        case 4:
            LyieUtils.loadImage(resource: educationImage, imageURL: EducationChildLessonsProvider.educationChildLessons().sorted(by: { $0.childId < $1.childId })[childEducationIndex].educationImageURL4, placeHolder: UIImage(named: "backgroundEdu"), isCircle: false)
        case 5:
            LyieUtils.loadImage(resource: educationImage, imageURL: EducationChildLessonsProvider.educationChildLessons().sorted(by: { $0.childId < $1.childId })[childEducationIndex].educationImageURL5, placeHolder: UIImage(named: "backgroundEdu"), isCircle: false)
        case 6:
            LyieUtils.loadImage(resource: educationImage, imageURL: EducationChildLessonsProvider.educationChildLessons().sorted(by: { $0.childId < $1.childId })[childEducationIndex].educationImageURL6, placeHolder: UIImage(named: "backgroundEdu"), isCircle: false)
        default:
            LyieUtils.loadImage(resource: educationImage, imageURL: EducationChildLessonsProvider.educationChildLessons().sorted(by: { $0.childId < $1.childId })[childEducationIndex].educationImageURL6, placeHolder: UIImage(named: "backgroundEdu"), isCircle: false)
        }
    }
}
