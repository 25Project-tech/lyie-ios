//
//  EducationsCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 29.11.2020.
//

import UIKit

class EducationsCell: UITableViewCell {
    static let reuseIdentifier = "EducationsCell"
    
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
    @IBOutlet weak var lockIcon: UIView!
    
    func config(Education: EducationStep, CellNumber: Int, goalData: Int, percentViewActive: Bool, lockIconHidden: Bool, completed: Bool, isProfile: Bool) {
        configDetail(Education: Education, CellNumber: CellNumber, goalData: goalData, percentViewActive: percentViewActive, lockIconHidden: lockIconHidden, completed: completed, isProfile: isProfile)
        lockIcon.isHidden = !lockIconHidden
        backgroundTopView.backgroundColor = StyleManager.colors.backgroundColor
        cellTitle.isHidden = !percentViewActive
        cellDesc.isHidden = !percentViewActive
        educationCellTitle.isHidden = percentViewActive
        educationCellDesc.isHidden = percentViewActive
        circleProgressBarView.isHidden = !percentViewActive
    }
    
    
    func configDetail(Education: EducationStep, CellNumber: Int, goalData: Int, percentViewActive: Bool, lockIconHidden: Bool, completed: Bool, isProfile: Bool) {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if studentEducationItem.mainEducationCellNum > CellNumber {
                let currentData = 100
                CircularProgressBar.circularProgress(progressCircleBarView: self.circleProgressBarView, actualData: currentData, goalData: goalData, firstColor: StyleManager.colors.leftTitleColor)
                valueText.isHidden = false
                valueText.text = "\(currentData)"
                valueText.textColor = StyleManager.colors.leftTitleColor
            } else if studentEducationItem.mainEducationCellNum == CellNumber {
                if studentEducationItem.currentEducationsCount != 0 {
                    if studentEducationItem.currentEducationNum == 0 {
                        let currentData = ((1 * 100) / studentEducationItem.currentEducationsCount)
                        CircularProgressBar.circularProgress(progressCircleBarView: self.circleProgressBarView, actualData: currentData, goalData: goalData, firstColor: StyleManager.colors.leftTitleColor)
                        valueText.isHidden = false
                        valueText.text = "\(currentData)"
                        valueText.textColor = StyleManager.colors.leftTitleColor
                    } else {
                        let currentData = ((studentEducationItem.currentEducationNum * 100) / studentEducationItem.currentEducationsCount)
                        CircularProgressBar.circularProgress(progressCircleBarView: self.circleProgressBarView, actualData: currentData, goalData: goalData, firstColor: StyleManager.colors.leftTitleColor)
                        valueText.isHidden = false
                        valueText.text = "\(currentData)"
                        valueText.textColor = StyleManager.colors.leftTitleColor
                    }
                } else {
                    if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                        if EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == studentEducationItem.mainEducation }).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue }).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).count != 0 {
                            let arrayCount = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == studentEducationItem.mainEducation }).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue }).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).count
                            let currentData = ((studentEducationItem.currentEducationNum * 100) / arrayCount)
                            CircularProgressBar.circularProgress(progressCircleBarView: self.circleProgressBarView, actualData: currentData, goalData: goalData, firstColor: StyleManager.colors.leftTitleColor)
                            valueText.text = "\(currentData)"
                        } else {
                            let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                            if arrayCount != 0 {
                                let currentData = ((studentEducationItem.currentEducationNum * 100) / arrayCount)
                                CircularProgressBar.circularProgress(progressCircleBarView: self.circleProgressBarView, actualData: currentData, goalData: goalData, firstColor: StyleManager.colors.leftTitleColor)
                                valueText.text = "\(currentData)"
                            }
                        }
                        
                        valueText.isHidden = false
                        valueText.textColor = StyleManager.colors.leftTitleColor
                    }
                }
                
            } else {
                let currentData = 0
                CircularProgressBar.circularProgress(progressCircleBarView: self.circleProgressBarView, actualData: currentData, goalData: goalData, firstColor: StyleManager.colors.leftTitleColor)
                valueText.isHidden = false
                valueText.text = "\(currentData)"
                valueText.textColor = StyleManager.colors.leftTitleColor
            }
        }
        
        if Education == .inovation  {
            if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                if CellNumber > studentEducationItem.mainEducationCellNum {
                    lockIcon.isHidden = !lockIconHidden
                    valueText.isHidden = true
                    circleProgressBarView.isHidden = true
                } else {
                    lockIcon.isHidden = lockIconHidden
                    valueText.isHidden = false
                    circleProgressBarView.isHidden = false
                }
            } else {
                lockIcon.isHidden = !lockIconHidden
                valueText.isHidden = true
                circleProgressBarView.isHidden = true
            }
        } else {
            lockIcon.isHidden = lockIconHidden
            valueText.isHidden = true
            circleProgressBarView.isHidden = true
        }
        
        mainView.makeShadow()
        
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
