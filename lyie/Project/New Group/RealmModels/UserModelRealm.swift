//
//  UserModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
import RealmSwift

class UserModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var userType: String = ""
    @objc dynamic var userID: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var targetString: String = ""
    @objc dynamic var dateofBirth: Date?
    @objc dynamic var placeofBirth: Int = 0
    @objc dynamic var gender: String = ""
    @objc dynamic var city: Int = 0
    @objc dynamic var phone: String = ""
    @objc dynamic var mail: String = ""
    @objc dynamic var navigateKargaKarga: Bool = false
    @objc dynamic var questionCount: Int = 0
    @objc dynamic var classID: String = ""
}
