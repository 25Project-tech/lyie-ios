//
//  NewUserModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

import Foundation
import RealmSwift

class NewUserModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var userType: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var mail: String = ""
    @objc dynamic var userID: String = ""
    @objc dynamic var classID: String = ""
    @objc dynamic var highSchoolName: String = ""
    @objc dynamic var University: String = ""
    @objc dynamic var Department: String = ""
    @objc dynamic var FirstMentor: String = ""
    @objc dynamic var SecondMentor: String = ""
    @objc dynamic var FirstClass: String = ""
    @objc dynamic var SecondClass: String = ""
    @objc dynamic var city: Int = 0
    @objc dynamic var approvedKVKK: Bool = false
}



