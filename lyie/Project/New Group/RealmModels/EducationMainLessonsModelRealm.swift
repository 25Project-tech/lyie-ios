//
//  EducationMainLessonsModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift

class EducationMainLessonsModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var mainEducationValue: Int = 0
    @objc dynamic var childCellNum: Int = 0
    @objc dynamic var cellHeight: Int = 0
    @objc dynamic var rightText: String = ""
    @objc dynamic var leftValue: Bool = false
    @objc dynamic var mainEducation: String = ""
    @objc dynamic var navigate: Bool = false
    @objc dynamic var leftText: String = ""
    @objc dynamic var videoUrl: String = ""
    @objc dynamic var rightValue: Bool = false
    @objc dynamic var mainEducationCellNum: Int = 0
    @objc dynamic var courseId: Int = 0
    @objc dynamic var childId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var educationImageURL: String = ""
    @objc dynamic var navigateCount: Int = 0
    @objc dynamic var descText: String = ""
    @objc dynamic var pdfUrl: String = ""
}

