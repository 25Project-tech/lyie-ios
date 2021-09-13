//
//  UserNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 8.12.2020.
//

import Foundation
import RealmSwift

protocol UserObserver: AnyObject {
    func onDidChange(users: [UserItem])
}

extension UserObserver {
    func startObservingUsers() {
        UserNotifier.shared.add(self)
    }
    
    func stopObservingUsers() {
        UserNotifier.shared.remove(self)
    }
}

class UserNotifier {
    
    struct WeakContainer {
        weak var value: UserObserver?
    }
    
    static let shared = UserNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: UserObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: UserObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ users: [UserItem]) {
        observers.forEach({ $0.value?.onDidChange(users: users)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension UserNotifier {
    
    func configure() {
        token?.invalidate()
        token = UserProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(UserProvider.users())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}
