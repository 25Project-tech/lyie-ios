//
//  QuestionItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
extension QuestionModelRealm {
    var toItem: QuestionItem {
        return QuestionItem(with: self)
    }
}

