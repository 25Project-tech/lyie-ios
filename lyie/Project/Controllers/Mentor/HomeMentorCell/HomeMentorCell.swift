//
//  HomeMentorCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.12.2020.
//

import UIKit
import Parse

class HomeMentorCell: UITableViewCell {
    
    static let reuseIdentifier = "HomeMentorCell"
    
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var hsName: UILabel!
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var navigateMentorInfo: UITableView!
    @IBOutlet weak var photoChangingView: UIView!
    @IBOutlet weak var photoChangingImage: UIImageView!
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var profileView: UIView!
    
    lazy var cells = [UIViewController]()
    var currentScoreDetailCount = 0
    
    var navigateScoreTapAction: ((HomeMentorCell) -> ())?
    var navigateProfileTapAction: ((HomeMentorCell) -> ())?
    var photoChangingTapAction: ((HomeMentorCell) -> ())?
    var navigateMentorTapAction: ((HomeMentorCell) -> ())?
    
    func config(isHidden: Bool) {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var infos = HomeMentorProvider.mentors(for: user), let userItem = UserProvider.users(for: user), let studentInfoItem = StudentInfoProvider.studentInfos(for: user) {
            LyieUtils.loadImage(resource: profilePic, imageURL: infos.userImageURL, placeHolder: UIImage(named: "Profile/profile-1"), isCircle: false)
            
            let score = infos.totalScoreUser
            self.scoreButton.setTitle(score, for: .normal)
            let nameArray = userItem.name.split(separator: " ")
            name.text = String(nameArray[0])
            name.textColor = .black
            if nameArray.count > 1 {
                surname.text = String(nameArray[1])
            } else {
                surname.text = ""
            }
            surname.textColor = .black
            
            if userItem.userType == "Mentor" {
                hsName.text = studentInfoItem.targetUniversity
                hsName.textColor = StyleManager.colors.leftTitleColor
            } else {
                hsName.text = studentInfoItem.highSchoolName
                hsName.textColor = StyleManager.colors.leftTitleColor
            }
        }
        idView.makeShadow()
        profileView.makeShadow()
        photoChangingView.isHidden = false
        photoChangingView.makeShadow()
        myTableView.dataSource = self
        myTableView.delegate = self
        self.myTableView.register(UINib(nibName: "HomeMentorCell", bundle: nil), forCellReuseIdentifier: "HomeMentorCell")
        photoChangingImage.image = UIImage(named: "Profile/photoChanging")
        coverPhoto.image = UIImage(named: "Home/Rectangle 3")

        lineView.backgroundColor = StyleManager.colors.lineColor
        horizontalView.backgroundColor = StyleManager.colors.leftTitleColor
        horizontalView.isHidden = isHidden
        
        let controller: HomeMentorController = UIStoryboard.home.instantiateViewController()
        controller.navigateMentorDelegate = self
        cells.append(controller)
//        myTableView.reloadData()
    }
    
    @IBAction func tappedScoreButton(_ sender: Any) {
        LyieLog.mPrint("tapped")
        self.navigateScoreTapAction!(self)
    }
    
    @IBAction func tappedPhotoChangeButton(_ sender: Any) {
        LyieLog.mPrint("tapped")
        self.photoChangingTapAction!(self)
    }
}

extension HomeMentorCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if indexPath.row != self.cells.count {
            cell.contentView.embed(self.cells[indexPath.row].view)
            cell.reloadInputViews()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

extension HomeMentorCell: NavigateDelegate {
    func navigateResearchPage() {}
    
    func navigateMentorPage() {
        self.navigateMentorTapAction!(self)
    }
}
