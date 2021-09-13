//
//  RealmObjectAdapter.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import RealmSwift

class RealmObjectAdapter<T: Object> {

    func objects() -> Results<T>? {
        return try? Realm().objects(T.self)
    }

    /// Creates Realm object and adds it to database
    /// - Parameter value: Parameters of object to set
    /// - Throws: Throws exception of adding failed
    /// - Returns: Returns created Object
    @discardableResult func create(_ value: [String: Any]? = nil) throws -> T {
        let object = T()

        if let value = value {
            object.setValuesForKeys(value)
        }

        try add(object)
        return object
    }

    /// Creates Realm object without adding it to database
    /// - Parameter value: Parameters of object to set
    /// - Returns: Returns created Object
    @discardableResult func justCreate(_ value: [String: Any]? = nil) -> T {
        let object = T()

        if let value = value {
            object.setValuesForKeys(value)
        }

        return object
    }

    func add(_ object: T) throws {
        try RealmService.add(object)
    }

    func edit(_ object: T, set value: [String: Any]) throws {
        let realm = try Realm()
        try realm.safeWrite {
            object.setValuesForKeys(value)
        }
    }

    func remove(_ object: T) throws {
        try RealmService.remove(object)
    }
}
