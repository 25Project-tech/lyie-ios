//
//  EducationMainLessonsNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift

protocol EducationMainLessonsObserver: AnyObject {
    func onDidChange(educationMainLessons: [EducationMainLessonsItem])
}

extension EducationMainLessonsObserver {
    func startObservingEducationMainLessons() {
        EducationMainLessonsNotifier.shared.add(self)
    }
    
    func stopObservingEducationMainLessons() {
        EducationMainLessonsNotifier.shared.remove(self)
    }
}

class EducationMainLessonsNotifier {
    
    struct WeakContainer {
        weak var value: EducationMainLessonsObserver?
    }
    
    static let shared = EducationMainLessonsNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: EducationMainLessonsObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: EducationMainLessonsObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ educationMainLessons: [EducationMainLessonsItem]) {
        observers.forEach({ $0.value?.onDidChange(educationMainLessons: educationMainLessons)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension EducationMainLessonsNotifier {
    
    func configure() {
        token?.invalidate()
        token = EducationMainLessonsProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(EducationMainLessonsProvider.educationMainLessons())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}

