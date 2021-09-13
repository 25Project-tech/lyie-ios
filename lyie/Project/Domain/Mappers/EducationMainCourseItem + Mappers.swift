//
//  EducationMainCourseItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
extension EducationMainCourseModelRealm {
    var toItem: EducationMainCourseItem {
        return EducationMainCourseItem(with: self)
    }
}

