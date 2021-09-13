//
//  HomeMentorNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 3.05.2021.
//

import Foundation
import RealmSwift

protocol HomeMentorObserver: AnyObject {
    func onDidChange(mentors: [HomeMentorInfo])
}

extension HomeMentorObserver {
    func startObservingHomeMentors() {
        HomeMentorNotifier.shared.add(self)
    }
    
    func stopObservingHomeMentors() {
        HomeMentorNotifier.shared.remove(self)
    }
}

class HomeMentorNotifier {
    
    struct WeakContainer {
        weak var value: HomeMentorObserver?
    }
    
    static let shared = HomeMentorNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: HomeMentorObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: HomeMentorObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ mentors: [HomeMentorInfo]) {
        observers.forEach({ $0.value?.onDidChange(mentors: mentors)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension HomeMentorNotifier {
    
    func configure() {
        token?.invalidate()
        token = HomeMentorProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(HomeMentorProvider.mentors())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}




