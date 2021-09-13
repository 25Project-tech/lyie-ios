//
//  QuestionModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
import RealmSwift

class QuestionModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var userID: String = ""
    @objc dynamic var question: String = ""
    @objc dynamic var mainEducation: String = ""
    @objc dynamic var mainEducationValue: Int = 101
    @objc dynamic var mainEducationCellNum: Int = 0
    @objc dynamic var childCellNum: Int = 0
    @objc dynamic var userPhotoURL: String = ""
}



