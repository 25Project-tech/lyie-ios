//
//  QuestionNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
import RealmSwift

protocol QuestionObserver: AnyObject {
    func onDidChange(questions: [QuestionItem])
}

extension QuestionObserver {
    func startObservingQuestions() {
        QuestionNotifier.shared.add(self)
    }
    
    func stopObservingQuestions() {
        QuestionNotifier.shared.remove(self)
    }
}

class QuestionNotifier {
    
    struct WeakContainer {
        weak var value: QuestionObserver?
    }
    
    static let shared = QuestionNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: QuestionObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: QuestionObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ questions: [QuestionItem]) {
        observers.forEach({ $0.value?.onDidChange(questions: questions)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension QuestionNotifier {
    
    func configure() {
        token?.invalidate()
        token = QuestionProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(QuestionProvider.questions())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}



