//
//  QuestionsForMentorProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
import RealmSwift
import Reachability

class QuestionsForMentorProvider {
    
    private static let adapter = RealmObjectAdapter<QuestionsForMentorModelRealm>()
    
    static let shared = QuestionsForMentorProvider()
    
    static func questionsForMentor() -> [QuestionsForMentorItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func questionsForMentor(for identifier: String) -> QuestionsForMentorItem? {
        return questionsForMentorModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> QuestionsForMentorItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(questionsForMentor: QuestionsForMentorItem, questions: [QuestionModelRealm]) {
        guard let model = questionsForMentorModel(for: questionsForMentor.identifier) else { return }
        try? RealmService.write {
            model.identifier = questionsForMentor.identifier
            model.questions.removeAll()
            model.questions.append(objectsIn: questions)
         }
    }
    
    static func remove(questionsForMentor: QuestionsForMentorItem) {
        guard let model = questionsForMentorModel(for: questionsForMentor.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension QuestionsForMentorProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for questionsForMentor: QuestionsForMentorItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = questionsForMentorModel(for: questionsForMentor.identifier) {
            return model.observe { (change) in
                switch change {
                case .change: onDidChange()
                case .deleted: break
                default: break
                }
            }
        }
        return nil
    }
}

extension QuestionsForMentorProvider {
    static func questionsForMentorModel(for identifier: String) -> QuestionsForMentorModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(QuestionsForMentorModelRealm.identifier)) == '\(identifier)'").first
    }
}
