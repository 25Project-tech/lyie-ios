//
//  MentorIDCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 16.01.2021.
//

import UIKit
import Parse

class MentorIDCell: UITableViewCell {
    static let reuseIdentifier = "MentorIDCell"
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameInfoText: UILabel!
    @IBOutlet weak var uniInfoText: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var photoView: UIView!
    
    var indexType = 0
    func config(index: Int) {
        indexType = index
        
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let userItem = UserProvider.users(for: user), let homeMentor = HomeMentorProvider.mentors(for: user), let studentInfoItem = StudentInfoProvider.studentInfos(for: user) {
            if userItem.userType == "Mentor" {
                
                nameInfoText.text = userItem.name
                uniInfoText.text = studentInfoItem.targetUniversity
                LyieUtils.loadImage(resource: photoImage, imageURL: homeMentor.userImageURL, placeHolder: UIImage(named: "Profile/profile-1"), isCircle: false)
                
                if index == 0 {
                    title.text = "1. Sınıfınız"
                } else {
                    title.text = "2. Sınıfınız"
                }
            } else if userItem.userType == "Student" {
                if index == 0 {
                    nameInfoText.text = homeMentor.parentFirstUserName
                    uniInfoText.text = homeMentor.parentFirstUserUniversity
                    LyieUtils.loadImage(resource: photoImage, imageURL: homeMentor.parentFirstUserUrl, placeHolder: UIImage(named: "Profile/profile-1"), isCircle: false)
                    title.text = "Mentor"
                } else {
                    nameInfoText.text = homeMentor.parentSecondUserName
                    uniInfoText.text = homeMentor.parentSecondUserUniversity
                    LyieUtils.loadImage(resource: photoImage, imageURL: homeMentor.parentSecondUserUrl, placeHolder: UIImage(named: "Profile/profile-1"), isCircle: false)
                    title.text = "Mentor"
                }
            } else {
                if index == 0 {
                    nameInfoText.text = "Dijital Mentor"
                    uniInfoText.text = homeMentor.parentFirstUserUniversity
                    photoImage.image = UIImage(named: "Home/karakterAdam")
                    title.text = "Mentor"
                } else {
                    nameInfoText.text = "Dijital Mentor"
                    uniInfoText.text = homeMentor.parentSecondUserUniversity
                    photoImage.image = UIImage(named: "Home/karakterKadın")
                    title.text = "Mentor"
                }
            }
        }
        
       
        mainView.makeShadow()
        photoView.makeShadow()
        nameInfoText.textColor = StyleManager.colors.leftTitleColor
        titleView.backgroundColor = StyleManager.colors.leftTitleColor
        titleView.cornerRadius = 10.0
        titleView.makeShadow()
    }
    
}
