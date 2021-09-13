//
//  LoginViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit
import PopupDialog
import Parse
import KRProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate, OnTapKeyboardHideable, Localizable {
    
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var showHidePassButton: UIButton!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            GradientView.makeViewGradient(view: loginButton, firstColor: StyleManager.colors.loginButtonStart, secondColor: StyleManager.colors.loginButtonStop)
        }
    }
    var userType: String = ""
    var iconClick = true
    var popup: PopupDialog!
    private var keyboardHandler: KeyboardHandler?
    
    func applyLanguage() {
        loginButton.setTitle(.localized(.login), for: .normal)
        orLabel.text = .localized(.or)
        orLabel.textColor = StyleManager.colors.lineColor
        registerButton.setTitle(.localized(.forget_password), for: .normal)
        idTF.attributedPlaceholder = NSAttributedString(string: .localized(.id),
                                                        attributes: [NSAttributedString.Key.foregroundColor: StyleManager.colors.lineColor])
        passTF.attributedPlaceholder = NSAttributedString(string: .localized(.password),
                                                          attributes: [NSAttributedString.Key.foregroundColor: StyleManager.colors.lineColor])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PFUser.logOut()
        startObservingLanguage()
        self.idTF.delegate = self
        self.passTF.delegate = self
        keyboardHandler = KeyboardHandler(with: scrollView, responders: [scrollView.subviews.first!])
    }
    
    deinit {
        stopObservingLanguage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        BG {
            self.UI {
                self.setupHideKeyboardOnTapRecognizer()
                self.idTF.becomeFirstResponder()
                self.idTF.autocorrectionType = .no
                self.idTF.inputAccessoryView = nil
                self.idTF.reloadInputViews()
                
                self.passTF.becomeFirstResponder()
                self.passTF.autocorrectionType = .no
                self.passTF.inputAccessoryView = nil
                self.passTF.reloadInputViews()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        idTF.resignFirstResponder()  //if desired
        passTF.resignFirstResponder()
        performAction()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func showAndHidePassButton(_ sender: Any) {
        if(iconClick) {
            passTF.isSecureTextEntry = false
            showHidePassButton.setImage(UIImage(named: "Settings/hidepass")?.tint(with: .darkGray), for: .normal)
        } else {
            passTF.isSecureTextEntry = true
            showHidePassButton.setImage(UIImage(named: "Settings/showpass")?.tint(with: .darkGray), for: .normal)
        }
        iconClick = !iconClick
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let query = PFUser.query()
        query?.whereKey("username", equalTo: self.idTF.text)
        query?.findObjectsInBackground(block: { (userObj, error) in
            if let userObj = userObj {
                if userObj.first?["userType"] != nil {
                    if userObj.first?["userType"] as! String == "User" {
                        if self.userType == "Student" {
                            self.userType = "User"
                            self.performAction()
                        } else if self.userType == "User" {
                            self.performAction()
                        }
                    } else {
                        self.performAction()
                    }
                }
            } else {
                self.performAction()
            }
        })
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        navigateToRegister()
    }
    
    func navigateToRegister() {
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigateToProfileUpdate() {
        if let currentUser = PFUser.current() {
            if (currentUser.username == "adminMentor") && (currentUser["userPass"] as! String == "1234Admin") {
                let controller: SignUpTableViewController = UIStoryboard.loginRegister.instantiateViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                let controller: ProfileUpdateTableViewController = UIStoryboard.loginRegister.instantiateViewController()
                if let pass = self.passTF.text {
                    controller.userPass = self.passTF.text!
                }
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    func performAction() {
        let idText = self.idTF.text
        let passText = self.passTF.text
        if (idText != "") && (passText != "") {
            KRProgressHUD.show()
            let query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: idText)
            query.findObjectsInBackground { [self] (objects, error) in
                if error != nil  {
                    KRProgressHUD.dismiss {
                        self.errorWarning(titleText: "Hata", des: error!.localizedDescription)
                    }
                } else if let objects = objects {
                    if objects.count > 0 {
                        if objects.first != nil {
                            if objects.first!["userType"] != nil {
                                if objects.first!["userType"] as! String == userType {
                                    PFUser.logInWithUsername(inBackground: idText!, password: passText!) { (user, error) in
                                        if user != nil {
                                            KRProgressHUD.dismiss {
                                                print("Login")
                                                if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
                                                    if var userItem = UserProvider.users(for: currentUserInfo) {
                                                        userItem.userType = objects.first!["userType"] as! String
                                                        userItem.userID = idText!
                                                        userItem.password = passText!
                                                        UserProvider.update(users: userItem)
                                                    }
                                                }
                                                self.navigateToProfileUpdate()
                                            }
                                        } else {
                                            KRProgressHUD.dismiss {
                                                self.errorWarning(titleText: "Hata", des: "Şifreniz yanlış")
                                            }
                                        }
                                    }
                                } else {
                                    KRProgressHUD.dismiss {
                                        errorWarning(titleText: "Hata", des: "Kullanıcı giriş alanı yanlıştır.")
                                    }
                                }
                            } else  {
                                KRProgressHUD.dismiss {
                                    self.errorWarning(titleText: "Hata", des: "Kullanıcı türü atanmamıştır.")
                                }
                            }
                        } else {
                            KRProgressHUD.dismiss {
                                self.errorWarning(titleText: "Hata", des: "Kullanıcı bulunamamaktadır.")
                            }
                        }
                    } else {
                        KRProgressHUD.dismiss {
                            self.errorWarning(titleText: "Hata", des: "Kullanıcı adınız ve ya şifreniz yanlış")
                        }
                    }
                }
            }
        } else {
            errorWarning(titleText: "Hata", des: "Alanlar boş bırakılamaz.")
        }
    }
}

// MARK: - AlertPopupViewDelegate
extension LoginViewController: AlertPopupViewDelegate {
    func closeTapped() {
        
    }
    
    func alertAccept() {
        popup?.dismiss()
    }
    
    func alertCancel() {
        popup?.dismiss()
    }
    
    func firstTapped() {
    }
    
    func secondTapped() {
    }
    
    func thirdTapped() {
    }
    
    func errorWarning(titleText: String, des: String) {
        self.UI {
            AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: titleText, desc: des, vc: self)
        }
    }
}
