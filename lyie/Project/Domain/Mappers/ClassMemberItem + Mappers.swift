//
//  ClassMemberItem + Mappers.swift
//  lyie
//
//  Created by Sevcan Eşim on 23.06.2021.
//

import Foundation
extension ClassMemberModelRealm {
    var toItem: ClassMemberItem {
        return ClassMemberItem(with: self)
    }
}

