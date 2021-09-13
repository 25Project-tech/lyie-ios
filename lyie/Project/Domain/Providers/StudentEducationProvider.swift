//
//  StudentEducationProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 4.01.2021.
//

import Foundation
import RealmSwift
import Reachability

class StudentEducationProvider {
    
    private static let adapter = RealmObjectAdapter<StudentEducationModelRealm>()
    
    static let shared = StudentEducationProvider()
    
    static func studentEducations() -> [StudentEducationItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func studentEducations(for identifier: String) -> StudentEducationItem? {
        return studentEducationsModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> StudentEducationItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(studentEducations: StudentEducationItem) {
        guard let model = studentEducationsModel(for: studentEducations.identifier) else { return }
        try? RealmService.write {
            model.identifier = studentEducations.identifier
            model.education101iotNum = studentEducations.education101iotNum
            model.education101aiNum = studentEducations.education101aiNum
            model.education101inoNum = studentEducations.education101inoNum
            model.mainEducation = studentEducations.mainEducation
            model.mainEducationCellNum = studentEducations.mainEducationCellNum
            model.mainEducationValue = studentEducations.mainEducationValue
            model.currentEducationNum = studentEducations.currentEducationNum
            model.currentEducationsCount = studentEducations.currentEducationsCount
            model.currentCell = studentEducations.currentCell
            model.questionAreaCell = studentEducations.questionAreaCell
            model.questionAreaMainEdu = studentEducations.questionAreaMainEdu
            model.questionAreaMainValue = studentEducations.questionAreaMainValue
         }
    }
    
    static func remove(studentEducations: StudentEducationItem) {
        guard let model = studentEducationsModel(for: studentEducations.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension StudentEducationProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for studentEducations: StudentEducationItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = studentEducationsModel(for: studentEducations.identifier) {
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

extension StudentEducationProvider {
    static func studentEducationsModel(for identifier: String) -> StudentEducationModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(StudentEducationModelRealm.identifier)) == '\(identifier)'").first
    }
}
 







