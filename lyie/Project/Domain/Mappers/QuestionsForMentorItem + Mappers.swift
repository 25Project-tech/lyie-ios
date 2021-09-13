//
//  QuestionsForMentorItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
extension QuestionsForMentorModelRealm {
    var toItem: QuestionsForMentorItem {
        return QuestionsForMentorItem(with: self)
    }
}
