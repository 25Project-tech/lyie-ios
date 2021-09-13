//
//  MentorViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.12.2020.
//

import UIKit
import Parse

class MentorViewController: UIViewController, Localizable, Styleable, OnTapKeyboardHideable {
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    @IBOutlet weak var rightBarButtonIcon: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var keyboardHandler: KeyboardHandler?
    
    func applyLanguage() {}
    
    func applyStyle() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        startObservingStyle()
        startObservingLanguage()
        config()
        keyboardHandler = KeyboardHandler(with: scrollView, responders: [scrollView.subviews.first!])
    }
    
    deinit {
        stopObservingStyle()
        stopObservingLanguage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BG {
            self.UI {
                self.setupHideKeyboardOnTapRecognizer()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.hidesBottomBarWhenPushed = false
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {}
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }
    
    func createdRealmObj() {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) {
            let questionObject = PFQuery(className: "QuestionArea")
            questionObject.whereKey("classID", equalTo: userItem.classID)
            questionObject.findObjectsInBackground { (objc, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    if let objc = objc {
                        if QuestionProvider.questions().count != objc.count {
                            QuestionNotifier.shared.removeAll()
                            
                            for i in 0..<objc.count {
                                QuestionProvider.create(with: "\(i)")
                                if var questionItem = QuestionProvider.questions(for: "\(i)") {
                                    questionItem.mainEducationValue = objc[i]["mainEducationValue"] as? Int ?? 0
                                    questionItem.userID = objc[i]["userID"] as? String ?? ""
                                    questionItem.mainEducation = objc[i]["mainEducation"] as? String ?? ""
                                    questionItem.mainEducationCellNum = objc[i]["mainEducationCellNum"] as? Int ?? 0
                                    questionItem.question = objc[i]["questionDesc"] as? String ?? ""
                                    questionItem.userPhotoURL = objc[i]["userProfileURL"] as? String ?? ""
                                    QuestionProvider.update(questions: questionItem)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension MentorViewController {
    
    func config() {
        createdRealmObj()
        logoView.backgroundColor = StyleManager.colors.white
        logoIcon.image = UIImage(named: "Dashboard/inovatim")
        logoView.makeShadow()
        shadowView.makeShadow()
        logoView.topBottomMakeShadow()
        leftBarButtonIcon.isHidden = true
        
        self.tabBarController?.tabBar.backgroundColor = StyleManager.colors.white
        self.tabBarController?.tabBar.tintColor = StyleManager.colors.leftTitleColor
        myTableView.backgroundColor = StyleManager.colors.backgroundColor
        
        myTableView.register(UINib(nibName: MentorInfo.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: MentorInfo.reuseIdentifier)
        myTableView.register(UINib(nibName: HomeEducationCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: HomeEducationCell.reuseIdentifier)
        myTableView.register(UINib(nibName: MessageAreaCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: MessageAreaCell.reuseIdentifier)
    }
    
    func warning() {
        self.UI {
            AlertModelAPI.withoutButtonAlert(imageString: "Settings/complete", title: "Başarılı", desc: "Mesajınız mentore ulaştırıldı.", vc: self)
        }
    }
    
    func navigateSpecificCell() {
        self.UI {
            let controller: SpecificQuestionAreaViewController = UIStoryboard.mentor.instantiateViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension MentorViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: MentorInfo = myTableView.dequeueReusableCell(withIdentifier: "MentorInfo", for: indexPath) as! MentorInfo
            
            let controller: MentorInfoController = UIStoryboard.mentor.instantiateViewController()
            self.addChild(controller)
            cell.contentView.addSubview(controller.view)
            
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))

            controller.willMove(toParent: self)
            self.view.layoutIfNeeded()
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell: HomeEducationCell = tableView.dequeueReusableCell(at: indexPath)
            cell.isMentor = false
            cell.config()
            cell.alertTapAction = { cell in
                self.navigateSpecificCell()
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell: MessageAreaCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config()
            cell.tappedWithSendButton = { cell in
                self.warning()
            }
            
            cell.selectionStyle = .none
            return cell
        default:
            let cell: MentorInfo = myTableView.dequeueReusableCell(withIdentifier: "MentorInfo", for: indexPath) as! MentorInfo
            
            let controller: MentorInfoController = UIStoryboard.mentor.instantiateViewController()
            self.addChild(controller)
            cell.contentView.addSubview(controller.view)

            controller.view.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
            cell.contentView.addConstraint(NSLayoutConstraint(item: controller.view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))

            controller.willMove(toParent: self)
            self.view.layoutIfNeeded()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 170.0
        case 1:
            return 680.0
        case 2:
            return 650.0
        default:
            return 170.0
        }
    }
}


