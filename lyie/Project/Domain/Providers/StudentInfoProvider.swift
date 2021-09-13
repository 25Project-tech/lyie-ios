//
//  StudentInfoProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 4.01.2021.
//

import Foundation
import RealmSwift
import Reachability

class StudentInfoProvider {
    
    private static let adapter = RealmObjectAdapter<StudentInfoModelRealm>()
    
    static let shared = StudentInfoProvider()
    
    static func studentInfos() -> [StudentInfoItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func studentInfos(for identifier: String) -> StudentInfoItem? {
        return studentInfosModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> StudentInfoItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(studentInfos: StudentInfoItem) {
        guard let model = studentInfosModel(for: studentInfos.identifier) else { return }
        try? RealmService.write {
            model.identifier = studentInfos.identifier
            model.userID = studentInfos.userID
            model.classID = studentInfos.classID
            model.highSchoolName = studentInfos.highSchoolName
            model.classNumber = studentInfos.classNumber
            model.departmentName = studentInfos.departmentName
            model.targetUniversity = studentInfos.targetUniversity
            model.targetDepartment = studentInfos.targetDepartment
         }
    }
    
    static func remove(studentInfos: StudentInfoItem) {
        guard let model = studentInfosModel(for: studentInfos.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension StudentInfoProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for studentInfos: StudentInfoItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = studentInfosModel(for: studentInfos.identifier) {
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

extension StudentInfoProvider {
    static func studentInfosModel(for identifier: String) -> StudentInfoModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(StudentInfoModelRealm.identifier)) == '\(identifier)'").first
    }
}
 






