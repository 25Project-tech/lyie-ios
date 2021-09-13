//
//  EducationMainCourseModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift

class EducationMainCourseModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var coverImageURL: String = ""
    @objc dynamic var level: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var title: String = ""
}
