//
//  EducationChildLessonsProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift
import Reachability

class EducationChildLessonsProvider {
    
    private static let adapter = RealmObjectAdapter<EducationChildLessonsModelRealm>()
    
    static let shared = EducationChildLessonsProvider()
    
    static func educationChildLessons() -> [EducationChildLessonsItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func educationChildLessons(for identifier: String) -> EducationChildLessonsItem? {
        return educationChildLessonsModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> EducationChildLessonsItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(educationChildLessons: EducationChildLessonsItem) {
        guard let model = educationChildLessonsModel(for: educationChildLessons.identifier) else { return }
        try? RealmService.write {
            model.identifier = educationChildLessons.identifier
            model.educationImageURL0 = educationChildLessons.educationImageURL0
            model.educationImageURL1 = educationChildLessons.educationImageURL1
            model.educationImageURL2 = educationChildLessons.educationImageURL2
            model.educationImageURL3 = educationChildLessons.educationImageURL3
            model.educationImageURL4 = educationChildLessons.educationImageURL4
            model.educationImageURL5 = educationChildLessons.educationImageURL5
            model.educationImageURL6 = educationChildLessons.educationImageURL6
            model.childId = educationChildLessons.childId
            model.title = educationChildLessons.title
            model.descText = educationChildLessons.descText
         }
    }
    
    static func remove(educationChildLessons: EducationChildLessonsItem) {
        guard let model = educationChildLessonsModel(for: educationChildLessons.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension EducationChildLessonsProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for educationChildLessons: EducationChildLessonsItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = educationChildLessonsModel(for: educationChildLessons.identifier) {
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

extension EducationChildLessonsProvider {
    static func educationChildLessonsModel(for identifier: String) -> EducationChildLessonsModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(EducationChildLessonsModelRealm.identifier)) == '\(identifier)'").first
    }
}
 







