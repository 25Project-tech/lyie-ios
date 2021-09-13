//
//  ResearchNotifier.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.02.2021.
//

import Foundation
import RealmSwift

protocol ResearchObserver: AnyObject {
    func onDidChange(research: [ResearchItem])
}

extension ResearchObserver {
    func startObservingResearchs() {
        ResearchNotifier.shared.add(self)
    }
    
    func stopObservingResearchs() {
        ResearchNotifier.shared.remove(self)
    }
}

class ResearchNotifier {
    
    struct WeakContainer {
        weak var value: ResearchObserver?
    }
    
    static let shared = ResearchNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: ResearchObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: ResearchObserver) {
        if let index = observers.index(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func removeAll() {
        observers.removeAll()
        compact()
    }
    
    func notifyOnDidChange(_ researchs: [ResearchItem]) {
        observers.forEach({ $0.value?.onDidChange(research: researchs)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension ResearchNotifier {
    
    func configure() {
        token?.invalidate()
        token = ResearchProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(ResearchProvider.researchs())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}




