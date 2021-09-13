//
//  ResearchModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.02.2021.
//

import Foundation
import RealmSwift

class ResearchModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var coverUrl: String = ""
    @objc dynamic var fileUrl: String = ""
}


