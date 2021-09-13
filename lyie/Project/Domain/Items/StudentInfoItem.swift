//
//  StudentInfoItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 4.01.2021.
//

import Foundation

struct StudentInfoItem: Codable {
    var identifier: String = ""
    var userID: String = ""
    var classID: String = ""
    var highSchoolName: String = ""
    var classNumber: String = "1"
    var departmentName: String = ""
    var targetUniversity: String = ""
    var targetDepartment: String = ""
}

extension StudentInfoItem {
    init(with model: StudentInfoModelRealm) {
        identifier = model.identifier
        userID = model.userID
        classID = model.classID
        highSchoolName = model.highSchoolName
        classNumber = model.classNumber
        departmentName = model.departmentName
        targetUniversity = model.targetUniversity
        targetDepartment = model.targetDepartment
    }
}


