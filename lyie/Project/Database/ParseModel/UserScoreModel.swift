//
//  UserScoreModel.swift
//  lyie
//
//  Created by Sevcan Eşim on 28.04.2021.
//

import Foundation
import Parse

class UserScoreModel {
    
    var objectId: String
    var userID: String
    var scoreDesc: String
    var scoreValue: Int = 0
    var totalScore: Int = 0
    
    init(objectId: String, userID: String, scoreDesc: String, scoreValue: Int, totalScore: Int) {
        self.objectId = objectId
        self.userID = userID
        self.scoreDesc = scoreDesc
        self.scoreValue = scoreValue
        self.totalScore = totalScore
    }
}

