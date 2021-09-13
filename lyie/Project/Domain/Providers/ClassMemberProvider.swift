//
//  ClassMemberProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 23.06.2021.
//

import Foundation
import RealmSwift
import Reachability

class ClassMemberProvider {
    
    private static let adapter = RealmObjectAdapter<ClassMemberModelRealm>()
    
    static let shared = ClassMemberProvider()
    
    static func classMembers() -> [ClassMemberItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func slassMembers(for identifier: String) -> ClassMemberItem? {
        return classMembersModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> ClassMemberItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(classMembers: ClassMemberItem) {
        guard let model = classMembersModel(for: classMembers.identifier) else { return }
        try? RealmService.write {
            model.identifier = classMembers.identifier
            model.classCode = classMembers.classCode
            model.userType = classMembers.userType
            model.userID = classMembers.userID
            model.name = classMembers.name
            model.dateofBirth = classMembers.dateofBirth
            model.gender = classMembers.gender
            model.city = classMembers.city
            model.phone = classMembers.phone
            model.mail = classMembers.mail
            model.score = classMembers.score
            model.educationInfo = classMembers.educationInfo
         }
    }
    
    static func remove(classMembers: ClassMemberItem) {
        guard let model = classMembersModel(for: classMembers.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension ClassMemberProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for classMembers: ClassMemberItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = classMembersModel(for: classMembers.identifier) {
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

extension ClassMemberProvider {
    static func classMembersModel(for identifier: String) -> ClassMemberModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(ClassMemberModelRealm.identifier)) == '\(identifier)'").first
    }
}
 




