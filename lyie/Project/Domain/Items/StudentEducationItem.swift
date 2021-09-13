//
//  StudentEducationItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 4.01.2021.
//

import Foundation

struct StudentEducationItem: Codable {
    var identifier: String = ""
    var education101iotNum: Int = 0 //
    var education101aiNum: Int = 0 //
    var education101inoNum: Int = 1 //
    var mainEducation: String = "" //
    var mainEducationValue: Int = 101 //
    var mainEducationCellNum: Int = 0
    var currentEducationNum: Int = 0
    var currentEducationsCount: Int = 0
    var currentCell: Int = 0
    var questionAreaCell: Int = 0
    var questionAreaMainEdu: String = ""
    var questionAreaMainValue: Int = 0
}

extension StudentEducationItem {
    init(with model: StudentEducationModelRealm) {
        identifier = model.identifier
        education101iotNum = model.education101iotNum
        education101aiNum = model.education101aiNum
        education101inoNum = model.education101inoNum
        mainEducation = model.mainEducation
        mainEducationValue = model.mainEducationValue
        mainEducationCellNum = model.mainEducationCellNum
        currentEducationNum = model.currentEducationNum
        currentEducationsCount = model.currentEducationsCount
        currentCell = model.currentCell
        questionAreaCell = model.questionAreaCell
        questionAreaMainEdu = model.questionAreaMainEdu
        questionAreaMainValue = model.questionAreaMainValue
    }
}



