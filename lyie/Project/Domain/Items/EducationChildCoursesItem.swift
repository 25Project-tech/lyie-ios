//
//  EducationChildCoursesItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation

struct EducationChildCoursesItem: Codable {
    var identifier: String = ""
    var mainEducationValue: Int = 0
    var mainEducation: String = ""
    var imageURL: String = ""
    var mainEducationCellNumber: Int = 0
    var courseId: Int = 0
    var title: String = ""
    var descText: String = ""
}

extension EducationChildCoursesItem {
    init(with model: EducationChildCoursesModelRealm) {
        identifier = model.identifier
        mainEducationValue = model.mainEducationValue
        mainEducation = model.mainEducation
        imageURL = model.imageURL
        mainEducationCellNumber = model.mainEducationCellNumber
        courseId = model.courseId
        title = model.title
        descText = model.descText
    }
}




