//
//  ResearchesFileModel.swift
//  lyie
//
//  Created by Sevcan Eşim on 1.05.2021.
//

import Foundation
import Parse

class ResearchesFileModel {
    var objectId: String
    var title: String
    var desc: String
    var coverImageURL: String
    var coverImageFile: FILE
    var file: FILE
    
    init(objectId: String, title: String, desc: String, coverImageURL: String, coverImageFile: FILE, file: FILE) {
        self.objectId = objectId
        self.title = title
        self.desc = desc
        self.coverImageURL = coverImageURL
        self.coverImageFile = coverImageFile
        self.file = file
    }
    
}


