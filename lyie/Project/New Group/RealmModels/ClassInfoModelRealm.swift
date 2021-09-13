//
//  ClassInfoModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
import RealmSwift

class ClassInfoModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var classID: String = ""
    @objc dynamic var firstMentorID: String = ""
    @objc dynamic var secondMentorID: String = ""
}
