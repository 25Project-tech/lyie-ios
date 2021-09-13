//
//  ResearchsItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.02.2021.
//

import Foundation
extension ResearchModelRealm {
    var toItem: ResearchItem {
        return ResearchItem(with: self)
    }
}

