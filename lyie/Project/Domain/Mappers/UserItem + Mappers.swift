//
//  UserItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 8.12.2020.
//

import Foundation
extension UserModelRealm {
    var toItem: UserItem {
        return UserItem(with: self)
    }
}
