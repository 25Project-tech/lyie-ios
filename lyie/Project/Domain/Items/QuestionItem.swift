//
//  QuestionItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation

struct QuestionItem: Codable {
    var identifier: String = ""
    var userID: String = ""
    var question: String = ""
    var mainEducation: String = ""
    var mainEducationValue: Int = 101
    var mainEducationCellNum: Int = 0
    var childCellNum: Int = 0
    var userPhotoURL: String = ""
    
    
    public static func toModel(_ item: QuestionItem) -> QuestionModelRealm {
        let model: QuestionModelRealm = QuestionModelRealm()
        model.identifier = item.identifier
        model.userID = item.userID
        model.question = item.userID
        model.mainEducation = item.mainEducation
        model.mainEducationValue = item.mainEducationValue
        model.mainEducationCellNum = item.mainEducationCellNum
        model.childCellNum = item.childCellNum
        model.userPhotoURL = item.userPhotoURL
        return model
    }
}

extension QuestionItem {
    init(with model: QuestionModelRealm) {
        identifier = model.identifier
        userID = model.userID
        question = model.question
        mainEducation = model.mainEducation
        mainEducationValue = model.mainEducationValue
        mainEducationCellNum = model.mainEducationCellNum
        childCellNum = model.childCellNum
        userPhotoURL = model.userPhotoURL
    }
}


