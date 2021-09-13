//
//  EducationChildCoursesItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
extension EducationChildCoursesModelRealm {
    var toItem: EducationChildCoursesItem {
        return EducationChildCoursesItem(with: self)
    }
}

