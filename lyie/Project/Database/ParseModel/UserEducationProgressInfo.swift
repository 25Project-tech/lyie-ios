//
//  UserEducationProgressInfo.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

//Parse-> EducationInfo
import Foundation
import Parse

class UserEducationProgressInfo {
    var objectId: String
    var userID: String
    var education101iotNum: Int
    var education101aiNum: Int
    var education101inoNum: Int
    var mainEducation: String
    var mainEducationValue: Int
    var mainEducationCellNum: Int
    var currentEducationNum: Int
    var currentEducationsCount: Int
    var currentCell: Int
    var questionAreaCell: Int
    var questionAreaMainEdu: String
    var questionAreaMainValue: Int
    
    init(objectId: String, userID: String, education101iotNum: Int, education101aiNum: Int, education101inoNum: Int, mainEducation: String, mainEducationValue: Int, mainEducationCellNum: Int, currentEducationNum: Int, currentEducationsCount: Int, currentCell: Int, questionAreaCell: Int, questionAreaMainEdu: String, questionAreaMainValue: Int) {
        self.objectId = objectId
        self.userID = userID
        self.education101inoNum = education101inoNum
        self.education101aiNum = education101aiNum
        self.education101iotNum = education101iotNum
        self.mainEducation = mainEducation
        self.mainEducationValue = mainEducationValue
        self.mainEducationCellNum = mainEducationCellNum
        self.currentEducationNum = currentEducationNum
        self.currentEducationsCount = currentEducationsCount
        self.currentCell = currentCell
        self.questionAreaCell = questionAreaCell
        self.questionAreaMainEdu = questionAreaMainEdu
        self.questionAreaMainValue = questionAreaMainValue
    }
}

