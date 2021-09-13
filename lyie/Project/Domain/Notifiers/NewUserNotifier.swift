//
//  NewUserNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

import Foundation
import RealmSwift

protocol NewUserObserver: AnyObject {
    func onDidChange(users: [NewUserItem])
}

extension NewUserObserver {
    func startObservingNewUsers() {
        NewUserNotifier.shared.add(self)
    }
    
    func stopObservingNewUsers() {
        NewUserNotifier.shared.remove(self)
    }
}

class NewUserNotifier {
    
    struct WeakContainer {
        weak var value: NewUserObserver?
    }
    
    static let shared = NewUserNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: NewUserObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: NewUserObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ users: [NewUserItem]) {
        observers.forEach({ $0.value?.onDidChange(users: users)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension NewUserNotifier {
    
    func configure() {
        token?.invalidate()
        token = NewUserProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(NewUserProvider.users())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}




