//
//  EducationMainLessonsItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
extension EducationMainLessonsModelRealm {
    var toItem: EducationMainLessonsItem {
        return EducationMainLessonsItem(with: self)
    }
}
