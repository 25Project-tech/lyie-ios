//
//  EducationAllOfThemVC.swift
//  lyie
//
//  Created by Sevcan Eşim on 8.01.2021.
//

import UIKit

class EducationAllOfThemVC: UIViewController {
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!

    var titleString = ""
    var descString = ""
    var imageName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoView.backgroundColor = StyleManager.colors.white
        logoIcon.image = UIImage(named: "Dashboard/inovatim")
        logoView.makeShadow()
        shadowView.makeShadow()
        logoView.topBottomMakeShadow()
        
        self.tabBarController?.tabBar.backgroundColor = StyleManager.colors.white
        self.tabBarController?.tabBar.tintColor = StyleManager.colors.leftTitleColor
        myTableView.backgroundColor = StyleManager.colors.backgroundColor
        
        myTableView.register(UINib(nibName: EducationAllOfThemCell.reuseIdentifier, bundle: nil) , forCellReuseIdentifier: EducationAllOfThemCell.reuseIdentifier)
        myTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tappedLeftBarButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        LyieUtils.configureLogOutActionSheet(view: self)
    }
}

extension EducationAllOfThemVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        default:
            let cell: EducationAllOfThemCell = tableView.dequeueReusableCell(at: indexPath)
            cell.config(titleString: titleString, desc: descString, imageName: imageName, isHidden: true, horizontalViewIsHidden: true, count: 0, indexRow: 0, videoUrl: "", cellId: 0, leftButtonValue: false, rightButtonValue: false, leftButtonText: "", rightButtonText: "")
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        default:
            return 600.0
        }
    }
}
