//
//  HomeMentorItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 3.05.2021.
//

import Foundation
extension HomeMentorModelRealm {
    var toItem: HomeMentorInfo {
        return HomeMentorInfo(with: self)
    }
}

