//
//  NewUserProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

import Foundation
import RealmSwift
import Reachability

class NewUserProvider {
    
    private static let adapter = RealmObjectAdapter<NewUserModelRealm>()
    
    static let shared = NewUserProvider()
    
    static func users() -> [NewUserItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func users(for identifier: String) -> NewUserItem? {
        return usersModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> NewUserItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(users: NewUserItem) {
        guard let model = usersModel(for: users.identifier) else { return }
        try? RealmService.write {
            model.identifier = users.identifier
            model.userType = users.userType
            model.name = users.name
            model.password = users.password
            model.phone = users.phone
            model.mail = users.mail
            model.userID = users.userID
            model.classID = users.classID
            model.highSchoolName = users.highSchoolName
            model.University = users.University
            model.Department = users.Department
            model.FirstMentor = users.FirstMentor
            model.SecondMentor = users.SecondMentor
            model.FirstClass = users.FirstClass
            model.SecondClass = users.SecondClass
            model.city = users.city
            model.approvedKVKK = users.approvedKVKK
         }
    }
    
    static func remove(users: NewUserItem) {
        guard let model = usersModel(for: users.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension NewUserProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for users: NewUserItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = usersModel(for: users.identifier) {
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

extension NewUserProvider {
    static func usersModel(for identifier: String) -> NewUserModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(NewUserModelRealm.identifier)) == '\(identifier)'").first
    }
}
 




