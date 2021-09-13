//
//  StudentEducationModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
import RealmSwift

class StudentEducationModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var education101iotNum: Int = 0
    @objc dynamic var education101aiNum: Int = 0
    @objc dynamic var education101inoNum: Int = 1
    @objc dynamic var mainEducation: String = ""
    @objc dynamic var mainEducationValue: Int = 101
    @objc dynamic var mainEducationCellNum: Int = 0
    @objc dynamic var currentEducationNum: Int = 0
    @objc dynamic var currentEducationsCount: Int = 0
    @objc dynamic var currentCell: Int = 0
    @objc dynamic var questionAreaCell: Int = 0
    @objc dynamic var questionAreaMainEdu: String = ""
    @objc dynamic var questionAreaMainValue: Int = 0
}
