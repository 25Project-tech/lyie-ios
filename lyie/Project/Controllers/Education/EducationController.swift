//
//  EducationController.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit
import PopupDialog
import Parse

enum CellName: String {
    case firstEducationCell = "FirstEducationCell"
    case titleCell = "TitleCell"
    case textCell = "TextCell"
    case educationAllOfThemCell = "EducationAllOfThemCell"
    case videoCell = "VideoCell"
    case readingCell = "ReadingCell"
    case suggestionCell = "SuggestionCell"
    case imageCell = "ImageCell"
    case slaytCell = "SlaytCell"
    case questionCell = "QuestionCell"
    case pdfCell = "PDFCell"
    case completeCell = "CompleteCell"
}

class EducationController: UIViewController, Localizable, Styleable, StudentEducationObserver {
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    @IBOutlet weak var rightBarButtonIcon: UIImageView!
    
    var cellNameString = ""
    var cellHeight = CGFloat(0)
    var currentEducationPartIndex = 0
    var popup: PopupDialog?
    var scoreValue = 0
    var totalScore = 0
    
    func applyLanguage() {}
    
    func applyStyle() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingStyle()
        startObservingLanguage()
        startObservingStudentEducations()
        arrayUpdate()
        config()
    }
    
    deinit {
        stopObservingStyle()
        stopObservingLanguage()
        stopObservingStudentEducations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.hidesBottomBarWhenPushed = false
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {}
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }
    
    func onDidChange(studentEducations: [StudentEducationItem]) {
        update()
    }
    
    func update() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                if (education.rawValue == "Inovation") { //Servis içeriği db aktarıldığında düzenleenecektir.
                    currentEducationPartIndex = studentEducationItem.questionAreaCell
                }
            }
        }
        myTableView.reloadData()
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if studentEducationItem.mainEducationCellNum > studentEducationItem.questionAreaCell {
                myTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: true)
            } else {
                if studentEducationItem.mainEducationCellNum == studentEducationItem.currentCell {
                    myTableView.scrollToRow(at: IndexPath(row: studentEducationItem.currentEducationNum, section: 0), at: .middle, animated: true)
                } else {
                    myTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: true)
                }
            }
        }
    }
    
    func arrayUpdate() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            let arrayCount = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == studentEducationItem.mainEducation }).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue }).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).count
            studentEducationItem.currentEducationsCount = arrayCount
            StudentEducationProvider.update(studentEducations: studentEducationItem)
        }
        
    }
}

extension EducationController: VideoDelegate {
    func onDismiss() {
        UI {
            self.popup?.dismiss()
        }
    }
}

extension EducationController {
    func showView(animated: Bool = true, videoText: String, videoDesc: String, videoUrl: String) { //CASE 2
        let customVC = HorizontalViewController(nibName: "HorizontalViewController", bundle: nil)
        customVC.videoDelegate = EducationController()
        customVC.videoText = videoText
        customVC.videoDesc = videoDesc
        customVC.videoUrl = videoUrl
        popup = PopupDialog(viewController: customVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
        self.present(popup!, animated: true, completion: nil)
    }
}

extension EducationController {
    
