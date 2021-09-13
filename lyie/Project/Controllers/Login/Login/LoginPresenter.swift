//
//  LoginPresenter.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import Alamofire

class LoginPresenter {
    private var loginView: LoginView!
    
    init(loginView: LoginView) {
        self.loginView = loginView
    }
    
    func loginUserWithGoogle(token: String, viewController: UIViewController) {
        let header = Header(authHeader: AuthHeader(username: "vestekmobile", password: "vektora1"))
        let bodyType = GoogleLoginBodyType(token: token, applicationId: "432")
        let body = GoogleLoginBody()
        body.bodyType = bodyType
        let loginRequest = BaseRequest(action: "LoginByGoogle", header:header , body: body)
        let router = APIRouter.loginWithGoogle(loginRequest: loginRequest)
        
        NetworkingModule().request(router: router,baseView: loginView,viewController:viewController,completion:  {response in
            switch response.result{
            case .success(let resultModel):
                if let jsonData = resultModel.data(using: .utf8)
                {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(GoogleLoginResponse.self, from: jsonData)
                        self.loginView.onLoginWithGoogleSuccess(response: response)
                    } catch {
                        LyieLog.mPrint(error.localizedDescription)
                    }
                }
            case .failure(let error):
                LyieLog.mPrint(error)
                break
            }
        })
    }
    
    func loginUserWithLyie(email: String, password: String, viewController: UIViewController) {
        let header = Header(authHeader: AuthHeader(username: "vestekmobile", password: "vektora1"))
        let bodyType = LyieLoginBodyType(email: email, password: password, userAgent: "Dev")
        let body = LyieLoginBody()
        body.bodyType = bodyType
        let loginRequest = BaseRequest(action: "Login", header:header , body: body)
        let router = APIRouter.loginWithLyie(loginRequest: loginRequest)
        
        
        NetworkingModule().request(router: router,baseView: loginView,viewController: viewController,completion:  {response in
            switch response.result{
            case .success(let resultModel):
                if let jsonData = resultModel.data(using: .utf8)
                {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(LyieLoginResponse.self, from: jsonData)
                        
                        switch (response.loginResponse?.loginResult?.responseCode)  {
                        case "6":
                            self.loginView.onLyieCredentialError()
                        case "5":
                            self.loginView.onLyieEmailActivationNotValid()
                        case "4":
                            self.loginView.onLyieUserNotFound()
                        case "3":
                            self.loginView.onLyieCredentialError()
                        case "1":
                            self.loginView.onLoginWithLyieSuccess(response: response)
                        default:
                            LyieLog.mPrint("default")
                        }
                        
                    } catch {
                        LyieLog.mPrint(error.localizedDescription)
                    }
                }
            case .failure(let error):
                LyieLog.mPrint(error)
                
                break
            }
        })
    }
    
    func getUserDetails(LyieToken: String, viewController: UIViewController) {
        let header = Header(authHeader: AuthHeader(username: "vestekmobile", password: "vektora1"))
        let bodyType = UserDetailBodyType(token: LyieToken, userAgent: "")
        let body = UserDetailBody()
        body.bodyType = bodyType
        let userRequest = BaseRequest(action: "GetUserDetail", header:header , body: body)
        let router = APIRouter.getUserDetails(userRequest: userRequest)
        
        NetworkingModule().request(router: router,baseView: loginView,viewController:viewController,completion:  {response in
            switch response.result{
            case .success(let resultModel):
                if let jsonData = resultModel.data(using: .utf8)
                {
                    let decoder = JSONDecoder()
                    do {
                        let userDetailResponse = try decoder.decode(UserDetailResponse.self, from: jsonData)
                        self.loginView.onGetUserDetails(response: userDetailResponse)
                    } catch {
                        LyieLog.mPrint(error.localizedDescription)
                    }
                }
            case .failure(let error):
                LyieLog.mPrint(error)
                break
            }
        })
    }
}

