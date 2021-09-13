//
//  StudentInfoItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 4.01.2021.
//

import Foundation
extension StudentInfoModelRealm {
    var toItem: StudentInfoItem {
        return StudentInfoItem(with: self)
    }
}
