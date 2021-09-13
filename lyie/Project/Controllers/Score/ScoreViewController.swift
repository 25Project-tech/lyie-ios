//
//  ScoreViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 26.12.2020.
//

import UIKit
import Parse

class ScoreViewController: UIViewController, Localizable, Styleable, HomeMentorObserver {
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    @IBOutlet weak var rightBarButtonIcon: UIImageView!
    
    func applyLanguage() {
        
    }
    
    func applyStyle() {
        
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeController.getData), name: NSNotification.Name("imageChanged"), object: nil)
        tabBarController?.hidesBottomBarWhenPushed = false
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func getData() {
        myTableView.reloadData()
    }
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {
        
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
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
    
    func onDidChange(mentors: [HomeMentorInfo]) {
        myTableView.reloadData()
    }
    
}

extension ScoreViewController {
    
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
        
        myTableView.register(UINib(nibName: HomeMentorCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: HomeMentorCell.reuseIdentifier)
        myTableView.register(UINib(nibName: ScoreListCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: ScoreListCell.reuseIdentifier)
    }
}



extension ScoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: HomeMentorCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(isHidden: false)
            cell.selectionStyle = .none
            cell.navigateScoreTapAction = { cell in
                self.navigateScoreVC()
            }
            cell.navigateProfileTapAction = { cell in
                self.navigateProfileVC()
            }
            cell.photoChangingTapAction = {cell in
                self.configureCameraActionSheet()
            }
            cell.navigateMentorTapAction = {cell in
                self.navigateMentorVC()
            }
            return cell
        case 1:
            let cell: ScoreListCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config()
            cell.selectionStyle = .none
            return cell
        default:
            let cell: HomeMentorCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(isHidden: false)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 375.0
        case 1:
            return 650.0
        default:
            return 690.0
        }
        
    }
}

extension ScoreViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
