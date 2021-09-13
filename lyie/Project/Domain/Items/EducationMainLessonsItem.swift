//
//  EducationMainLessonsItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation

struct EducationMainLessonsItem: Codable {
    var identifier: String = ""
    var mainEducationValue: Int = 0
    var childCellNum: Int = 0
    var cellHeight: Int = 0
    var rightText: String = ""
    var leftValue: Bool = false
    var mainEducation: String = ""
    var navigate: Bool = false
    var leftText: String = ""
    var videoUrl: String = ""
    var rightValue: Bool = false
    var mainEducationCellNum: Int = 0
    var courseId: Int = 0
    var childId: Int = 0
    var title: String = ""
    var type: String = ""
    var educationImageURL: String = ""
    var navigateCount: Int = 0
    var descText: String = ""
    var pdfUrl: String = ""
}

extension EducationMainLessonsItem {
    init(with model: EducationMainLessonsModelRealm) {
        identifier = model.identifier
        mainEducationValue = model.mainEducationValue
        childCellNum = model.childCellNum
        cellHeight = model.cellHeight
        rightText = model.rightText
        leftValue = model.leftValue
        mainEducation = model.mainEducation
        navigate = model.navigate
        leftText = model.leftText
        videoUrl = model.videoUrl
        rightValue = model.rightValue
        mainEducationCellNum = model.mainEducationCellNum
        courseId = model.courseId
        childId = model.childId
        title = model.title
        type = model.type
        educationImageURL = model.educationImageURL
        navigateCount = model.navigateCount
        descText = model.descText
        pdfUrl = model.pdfUrl
    }
}
