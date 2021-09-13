//
//  QuestionsForMentorNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.02.2021.
//

import Foundation
import RealmSwift

protocol QuestionsForMentorObserver: AnyObject {
    func onDidChange(questionsForMentor: [QuestionsForMentorItem])
}

extension QuestionsForMentorObserver {
    func startObservingQuestionsForMentor() {
        QuestionsForMentorNotifier.shared.add(self)
    }
    
    func stopObservingQuestionsForMentor() {
        QuestionsForMentorNotifier.shared.remove(self)
    }
}

class QuestionsForMentorNotifier {
    
    struct WeakContainer {
        weak var value: QuestionsForMentorObserver?
    }
    
    static let shared = QuestionsForMentorNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: QuestionsForMentorObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: QuestionsForMentorObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ questionsForMentor: [QuestionsForMentorItem]) {
        observers.forEach({ $0.value?.onDidChange(questionsForMentor: questionsForMentor)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension QuestionsForMentorNotifier {
    
    func configure() {
        token?.invalidate()
        token = QuestionsForMentorProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(QuestionsForMentorProvider.questionsForMentor())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}




