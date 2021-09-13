//
//  ClassMemberModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 23.06.2021.
//

import Foundation
import RealmSwift

class ClassMemberModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var classCode: Int = 0
    @objc dynamic var userType: String = ""
    @objc dynamic var userID: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var dateofBirth: Date?
    @objc dynamic var gender: String = ""
    @objc dynamic var city: Int = 0
    @objc dynamic var phone: String = ""
    @objc dynamic var mail: String = ""
    @objc dynamic var score: Int = 0
    @objc dynamic var educationInfo: String = ""
}

