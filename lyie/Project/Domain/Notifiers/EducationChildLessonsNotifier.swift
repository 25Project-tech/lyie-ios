//
//  EducationChildLessonsNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift

protocol EducationChildLessonsObserver: AnyObject {
    func onDidChange(educationChildLessons: [EducationChildLessonsItem])
}

extension EducationChildLessonsObserver {
    func startObservingEducationChildLessons() {
        EducationChildLessonsNotifier.shared.add(self)
    }
    
    func stopObservingEducationChildLessons() {
        EducationChildLessonsNotifier.shared.remove(self)
    }
}

class EducationChildLessonsNotifier {
    
    struct WeakContainer {
        weak var value: EducationChildLessonsObserver?
    }
    
    static let shared = EducationChildLessonsNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: EducationChildLessonsObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: EducationChildLessonsObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ educationChildLessons: [EducationChildLessonsItem]) {
        observers.forEach({ $0.value?.onDidChange(educationChildLessons: educationChildLessons)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension EducationChildLessonsNotifier {
    
    func configure() {
        token?.invalidate()
        token = EducationChildLessonsProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(EducationChildLessonsProvider.educationChildLessons())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}


