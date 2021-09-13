//
//  UserProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 8.12.2020.
//

import Foundation
import RealmSwift
import Reachability

class UserProvider {
    
    private static let adapter = RealmObjectAdapter<UserModelRealm>()
    
    static let shared = UserProvider()
    
    static func users() -> [UserItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func users(for identifier: String) -> UserItem? {
        return usersModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> UserItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(users: UserItem) {
        guard let model = usersModel(for: users.identifier) else { return }
        try? RealmService.write {
            model.identifier = users.identifier
            model.userType = users.userType
            model.userID = users.userID
            model.password = users.password
            model.name = users.name
            model.targetString = users.targetString
            model.dateofBirth = users.dateofBirth
            model.placeofBirth = users.placeofBirth
            model.gender = users.gender
            model.city = users.city
            model.phone = users.phone
            model.mail = users.mail
            model.navigateKargaKarga = users.navigateKargaKarga
            model.classID = users.classID
            model.questionCount = users.questionCount
         }
    }
    
    static func remove(users: UserItem) {
        guard let model = usersModel(for: users.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension UserProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for users: UserItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
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

extension UserProvider {
    static func usersModel(for identifier: String) -> UserModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(UserModelRealm.identifier)) == '\(identifier)'").first
    }
}
