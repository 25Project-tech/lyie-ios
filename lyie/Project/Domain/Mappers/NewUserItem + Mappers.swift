//
//  NewUserItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

import Foundation
extension NewUserModelRealm {
    var toItem: NewUserItem {
        return NewUserItem(with: self)
    }
}