    func config() {
        logoView.backgroundColor = StyleManager.colors.white
        logoIcon.image = UIImage(named: "Dashboard/inovatim")
        logoView.makeShadow()
        shadowView.makeShadow()
        logoView.topBottomMakeShadow()
        leftBarButtonIcon.isHidden = true
        
        self.tabBarController?.tabBar.backgroundColor = StyleManager.colors.white
        self.tabBarController?.tabBar.tintColor = StyleManager.colors.leftTitleColor
        myTableView.backgroundColor = StyleManager.colors.backgroundColor
        
        myTableView.register(UINib(nibName: FirstEducationCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FirstEducationCell.reuseIdentifier)
        myTableView.register(UINib(nibName: TitleCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TitleCell.reuseIdentifier)
        myTableView.register(UINib(nibName: TextCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TextCell.reuseIdentifier)
        myTableView.register(UINib(nibName: EducationAllOfThemCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: EducationAllOfThemCell.reuseIdentifier)
        myTableView.register(UINib(nibName: VideoCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: VideoCell.reuseIdentifier)
        myTableView.register(UINib(nibName: ReadingCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ReadingCell.reuseIdentifier)
        myTableView.register(UINib(nibName: SuggestionCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SuggestionCell.reuseIdentifier)
        myTableView.register(UINib(nibName: ImageCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ImageCell.reuseIdentifier)
        myTableView.register(UINib(nibName: SlaytCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SlaytCell.reuseIdentifier)
        myTableView.register(UINib(nibName: QuestionCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: QuestionCell.reuseIdentifier)
        myTableView.register(UINib(nibName: PDFCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PDFCell.reuseIdentifier)
        myTableView.register(UINib(nibName: CompleteCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CompleteCell.reuseIdentifier)
        
        update()
    }
}

extension EducationController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if studentEducationItem.mainEducationCellNum > studentEducationItem.questionAreaCell {
                return EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == studentEducationItem.mainEducation }).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue }).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).count
            } else {
                if studentEducationItem.currentEducationNum == 0 {
                    return 1
                } else {
                    return studentEducationItem.currentEducationNum + 1
                }
            }
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        default:
            return configHeight(indexPathCell: indexPath.row)
        }
    }
    
    func configHeight(indexPathCell: Int) -> CGFloat {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            let cellArray = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == studentEducationItem.mainEducation}).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })
            
            if indexPathCell > cellArray.count {
            } else {
                cellHeight = CGFloat(EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == studentEducationItem.mainEducation}).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPathCell].cellHeight)
            }
        }
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var mainCell = UITableViewCell()
        switch indexPath.row {
        default:
            if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                
                let titleString = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].title
                let descString = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].descText
                let imageString = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].educationImageURL
                let cellString = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].type
                let cellCount = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].navigateCount
                let childID = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].childId
                let videoUrl = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].videoUrl
                let cellId = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].childId
                let leftValue = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].leftValue
                let rightValue = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].rightValue
                let leftText = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].leftText
                let rightText = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == "Inovation"}).filter({ $0.mainEducationValue == 101}).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).sorted(by: { $0.childCellNum < $1.childCellNum })[indexPath.row].rightText
                
                if indexPath.row == studentEducationItem.currentEducationNum  {
                    if studentEducationItem.mainEducationCellNum > studentEducationItem.questionAreaCell {
                        mainCell = configName(cellNameString: CellName(rawValue: cellString)!, indexPath: indexPath, title: titleString, desc: descString, imageString: imageString, isHidden: true, horizontalViewIsHidden: false, count: cellCount, index: childID, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftValue, rightButtonValue: rightValue, leftButtonText: leftText, rightButtonText: rightText)
                    } else {
                        mainCell = configName(cellNameString: CellName(rawValue: cellString)!, indexPath: indexPath, title: titleString, desc: descString, imageString: imageString, isHidden: false, horizontalViewIsHidden: true, count: cellCount, index: childID, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftValue, rightButtonValue: rightValue, leftButtonText: leftText, rightButtonText: rightText)
                    }
                    
                } else {
                    mainCell = configName(cellNameString: CellName(rawValue: cellString)!, indexPath: indexPath, title: titleString, desc: descString, imageString: imageString, isHidden: true, horizontalViewIsHidden: false, count: cellCount, index: childID, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftValue, rightButtonValue: rightValue, leftButtonText: leftText, rightButtonText: rightText)
                }
                
            } else {
                let cell: FirstEducationCell = myTableView.dequeueReusableCell(withIdentifier: "FirstEducationCell", for: indexPath) as! FirstEducationCell
                cell.config()
                cell.selectionStyle = .none
                mainCell = cell
            }
        }
        return mainCell
    }
    
    
    
    func configName(cellNameString: CellName, indexPath: IndexPath, title: String, desc: String, imageString: String, isHidden: Bool, horizontalViewIsHidden: Bool, count: Int, index: Int, videoUrl: String, cellId: Int, leftButtonValue: Bool, rightButtonValue: Bool, leftButtonText: String, rightButtonText: String) -> UITableViewCell {
        switch cellNameString {
        case .firstEducationCell:
            let cell: FirstEducationCell = myTableView.dequeueReusableCell(withIdentifier: "FirstEducationCell", for: indexPath) as! FirstEducationCell
            cell.config()
            cell.selectionStyle = .none
            return cell
        case .titleCell:
            let cell: TitleCell = myTableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
            cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText)
            cell.allButtonTapAction = { cell in
                let controller: EducationPDFController = UIStoryboard.education.instantiateViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            }
            cell.selectionStyle = .none
            return cell
        case .textCell:
            let cell: TextCell = myTableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText)
            cell.allButtonTapAction = { cell in
                EducationController.studentEducationUpdate()
            }
            cell.selectionStyle = .none
            return cell
        case .educationAllOfThemCell:
            let cell: EducationAllOfThemCell = myTableView.dequeueReusableCell(withIdentifier: "EducationAllOfThemCell", for: indexPath) as! EducationAllOfThemCell
            cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText)
            cell.allButtonTapAction = { cell in
                EducationController.studentEducationUpdate()
            }
            cell.selectionStyle = .none
            return cell
        case .videoCell:
            let cell: VideoCell = myTableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
            cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText)
            cell.allButtonTapAction = { cell in
                EducationController.studentEducationUpdate()
            }
            cell.navigateBButtonTapAction = { cell in
                self.showView(videoText: leftButtonText, videoDesc: rightButtonText, videoUrl: videoUrl)
            }
            cell.selectionStyle = .none
            return cell
        case .readingCell:
            let cell: ReadingCell = myTableView.dequeueReusableCell(withIdentifier: "ReadingCell", for: indexPath) as! ReadingCell
            cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText)
            cell.allButtonTapAction = { cell in
                EducationController.studentEducationUpdate()
            }
            cell.selectionStyle = .none
            return cell
        case .suggestionCell:
            let cell: SuggestionCell = myTableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as! SuggestionCell
            cell.config()
            cell.selectionStyle = .none
            return cell
        case .imageCell:
            let cell: ImageCell = myTableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText)
            cell.allButtonTapAction = { cell in
                EducationController.studentEducationUpdate()
            }
            cell.selectionStyle = .none
            return cell
        case .slaytCell:
            let cell: SlaytCell = myTableView.dequeueReusableCell(withIdentifier: "SlaytCell", for: indexPath) as! SlaytCell
            cell.layoutIfNeeded()
            
            let controller: ParentSlaytController = UIStoryboard.education.instantiateViewController()
            controller.pageCountValue = count
            controller.childEducationIndex = index
            controller.isHiddenValue = isHidden
            self.addChild(controller)
            cell.contentView.addSubview(controller.view)

            controller.view.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))

            controller.didMove(toParent: self)
            controller.view.layoutIfNeeded()
            cell.selectionStyle = .none
            return cell
        case .questionCell:
            let cell: QuestionCell = myTableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
            cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText)
            cell.tappedLeftButton = { cell in
                if leftButtonValue == true {
                    cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText, leftButtonColor: UIColor.green, rightButtonColor: UIColor.clear)
                } else {
                    cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText, leftButtonColor: UIColor.red, rightButtonColor: UIColor.green)
                }
                self.navigateAfterQuestion()
            }
            
            cell.tappedRightButton = { cell in
                if rightButtonValue == true {
                    cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText, leftButtonColor: UIColor.clear, rightButtonColor: UIColor.green)
                } else {
                    cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText, leftButtonColor: UIColor.green, rightButtonColor: UIColor.red)
                }
                self.navigateAfterQuestion()
            }
            cell.selectionStyle = .none
            return cell
        case .pdfCell:
            let cell: PDFCell = myTableView.dequeueReusableCell(withIdentifier: "PDFCell", for: indexPath) as! PDFCell
            cell.config(titleString: title, desc: desc, imageName: imageString, isHidden: isHidden, horizontalViewIsHidden: horizontalViewIsHidden, count: count, indexRow: index, videoUrl: videoUrl, cellId: cellId, leftButtonValue: leftButtonValue, rightButtonValue: rightButtonValue, leftButtonText: leftButtonText, rightButtonText: rightButtonText)
            cell.allButtonTapAction = { cell in
                self.navigateSpecificCell()
            }
            cell.selectionStyle = .none
            return cell
        case .completeCell:
            let cell: CompleteCell = myTableView.dequeueReusableCell(withIdentifier: "CompleteCell", for: indexPath) as! CompleteCell
            cell.config()
            cell.navigateTapAction = { cell in
                if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                    let cellArray = EducationMainLessonsProvider.educationMainLessons().filter({ $0.type == "CompleteCell"}).filter({ $0.mainEducation == studentEducationItem.mainEducation}).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue}).filter({ $0.mainEducationCellNum == studentEducationItem.mainEducationCellNum}).filter({ $0.childCellNum == studentEducationItem.currentEducationNum})
                    if cellArray.count > 0 {
                        if studentEducationItem.currentEducationNum == cellArray[0].childCellNum {
                            EducationController.studentEducationUpdate()
                        }
                    }
                }
                self.tabBarController?.selectedIndex = 0
            }
            return cell
        default:
            let cell: FirstEducationCell = myTableView.dequeueReusableCell(at: indexPath)
            cell.config()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func navigateSpecificCell() {
        self.UI {
            let controller: EducationPDFController = UIStoryboard.education.instantiateViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    class func studentEducationUpdate() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if studentEducationItem.questionAreaCell == studentEducationItem.mainEducationCellNum {
                if studentEducationItem.currentEducationsCount == studentEducationItem.currentEducationNum + 1 {
                    if EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == studentEducationItem.mainEducation }).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue }).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell + 1}).count != 0 {
                        newPart()
                        EducationController().scoreValue = 100
                        completeCellUpdate(partTitle: "")
                    }
                } else {
                    if studentEducationItem.currentEducationNum + 1 == studentEducationItem.currentEducationsCount {
                        if EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == studentEducationItem.mainEducation }).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue }).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell + 1}).count != 0 {
                            newPart()
                            EducationController().scoreValue = 100
                            completeCellUpdate(partTitle: "")
                        }
                    } else {
                        updateMechanismCurrentEducationNum()
                    }
                }
            } else {
                updateMechanismCurrentEducationNum()
            }
            
            LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId:  PFUser.current()?.objectId ?? "", userID: PFUser.current()?.username ?? "", education101iotNum: studentEducationItem.education101iotNum, education101aiNum: studentEducationItem.education101aiNum, education101inoNum: studentEducationItem.education101inoNum, mainEducation: studentEducationItem.mainEducation, mainEducationValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum, currentEducationNum: studentEducationItem.currentEducationNum, currentEducationsCount: LyieUtils.objectCountValue(), currentCell: studentEducationItem.currentCell, questionAreaCell: studentEducationItem.currentCell, questionAreaMainEdu: studentEducationItem.mainEducation, questionAreaMainValue: studentEducationItem.mainEducationValue))
        }
    }
    
    class func completeCellUpdate(partTitle: String) {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if let currentUser = PFUser.current() {
                let query = PFQuery(className: "UserScoreInfo")
                query.countObjectsInBackground { (count, error) in
                    if count != 0 {
                        query.whereKey("totalScore", greaterThan: 0)
                        query.findObjectsInBackground { (objects, error) in
                            if let objects = objects {
                                if objects.count > 0 {
                                    if objects.last!["totalScore"] != nil {
                                        EducationController().totalScore = objects.last!["totalScore"] as! Int
                                        LyieUtils.scoreDetailPart(scoreDetail: UserScoreModel(objectId: currentUser.objectId ?? "", userID: currentUser.username!, scoreDesc: "\(studentEducationItem.mainEducation) - 101 - \(partTitle) bölüm tamamlandı.", scoreValue: EducationController().scoreValue, totalScore: EducationController().totalScore + EducationController().scoreValue))
                                    }
                                } else {
                                    LyieUtils.scoreDetailPart(scoreDetail: UserScoreModel(objectId: currentUser.objectId ?? "", userID: currentUser.username!, scoreDesc: "\(studentEducationItem.mainEducation) - 101 - \(partTitle) bölüm tamamlandı.", scoreValue: EducationController().scoreValue, totalScore: EducationController().scoreValue))
                                }
                            }
                        }
                    } else {
                        LyieUtils.scoreDetailPart(scoreDetail: UserScoreModel(objectId: currentUser.objectId ?? "", userID: currentUser.username!, scoreDesc: "\(studentEducationItem.mainEducation) - 101 - \(partTitle) bölüm tamamlandı.", scoreValue: EducationController().scoreValue, totalScore: EducationController().scoreValue))
                    }
                }
            }
        }
    }
    
    class func updateMechanismCurrentCell() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            studentEducationItem.currentCell = studentEducationItem.currentCell + 1
            StudentEducationProvider.update(studentEducations: studentEducationItem)
        }
    }
    
    class func updateMechanismCurrentEducationNum() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            studentEducationItem.currentEducationNum = studentEducationItem.currentEducationNum + 1
            StudentEducationProvider.update(studentEducations: studentEducationItem)
        }
    }
    
    class func newPart() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            studentEducationItem.currentEducationNum = 0
            studentEducationItem.mainEducationCellNum = studentEducationItem.mainEducationCellNum + 1
            studentEducationItem.currentCell = studentEducationItem.currentCell + 1
            studentEducationItem.questionAreaCell = studentEducationItem.questionAreaCell + 1
            if EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == studentEducationItem.mainEducation }).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue }).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).count != 0 {
                let arrayCount = EducationMainLessonsProvider.educationMainLessons().filter({ $0.mainEducation == studentEducationItem.mainEducation }).filter({ $0.mainEducationValue == studentEducationItem.mainEducationValue }).filter({ $0.mainEducationCellNum == studentEducationItem.questionAreaCell}).count
                studentEducationItem.currentEducationsCount = arrayCount
                StudentEducationProvider.update(studentEducations: studentEducationItem)
            } else {
                StudentEducationProvider.update(studentEducations: studentEducationItem)
            }
        }
    }
    
    func navigateAfterQuestion() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
            if (studentEducationItem.mainEducationCellNum == 0 && studentEducationItem.currentEducationNum == 9) || (studentEducationItem.mainEducationCellNum == 1 && studentEducationItem.currentEducationNum == 2) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    EducationController.studentEducationUpdate()
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                EducationController.studentEducationUpdate()
            }
        }
    }
}
