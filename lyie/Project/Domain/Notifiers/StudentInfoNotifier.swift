//
//  StudentInfoNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 4.01.2021.
//

import Foundation
import RealmSwift

protocol StudentInfoObserver: AnyObject {
    func onDidChange(studentInfos: [StudentInfoItem])
}

extension StudentInfoObserver {
    func startObservingStudentInfos() {
        StudentInfoNotifier.shared.add(self)
    }
    
    func stopObservingStudentInfos() {
        StudentInfoNotifier.shared.remove(self)
    }
}

class StudentInfoNotifier {
    
    struct WeakContainer {
        weak var value: StudentInfoObserver?
    }
    
    static let shared = StudentInfoNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: StudentInfoObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: StudentInfoObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ studentInfos: [StudentInfoItem]) {
        observers.forEach({ $0.value?.onDidChange(studentInfos: studentInfos)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension StudentInfoNotifier {
    
    func configure() {
        token?.invalidate()
        token = StudentInfoProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(StudentInfoProvider.studentInfos())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}




