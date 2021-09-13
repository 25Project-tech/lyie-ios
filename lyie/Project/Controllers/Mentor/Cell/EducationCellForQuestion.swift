//
//  EducationCellForQuestion.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.02.2021.
//

import UIKit

class EducationCellForQuestion: UITableViewCell {
    
    static let reuseIdentifier = "EducationCellForQuestion"
    
    @IBOutlet weak var cellPhoto: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDesc: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var valueText: UILabel!
    @IBOutlet weak var educationCellTitle: UILabel!
    @IBOutlet weak var educationCellDesc: UILabel!
    @IBOutlet weak var circleProgressBarView: KDCircularProgress! {
        didSet {
            circleProgressBarView.trackColor = .clear
        }
    }
    @IBOutlet var backgroundTopView: UIView!
    
    func config(Education: EducationStep, CellNumber: Int, currentData: Int, goalData: Int, percentViewActive: Bool, completed: Bool) {
        configDetail(Education: Education, CellNumber: CellNumber, currentData: currentData, goalData: goalData, percentViewActive: percentViewActive, completed: completed)
        backgroundTopView.backgroundColor = StyleManager.colors.backgroundColor
        cellTitle.isHidden = !percentViewActive
        cellDesc.isHidden = !percentViewActive
        educationCellTitle.isHidden = percentViewActive
        educationCellDesc.isHidden = percentViewActive
        circleProgressBarView.isHidden = !percentViewActive
    }
    
    
    func configDetail(Education: EducationStep, CellNumber: Int, currentData: Int, goalData: Int, percentViewActive: Bool,  completed: Bool) {
        mainView.makeShadow()
        if completed {
            CircularProgressBar.circularProgress(progressCircleBarView: self.circleProgressBarView, actualData: currentData, goalData: goalData, firstColor: StyleManager.colors.leftTitleColor)
            let val = (currentData * 100) / goalData
            valueText.isHidden = false
            valueText.text = "\(val)"
            valueText.textColor = StyleManager.colors.leftTitleColor
        } else {
            if CellNumber != 0 {
                valueText.isHidden = true
                circleProgressBarView.isHidden = true
            } else {
                CircularProgressBar.circularProgress(progressCircleBarView: self.circleProgressBarView, actualData: currentData, goalData: goalData, firstColor: StyleManager.colors.leftTitleColor)
                let val = (currentData * 100) / goalData
                valueText.isHidden = false
                valueText.text = "\(val)"
                valueText.textColor = StyleManager.colors.leftTitleColor
            }
        }
        
        self.cellTitle.text = EducationChildCoursesProvider.educationChildCourses().filter({ $0.mainEducation == Education.rawValue }).filter({ $0.mainEducationValue == 101 }).sorted { $0.courseId < $1.courseId }[CellNumber].title
        self.cellDesc.text = EducationChildCoursesProvider.educationChildCourses().filter({ $0.mainEducation == Education.rawValue }).filter({ $0.mainEducationValue == 101 }).sorted { $0.courseId < $1.courseId }[CellNumber].descText
        
//        let imageURLString = EducationChildCoursesProvider.educationChildCourses().filter({ $0.mainEducation == Education.rawValue }).filter({ $0.mainEducationValue == 101 }).sorted { $0.courseId < $1.courseId }[CellNumber].imageURL
        let imageURLString = ""
        LyieUtils.loadImage(resource: cellPhoto, imageURL: imageURLString, placeHolder: UIImage(named: EducationsService.getList(by: Education, mainEduValue: 101)[CellNumber].imageString), isCircle: false)
        
        cellTitle.textColor = StyleManager.colors.leftTitleColor
        educationCellTitle.textColor = StyleManager.colors.leftTitleColor
        educationCellTitle.text = cellTitle.text
        educationCellDesc.text = cellDesc.text
        cellTitle.isHidden = !percentViewActive
        cellDesc.isHidden = !percentViewActive
        educationCellTitle.isHidden = percentViewActive
        educationCellDesc.isHidden = percentViewActive
        circleProgressBarView.isHidden = !percentViewActive
    }
}

