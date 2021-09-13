//
//  HomeController.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit
import SideMenu
import PDFKit
import Parse

class HomeController: UIViewController, Localizable, Styleable, MenuControllerDelegate, HomeMentorObserver {
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    @IBOutlet weak var rightBarButtonIcon: UIImageView!
    
    private var sideMenu: SideMenuNavigationController?
    
    private let stocksAndIndicesController = StockAndIndices()
    private let risingStocksViewController = RisingStocksViewController()
    private let fallingStocksViewController = FallingStocksViewController()
    private let hacmeGore30ViewController = HacmeGore30ViewController()
    private let hacmeGore50ViewController = HacmeGore50ViewController()
    private let hacmeGore100ViewController = HacmeGore100ViewController()
    
    var index = 0
    var pdfIndex = 0
    var rowIndexPath = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingStyle()
        startObservingLanguage()
        startObservingHomeMentors()
        config()
    }
    
    deinit {
        stopObservingStyle()
        stopObservingLanguage()
        stopObservingHomeMentors()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeController.getData), name: NSNotification.Name("imageChanged"), object: nil)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func getData() {
        myTableView.reloadData()
    }
    
    func onDidChange(mentors: [HomeMentorInfo]) {
        myTableView.reloadData()
    }
    
    func applyLanguage() {}
    
    func applyStyle() {}
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {
        
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }
}

extension HomeController {
    
