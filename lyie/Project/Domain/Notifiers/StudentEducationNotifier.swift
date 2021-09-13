//
//  StudentEducationNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 4.01.2021.
//

import Foundation
import RealmSwift

protocol StudentEducationObserver: AnyObject {
    func onDidChange(studentEducations: [StudentEducationItem])
}

extension StudentEducationObserver {
    func startObservingStudentEducations() {
        StudentEducationNotifier.shared.add(self)
    }
    
    func stopObservingStudentEducations() {
        StudentEducationNotifier.shared.remove(self)
    }
}

class StudentEducationNotifier {
    
    struct WeakContainer {
        weak var value: StudentEducationObserver?
    }
    
    static let shared = StudentEducationNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: StudentEducationObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: StudentEducationObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ studentEducations: [StudentEducationItem]) {
        observers.forEach({ $0.value?.onDidChange(studentEducations: studentEducations)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension StudentEducationNotifier {
    
    func configure() {
        token?.invalidate()
        token = StudentEducationProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(StudentEducationProvider.studentEducations())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}





