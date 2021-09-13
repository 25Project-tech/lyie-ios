//
//  ClassMemberItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 23.06.2021.
//

import Foundation

struct ClassMemberItem: Codable {
    var identifier: String = ""
    var classCode: Int = 0
    var userType: String = ""
    var userID: String = ""
    var name: String = ""
    var dateofBirth: Date?
    var gender: String = ""
    var city: Int = 0
    var phone: String = ""
    var mail: String = ""
    var score: Int = 0
    var educationInfo: String = ""
}

extension ClassMemberItem {
    init(with model: ClassMemberModelRealm) {
        identifier = model.identifier
        classCode = model.classCode
        userType = model.userType
        userID = model.userID
        name = model.name
        dateofBirth = model.dateofBirth
        gender = model.gender
        city = model.city
        phone = model.phone
        mail = model.mail
        score = model.score
        educationInfo = model.educationInfo
    }
}

