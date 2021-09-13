//
//  EducationMainLessonsProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift
import Reachability

class EducationMainLessonsProvider {
    
    private static let adapter = RealmObjectAdapter<EducationMainLessonsModelRealm>()
    
    static let shared = EducationMainLessonsProvider()
    
    static func educationMainLessons() -> [EducationMainLessonsItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func educationMainLessons(for identifier: String) -> EducationMainLessonsItem? {
        return educationMainLessonsModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> EducationMainLessonsItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(educationMainLessons: EducationMainLessonsItem) {
        guard let model = educationMainLessonsModel(for: educationMainLessons.identifier) else { return }
        try? RealmService.write {
            model.identifier = educationMainLessons.identifier
            model.mainEducationValue = educationMainLessons.mainEducationValue
            model.childCellNum  = educationMainLessons.childCellNum
            model.cellHeight = educationMainLessons.cellHeight
            model.rightText = educationMainLessons.rightText
            model.leftValue = educationMainLessons.leftValue
            model.mainEducation = educationMainLessons.mainEducation
            model.navigate = educationMainLessons.navigate
            model.leftText = educationMainLessons.leftText
            model.videoUrl = educationMainLessons.videoUrl
            model.rightValue = educationMainLessons.rightValue
            model.mainEducationCellNum = educationMainLessons.mainEducationCellNum
            model.courseId = educationMainLessons.courseId
            model.childId = educationMainLessons.childId
            model.title = educationMainLessons.title
            model.type = educationMainLessons.type
            model.educationImageURL = educationMainLessons.educationImageURL
            model.navigateCount = educationMainLessons.navigateCount
            model.descText = educationMainLessons.descText
            model.pdfUrl = educationMainLessons.pdfUrl
         }
    }
    
    static func remove(educationMainLessons: EducationMainLessonsItem) {
        guard let model = educationMainLessonsModel(for: educationMainLessons.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension EducationMainLessonsProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for educationMainLessons: EducationMainLessonsItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = educationMainLessonsModel(for: educationMainLessons.identifier) {
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

extension EducationMainLessonsProvider {
    static func educationMainLessonsModel(for identifier: String) -> EducationMainLessonsModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(EducationMainLessonsModelRealm.identifier)) == '\(identifier)'").first
    }
}
 






