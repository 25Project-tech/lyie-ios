//
//  UserModel.swift
//  lyie
//
//  Created by Sevcan Eşim on 26.02.2021.
//

import Foundation
import Parse

class UserModel {
    
    var objectId: String
    var placeOfBirth: Int
    var gender: String
    var emailVerified: Bool
    var userType: String
    var city: Int
    var phone: String
    var navigateKK: Bool
//    var mentors:
    var userName: String
    var dateOfBirth: Date
    var fullName: String
    var password: String
    var email: String
    
    init(objectId: String, placeOfBirth: Int, gender: String, emailVerified: Bool, userType: String, city: Int, phone: String, navigateKK: Bool, userName: String, dateOfBirth: Date, fullName: String, password: String, email: String) {
        self.objectId = objectId
        self.placeOfBirth = placeOfBirth
        self.gender = gender
        self.emailVerified = emailVerified
        self.userType = userType
        self.city = city
        self.phone = phone
        self.navigateKK = navigateKK
        self.userName = userName
        self.dateOfBirth = dateOfBirth
        self.fullName = fullName
        self.password = password
        self.email = email
    }
}

