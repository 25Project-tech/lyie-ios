//
//  RealmService.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import RealmSwift

class RealmService {
    
    static let version: UInt64 = 17

    static func configure() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: version, migrationBlock: migrate)
    }

    static func write(_ writeClosure: ()->()) throws {
        let realm = try Realm()
        try realm.safeWrite(writeClosure)
    }

    static func add(_ object: Object) throws {
        let realm = try Realm()
        try realm.safeWrite {
            realm.add(object)
        }
    }

    static func add(_ objects: [Object], completion: @escaping ()->()) throws {
        let realm = try Realm()
        try realm.safeWrite {
            realm.add(objects)
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    static func remove(_ object: Object) throws {
        let realm = try Realm()
        try realm.safeWrite {
            realm.delete(object)
        }
    }

    static func removeAll(of type: Object.Type) throws {
        let realm = try Realm()
        try realm.safeWrite {
            realm.delete(realm.objects(type))
        }
    }

    static func migrate(migration: Migration, oldVersion: UInt64) {

    }
}

extension Realm {

    func safeWrite( _ writeClosure: () -> ()) throws {
        if isInWriteTransaction {
            writeClosure()
        } else {
            try write { writeClosure() }
        }
    }
}
