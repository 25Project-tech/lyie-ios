//
//  ResearchItem.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.02.2021.
//

import Foundation

struct ResearchItem: Codable {
    var identifier: String = ""
    var title: String = ""
    var desc: String = ""
    var coverUrl: String = ""
    var fileUrl: String = ""
}

extension ResearchItem {
    init(with model: ResearchModelRealm) {
        identifier = model.identifier
        title = model.title
        desc = model.desc
        coverUrl = model.coverUrl
        fileUrl = model.fileUrl
    }
}

