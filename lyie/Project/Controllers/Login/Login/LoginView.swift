//
//  LoginView.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

protocol LoginView: BaseView {
    func onLoginWithGoogleSuccess(response: GoogleLoginResponse)
    func onLoginWithLyieSuccess(response: LyieLoginResponse)
    
    func onLyieUserNotFound()
    func onLyieCredentialError()
    func onLyieEmailActivationNotValid()
    
    func onGetUserDetails(response: UserDetailResponse)
}
