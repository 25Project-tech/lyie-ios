//
//  FirebaseEventTracker.swift
//  NewProject
//
//  Created by Sevcan Eşim on 14/11/20
//  Copyright © 2020 Sevcan Esim. All rights reserved.
//

enum FirebaseEventType: String {
    case AGREEMENT_PROBLEM
    case GOOGLE_LOGIN_SUCCESS
    case GOOGLE_LOGIN_FAIL
    case SIGN_UP_SUCCESS
    case SIGN_UP_FAIL
    case CRM_ERROR
    case FORGET_PASSWORD_SUCCESS
    case FORGET_PASSWORD_FAIL
    case REGISTER
    case LOGOUT
    case GET_BACKUP
}

enum LoginFailType: String {
    case PASSWORD_OR_EMAIL_INCORRECT
    case USER_NOT_REGISTERED
    case USER_NOT_ACTIVE
    case INTERNET_CONNECTION_PROBLEM
    case UNKNOWN
}

enum AgreementProblemType: String {
    case AGREEMENT_IS_NOT_ACCEPTED
}

enum SignUpFailType: String {
    case USERNAME_REGISTERED_ACTIVE_USER
    case USERNAME_REGISTERED_INACTIVE_USER
}

enum ForgotPasswordFailType: String {
    case CUSTOMER_NOT_FOUND
    case UNKNOWN
    case INTERNET_CONNECTION_PROBLEM
    case REGISTER_ERROR
}

enum ProfilUpdateType: String {
    case NAME
    case SURNAME
    case AGE
    case GENDER
    case HEIGHT
    case WEIGHT
    case TARGET_WEIGHT
}


//import FirebaseAnalytics

func sendLogEvent(eventName: String ,attribute: String) {
    
//    Analytics.logEvent(eventName,
//                       parameters:
//                        [eventName: attribute])
}

