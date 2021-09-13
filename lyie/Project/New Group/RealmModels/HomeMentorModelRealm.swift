//
//  HomeMentorModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 3.05.2021.
//

import Foundation
import RealmSwift

class HomeMentorModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var userImageURL: String = ""
    @objc dynamic var parentFirstUserName: String = ""
    @objc dynamic var parentFirstUserUniversity: String = ""
    @objc dynamic var parentFirstUserUrl: String = ""
    @objc dynamic var parentSecondUserName: String = ""
    @objc dynamic var parentSecondUserUniversity: String = ""
    @objc dynamic var parentSecondUserUrl: String = ""
    @objc dynamic var totalScoreUser: String = "0"
}

