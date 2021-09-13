//
//  UserItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 8.12.2020.
//

import Foundation

struct UserItem: Codable {
    var identifier: String = ""
    var userType: String = ""
    var userID: String = ""
    var password: String = ""
    var name: String = ""
    var targetString: String = ""
    var dateofBirth: Date?
    var placeofBirth: Int = 0
    var gender: String = ""
    var city: Int = 0
    var phone: String = ""
    var mail: String = ""
    var navigateKargaKarga: Bool = false
    var questionCount: Int = 0
    var classID: String = ""
}

extension UserItem {
    init(with model: UserModelRealm) {
        identifier = model.identifier
        userType = model.userType
        userID = model.userID
        password = model.password
        name = model.name
        targetString = model.targetString
        dateofBirth = model.dateofBirth
        placeofBirth = model.placeofBirth
        gender = model.gender
        city = model.city
        phone = model.phone
        mail = model.mail
        navigateKargaKarga = model.navigateKargaKarga
        questionCount = model.questionCount
        classID = model.classID
    }
}
