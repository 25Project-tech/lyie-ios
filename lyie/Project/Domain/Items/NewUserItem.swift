//
//  NewUserItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

import Foundation

struct NewUserItem: Codable {
    var identifier: String = ""
    var userType: String = "" //0
    var name: String = ""  //1
    var password: String = "" //2
    var phone: String = "" //3
    var mail: String = "" //4
    var userID: String = "" //5
    var classID: String = "" //6
    var highSchoolName: String = "" //7
    var University: String = "" //8
    var Department: String = "" //9
    var FirstMentor: String = ""  //10
    var SecondMentor: String = ""  //11
    var FirstClass: String = ""  //12
    var SecondClass: String = "" //13
    var city: Int = 0
    var approvedKVKK: Bool = false
}

extension NewUserItem {
    init(with model: NewUserModelRealm) {
        identifier = model.identifier
        userType = model.userType
        name = model.name
        password = model.password
        phone = model.phone
        mail = model.mail
        userID = model.userID
        classID = model.classID
        highSchoolName = model.highSchoolName
        University = model.University
        Department = model.Department
        FirstMentor = model.FirstMentor
        SecondMentor = model.SecondMentor
        FirstClass = model.FirstClass
        SecondClass = model.SecondClass
        city = model.city
        approvedKVKK = model.approvedKVKK
    }
}


