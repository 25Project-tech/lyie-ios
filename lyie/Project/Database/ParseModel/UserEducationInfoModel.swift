//
//  UserEducationInfoModel.swift
//  lyie
//
//  Created by Sevcan Eşim on 26.02.2021.
//

//Parse-> EducationInfo
import Foundation
import Parse

class UserEducationModel {
    var objectId: String
    var userId: String
    var highSchoolName: String
    var highSClassNumber: String
    var departmentName: String
    var targetUniversity: String
    var targetDepartment: String
    
    init(objectId: String, userId: String, highSchoolName: String, highSClassNumber: String, departmentName: String, targetUniversity: String, targetDepartment: String) {
        self.objectId = objectId
        self.userId = userId
        self.highSchoolName = highSchoolName
        self.highSClassNumber = highSClassNumber
        self.departmentName = departmentName
        self.targetUniversity = targetUniversity
        self.targetDepartment = targetDepartment
    }
}

