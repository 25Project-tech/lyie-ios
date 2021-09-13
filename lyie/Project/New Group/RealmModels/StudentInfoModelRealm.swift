//
//  StudentInfoModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
import RealmSwift

class StudentInfoModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var userID: String = ""
    @objc dynamic var classID: String = ""
    @objc dynamic var highSchoolName: String = ""
    @objc dynamic var classNumber: String = "1"
    @objc dynamic var departmentName: String = ""
    @objc dynamic var targetUniversity: String = ""
    @objc dynamic var targetDepartment: String = ""
}