    func config() {
        
        if logoView != nil && logoIcon != nil && shadowView != nil && leftBarButtonIcon != nil && rightBarButtonIcon != nil && myTableView != nil {
//            logoView.backgroundColor = StyleManager.colors.white
            logoIcon.image = UIImage(named: "Dashboard/inovatim")
            logoView.makeShadow()
            shadowView.makeShadow()
            logoView.topBottomMakeShadow()
            leftBarButtonIcon.isHidden = true
            
//            self.tabBarController?.tabBar.backgroundColor = StyleManager.colors.white
            self.tabBarController?.tabBar.tintColor = StyleManager.colors.leftTitleColor
            myTableView.backgroundColor = StyleManager.colors.backgroundColor
            
            myTableView.register(UINib(nibName: HomeMentorCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: HomeMentorCell.reuseIdentifier)
            myTableView.register(UINib(nibName: HomeIndicator.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: HomeIndicator.reuseIdentifier)
            myTableView.register(UINib(nibName: HomeEducationCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: HomeEducationCell.reuseIdentifier)
            myTableView.register(UINib(nibName: ResearchesHomeCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: ResearchesHomeCell.reuseIdentifier)
            myTableView.register(UINib(nibName: HomeSpecialEducationCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: HomeSpecialEducationCell.reuseIdentifier)
            sideMenuConfig()
            
            LyieUtils.homeMentorCardUpdate {
                LyieUtils.profileProgressUpdate {
//                    if let user = UserDefaults.standard.string(forKey: currentUserKey), var infos = HomeMentorProvider.mentors(for: user) {
//                        let scoreObject = PFQuery(className: "UserScoreInfo")
//                        scoreObject.whereKey("userID", equalTo: PFUser.current()?.username)
//                        scoreObject.order(byDescending: "totalScore")
//                        scoreObject.getFirstObjectInBackground { (objc, error) in
//                            if error != nil {
//
//                            } else {
//                                if let objc = objc {
//                                    infos.totalScoreUser = "\(objc["totalScore"] as? Int ?? 0)"
//                                    print(objc["totalScore"] as? Int ?? 0)
//                                    HomeMentorProvider.update(mentors: infos)
//                                } else {
//
//                                }
//                            }
//                        }
//                    }
                }
            }
        }
    }
    
    func sideMenuConfig() {
        let menu = MenuController(with: SideMenuItem.allCases)
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
//        SideMenuManager.default.addPanGestureToPresent(toView: view)
        addChildControllers()
    }
    
    func addChildControllers() {
        addChild(stocksAndIndicesController)
        addChild(risingStocksViewController)
        addChild(fallingStocksViewController)
        addChild(hacmeGore30ViewController)
        addChild(hacmeGore50ViewController)
        addChild(hacmeGore100ViewController)

        view.addSubview(stocksAndIndicesController.view)
        view.addSubview(risingStocksViewController.view)
        view.addSubview(fallingStocksViewController.view)
        view.addSubview(hacmeGore30ViewController.view)
        view.addSubview(hacmeGore50ViewController.view)
        view.addSubview(hacmeGore100ViewController.view)

        stocksAndIndicesController.view.frame = view.bounds
        risingStocksViewController.view.frame = view.bounds
        fallingStocksViewController.view.frame = view.bounds
        hacmeGore30ViewController.view.frame = view.bounds
        hacmeGore50ViewController.view.frame = view.bounds
        hacmeGore100ViewController.view.frame = view.bounds

        stocksAndIndicesController.didMove(toParent: self)
        risingStocksViewController.didMove(toParent: self)
        fallingStocksViewController.didMove(toParent: self)
        hacmeGore30ViewController.didMove(toParent: self)
        hacmeGore50ViewController.didMove(toParent: self)
        hacmeGore100ViewController.didMove(toParent: self)

        stocksAndIndicesController.view.isHidden = true
        risingStocksViewController.view.isHidden = true
        fallingStocksViewController.view.isHidden = true
        hacmeGore30ViewController.view.isHidden = true
        hacmeGore50ViewController.view.isHidden = true
        hacmeGore100ViewController.view.isHidden = true
    }
    
    @IBAction func didTapMenuButton() {
        print("SideMenu")
//        present(sideMenu!, animated: true)
    }

    func didSelectMenuItem(named: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)

        title = named.rawValue
        switch named {
        case .cell1:
            stocksAndIndicesController.view.isHidden = false
            risingStocksViewController.view.isHidden = true
            fallingStocksViewController.view.isHidden = true
            hacmeGore30ViewController.view.isHidden = true
            hacmeGore50ViewController.view.isHidden = true
            hacmeGore100ViewController.view.isHidden = true
            
            
        case .cell2:
            stocksAndIndicesController.view.isHidden = true
            risingStocksViewController.view.isHidden = false
            fallingStocksViewController.view.isHidden = true
            hacmeGore30ViewController.view.isHidden = true
            hacmeGore50ViewController.view.isHidden = true
            hacmeGore100ViewController.view.isHidden = true
            

        case .cell3:
            stocksAndIndicesController.view.isHidden = true
            risingStocksViewController.view.isHidden = true
            fallingStocksViewController.view.isHidden = false
            hacmeGore30ViewController.view.isHidden = true
            hacmeGore50ViewController.view.isHidden = true
            hacmeGore100ViewController.view.isHidden = true
            
        case .cell4:
            stocksAndIndicesController.view.isHidden = true
            risingStocksViewController.view.isHidden = true
            fallingStocksViewController.view.isHidden = true
            hacmeGore30ViewController.view.isHidden = false
            hacmeGore50ViewController.view.isHidden = true
            hacmeGore100ViewController.view.isHidden = true
            
        case .cell5:
            stocksAndIndicesController.view.isHidden = true
            risingStocksViewController.view.isHidden = true
            fallingStocksViewController.view.isHidden = true
            hacmeGore30ViewController.view.isHidden = true
            hacmeGore50ViewController.view.isHidden = false
            hacmeGore100ViewController.view.isHidden = true
            
        case .cell6:
            stocksAndIndicesController.view.isHidden = true
            risingStocksViewController.view.isHidden = true
            fallingStocksViewController.view.isHidden = true
            hacmeGore30ViewController.view.isHidden = true
            hacmeGore50ViewController.view.isHidden = true
            hacmeGore100ViewController.view.isHidden = false
        }

    }
    
    func navigateScoreVC() {
        self.tabBarController?.selectedIndex = 4
    }
    
    func navigateProfileVC() {
        self.tabBarController?.selectedIndex = 1
    }
    
    func navigateMentorVC() {
        self.tabBarController?.selectedIndex = 3
    }
    
    func navigateEducationVC() {
        self.tabBarController?.selectedIndex = 2
    }
}

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: HomeMentorCell = tableView.dequeueReusableCell(at: indexPath)
            rowIndexPath = indexPath
            cell.config(isHidden: true)
            cell.selectionStyle = .none
            cell.navigateScoreTapAction = { cell in
                self.navigateScoreVC()
            }
            cell.navigateProfileTapAction = { cell in
                self.navigateProfileVC()
            }
            cell.photoChangingTapAction = {cell in
                cell.profilePic.tag = indexPath.row
                self.configureCameraActionSheet()
            }
            cell.navigateMentorTapAction = { cell in
                self.navigateMentorVC()
            }
            
            return cell
        case 1:
            let cell: HomeIndicator = tableView.dequeueReusableCell(at: indexPath)
            cell.config()
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell: HomeEducationCell = tableView.dequeueReusableCell(at: indexPath)
            cell.isMentor = true
            cell.config()
            cell.alertTapAction = { cell in
                self.navigateEducationVC()
            }
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell: HomeIndicator = tableView.dequeueReusableCell(at: indexPath)
            cell.config()
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell: ResearchesHomeCell = myTableView.dequeueReusableCell(withIdentifier: "ResearchesHomeCell", for: indexPath) as! ResearchesHomeCell
//            cell.layoutIfNeeded()
            
            let controller: HomeResearchesController = UIStoryboard.home.instantiateViewController()
            self.addChild(controller)
            cell.contentView.addSubview(controller.view)

            if let views = controller.view {
                views.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addConstraint(NSLayoutConstraint(item: views, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
                cell.contentView.addConstraint(NSLayoutConstraint(item: views, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
                cell.contentView.addConstraint(NSLayoutConstraint(item: views, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
                cell.contentView.addConstraint(NSLayoutConstraint(item: views, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: cell.contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
            }
            
            controller.didMove(toParent: self)
            cell.clipsToBounds = true
            self.view.layoutIfNeeded()
            cell.selectionStyle = .none
            
            return cell
        case 5:
            let cell: HomeIndicator = tableView.dequeueReusableCell(at: indexPath)
            cell.config()
            cell.selectionStyle = .none
            return cell
        case 6:
            let cell: HomeSpecialEducationCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config()
            cell.selectionStyle = .none
            return cell
        default:
            let cell: HomeMentorCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(isHidden: true)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 375.0
        case 1:
            return 10.0
        case 2:
            return 680.0
        case 3:
            return 10.0
        case 4:
            return 600.0
        case 5:
            return 10.0
        case 6:
            return 700.0
        default:
            return 690.0
        }
        
    }
}

extension HomeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    ///Present action sheet options gallery/camera
    func configureCameraActionSheet() {
        var alertStyle = UIAlertController.Style.actionSheet
        
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            let camera = UIAlertAction(title: "Fotoğraf Çek", style: .default) { action in
                self.openCamera()
            }
            let gallery = UIAlertAction(title: "Galeriden seç", style: .default) { action in
                self.openGallery()
            }
            
            actionSheet.addAction(camera)
            actionSheet.addAction(gallery)
            actionSheet.addAction(cancel)
            
            self.present(actionSheet, animated: true, completion: nil)
        } else {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            let camera = UIAlertAction(title: "Fotoğraf Çek", style: .default) { action in
                self.openCamera()
            }
            let gallery = UIAlertAction(title: "Galeriden seç", style: .default) { action in
                self.openGallery()
            }
            
            actionSheet.addAction(camera)
            actionSheet.addAction(gallery)
            actionSheet.addAction(cancel)
            
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    func openGallery() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let cell: HomeMentorCell = myTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! HomeMentorCell
            cell.profilePic.image = image
            LyieUtils.uploadProfilePic(image: image, cell: cell.profilePic)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "imageChanged"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
}

