//
//  ResearchProvider.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.02.2021.
//

import Foundation
import RealmSwift
import Reachability

class ResearchProvider {
    
    private static let adapter = RealmObjectAdapter<ResearchModelRealm>()
    
    static let shared = ResearchProvider()
    
    static func researchs() -> [ResearchItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func researchs(for identifier: String) -> ResearchItem? {
        return researchsModel(for: identifier)?.toItem
    }
    
    @discardableResult static func create(with identifier: String = "currentUser") -> ResearchItem {
        guard let model = try? adapter.create(["identifier": identifier]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(researchs: ResearchItem) {
        guard let model = researchsModel(for: researchs.identifier) else { return }
        try? RealmService.write {
            model.identifier = researchs.identifier
            model.title = researchs.title
            model.desc = researchs.desc
            model.coverUrl = researchs.coverUrl
            model.fileUrl = researchs.fileUrl
         }
    }
    
    static func remove(researchs: ResearchItem) {
        guard let model = researchsModel(for: researchs.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension ResearchProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    static func token(for researchs: ResearchItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = researchsModel(for: researchs.identifier) {
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

extension ResearchProvider {
    static func researchsModel(for identifier: String) -> ResearchModelRealm? {
        return adapter.objects()?.filter("\(#keyPath(ResearchModelRealm.identifier)) == '\(identifier)'").first
    }
}
 




