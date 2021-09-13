//
//  StudentEducationItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 4.01.2021.
//

import Foundation
extension StudentEducationModelRealm {
    var toItem: StudentEducationItem {
        return StudentEducationItem(with: self)
    }
}
