//
//  EducationChildCoursesNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift

protocol EducationChildCoursesObserver: AnyObject {
    func onDidChange(educationChildCourses: [EducationChildCoursesItem])
}

extension EducationChildCoursesObserver {
    func startObservingEducationChildCourses() {
        EducationChildCoursesNotifier.shared.add(self)
    }
    
    func stopObservingEducationChildCourses() {
        EducationChildCoursesNotifier.shared.remove(self)
    }
}

class EducationChildCoursesNotifier {
    
    struct WeakContainer {
        weak var value: EducationChildCoursesObserver?
    }
    
    static let shared = EducationChildCoursesNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: EducationChildCoursesObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: EducationChildCoursesObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ educationChildCourses: [EducationChildCoursesItem]) {
        observers.forEach({ $0.value?.onDidChange(educationChildCourses: educationChildCourses)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension EducationChildCoursesNotifier {
    
    func configure() {
        token?.invalidate()
        token = EducationChildCoursesProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(EducationChildCoursesProvider.educationChildCourses())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}

