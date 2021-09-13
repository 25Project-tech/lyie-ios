//
//  EducationChildLessonsItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
extension EducationChildLessonsModelRealm {
    var toItem: EducationChildLessonsItem {
        return EducationChildLessonsItem(with: self)
    }
}

