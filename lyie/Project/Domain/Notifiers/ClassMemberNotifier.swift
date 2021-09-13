//
//  ClassMemberNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 23.06.2021.
//

import Foundation
import RealmSwift

protocol ClassMemberObserver: AnyObject {
    func onDidChange(classMembers: [ClassMemberItem])
}

extension ClassMemberObserver {
    func startObservingClassMembers() {
        ClassMemberNotifier.shared.add(self)
    }
    
    func stopObservingClassMembers() {
        ClassMemberNotifier.shared.remove(self)
    }
}

class ClassMemberNotifier {
    
    struct WeakContainer {
        weak var value: ClassMemberObserver?
    }
    
    static let shared = ClassMemberNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: ClassMemberObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: ClassMemberObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ classMembers: [ClassMemberItem]) {
        observers.forEach({ $0.value?.onDidChange(classMembers: classMembers)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension ClassMemberNotifier {
    
    func configure() {
        token?.invalidate()
        token = ClassMemberProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(ClassMemberProvider.classMembers())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}




