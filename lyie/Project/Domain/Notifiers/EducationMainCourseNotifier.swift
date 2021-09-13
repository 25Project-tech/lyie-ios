//
//  EducationMainCourseNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift

protocol EducationMainCourseObserver: AnyObject {
    func onDidChange(educationMainCourse: [EducationMainCourseItem])
}

extension EducationMainCourseObserver {
    func startObservingEducationMainCourse() {
        EducationMainCourseNotifier.shared.add(self)
    }
    
    func stopObservingEducationMainCourse() {
        EducationMainCourseNotifier.shared.remove(self)
    }
}

class EducationMainCourseNotifier {
    
    struct WeakContainer {
        weak var value: EducationMainCourseObserver?
    }
    
    static let shared = EducationMainCourseNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: EducationMainCourseObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: EducationMainCourseObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ educationMainCourse: [EducationMainCourseItem]) {
        observers.forEach({ $0.value?.onDidChange(educationMainCourse: educationMainCourse)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension EducationMainCourseNotifier {
    
    func configure() {
        token?.invalidate()
        token = EducationMainCourseProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(EducationMainCourseProvider.educationMainCourse())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}
