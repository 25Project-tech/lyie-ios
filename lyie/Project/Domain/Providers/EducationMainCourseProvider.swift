//
//  EducationMainCourseProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift
import Reachability

class EducationMainCourseProvider {
    
    private static let adapter = RealmObjectAdapter<EducationMainCourseModelRealm>()
    
    static let shared = EducationMainCourseProvider()
    
    static func educationMainCourse() -> [EducationMainCourseItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func educationMainCourse(for identifier: String) -> EducationMainCourseItem? {
        return educationMainCourseModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> EducationMainCourseItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(educationMainCourse: EducationMainCourseItem) {
        guard let model = educationMainCourseModel(for: educationMainCourse.identifier) else { return }
        try? RealmService.write {
            model.identifier = educationMainCourse.identifier
            model.coverImageURL = educationMainCourse.coverImageURL
            model.level = educationMainCourse.level
            model.title = educationMainCourse.title
            model.desc = educationMainCourse.desc
         }
    }
    
    static func remove(educationMainCourse: EducationMainCourseItem) {
        guard let model = educationMainCourseModel(for: educationMainCourse.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension EducationMainCourseProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for educationMainCourse: EducationMainCourseItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = educationMainCourseModel(for: educationMainCourse.identifier) {
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

extension EducationMainCourseProvider {
    static func educationMainCourseModel(for identifier: String) -> EducationMainCourseModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(EducationMainCourseModelRealm.identifier)) == '\(identifier)'").first
    }
}
 





