//
//  EducationMainCourseItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation

struct EducationMainCourseItem: Codable {
    var identifier: String = ""
    var coverImageURL: String = ""
    var level: String = ""
    var desc: String = ""
    var title: String = ""
}

extension EducationMainCourseItem {
    init(with model: EducationMainCourseModelRealm) {
        identifier = model.identifier
        coverImageURL = model.coverImageURL
        level = model.level
        desc = model.desc
        title = model.title
    }
}



