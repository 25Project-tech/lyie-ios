//
//  QuestionProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
import RealmSwift
import Reachability

class QuestionProvider {
    
    private static let adapter = RealmObjectAdapter<QuestionModelRealm>()
    
    static let shared = QuestionProvider()
    
    static func questions() -> [QuestionItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func questions(for identifier: String) -> QuestionItem? {
        return questionsModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> QuestionItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(questions: QuestionItem) {
        guard let model = questionsModel(for: questions.identifier) else { return }
        try? RealmService.write {
            model.identifier = questions.identifier
            model.userID = questions.userID
            model.question = questions.question
            model.mainEducation = questions.mainEducation
            model.mainEducationValue = questions.mainEducationValue
            model.mainEducationCellNum = questions.mainEducationCellNum
            model.childCellNum = questions.childCellNum
            model.userPhotoURL = questions.userPhotoURL
         }
    }
    
    static func remove(questions: QuestionItem) {
        guard let model = questionsModel(for: questions.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension QuestionProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for questions: QuestionItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = questionsModel(for: questions.identifier) {
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

extension QuestionProvider {
    static func questionsModel(for identifier: String) -> QuestionModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(QuestionModelRealm.identifier)) == '\(identifier)'").first
    }
}
 




