//
//  LyieUtils.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.
//

import Foundation
import UIKit
import Parse
import KRProgressHUD
import Kingfisher

class LyieUtils {
    
    //MARK: - Email Verification
    static func configTextFieldAsEmail(text: String, errorLabel: UILabel? = UILabel(), seperatorView: UIView? = UIView()) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValid =  emailPred.evaluate(with: text)
        if text.count == 0 {
            errorLabel!.isHidden = false
            errorLabel?.text = .localized(.error_email_not_found)
            seperatorView!.backgroundColor = .red
        } else {
            if isValid {
                errorLabel!.isHidden = true
                seperatorView!.backgroundColor = .systemGreen
            } else {
                errorLabel!.isHidden = false
                errorLabel?.text = .localized(.error_email_not_valid)
                seperatorView!.backgroundColor = .red
            }
        }
        return emailPred.evaluate(with: text)
    }

    static func configTextFieldAsName(text: String, errorLabel: UILabel? = UILabel(), seperatorView: UIView? = UIView()) -> Bool {
        if text.count >= 2 {
            errorLabel!.isHidden = true
            seperatorView!.backgroundColor = .systemGreen
            return true
        } else if text.count == 0 {
            errorLabel?.text = .localized(.error_name_not_found)
            errorLabel!.isHidden = false
            seperatorView!.backgroundColor = .red
            return false
        } else {
            errorLabel?.text = .localized(.error_name_not_valid)
            errorLabel!.isHidden = false
            seperatorView!.backgroundColor = .red
            return false
        }
    }

    static func configTextFieldAsSurname(text: String, errorLabel: UILabel? = UILabel(), seperatorView: UIView? = UIView()) -> Bool {
        if text.count >= 2 {
            errorLabel!.isHidden = true
            seperatorView!.backgroundColor = .systemGreen
            return true
        } else if text.count == 0 {
            errorLabel?.text = .localized(.error_surname_not_found)
            errorLabel!.isHidden = false
            seperatorView!.backgroundColor = .red
            return false
        } else {
            errorLabel?.text = .localized(.error_surname_not_valid)
            errorLabel!.isHidden = false
            seperatorView!.backgroundColor = .red
            return false
        }
    }

    static func configTextFieldAsPassword(text: String, errorLabel: UILabel? = UILabel(), seperatorView: UIView? = UIView()) -> Bool {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let containsCapital = texttest.evaluate(with: text)
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = texttest1.evaluate(with: text)
        
        let specialCharacterRegEx  = ".*[^A-Za-z0-9].*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        let containsSpecialChar = texttest2.evaluate(with: text)
        
        if text.count >= 8 {
            if containsCapital {
                if containsNumber {
                    if containsSpecialChar {
                        errorLabel!.isHidden = true
                        seperatorView!.backgroundColor = .systemGreen
                        return true
                    } else {
                        errorLabel!.isHidden = false
                        seperatorView!.backgroundColor = .red
                        errorLabel!.text = .localized(.error_password_contains_special_char)
                        return false
                    }
                } else {
                    errorLabel!.isHidden = false
                    seperatorView!.backgroundColor = .red
                    errorLabel!.text = .localized(.error_password_contains_number)
                    return false
                }
            } else {
                errorLabel!.isHidden = false
                seperatorView!.backgroundColor = .red
                errorLabel!.text = .localized(.error_password_contains_uppercase)
                return false
            }
        } else if text.count == 0 {
            errorLabel!.isHidden = false
            seperatorView!.backgroundColor = .red
            errorLabel!.text = .localized(.error_password_not_found)
            return false
        } else {
            errorLabel!.isHidden = false
            seperatorView!.backgroundColor = .red
            errorLabel!.text = .localized(.error_password_contains_length)
            return false
        }
    }

    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    //MARK: - PROFILE UPDATE
    static func loadImage(resource: UIImageView, imageURL: String, placeHolder: UIImage!, isCircle: Bool!) {
        if isCircle {
            resource.layer.cornerRadius = resource.frame.size.width / 2
            resource.contentMode = .scaleAspectFill
            resource.clipsToBounds = true
        }
        
        let logoUrl = URL(string: imageURL)
        resource.kf.indicatorType = .activity
        resource.kf.setImage(
            with: logoUrl,
            placeholder: placeHolder,
            options: [
                .transition(.fade(1))
            ])
    }
    
    static func checkUserName(view: UIViewController) {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: user) {
            let user = PFUser()
            let query = PFUser.query()
            query?.whereKey("username", equalTo: newUserItem.userID)
            query?.getFirstObjectInBackground(block: { (userObj, error) in
                if error != nil {
                    print("Kayıtlanabilir")
                } else {
                    if let userObj = userObj {
                        AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: "Kullanıcı adı kullanımda", vc: view)
                    }
                }
            })
        }
        
    }
    static func uploadUserInfo(view: UIViewController, _ completion: @escaping ()->()) {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: user) {
            KRProgressHUD.show()
            if (newUserItem.userID != "" && newUserItem.password != "" && newUserItem.userType != "") {
                let user = PFUser()
                let query = PFUser.query()
                query?.whereKey("username", equalTo: newUserItem.userID)
                query?.findObjectsInBackground(block: { (objc, error) in
                    if error != nil {
                        let studentInfoObject = PFObject(className: "UserEducationInfo")
                        
                        studentInfoObject["userID"] = newUserItem.userID
                        
                        if newUserItem.userType == "Mentor" {
                            studentInfoObject["targetUniversity"] = newUserItem.University
                            studentInfoObject["targetDepartment"] = newUserItem.Department
                        }
                        
                        if newUserItem.userType == "Student" {
                            studentInfoObject["highSchoolName"] = newUserItem.highSchoolName
                        }
                        
                        studentInfoObject.saveInBackground { (success, error) in
                            if error != nil {
                                KRProgressHUD.dismiss {
                                    AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: error!.localizedDescription, vc: view)
                                    completion()
                                }
                            } else  {
                                print("saved education info")
                                if newUserItem.userType == "Mentor" {
                                    let MentorInfoObject = PFObject(className: "MentorInfo")
                                    MentorInfoObject["FirstClass"] = newUserItem.FirstClass
                                    MentorInfoObject["SecondClass"] = newUserItem.SecondClass
                                    MentorInfoObject["UserID"] = newUserItem.userID
                                    MentorInfoObject.saveInBackground { (success, error) in
                                        if error != nil {
                                            KRProgressHUD.dismiss {
                                                AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: error!.localizedDescription, vc: view)
                                                completion()
                                            }
                                        } else {
                                            print("mentor info success")
                                            let mentorInfo = user.relation(forKey: "mentorInfo")
                                            mentorInfo.add(MentorInfoObject)
                                        }
                                    }
                                }
                                
                                if newUserItem.userType == "Student" {
                                    let classInfoObject = PFObject(className: "ClassInfo")
                                    classInfoObject["classID"] = newUserItem.classID
                                    classInfoObject["FirstMentor"] = newUserItem.FirstMentor
                                    classInfoObject["SecondMentor"] = newUserItem.SecondMentor
                                    classInfoObject["StudentId"] = newUserItem.userID
                                    classInfoObject.saveInBackground { (success, error) in
                                        if error != nil {
                                            KRProgressHUD.dismiss {
                                                AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: error!.localizedDescription, vc: view)
                                                completion()
                                            }
                                        } else {
                                            print("class info success")
                                            let userClass = user.relation(forKey: "studentClassInfo")
                                            userClass.add(classInfoObject)
                                        }
                                    }
                                }
                                
                                user.username = newUserItem.userID
                                user.password = newUserItem.password
                                user["userPass"] = newUserItem.password
                                user["userType"] = newUserItem.userType
                                user["fullName"] = newUserItem.name
                                user["phone"] = newUserItem.phone
                                user["email"] = newUserItem.mail
                                user["approved"] = newUserItem.approvedKVKK
                                
                                let userEducation = user.relation(forKey: "userEducation")
                                userEducation.add(studentInfoObject)
                                
                                user.signUpInBackground { (isSuccess, error) in
                                    if error != nil {
                                        KRProgressHUD.dismiss {
                                            AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: error!.localizedDescription, vc: view)
                                            completion()
                                        }
                                    } else {
                                        user.saveInBackground { (issuccess, error) in
                                            if error != nil {
                                                KRProgressHUD.dismiss {
                                                    AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: error!.localizedDescription, vc: view)
                                                    completion()
                                                }
                                            } else {
                                                KRProgressHUD.dismiss {
                                                    AlertModelAPI.withoutButtonAlert(imageString: "Settings/complete", title: "Başarılı", desc: "Kayıt Başarılı", vc: view)
                                                    PFUser.enableRevocableSessionInBackground()
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                        AlertModelAPI.dismissPopups()
                                                        completion()
                                                    }
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        if let objc = objc {
                            if objc.isEmpty {
                                let studentInfoObject = PFObject(className: "UserEducationInfo")
                                
                                studentInfoObject["userID"] = newUserItem.userID
                                
                                if newUserItem.userType == "Mentor" {
                                    studentInfoObject["targetUniversity"] = newUserItem.University
                                    studentInfoObject["targetDepartment"] = newUserItem.Department
                                }
                                
                                if newUserItem.userType == "Student" {
                                    studentInfoObject["highSchoolName"] = newUserItem.highSchoolName
                                }
                                
                                studentInfoObject.saveInBackground { (success, error) in
                                    if error != nil {
                                        KRProgressHUD.dismiss {
                                            AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: error!.localizedDescription, vc: view)
                                        }
                                    } else  {
                                        print("saved education info")
                                        if newUserItem.userType == "Mentor" {
                                            let MentorInfoObject = PFObject(className: "MentorInfo")
                                            MentorInfoObject["FirstClass"] = newUserItem.FirstClass
                                            MentorInfoObject["SecondClass"] = newUserItem.SecondClass
                                            MentorInfoObject["UserID"] = newUserItem.userID
                                            MentorInfoObject.saveInBackground { (success, error) in
                                                if error != nil {
                                                    KRProgressHUD.dismiss {
                                                        AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: error!.localizedDescription, vc: view)
                                                    }
                                                } else {
                                                    print("mentor info success")
                                                    let mentorInfo = user.relation(forKey: "mentorInfo")
                                                    mentorInfo.add(MentorInfoObject)
                                                }
                                            }
                                        }
                                        
                                        if newUserItem.userType == "Student" {
                                            let classInfoObject = PFObject(className: "ClassInfo")
                                            classInfoObject["classID"] = newUserItem.classID
                                            classInfoObject["FirstMentor"] = newUserItem.FirstMentor
                                            classInfoObject["SecondMentor"] = newUserItem.SecondMentor
                                            classInfoObject["StudentId"] = newUserItem.userID
                                            classInfoObject.saveInBackground { (success, error) in
                                                if error != nil {
                                                    KRProgressHUD.dismiss {
                                                        AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: error!.localizedDescription, vc: view)
                                                    }
                                                } else {
                                                    print("class info success")
                                                    let userClass = user.relation(forKey: "studentClassInfo")
                                                    userClass.add(classInfoObject)
                                                }
                                            }
                                        }
                                        
                                        user.username = newUserItem.userID
                                        user.password = newUserItem.password
                                        user["userPass"] = newUserItem.password
                                        user["userType"] = newUserItem.userType
                                        user["fullName"] = newUserItem.name
                                        user["phone"] = newUserItem.phone
                                        user["email"] = newUserItem.mail
                                        user["approved"] = newUserItem.approvedKVKK
                                        
                                        let userEducation = user.relation(forKey: "userEducation")
                                        userEducation.add(studentInfoObject)
                                        
                                        user.signUpInBackground { (isSuccess, error) in
                                            if error != nil {
                                                KRProgressHUD.dismiss {
                                                    AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: error!.localizedDescription, vc: view)
                                                }
                                            } else {
                                                user.saveInBackground { (issuccess, error) in
                                                    if error != nil {
                                                        KRProgressHUD.dismiss {
                                                            AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: error!.localizedDescription, vc: view)
                                                        }
                                                    } else {
                                                        KRProgressHUD.dismiss {
                                                            
                                                            AlertModelAPI.withoutButtonAlert(imageString: "Settings/complete", title: "Başarılı", desc: "Kayıt Başarılı", vc: view)
                                                            PFUser.enableRevocableSessionInBackground()
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                                AlertModelAPI.dismissPopups()
                                                                completion()
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                KRProgressHUD.dismiss {
                                    AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: "Kullanıcı adı kullanımda", vc: view)
                                    PFUser.enableRevocableSessionInBackground()
                                }
                            }
                        }
                    }
                })
            } else {
                KRProgressHUD.dismiss {
                    AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Hata", desc: "Kullanıcı adınız,şifreniz ve ya kullanıcı türü alanı boş bırakılamaz.", vc: view)
                }
            }
        }
    }
    
    static func updateHighSchool() -> [String] {
        var hgArray = [String]()
        let query = PFQuery(className: "HighSchoolList")
        query.findObjectsInBackground { (objects, error) in
            if let objects = objects {
                if objects.count > 0 {
                    for object in objects {
                        hgArray.append(object.object(forKey: "hsName") as! String)
                        print(object.object(forKey: "hsName") as? String ?? "")
                    }
                }
            }
        }
        return hgArray
    }
    
    static func updateCities() -> [String] {
        var cityArray = [String]()
        let query = PFQuery(className: "CityList")
        query.findObjectsInBackground { (objects, error) in
            if let objects = objects {
                if objects.count > 0 {
                    for object in objects {
                        cityArray.append(object.object(forKey: "cityName") as! String)
                    }
                }
            }
        }
        return cityArray
    }

    static func updateDepartment() {
        for i in 0..<DepartmentService.allDepartmentList().count {
            let object = PFObject(className: "HighSchooolDepartmentList")
            object["departmentName"] = DepartmentService.allDepartmentList()[i].name
            object["departmentID"] = DepartmentService.allDepartmentList()[i].id
            object.saveInBackground { (success, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print(i, "succeess")
                }
            }
        }
    }
    
    static func profileProgressUpdate(_ completion: @escaping ()->()) {
        if let user = PFUser.current() {
            let studentPrrogress = PFQuery(className: "UserEducationProgressInfo")
            studentPrrogress.whereKey("userID", equalTo: user.username)
            studentPrrogress.getFirstObjectInBackground { (obj, error) in
                if error != nil {
                    print("no progress record")
                } else {
                    if let obj = obj {
                        if let user = UserDefaults.standard.string(forKey: currentUserKey), var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                            studentEducationItem.mainEducationValue = obj["mainEducationValue"] as? Int ?? 0
                            studentEducationItem.education101aiNum = obj["education101aiNum"] as? Int ?? 0
                            studentEducationItem.education101iotNum = obj["education101iotNum"] as? Int ?? 0
                            studentEducationItem.education101inoNum = obj["education101inoNum"] as? Int ?? 0
                            studentEducationItem.mainEducation = obj["mainEducation"] as? String ?? ""
                            studentEducationItem.mainEducationCellNum = obj["mainEducationCellNum"] as? Int ?? 0
                            studentEducationItem.currentEducationNum = obj["currentEducationNum"] as? Int ?? 0
                            studentEducationItem.currentEducationsCount = obj["currentEducationsCount"] as? Int ?? 0
                            studentEducationItem.currentCell = obj["currentCell"] as? Int ?? 0
                            studentEducationItem.questionAreaCell = obj["questionAreaCell"] as? Int ?? 0
                            studentEducationItem.questionAreaMainEdu = obj["questionAreaMainEdu"] as? String ?? ""
                            studentEducationItem.questionAreaMainValue = obj["questionAreaMainValue"] as? Int ?? 0
                            StudentEducationProvider.update(studentEducations: studentEducationItem)
                        }
                    }
                }
            }
        }
    }
    
    static func uploadProfilePic(image: UIImage, cell: UIImageView) {
        if let currentUser = PFUser.current() {
            if let userImage = image.resize(toHeight: 300.0)?.pngData() {
                let pfImage = PFFileObject(name: "userImage.png", data: userImage)
                currentUser["userImage"] = pfImage
                currentUser.saveInBackground { (success, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                    } else {
                        print("Saved")
                        if let query = PFUser.query() {
                            query.whereKey("username", equalTo: currentUser.username)
                            query.getFirstObjectInBackground { (currentObject, error) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                } else {
                                    if let currentObject = currentObject {
                                        if currentObject["userImage"] != nil {
                                            let file: PFFileObject = currentObject["userImage"] as! PFFileObject
                                            file.getFilePathInBackground()
                                            if let secondQuery = PFUser.query() {
                                                secondQuery.whereKey("email", equalTo: currentUser.email)
                                                secondQuery.getFirstObjectInBackground() { (update: PFObject?, error: Error?) in
                                                    if let error = error {
                                                        print(error.localizedDescription)
                                                    } else if let update = update {
                                                        if let inputString = file.url {
                                                            let splits = inputString.components(separatedBy: "http://127.0.0.1:1337/")
                                                            let userImageUrl = "http://54.237.251.163/" + splits[1]
                                                            update["userImageUrl"] = userImageUrl
                                                            update.saveInBackground() { (succeeded, error)  in
                                                                if (succeeded) {
                                                                    if let thirdQuery = PFUser.query() {
                                                                        thirdQuery.whereKey("username", equalTo: currentUser.username)
                                                                        thirdQuery.getFirstObjectInBackground { (photoObject, error) in
                                                                            if error != nil {
                                                                                print(error?.localizedDescription)
                                                                            } else {
                                                                                print("succeess")
                                                                                if let photoObject = photoObject {
                                                                                    if let user = UserDefaults.standard.string(forKey: currentUserKey), var homeMentor = HomeMentorProvider.mentors(for: user) {
                                                                                        homeMentor.userImageURL = photoObject["userImageUrl"] as? String ?? ""
                                                                                        HomeMentorProvider.update(mentors: homeMentor)
                                                                                    }
                                                                                }
                                                                                
                                                                            }
                                                                        }
                                                                    }
                                                                } else {
                                                                    print(error!.localizedDescription)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func updatePp(image: UIImageView) {
        if let currentUser = PFUser.current() {
            if let query = PFUser.query() {
                query.whereKey("username", equalTo: currentUser.username)
                query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                        image.image = UIImage(named: "Profile/profile-1")
                    } else if let objects = objects?.first {
                        if objects["userImageUrl"] != nil {
                            if let url = URL(string: objects["userImageUrl"] as! String) {
                                let data = try? Data(contentsOf: url)

                                if let imageData = data {
                                    image.image = UIImage(data: imageData)!
                                } else {
                                    image.image = UIImage(named: "Profile/profile-1")
                                }
                            } else {
                                image.image = UIImage(named: "Profile/profile-1")
                            }
                        } else {
                            image.image = UIImage(named: "Profile/profile-1")
                        }
                    } else {
                        image.image = UIImage(named: "Profile/profile-1")
                    }
                }
            }
        }
    }
    
    static func homeMentorCardUpdate(_ completion: @escaping ()->()) {
        if let user = PFUser.current() {
            if let query = PFUser.query() {
                query.whereKey("username", equalTo: user.username)
                query.getFirstObjectInBackground { (infos, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        completion()
                    } else {
                        if let infos = infos {
                            if let currentUser = UserDefaults.standard.string(forKey: currentUserKey), var homeMentor = HomeMentorProvider.mentors(for: currentUser) {
                                homeMentor.userImageURL = infos["userImageUrl"] as? String ?? ""
                                HomeMentorProvider.update(mentors: homeMentor)
                                let currentUserClass = user.relation(forKey: "studentClassInfo")
                                currentUserClass.query().getFirstObjectInBackground { (mentorObject, error) in
                                    if error != nil {
                                        completion()
                                    } else {
                                        if let mentorObject = mentorObject {
                                            if let firstMentor = mentorObject["FirstMentor"] {
                                                if let mentorQuery = PFUser.query() {
                                                    mentorQuery.whereKey("username", equalTo: firstMentor)
                                                    mentorQuery.getFirstObjectInBackground { (firstMentorInfo, error) in
                                                        if error != nil {
                                                            print(error?.localizedDescription)
                                                            homeMentor.parentFirstUserName = ""
                                                            homeMentor.parentFirstUserUrl = ""
                                                            homeMentor.parentFirstUserUniversity = ""
                                                            HomeMentorProvider.update(mentors: homeMentor)
                                                        } else {
                                                            if let firstMentorInfo = firstMentorInfo {
                                                                homeMentor.parentFirstUserName = firstMentorInfo["fullName"] as? String ?? ""
                                                                homeMentor.parentFirstUserUrl = firstMentorInfo["userImageUrl"] as? String ?? ""
                                                                HomeMentorProvider.update(mentors: homeMentor)
                                                                let educationFirstMentorInfo = firstMentorInfo.relation(forKey: "userEducation")
                                                                educationFirstMentorInfo.query().getFirstObjectInBackground { (educationFirst, error) in
                                                                    if error != nil {
                                                                        print(error?.localizedDescription)
                                                                        homeMentor.parentFirstUserUniversity = ""
                                                                    } else {
                                                                        if let educationFirst = educationFirst {
                                                                            homeMentor.parentFirstUserUniversity = educationFirst["targetUniversity"] as? String ?? ""
                                                                            HomeMentorProvider.update(mentors: homeMentor)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            if let secondMentor = mentorObject["SecondMentor"] {
                                                if let secondMentorQuery = PFUser.query() {
                                                    secondMentorQuery.whereKey("username", equalTo: secondMentor)
                                                    secondMentorQuery.getFirstObjectInBackground { (secondMentorInfo, error) in
                                                        if error != nil {
                                                            print(error?.localizedDescription)
                                                            homeMentor.parentSecondUserName = ""
                                                            homeMentor.parentSecondUserUrl = ""
                                                            homeMentor.parentSecondUserUniversity = ""
                                                            HomeMentorProvider.update(mentors: homeMentor)
                                                        } else {
                                                            if let secondMentorInfo = secondMentorInfo {
                                                                homeMentor.parentSecondUserName = secondMentorInfo["fullName"] as? String ?? ""
                                                                homeMentor.parentSecondUserUrl = secondMentorInfo["userImageUrl"] as? String ?? ""
                                                                HomeMentorProvider.update(mentors: homeMentor)
                                                                let educationSecondMentorInfo = secondMentorInfo.relation(forKey: "userEducation")
                                                                educationSecondMentorInfo.query().getFirstObjectInBackground { (educationSecond, error) in
                                                                    if error != nil {
                                                                        print(error?.localizedDescription)
                                                                        homeMentor.parentSecondUserUniversity = ""
                                                                    } else {
                                                                        if let educationSecond = educationSecond {
                                                                            homeMentor.parentSecondUserUniversity = educationSecond["targetUniversity"] as? String ?? ""
                                                                            HomeMentorProvider.update(mentors: homeMentor)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            if let currentUser = PFUser.current() {
                                                let currentUserScore = currentUser.relation(forKey: "userScore")
                                                currentUserScore.query().findObjectsInBackground { (objects, error) in
                                                    if let objects = objects {
                                                        if objects.count > 0 {
                                                            homeMentor.totalScoreUser = "\(objects.count * 100)"
                                                            HomeMentorProvider.update(mentors: homeMentor)
                                                        }
                                                    }
                                                }
                                            }
                                            completion()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    static func updateUser(target: String, fullName: String, birthDay: Date, birthPlace: Int, gender: String, city: Int, phone: String, mailAdress: String, userPass: String, approved: Bool, userEducation: UserEducationModel) {
        if let user = PFUser.current() {
            let studentInfoClass = PFQuery(className: "UserEducationInfo")
            studentInfoClass.whereKey("userID", equalTo: PFUser.current()?.username)
            studentInfoClass.getFirstObjectInBackground { (studentInfoObject, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    let studentInfoObject = PFObject(className: "UserEducationInfo")
                    studentInfoObject["userID"] = user.username
                    studentInfoObject["highSchoolName"] = userEducation.highSchoolName
                    studentInfoObject["highSClassNumber"] = userEducation.highSClassNumber
                    studentInfoObject["departmentName"] = userEducation.departmentName
                    studentInfoObject["targetUniversity"] = userEducation.targetUniversity
                    studentInfoObject["targetDepartment"] = userEducation.targetDepartment
                    
                    studentInfoObject.saveInBackground { (success, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else  {
                            print("saved education info")
                            user["objectId"] = user.objectId
                            user["purpose"] = target
                            user["fullName"] = fullName
                            user["dateOfBirth"] = birthDay
                            user["placeOfBirth"] = birthPlace
                            user["gender"] = gender
                            user["city"] = city
                            user["phone"] = phone
                            user["email"] = mailAdress
                            user["userPass"] = userPass
                            user["approved"] = approved
                            let userEducation = user.relation(forKey: "userEducation")
                            userEducation.add(studentInfoObject)
                            user.saveInBackground { (issuccess, error) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                } else {
                                    print("saved")
                                }
                            }
                        }
                    }
                } else {
                    if let studentInfoObject = studentInfoObject {
                        studentInfoObject["userID"] = user.username
                        studentInfoObject["highSchoolName"] = userEducation.highSchoolName
                        studentInfoObject["highSClassNumber"] = userEducation.highSClassNumber
                        studentInfoObject["departmentName"] = userEducation.departmentName
                        studentInfoObject["targetUniversity"] = userEducation.targetUniversity
                        studentInfoObject["targetDepartment"] = userEducation.targetDepartment
                        
                        studentInfoObject.saveInBackground { (success, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            } else  {
                                print("saved education info")
                                user["objectId"] = user.objectId
                                user["purpose"] = target
                                user["fullName"] = fullName
                                user["dateOfBirth"] = birthDay
                                user["placeOfBirth"] = birthPlace
                                user["gender"] = gender
                                user["city"] = city
                                user["phone"] = phone
                                user["email"] = mailAdress
                                user["userPass"] = userPass
                                user["approved"] = approved
                                let userEducation = user.relation(forKey: "userEducation")
                                userEducation.add(studentInfoObject)
                                user.saveInBackground { (issuccess, error) in
                                    if error != nil {
                                        print(error?.localizedDescription)
                                    } else {
                                        print("saved")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func profileTargetStringUpdate(text: String) {
        if let user = PFUser.current() {
            user["purpose"] = text
            user.saveInBackground { (success, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("saved profileTargetStringUpdate")
                }
            }
        }
    }
    
    static func profileFullNameUpdate(text: String) {
        if let user = PFUser.current() {
            user["fullName"] = text
            user.saveInBackground { (success, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("saved profileFullNameUpdat")
                }
            }
        }
    }
    
    static func profileBirthdayUpdate(text: Date) {
        if let user = PFUser.current() {
            user["dateOfBirth"] = text
            user.saveInBackground { (success, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("saved profileBirthdayUpdate")
                }
            }
        }
    }
    
    static func profilePlaceBirthUpdate(text: Int) {
        if let user = PFUser.current() {
            user["placeOfBirth"] = text
            user.saveInBackground { (success, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("saved profilePlaceBirthUpdate")
                }
            }
        }
    }
    
    static func profileGenderUpdated(text: String) {
        if let user = PFUser.current() {
            user["gender"] = text
            user.saveInBackground { (success, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("saved profileGenderUpdated")
                }
            }
        }
    }
    
    static func profileCityUpdated(text: Int) {
        if let user = PFUser.current() {
            user["city"] = text
            user.saveInBackground { (success, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("saved profileCityUpdated")
                }
            }
        }
    }
    
    static func profilePhoneUpdate(text: String) {
        if let user = PFUser.current() {
            user["phone"] = text
            user.saveInBackground { (success, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("saved profilePhoneUpdate")
                }
            }
        }
    }
    
    static func profileMailUpdated(text: String) {
        if let user = PFUser.current() {
            user["email"] = text
            user.saveInBackground { (success, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("saved profileMailUpdated")
                }
            }
        }
    }
    
    static func profileHGUpdate(text: String) {
        if let user = PFUser.current() {
            let studentInfoClass = PFQuery(className: "UserEducationInfo")
            studentInfoClass.whereKey("userID", equalTo: user.username)
            studentInfoClass.getFirstObjectInBackground { (studentInfoObject, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    let studentInfoObject = PFObject(className: "UserEducationInfo")
                    studentInfoObject["highSchoolName"] = text
                    studentInfoObject.saveInBackground { (success, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else  {
                            print("saved education info")
                        }
                    }
                } else {
                    if let studentInfoObject = studentInfoObject {
                        studentInfoObject["highSchoolName"] = text
                        studentInfoObject.saveInBackground { (success, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            } else  {
                                print("saved education info")
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func profileClassUpdate(text: String) {
        if let user = PFUser.current() {
            let studentInfoClass = PFQuery(className: "UserEducationInfo")
            studentInfoClass.whereKey("userID", equalTo: user.username)
            studentInfoClass.getFirstObjectInBackground { (studentInfoObject, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    let studentInfoObject = PFObject(className: "UserEducationInfo")
                    studentInfoObject["highSClassNumber"] = text
                    studentInfoObject.saveInBackground { (success, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else  {
                            print("saved education info")
                        }
                    }
                } else {
                    if let studentInfoObject = studentInfoObject {
                        studentInfoObject["highSClassNumber"] = text
                        studentInfoObject.saveInBackground { (success, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            } else  {
                                print("saved education info")
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func profileHGDeprtUpdate(text: String) {
        if let user = PFUser.current() {
            let studentInfoClass = PFQuery(className: "UserEducationInfo")
            studentInfoClass.whereKey("userID", equalTo: user.username)
            studentInfoClass.getFirstObjectInBackground { (studentInfoObject, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    let studentInfoObject = PFObject(className: "UserEducationInfo")
                    studentInfoObject["departmentName"] = text
                    studentInfoObject.saveInBackground { (success, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else  {
                            print("saved education info")
                        }
                    }
                } else {
                    if let studentInfoObject = studentInfoObject {
                        studentInfoObject["departmentName"] = text
                        studentInfoObject.saveInBackground { (success, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            } else  {
                                print("saved education info")
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func profileTarrgetUniUpdated(text: String) {
        if let user = PFUser.current() {
            let studentInfoClass = PFQuery(className: "UserEducationInfo")
            studentInfoClass.whereKey("userID", equalTo: user.username)
            studentInfoClass.getFirstObjectInBackground { (studentInfoObject, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    let studentInfoObject = PFObject(className: "UserEducationInfo")
                    studentInfoObject["targetUniversity"] = text
                    studentInfoObject.saveInBackground { (success, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else  {
                            print("saved education info")
                        }
                    }
                } else {
                    if let studentInfoObject = studentInfoObject {
                        studentInfoObject["userID"] = user.username
                        studentInfoObject["targetUniversity"] = text
                        studentInfoObject.saveInBackground { (success, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            } else  {
                                print("saved education info")
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func profileTargetDepUpdate(text: String) {
        if let user = PFUser.current() {
            let studentInfoClass = PFQuery(className: "UserEducationInfo")
            studentInfoClass.whereKey("userID", equalTo: user.username)
            studentInfoClass.getFirstObjectInBackground { (studentInfoObject, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    let studentInfoObject = PFObject(className: "UserEducationInfo")
                    studentInfoObject["targetDepartment"] = text
                    studentInfoObject.saveInBackground { (success, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else  {
                            print("saved education info")
                        }
                    }
                } else {
                    if let studentInfoObject = studentInfoObject {
                        studentInfoObject["targetDepartment"] = text
                        
                        studentInfoObject.saveInBackground { (success, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            } else  {
                                print("saved education info")
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - LOGOUT
    static func configureLogOutActionSheet(view: UIViewController) {
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            let logout = UIAlertAction(title: "Çıkış Yap", style: .default) { action in
                LyieUtils.startLogoutProcess(view: view)
            }
            
            let kvkk = UIAlertAction(title: "KVKK", style: .default) { action in
                let controller: KVKKViewController = UIStoryboard.home.instantiateViewController()
                view.navigationController?.pushViewController(controller, animated: true)
            }
            
            actionSheet.addAction(logout)
            actionSheet.addAction(cancel)
            actionSheet.addAction(kvkk)
            view.present(actionSheet, animated: true, completion: nil)
        } else {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            let logout = UIAlertAction(title: "Çıkış Yap", style: .default) { action in
                LyieUtils.startLogoutProcess(view: view)
            }
            
            let kvkk = UIAlertAction(title: "KVKK", style: .default) { action in
                let controller: KVKKViewController = UIStoryboard.home.instantiateViewController()
                view.navigationController?.pushViewController(controller, animated: true)
            }
            
            actionSheet.addAction(logout)
            actionSheet.addAction(cancel)
            actionSheet.addAction(kvkk)
            view.present(actionSheet, animated: true, completion: nil)
        }
        
    }
    
    static func startLogoutProcess(view: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            AlertModelAPI.dismissPupup()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.startLogoutProcess(completionHandler: {(success) -> Void in
                if success {
                    let controller = UIStoryboard.loginRegister.instantiateInitialViewController()
                    view.show(controller!, sender: nil)
                } else {
                    //Error
                }
            })
        }
    }
    
    static func logOut() {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                
            }
        }
    }

    //MARK:- SCORE PART
//    static func updateScoreDetail() {
//        var detailDesc = [String]()
//        var detailValue = [Int]()
//
//        detailDesc.removeAll(keepingCapacity: false)
//        detailValue.removeAll(keepingCapacity: false)
//
//        if let currentUser = PFUser.current() {
//            let currentUserScore = currentUser.relation(forKey: "userScore")
//            currentUserScore.query().findObjectsInBackground { (objects, error) in
//                if let objects = objects {
//                    if objects.count > 0 {
//                        for object in objects {
//                            self.count = objects.count
//                            self.detailDesc.append(object.object(forKey: "scoreDesc") as! String)
//                            self.detailValue.append(object.object(forKey: "scoreValue") as! Int)
//                            self.scoreTableView.reloadData()
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    static func calculatorScoreListCount() -> Int {
//        var count = 0
//        if let currentUser = PFUser.current() {
//            let query = PFQuery(className: "UserScoreInfo")
//            query.countObjectsInBackground { (count, error) in
//                count = Int(count)
//            }
//        }
//        return count
//    }
    
    static func scoreDetailPart(scoreDetail: UserScoreModel) {
        if let currentUser = PFUser.current() {
            let currentUserScoreObject = PFObject(className: "UserScoreInfo")
            currentUserScoreObject["userID"] = currentUser.username
            currentUserScoreObject["scoreDesc"] = scoreDetail.scoreDesc
            currentUserScoreObject["scoreValue"] = scoreDetail.scoreValue
            currentUserScoreObject["totalScore"] = scoreDetail.totalScore
            currentUserScoreObject.saveInBackground { (success, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else  {
                    print("saved education progress info")
                    let userEducation = currentUser.relation(forKey: "userScore")
                    userEducation.add(currentUserScoreObject)
                    currentUser.saveInBackground { (issuccess, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else {
                            print("saved")
                            LyieUtils.totalScore {
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func totalScore(_ completion: @escaping ()->()) {
        
//        if let user = UserDefaults.standard.string(forKey: currentUserKey), var infos = HomeMentorProvider.mentors(for: user) {
//            let scoreObject = PFQuery(className: "UserScoreInfo")
//            scoreObject.whereKey("userID", equalTo: PFUser.current()?.username)
//            scoreObject.order(byDescending: "totalScore")
//            scoreObject.getFirstObjectInBackground { (objc, error) in
//                if error != nil {
//
//                } else {
//                    if let objc = objc {
//                        infos.totalScoreUser = "\(objc["totalScore"] as? Int ?? 0)"
//                        print(objc["totalScore"] as? Int ?? 0)
//                        HomeMentorProvider.update(mentors: infos)
//                    } else {
//
//                    }
//                }
//            }
//        }
        if let user = UserDefaults.standard.string(forKey: currentUserKey), var infos = HomeMentorProvider.mentors(for: user) {
            if let currentUser = PFUser.current() {
                let currentUserScore = currentUser.relation(forKey: "userScore")
                currentUserScore.query().findObjectsInBackground { (objects, error) in
                    if let objects = objects {
                        if objects.count > 0 {
                            infos.totalScoreUser = "\(objects.count * 100)"
                            HomeMentorProvider.update(mentors: infos)
                        }
                    }
                }
            }
        }
    }
    
    
    
    //MARK: - CLASS
    static func getClassCount() {
//        let query = PFQuery(className: "UniversityList")
//        query.findObjectsInBackground { (objects, error) in
//            if let objects = objects {
//                if objects.count > 0 {
//                    for object in objects {
//                        universityArray.append(object.object(forKey: "universityName") as! String)
//                        universityId.append(object.object(forKey: "universityId") as! Int)
//                    }
//                }
//            }
//        }
    }
    
   
   
    
    
    
    //MARK: - QUESTION PART
    
    static func updateQuestion(desc: String, mainEducation: String, mainEducationValue: String, mainEducationCellNum: String, answerID: String) {
        
    }
    
    
    //MARK: - RESEARCHES PART
    
//    static func updateResearches() -> ResearchesFileModel {
//        let query = PFQuery(className: "Researches")
//        let pdfQuery = PFQuery(className: "Files")
//       
//        query.findObjectsInBackground { (objects, error) in
//            if error != nil {
//                print(error?.localizedDescription)
//            } else {
//                if let objects = objects {
//                    if objects.count > 0 {
//                        for object in objects {
//                            
//                            pdfQuery.whereKey("objectId", equalTo: object.objectId)
//                            query.whereKey("pdfFile", matchesQuery: pdfQuery)
//                            
//                            query.findObjectsInBackground { (objs, error) in
//                                if error != nil {
//                                    print(error?.localizedDescription)
//                                } else {
//                                    if let objs = objs {
//                                        if objs.count > 0 {
//                                            for obje in objs {
//                                                
//                                                model = ResearchesFileModel(objectId: object.object(forKey: "objectId"), title: object.object(forKey: "title"), desc: object.object(forKey: "desc"), coverImageURL: object.object(forKey: "coverImageURL"), coverImageFile: object.object(forKey: "coverImageFile"), file: objs.object(forKey: "file"))
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    //MARK: - EDUCATION PROGRESS
    
    static func objectCountValue() -> Int {
        var objectCount = 0
        if let currentUser = PFUser.current() {
            let query = PFQuery(className: "EducationMainLessons")
            query.whereKey("mainEducation", equalTo: "Inovation")
            query.findObjectsInBackground { (objects, error) in
                if let objects = objects {
                    for object in objects {
                        if object.object(forKey: "mainEducationValue") != nil && object.object(forKey: "mainEducationCellNum") != nil {
                            if object.object(forKey: "mainEducationValue") as! Int == 101 {
                                if object.object(forKey: "mainEducationCellNum") as! Int == 0 {
                                    objectCount = objectCount + 1
                                }
                            }
                        }
                    }
                }
            }
        }
        return objectCount
    }
    
    static func cancelInfoUserEducationProgress() {
        var objectCount = 0
        if let currentUser = PFUser.current() {
            let query = PFQuery(className: "EducationMainLessons")
            query.whereKey("mainEducation", equalTo: "Inovation")
            query.findObjectsInBackground { (objects, error) in
                if let objects = objects {
                    for object in objects {
                        if object.object(forKey: "mainEducationValue") != nil && object.object(forKey: "mainEducationCellNum") != nil {
                            if object.object(forKey: "mainEducationValue") as! Int == 101 {
                                if object.object(forKey: "mainEducationCellNum") as! Int == 0 {
                                    objectCount = objectCount + 1
                                }
                            }
                        }
                    }
                    LyieUtils.updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo(objectId: currentUser.objectId ?? "", userID: currentUser.username ?? "", education101iotNum: 0, education101aiNum: 0, education101inoNum: 1, mainEducation: "Inovation", mainEducationValue: 101, mainEducationCellNum: 0, currentEducationNum: 0, currentEducationsCount: objectCount, currentCell: 0, questionAreaCell: 0, questionAreaMainEdu: "Inovation", questionAreaMainValue: 101))
                    objectCount = 0
                }
            }
            
 
            if let user = UserDefaults.standard.string(forKey: currentUserKey), var studentEducationItem = StudentEducationProvider.studentEducations(for: user) {
                studentEducationItem.education101aiNum = 0
                studentEducationItem.education101inoNum = 1
                studentEducationItem.education101iotNum = 0
                studentEducationItem.mainEducation = "Inovation"
                studentEducationItem.mainEducationValue = 101
                studentEducationItem.mainEducationCellNum = 0
                studentEducationItem.currentEducationNum = 0
                studentEducationItem.currentCell = 0
                if let education = EducationStep(rawValue: studentEducationItem.mainEducation) {
                    let arrayCount = EducationServices.getList(by: education.rawValue, mainEduValue: studentEducationItem.mainEducationValue, mainEducationCellNum: studentEducationItem.mainEducationCellNum).count
                    studentEducationItem.currentEducationsCount = arrayCount
                }
                
                StudentEducationProvider.update(studentEducations: studentEducationItem)
            }
        }
        
    }
    static func updateUserEducationProgress(userEducationProgress: UserEducationProgressInfo) {
        if let user = PFUser.current() {
            let educationProgressClass = PFQuery(className: "UserEducationProgressInfo")
            educationProgressClass.whereKey("userID", equalTo: user.username)
            educationProgressClass.getFirstObjectInBackground { (currentUserEducationProgressObject, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    let currentUserEducationProgressObject = PFObject(className: "UserEducationProgressInfo")
                    currentUserEducationProgressObject["userID"] = PFUser.current()?.username
                    currentUserEducationProgressObject["education101iotNum"] = userEducationProgress.education101iotNum
                    currentUserEducationProgressObject["education101aiNum"] = userEducationProgress.education101aiNum
                    currentUserEducationProgressObject["education101inoNum"] = userEducationProgress.education101inoNum
                    currentUserEducationProgressObject["mainEducation"] = userEducationProgress.mainEducation
                    currentUserEducationProgressObject["mainEducationValue"] = userEducationProgress.mainEducationValue
                    currentUserEducationProgressObject["mainEducationCellNum"] = userEducationProgress.mainEducationCellNum
                    currentUserEducationProgressObject["currentEducationNum"] = userEducationProgress.currentEducationNum
                    
                    currentUserEducationProgressObject["currentCell"] = userEducationProgress.currentCell
                    currentUserEducationProgressObject["questionAreaMainEdu"] = userEducationProgress.questionAreaMainEdu
                    currentUserEducationProgressObject["questionAreaMainValue"] = userEducationProgress.questionAreaMainValue
                    currentUserEducationProgressObject["questionAreaCell"] = userEducationProgress.questionAreaCell
                    currentUserEducationProgressObject.saveInBackground { (success, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else  {
                            print("saved education progress info")
                                
                            let userEducation = user.relation(forKey: "userEducationProgress")
                            userEducation.add(currentUserEducationProgressObject)
                            user.saveInBackground { (issuccess, error) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                } else {
                                    print("saved")
                                    var objectCount = 0
                                    if let currentUser = PFUser.current() {
                                        let query = PFQuery(className: "EducationMainLessons")
                                        query.whereKey("mainEducation", equalTo: userEducationProgress.mainEducation)
                                        query.findObjectsInBackground { (objects, error) in
                                            if let objects = objects {
                                                for object in objects {
                                                    if object.object(forKey: "mainEducationValue") != nil && object.object(forKey: "mainEducationCellNum") != nil {
                                                        if object.object(forKey: "mainEducationValue") as! Int == userEducationProgress.mainEducationValue {
                                                            if object.object(forKey: "mainEducationCellNum") as! Int == 0 {
                                                                objectCount = objectCount + 1
                                                            }
                                                        }
                                                    }
                                                }
                                                currentUserEducationProgressObject["currentEducationsCount"] = objectCount
                                                currentUserEducationProgressObject.saveInBackground { (success, error) in
                                                    if error != nil {
                                                        print(error?.localizedDescription)
                                                    } else  {
                                                        print("saved education progress count info")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    objectCount = 0
                                }
                            }
                        }
                    }
                } else {
                    if let currentUserEducationProgressObject = currentUserEducationProgressObject {
                        currentUserEducationProgressObject["userID"] = PFUser.current()?.username
                        currentUserEducationProgressObject["education101iotNum"] = userEducationProgress.education101iotNum
                        currentUserEducationProgressObject["education101aiNum"] = userEducationProgress.education101aiNum
                        currentUserEducationProgressObject["education101inoNum"] = userEducationProgress.education101inoNum
                        currentUserEducationProgressObject["mainEducation"] = userEducationProgress.mainEducation
                        currentUserEducationProgressObject["mainEducationValue"] = userEducationProgress.mainEducationValue
                        currentUserEducationProgressObject["mainEducationCellNum"] = userEducationProgress.mainEducationCellNum
                        currentUserEducationProgressObject["currentEducationNum"] = userEducationProgress.currentEducationNum
                        currentUserEducationProgressObject["currentEducationsCount"] = userEducationProgress.currentEducationsCount
                        currentUserEducationProgressObject["currentCell"] = userEducationProgress.currentCell
                        currentUserEducationProgressObject["questionAreaMainEdu"] = userEducationProgress.questionAreaMainEdu
                        currentUserEducationProgressObject["questionAreaMainValue"] = userEducationProgress.questionAreaMainValue
                        currentUserEducationProgressObject["questionAreaCell"] = userEducationProgress.questionAreaCell
                        currentUserEducationProgressObject.saveInBackground { (success, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            } else  {
                                print("saved education progress info")
                                    
                                let userEducation = user.relation(forKey: "userEducationProgress")
                                userEducation.add(currentUserEducationProgressObject)
                                user.saveInBackground { (issuccess, error) in
                                    if error != nil {
                                        print(error?.localizedDescription)
                                    } else {
                                        print("saved")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    static func updateRealmData() {
        
    }
    //MARK: - MENTOR PART
    
    static func getMentorClass(userName: String) {
        var classId = ""
        let mentorInfoQuery = PFQuery(className: "MentorInfo")
        mentorInfoQuery.whereKey("UserID", equalTo: userName)
        mentorInfoQuery.findObjectsInBackground { (objects, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if let objects = objects {
                    if !objects.isEmpty {
                        if (objects.first != nil) {
                            if objects.first!["FirstClass"] != nil {
                                if let user = UserDefaults.standard.string(forKey: currentUserKey), var newUserItem = NewUserProvider.users(for: user) {
                                    if (objects.first!["FirstClass"] as! String) != nil {
                                        newUserItem.classID = "\(objects.first!["FirstClass"] as! String)"
                                        NewUserProvider.update(users: newUserItem)
                                        
                                        let studentClassInfoQuery = PFQuery(className: "ClassInfo")
                                        studentClassInfoQuery.whereKey("classID", equalTo: newUserItem.classID)
                                        studentClassInfoQuery.findObjectsInBackground { (objs, error) in
                                            if error != nil {
                                                print(error?.localizedDescription)
                                            } else {
                                                if let objs = objs {
                                                    if objs.first != nil {
                                                        if  objs.first!["SecondMentor"] as! String != nil {
                                                            newUserItem.SecondMentor = objs.first!["SecondMentor"] as! String
                                                            NewUserProvider.update(users: newUserItem)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func updateMentor(indexType: Int, nameInfoText: UILabel, title: UILabel, UniInfoText: UILabel, mentorPhoto: UIImageView, mentorController: Bool) {
        if let currentUser = PFUser.current() {
            let currentUserClass = currentUser.relation(forKey: "studentClassInfo")
            currentUserClass.query().findObjectsInBackground { (objects, error) in
                if let objects = objects {
                    if objects.count > 0 {
                        for object in objects {
                            if object.object(forKey: "FirstMentor") != nil {
                                if indexType == 0 {
                                    let firstUser = object.object(forKey: "FirstMentor") as! String
                                    if let query = PFUser.query() {
                                        query.whereKey("username", equalTo: firstUser)
                                        query.findObjectsInBackground { [self] (objects, error) in
                                            if error != nil  {
                                                print(error?.localizedDescription)
                                            } else {
                                                if let objects = objects {
                                                    if objects.count > 0 {
                                                        if objects.first != nil {
                                                            if objects.first!["fullName"] != nil {
                                                                nameInfoText.text = objects.first!["fullName"] as! String
                                                                if objects.first!["userImageUrl"] != nil {
                                                                    if let url = URL(string: objects.first!["userImageUrl"] as! String) {
                                                                        let data = try? Data(contentsOf: url)
                                                                        
                                                                        if let imageData = data {
                                                                            mentorPhoto.image = UIImage(data: imageData)!
                                                                        } else {
                                                                            mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                        }
                                                                    } else {
                                                                        mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                    }
                                                                } else {
                                                                    mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                }
                                                                title.text = "Mentor"
                                                                let educationInfo = objects.first?.relation(forKey: "userEducation")
                                                                educationInfo?.query().findObjectsInBackground(block: { (objes, error) in
                                                                    if error != nil {
                                                                        print(error?.localizedDescription)
                                                                    } else {
                                                                        if let objes = objes {
                                                                            if objes.count > 0 {
                                                                                if objes.first != nil {
                                                                                    if objes.first!["targetUniversity"] != nil {
                                                                                        UniInfoText.text = objes.first!["targetUniversity"] as! String
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                })
                                                            }
                                                        }
                                                    } else {
                                                        mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                if mentorController == false {
                                    nameInfoText.text = "Kamil Mercimek"
                                    mentorPhoto.image = UIImage(named: "Profile/photo1")
                                    title.text = "Lider"
                                    UniInfoText.text = "İstanbul Üniversitesi"
                                } else {
                                    if let query = PFUser.query() {
                                        query.whereKey("username", equalTo: PFUser.current()?.username)
                                        query.findObjectsInBackground { [self] (objects, error) in
                                            if error != nil  {
                                                print(error?.localizedDescription)
                                            } else {
                                                if let objects = objects {
                                                    if objects.count > 0 {
                                                        if objects.first != nil {
                                                            if objects.first!["fullName"] != nil {
                                                                nameInfoText.text = objects.first!["fullName"] as! String
                                                                if currentUser["userImageUrl"] != nil {
                                                                    if let url = URL(string: currentUser["userImageUrl"] as! String) {
                                                                        let data = try? Data(contentsOf: url)
                                                                        
                                                                        if let imageData = data {
                                                                            mentorPhoto.image = UIImage(data: imageData)!
                                                                        } else {
                                                                            mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                        }
                                                                    } else {
                                                                        mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                    }
                                                                } else {
                                                                    mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                }
                                                                title.text = "Mentor"
                                                                let educationInfo = objects.first?.relation(forKey: "userEducation")
                                                                educationInfo?.query().findObjectsInBackground(block: { (objes, error) in
                                                                    if error != nil {
                                                                        print(error?.localizedDescription)
                                                                    } else {
                                                                        if let objes = objes {
                                                                            if objes.count > 0 {
                                                                                if objes.first != nil {
                                                                                    if objes.first!["targetUniversity"] != nil {
                                                                                        UniInfoText.text = objes.first!["targetUniversity"] as! String
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                })
                                                            }
                                                        }
                                                    } else {
                                                        mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                            if object.object(forKey: "SecondMentor") != nil {
                                if indexType == 1 {
                                    let secondUser = object.object(forKey: "SecondMentor") as! String
                                    if let query = PFUser.query() {
                                        query.whereKey("username", equalTo: secondUser)
                                        query.findObjectsInBackground { [self] (objects, error) in
                                            if error != nil  {
                                                print(error?.localizedDescription)
                                            } else {
                                                if let objects = objects {
                                                    if objects.count > 0 {
                                                        if objects.first != nil {
                                                            if objects.first!["fullName"] != nil {
                                                                nameInfoText.text = objects.first!["fullName"] as! String
                                                                if objects.first!["userImageUrl"] != nil {
                                                                    if let url = URL(string: objects.first!["userImageUrl"] as! String) {
                                                                        let data = try? Data(contentsOf: url)
                                                                        
                                                                        if let imageData = data {
                                                                            mentorPhoto.image = UIImage(data: imageData)!
                                                                        } else {
                                                                            mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                        }
                                                                    } else {
                                                                        mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                    }
                                                                } else {
                                                                    mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                }
                                                                
                                                                title.text = "Mentor"
                                                                let educationInfo = objects.first?.relation(forKey: "userEducation")
                                                                educationInfo?.query().findObjectsInBackground(block: { (objes, error) in
                                                                    if error != nil {
                                                                        print(error?.localizedDescription)
                                                                    } else {
                                                                        if let objes = objes {
                                                                            if objes.count > 0 {
                                                                                if objes.first != nil {
                                                                                    if objes.first!["targetUniversity"] != nil {
                                                                                        UniInfoText.text = objes.first!["targetUniversity"] as! String
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                })
                                                            }
                                                        }
                                                    } else {
                                                        mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                if mentorController == false {
                                    nameInfoText.text = "Kamil Mercimek"
                                    mentorPhoto.image = UIImage(named: "Profile/photo1")
                                    title.text = "Lider"
                                    UniInfoText.text = "İstanbul Üniversitesi"
                                } else {
                                    if let query = PFUser.query() {
                                        query.whereKey("username", equalTo: PFUser.current()?.username)
                                        query.findObjectsInBackground { [self] (objects, error) in
                                            if error != nil  {
                                                print(error?.localizedDescription)
                                            } else {
                                                if let objects = objects {
                                                    if objects.count > 0 {
                                                        if objects.first != nil {
                                                            if objects.first!["fullName"] != nil {
                                                                nameInfoText.text = objects.first!["fullName"] as! String
                                                                if currentUser["userImageUrl"] != nil {
                                                                    if let url = URL(string: currentUser["userImageUrl"] as! String) {
                                                                        let data = try? Data(contentsOf: url)
                                                                        
                                                                        if let imageData = data {
                                                                            mentorPhoto.image = UIImage(data: imageData)!
                                                                        } else {
                                                                            mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                        }
                                                                    } else {
                                                                        mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                    }
                                                                } else {
                                                                    mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                }
                                                                title.text = "Mentor"
                                                                let educationInfo = objects.first?.relation(forKey: "userEducation")
                                                                educationInfo?.query().findObjectsInBackground(block: { (objes, error) in
                                                                    if error != nil {
                                                                        print(error?.localizedDescription)
                                                                    } else {
                                                                        if let objes = objes {
                                                                            if objes.count > 0 {
                                                                                if objes.first != nil {
                                                                                    if objes.first!["targetUniversity"] != nil {
                                                                                        UniInfoText.text = objes.first!["targetUniversity"] as! String
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                })
                                                            }
                                                        }
                                                    } else {
                                                        mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        if mentorController == false {
                            nameInfoText.text = "Kamil Mercimek"
                            mentorPhoto.image = UIImage(named: "Profile/photo1")
                            title.text = "Lider"
                            UniInfoText.text = "İstanbul Üniversitesi"
                        } else {
                            if let query = PFUser.query() {
                                query.whereKey("username", equalTo: PFUser.current()?.username)
                                query.findObjectsInBackground { [self] (objects, error) in
                                    if error != nil  {
                                        print(error?.localizedDescription)
                                    } else {
                                        if let objects = objects {
                                            if objects.count > 0 {
                                                if objects.first != nil {
                                                    if objects.first!["fullName"] != nil {
                                                        nameInfoText.text = objects.first!["fullName"] as! String
                                                        if currentUser["userImageUrl"] != nil {
                                                            if let url = URL(string: currentUser["userImageUrl"] as! String) {
                                                                let data = try? Data(contentsOf: url)
                                                                
                                                                if let imageData = data {
                                                                    mentorPhoto.image = UIImage(data: imageData)!
                                                                } else {
                                                                    mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                                }
                                                            } else {
                                                                mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                            }
                                                        } else {
                                                            mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                                        }
                                                        title.text = "Mentor"
                                                        let educationInfo = objects.first?.relation(forKey: "userEducation")
                                                        educationInfo?.query().findObjectsInBackground(block: { (objes, error) in
                                                            if error != nil {
                                                                print(error?.localizedDescription)
                                                            } else {
                                                                if let objes = objes {
                                                                    if objes.count > 0 {
                                                                        if objes.first != nil {
                                                                            if objes.first!["targetUniversity"] != nil {
                                                                                UniInfoText.text = objes.first!["targetUniversity"] as! String
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        })
                                                    }
                                                }
                                            } else {
                                                mentorPhoto.image = UIImage(named: "Profile/profile-1")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }



    //MARK: - EDUCATIONS
    
    func createdRealmObjForEducation() {
        let mainQuery = PFQuery(className: "EducationMainCourse")
        mainQuery.limit = 100000
        mainQuery.findObjectsInBackground { mainObj, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if let mainObj = mainObj {
                    if EducationMainCourseProvider.educationMainCourse().count != mainObj.count {
                        EducationMainCourseNotifier.shared.removeAll()
                        for i in 0..<mainObj.count {
                            EducationMainCourseProvider.create(with: "\(i)")
                            if var mainCourseItem = EducationMainCourseProvider.educationMainCourse(for: "\(i)") {
                                mainCourseItem.coverImageURL = mainObj[i]["coverImageURL"] as? String ?? ""
                                mainCourseItem.level = mainObj[i]["level"] as? String ?? ""
                                mainCourseItem.desc = mainObj[i]["desc"] as? String ?? ""
                                mainCourseItem.title = mainObj[i]["title"] as? String ?? ""
                                EducationMainCourseProvider.update(educationMainCourse: mainCourseItem)
                                
                                let childCourses = mainObj[i].relation(forKey: "educationChildCourses")
                                childCourses.query().findObjectsInBackground { (childCoursesObj, error) in
                                    if error != nil {
                                        print(error?.localizedDescription)
                                    } else {
                                        if let childCoursesObj = childCoursesObj {
                                            if EducationChildCoursesProvider.educationChildCourses().count != childCoursesObj.count {
                                                EducationChildCoursesNotifier.shared.removeAll()
                                                
                                                for j in 0..<childCoursesObj.count {
                                                    let id = childCoursesObj[j]["courseId"]!
                                                    EducationChildCoursesProvider.create(with: "\(id)")
                                                    
                                                    if var childCourseItem = EducationChildCoursesProvider.educationChildCourses(for: String(describing: id)) {
                                                        childCourseItem.mainEducationValue = childCoursesObj[j]["mainEducationValue"] as? Int ?? 0
                                                        childCourseItem.mainEducation = childCoursesObj[j]["mainEducation"] as? String ?? ""
                                                        childCourseItem.imageURL = childCoursesObj[j]["imageURL"] as? String ?? ""
                                                        childCourseItem.mainEducationCellNumber = childCoursesObj[j]["mainEducationCellNum"] as? Int ?? 0
                                                        childCourseItem.courseId = childCoursesObj[j]["courseId"] as? Int ?? 0
                                                        childCourseItem.title = childCoursesObj[j]["title"] as? String ?? ""
                                                        childCourseItem.descText = childCoursesObj[j]["descText"] as? String ?? ""
                                                        EducationChildCoursesProvider.update(educationChildCourses: childCourseItem)
                                                        
                                                        let mainLessons = childCoursesObj[j].relation(forKey: "educationMainLessons")
                                                        mainLessons.query().findObjectsInBackground { (mainLessonsObj, error) in
                                                            if error != nil {
                                                                print(error?.localizedDescription)
                                                            } else {
                                                                if let mainLessonsObj = mainLessonsObj {
                                                                    if EducationMainLessonsProvider.educationMainLessons().count != mainLessonsObj.count {
                                                                        EducationMainLessonsNotifier.shared.removeAll()
                                                                        
                                                                        for k in 0..<mainLessonsObj.count {
                                                                            let mainID = mainLessonsObj[k]["courseId"]!
                                                                            EducationMainLessonsProvider.create(with: "\(mainID)")
                                                                            
                                                                            if var mainLessonsItem = EducationMainLessonsProvider.educationMainLessons(for: String(describing: mainID)) {
                                                                                mainLessonsItem.mainEducationValue = mainLessonsObj[k]["mainEducationValue"] as? Int ?? 0
                                                                                mainLessonsItem.childCellNum = mainLessonsObj[k]["childCellNum"] as? Int ?? 0
                                                                                mainLessonsItem.cellHeight = mainLessonsObj[k]["cellHeight"] as? Int ?? 0
                                                                                mainLessonsItem.rightText = mainLessonsObj[k]["rightText"] as? String ?? ""
                                                                                mainLessonsItem.leftValue = mainLessonsObj[k]["leftValue"] as? Bool ?? false
                                                                                mainLessonsItem.mainEducation = mainLessonsObj[k]["mainEducation"] as? String ?? ""
                                                                                mainLessonsItem.navigate = (mainLessonsObj[k]["navigate"] != nil)
                                                                                mainLessonsItem.leftText = mainLessonsObj[k]["leftText"] as? String ?? ""
                                                                                mainLessonsItem.videoUrl = mainLessonsObj[k]["videoUrl"] as? String ?? ""
                                                                                mainLessonsItem.rightValue = mainLessonsObj[k]["rightValue"] as? Bool ?? false
                                                                                mainLessonsItem.mainEducationCellNum = mainLessonsObj[k]["mainEducationCellNum"] as? Int ?? 0
                                                                                mainLessonsItem.courseId = mainLessonsObj[k]["courseId"] as? Int ?? 0
                                                                                mainLessonsItem.childId = mainLessonsObj[k]["childId"] as? Int ?? 0
                                                                                mainLessonsItem.title = mainLessonsObj[k]["title"] as? String ?? ""
                                                                                mainLessonsItem.type = mainLessonsObj[k]["type"] as? String ?? ""
                                                                                mainLessonsItem.educationImageURL = mainLessonsObj[k]["educationImageURL"] as? String ?? ""
                                                                                mainLessonsItem.navigateCount = mainLessonsObj[k]["navigateCount"] as? Int ?? 0
                                                                                mainLessonsItem.descText = mainLessonsObj[k]["descText"] as? String ?? ""
                                                                                mainLessonsItem.pdfUrl = mainLessonsObj[k]["pdfUrl"] as? String ?? ""
                                                                                EducationMainLessonsProvider.update(educationMainLessons: mainLessonsItem)
                                                                                
                                                                                if mainLessonsItem.navigateCount != 0 {
                                                                                    
                                                                                    let childLessonsQuery = PFQuery(className: "EducationChildLessons")
                                                                                    childLessonsQuery.whereKey("childId", equalTo: mainLessonsItem.childId)
                                                                                    childLessonsQuery.getFirstObjectInBackground { childLessonsObj, error in
                                                                                        if error != nil {
                                                                                            print(error?.localizedDescription)
                                                                                        } else {
                                                                                            if let childLessonsObj = childLessonsObj {
                                                                                                EducationChildLessonsProvider.create(with: "\(mainLessonsItem.childId)")
                                                                                                
                                                                                                if var childLessonsItem = EducationChildLessonsProvider.educationChildLessons(for: "\(mainLessonsItem.childId)") {
                                                                                                    childLessonsItem.educationImageURL0 = childLessonsObj["educationImageURL0"] as? String ?? ""
                                                                                                    childLessonsItem.educationImageURL1 = childLessonsObj["educationImageURL1"] as? String ?? ""
                                                                                                    childLessonsItem.educationImageURL2 = childLessonsObj["educationImageURL2"] as? String ?? ""
                                                                                                    childLessonsItem.educationImageURL3 = childLessonsObj["educationImageURL3"] as? String ?? ""
                                                                                                    childLessonsItem.educationImageURL4 = childLessonsObj["educationImageURL4"] as? String ?? ""
                                                                                                    childLessonsItem.educationImageURL5 = childLessonsObj["educationImageURL5"] as? String ?? ""
                                                                                                    childLessonsItem.educationImageURL6 = childLessonsObj["educationImageURL6"] as? String ?? ""
                                                                                                    childLessonsItem.childId = childLessonsObj["childId"] as? Int ?? 0
                                                                                                    childLessonsItem.title = childLessonsObj["title"] as? String ?? ""
                                                                                                    childLessonsItem.descText = childLessonsObj["descText"] as? String ?? ""
                                                                                                    
                                                                                                    EducationChildLessonsProvider.update(educationChildLessons: childLessonsItem)
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
