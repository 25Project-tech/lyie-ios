//
//  MentorInfoCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.12.2020.
//

import UIKit
import Parse

class MentorInfoCell: UITableViewCell {

    static let reuseIdentifier = "MentorInfoCell"
    
    @IBOutlet weak var mentorPhoto: UIImageView!
    @IBOutlet weak var mentorName: UILabel!
    @IBOutlet weak var mentorUni: UILabel!
    @IBOutlet weak var navigateView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var profileView: UIView!
    
    var navigateMentorTapAction: ((MentorInfoCell) -> ())?
    var indexType = 0
    
    func config(index: Int) {
        indexType = index
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user), let homeMentor = HomeMentorProvider.mentors(for: user), let studentInfoItem = StudentInfoProvider.studentInfos(for: user) {
            if userItem.userType == "Mentor" {
                mentorName.text = "Kamil Mercimek"
                mentorUni.text = "İstanbul Üniversitesi"
                mentorPhoto.image = UIImage(named: "Profile/photo1")
                title.text = "Lider"
            } else if userItem.userType == "Student" {
                if index == 0 {
                    mentorName.text = homeMentor.parentFirstUserName
                    mentorUni.text = homeMentor.parentFirstUserUniversity
                    LyieUtils.loadImage(resource: mentorPhoto, imageURL: homeMentor.parentFirstUserUrl, placeHolder: UIImage(named: "Profile/profile-1"), isCircle: false)
                    title.text = "Mentor"
                } else {
                    mentorName.text = homeMentor.parentSecondUserName
                    mentorUni.text = homeMentor.parentSecondUserUniversity
                    LyieUtils.loadImage(resource: mentorPhoto, imageURL: homeMentor.parentSecondUserUrl, placeHolder: UIImage(named: "Profile/profile-1"), isCircle: false)
                    title.text = "Mentor"
                }
            } else {
                if index == 0 {
                    mentorName.text = "Dijital Mentor"
                    mentorUni.text = homeMentor.parentFirstUserUniversity
                    mentorPhoto.image = UIImage(named: "Home/karakterAdam")
                    title.text = "Mentor"
                } else {
                    mentorName.text = "Dijital Mentor"
                    mentorUni.text = homeMentor.parentSecondUserUniversity
                    mentorPhoto.image = UIImage(named: "Home/karakterKadın")
                    title.text = "Mentor"
                }
            }
        }
        profileView.makeShadow()
        
        mentorUni.textColor = StyleManager.colors.leftTitleColor
        navigateView.backgroundColor = StyleManager.colors.leftTitleColor
        navigateView.cornerRadius = 19.0
        
        titleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleView.cornerRadius = 10.0
        titleView.makeShadow()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBAction func navigateButtonTapped(_ sender: Any) {
        self.navigateMentorTapAction!(self)
    }
}

