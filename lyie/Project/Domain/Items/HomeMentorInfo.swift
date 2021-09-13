//
//  HomeMentorInfo.swift
//  lyie
//
//  Created by Sevcan Eşim on 3.05.2021.
//

import Foundation

struct HomeMentorInfo: Codable {
    var identifier: String = ""
    var userImageURL: String = ""
    var parentFirstUserName: String = ""
    var parentFirstUserUniversity: String = ""
    var parentFirstUserUrl: String = ""
    var parentSecondUserName: String = ""
    var parentSecondUserUniversity: String = ""
    var parentSecondUserUrl: String = ""
    var totalScoreUser: String = "0"
}

extension HomeMentorInfo {
    init(with model: HomeMentorModelRealm) {
        identifier = model.identifier
        userImageURL = model.userImageURL
        parentFirstUserName = model.parentFirstUserName
        parentFirstUserUrl = model.parentFirstUserUrl
        parentFirstUserUniversity = model.parentFirstUserUniversity
        parentSecondUserUrl = model.parentSecondUserUrl
        parentSecondUserName = model.parentSecondUserName
        parentSecondUserUniversity = model.parentSecondUserUniversity
        totalScoreUser = model.totalScoreUser
    }
}
