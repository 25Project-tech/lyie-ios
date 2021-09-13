//
//  QuestionsForMentorItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation

struct QuestionsForMentorItem: Codable {
    var identifier: String = ""
    var questions: [QuestionItem]
}

extension QuestionsForMentorItem {
    init(with model: QuestionsForMentorModelRealm) {
        identifier = model.identifier
        questions = model.questions.compactMap({ QuestionItem(with: $0) })
    }
}

