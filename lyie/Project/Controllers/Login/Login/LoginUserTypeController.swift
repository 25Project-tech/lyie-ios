//
//  LoginUserTypeController.swift
//  lyie
//
//  Created by Sevcan Eşim on 22.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit
import Parse

class LoginUserTypeController: UIViewController, Localizable {
    
    @IBOutlet weak var highSLoginLabel: UILabel!
    @IBOutlet weak var mentorLoginLabel: UILabel!
    @IBOutlet weak var inovatimLoginLabel: UILabel!
    @IBOutlet weak var hsView: UIView!
    @IBOutlet weak var mentorView: UIView!
    @IBOutlet weak var inovatimView: UIView!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            GradientView.makeViewGradient(view: signUpButton, firstColor: StyleManager.colors.mLoginStart, secondColor: StyleManager.colors.mLoginStop)
        }
    }
    @IBOutlet weak var highSLogin: UIButton! {
        didSet {
            GradientView.makeViewGradient(view: highSLogin, firstColor: StyleManager.colors.hsLoginButtonStart, secondColor: StyleManager.colors.hsLoginButtonStop)
        }
    }
    
    @IBOutlet weak var mentorLogin: UIButton! {
        didSet {
            GradientView.makeViewGradient(view: mentorLogin, firstColor: StyleManager.colors.mLoginStart, secondColor: StyleManager.colors.mLoginStop)
        }
    }
    
    //Kullanıcı kaydı için
    @IBOutlet weak var inovatimLogin: UIButton! {
        didSet {
            GradientView.makeViewGradient(view: inovatimLogin, firstColor: StyleManager.colors.mLoginStart, secondColor: StyleManager.colors.mLoginStop)
        }
    }
    
    func applyLanguage() {
        highSLoginLabel.text = .localized(.highSLoginText)
        highSLoginLabel.textColor = .white
        mentorLoginLabel.text = .localized(.mentorLoginText)
        mentorLoginLabel.textColor = .white
        inovatimLoginLabel.text = .localized(.inovatimLoginText)
        inovatimLoginLabel.textColor  = .white
        signUpButton.cornerRadius = 10.0
        signUpButton.setTitle("Kayıt Ol", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingLanguage()
        initItems("1234567")
        inovatimView.isHidden = false
    }
    
    deinit {
        stopObservingLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func hsLogin(_ sender: Any) {
        if let user = UserDefaults.standard.string(forKey: currentUserKey), let newUserItem = NewUserProvider.users(for: user) {
            if newUserItem.userType == "User" {
                //student
                navigateToLogin(userType: "User")
            } else {
                //student
                navigateToLogin(userType: "Student")
            }
        } else {
            //student
            navigateToLogin(userType: "Student")
        }
    }
    
    @IBAction func mLogin(_ sender: Any) {
        //mentor
        navigateToLogin(userType: "Mentor")
    }
    
    @IBAction func iLogin(_ sender: Any) {
        //LUser
        navigateToLogin(userType: "User")
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let controller: SignUpVC = UIStoryboard.loginRegister.instantiateViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func navigateToLogin(userType: String) {
        if let controller: LoginViewController = self.storyboard?.instantiateViewController() {
            controller.userType = userType
            if let user = UserDefaults.standard.string(forKey: currentUserKey), var userItem = UserProvider.users(for: user) {
                userItem.userType = userType
                UserProvider.update(users: userItem)
            }
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    /// Init Views populate User Defaults & Stuff
    func initItems(_ userId: String) {
        UserDefaults.standard.set(userId, forKey: currentUserKey)
        UserDefaults.standard.synchronize()
        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
            let userItem = UserProvider.users(for: currentUserInfo)
            if userItem == nil {
                UserProvider.create(with: currentUserInfo)
            }
            
            let studentInfoItem = StudentInfoProvider.studentInfos(for: currentUserInfo)
            if studentInfoItem == nil {
                StudentInfoProvider.create(with: currentUserInfo)
            }
            
            let studentEducationItem = StudentEducationProvider.studentEducations(for: currentUserInfo)
            if studentEducationItem == nil {
                StudentEducationProvider.create(with: currentUserInfo)
            }
            
            let newUserItem = NewUserProvider.users(for: currentUserInfo)
            if newUserItem == nil {
                NewUserProvider.create(with: currentUserInfo)
            }
            
            let homeMentorItem = HomeMentorProvider.mentors(for: currentUserInfo)
            if homeMentorItem == nil {
                HomeMentorProvider.create(with: currentUserInfo)
            }
        }
    }
}
