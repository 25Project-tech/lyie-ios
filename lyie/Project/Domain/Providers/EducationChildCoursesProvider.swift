//
//  EducationChildCoursesProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift
import Reachability

class EducationChildCoursesProvider {
    
    private static let adapter = RealmObjectAdapter<EducationChildCoursesModelRealm>()
    
    static let shared = EducationChildCoursesProvider()
    
    static func educationChildCourses() -> [EducationChildCoursesItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func educationChildCourses(for identifier: String) -> EducationChildCoursesItem? {
        return educationChildCoursesModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> EducationChildCoursesItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(educationChildCourses: EducationChildCoursesItem) {
        guard let model = educationChildCoursesModel(for: educationChildCourses.identifier) else { return }
        try? RealmService.write {
            model.identifier = educationChildCourses.identifier
            model.mainEducationValue = educationChildCourses.mainEducationValue
            model.mainEducation = educationChildCourses.mainEducation
            model.imageURL = educationChildCourses.imageURL
            model.mainEducationCellNumber = educationChildCourses.mainEducationCellNumber
            model.courseId = educationChildCourses.courseId
            model.title = educationChildCourses.title
            model.descText = educationChildCourses.descText
         }
    }
    
    static func remove(educationChildCourses: EducationChildCoursesItem) {
        guard let model = educationChildCoursesModel(for: educationChildCourses.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension EducationChildCoursesProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for educationChildCourses: EducationChildCoursesItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = educationChildCoursesModel(for: educationChildCourses.identifier) {
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

extension EducationChildCoursesProvider {
    static func educationChildCoursesModel(for identifier: String) -> EducationChildCoursesModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(EducationChildCoursesModelRealm.identifier)) == '\(identifier)'").first
    }
}
 






