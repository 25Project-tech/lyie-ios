//
//  EducationChildCoursesModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift

class EducationChildCoursesModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var mainEducationValue: Int = 0
    @objc dynamic var mainEducation: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var mainEducationCellNumber: Int = 0
    @objc dynamic var courseId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var descText: String = ""
}
