//
//  SpecificQuestionAreaViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.01.2021.
//

import UIKit
import PopupDialog
import Parse

class SpecificQuestionAreaViewController: UIViewController, Localizable, Styleable, QuestionObserver, StudentEducationObserver {
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    @IBOutlet weak var rightBarButtonIcon: UIImageView!
    
    var popup: PopupDialog?
    
    func applyLanguage() {
        
    }
    
    func applyStyle() {
        
    }
    
    var mainEducation = ""
    var mainEducationValue = 0
    var mainEducationCellNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingStyle()
        startObservingLanguage()
        startObservingQuestions()
        startObservingStudentEducations()
        startObservingQuestions()
        config()
    }
    
    deinit {
        stopObservingStyle()
        stopObservingLanguage()
        stopObservingQuestions()
        stopObservingStudentEducations()
        stopObservingQuestions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.hidesBottomBarWhenPushed = false
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }
}

extension SpecificQuestionAreaViewController {
    
    func config() {
        
        logoView.backgroundColor = StyleManager.colors.white
        logoIcon.image = UIImage(named: "Dashboard/inovatim")
        logoView.makeShadow()
        shadowView.makeShadow()
        logoView.topBottomMakeShadow()
        
        self.tabBarController?.tabBar.backgroundColor = StyleManager.colors.white
        self.tabBarController?.tabBar.tintColor = StyleManager.colors.leftTitleColor
        myTableView.backgroundColor = StyleManager.colors.backgroundColor
        
        myTableView.register(UINib(nibName: MentorInfo.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: MentorInfo.reuseIdentifier)
        myTableView.register(UINib(nibName: "EducationCellForQuestion", bundle: nil), forCellReuseIdentifier: "EducationCellForQuestion")
        myTableView.register(UINib(nibName: "SpecificQuestionAreaCell", bundle: nil), forCellReuseIdentifier: "SpecificQuestionAreaCell")
        
    }
    
    func showAlertAns() {
        let customVC = TVPopupAlertViewController(nibName: "TVPopupAlertViewController", bundle: nil)
        customVC.tvDelegate = self
        customVC.textViewType = 2
        customVC.mainEducation = mainEducation
        customVC.mainEducationValue = mainEducationValue
        customVC.mainEducationCellNum = mainEducationCellNum
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func showAlertQues() {
        let customVC = TVPopupAlertViewController(nibName: "TVPopupAlertViewController", bundle: nil)
        customVC.tvDelegate = self
        customVC.textViewType = 1
        customVC.mainEducation = mainEducation
        customVC.mainEducationValue = mainEducationValue
        customVC.mainEducationCellNum = mainEducationCellNum
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
    
    
    func onDidChange(questions: [QuestionItem]) {
        let index = IndexPath(row: 2, section: 0)
        myTableView.reloadRows(at: [index], with: .automatic)
    }
    
    func onDidChange(studentEducations: [StudentEducationItem]) {
        myTableView.reloadData()
    }
    
}

extension SpecificQuestionAreaViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: MentorInfo = myTableView.dequeueReusableCell(withIdentifier: "MentorInfo", for: indexPath) as! MentorInfo
            configMentorCell(cell: cell)
            return cell
        case 1:
            let cell: EducationCellForQuestion = tableView.dequeueReusableCell(at: indexPath) as EducationCellForQuestion
            if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                if studentEducationItem.mainEducationCellNum > studentEducationItem.questionAreaCell {
                    cell.config(Education: .inovation, CellNumber: studentEducationItem.questionAreaCell, currentData: 100, goalData: 100, percentViewActive: true, completed: true)
                } else if studentEducationItem.mainEducationCellNum == studentEducationItem.questionAreaCell {
                    if studentEducationItem.currentEducationsCount != 0 {
                        if studentEducationItem.currentEducationNum == 0 {
                            let currentData = ((1 * 100) / studentEducationItem.currentEducationsCount)
                            cell.config(Education: .inovation, CellNumber: studentEducationItem.questionAreaCell, currentData: currentData, goalData: 100, percentViewActive: true, completed: true)
                        } else {
                            let currentData = ((studentEducationItem.currentEducationNum * 100) / studentEducationItem.currentEducationsCount)
                            cell.config(Education: .inovation, CellNumber: studentEducationItem.questionAreaCell, currentData: currentData, goalData: 100, percentViewActive: true, completed: true)
                        }
                    } else {
                        if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                            let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                            
                            let currentData = ((studentEducationItem.currentEducationNum * 100) / arrayCount)
                            cell.config(Education: .inovation, CellNumber: studentEducationItem.questionAreaCell, currentData: currentData, goalData: 100, percentViewActive: true, completed: true)
                        }
                    }
                    
                } else {
                    let currentData = 0
                    cell.config(Education: .inovation, CellNumber: studentEducationItem.questionAreaCell, currentData: currentData, goalData: 100, percentViewActive: true, completed: true)
                }
            } else {
                let currentData = 0
                cell.config(Education: .inovation, CellNumber: 0, currentData: currentData, goalData: 100, percentViewActive: true, completed: true)
            }
            return cell
                
        case 2:
            let cell: SpecificQuestionAreaCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(education: mainEducation, educationValue: mainEducationValue, educationCell: mainEducationCellNum)
            cell.alertTapAns = { cell in
                self.showAlertAns()
            }
            cell.alertTapQues = { cell in
                self.showAlertQues()
            }
            cell.selectionStyle = .none
            return cell
        default:
            let cell: MentorInfo = myTableView.dequeueReusableCell(withIdentifier: "MentorInfo", for: indexPath) as! MentorInfo
            configMentorCell(cell: cell)
            return cell
        }
    }
    
    func configMentorCell(cell: UITableViewCell) {
        cell.layoutIfNeeded()
        
        let controller: MentorInfoController = UIStoryboard.mentor.instantiateViewController()
        self.addChild(controller)
        cell.contentView.addSubview(controller.view)

        controller.view.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
        cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
        cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
        cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))

        controller.didMove(toParent: self)
        self.view.layoutIfNeeded()
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 170.0
        case 1:
            return 100.0
        case 2:
            return 520.0
        default:
            return 170.0
        }
        
    }
}

//MARK: - TVDelegate DELEGATE
extension SpecificQuestionAreaViewController: TVDelegate {
    
    func onChangeText(target: String) {}
    
    func onChangeText(ques: String) {
        self.myTableView.reloadData()
        popup?.dismiss()
    }
    
    func onChangeText(ans: String) {
        self.myTableView.reloadData()
        popup?.dismiss()
    }
    
    func onTVDismissed() {
        popup?.dismiss()
    }
}
