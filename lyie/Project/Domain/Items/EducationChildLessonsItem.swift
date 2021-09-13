//
//  EducationChildLessonsItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation

struct EducationChildLessonsItem: Codable {
    var identifier: String = ""
    var educationImageURL0: String = ""
    var educationImageURL1: String = ""
    var educationImageURL2: String = ""
    var educationImageURL3: String = ""
    var educationImageURL4: String = ""
    var educationImageURL5: String = ""
    var educationImageURL6: String = ""
    var childId: Int = 0
    var title: String = ""
    var descText: String = ""
}

extension EducationChildLessonsItem {
    init(with model: EducationChildLessonsModelRealm) {
        identifier = model.identifier
        educationImageURL0 = model.educationImageURL0
        educationImageURL1 = model.educationImageURL1
        educationImageURL2 = model.educationImageURL2
        educationImageURL3 = model.educationImageURL3
        educationImageURL4 = model.educationImageURL4
        educationImageURL5 = model.educationImageURL5
        educationImageURL6 = model.educationImageURL6
        childId = model.childId
        title = model.title
        descText = model.descText
    }
}
