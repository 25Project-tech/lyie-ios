//
//  QuestionsForMentorModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
import RealmSwift

class QuestionsForMentorModelRealm: Object {
    @objc dynamic var identifier: String = ""
    let questions = List<QuestionModelRealm>()
    
    public static func createItem(identifier: String) -> QuestionsForMentorItem {
        let model: QuestionsForMentorModelRealm = QuestionsForMentorModelRealm()
        model.identifier = identifier
        let questionItem: QuestionsForMentorItem = QuestionsForMentorItem(with: model)
        return questionItem
    }

}

