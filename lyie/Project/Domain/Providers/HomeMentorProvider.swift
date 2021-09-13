//
//  HomeMentorProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 3.05.2021.
//

import Foundation
import RealmSwift
import Reachability

class HomeMentorProvider {
    
    private static let adapter = RealmObjectAdapter<HomeMentorModelRealm>()
    
    static let shared = HomeMentorProvider()
    
    static func mentors() -> [HomeMentorInfo] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func mentors(for identifier: String) -> HomeMentorInfo? {
        return mentorsModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> HomeMentorInfo {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(mentors: HomeMentorInfo) {
        guard let model = mentorsModel(for: mentors.identifier) else { return }
        try? RealmService.write {
            model.identifier = mentors.identifier
            model.userImageURL = mentors.userImageURL
            model.parentFirstUserName = mentors.parentFirstUserName
            model.parentFirstUserUrl = mentors.parentFirstUserUrl
            model.parentFirstUserUniversity = mentors.parentFirstUserUniversity
            model.parentSecondUserUrl = mentors.parentSecondUserUrl
            model.parentSecondUserName = mentors.parentSecondUserName
            model.parentSecondUserUniversity = mentors.parentSecondUserUniversity
            model.totalScoreUser = mentors.totalScoreUser
         }
    }
    
    static func remove(mentors: HomeMentorInfo) {
        guard let model = mentorsModel(for: mentors.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension HomeMentorProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for mentors: HomeMentorInfo, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = mentorsModel(for: mentors.identifier) {
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

extension HomeMentorProvider {
    static func mentorsModel(for identifier: String) -> HomeMentorModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(HomeMentorModelRealm.identifier)) == '\(identifier)'").first
    }
}
 




