//
//  EducationChildLessonsModelRealm.swift
//  lyie
//
//  Created by Sevcan Eşim on 15.05.2021.
//

import Foundation
import RealmSwift

class EducationChildLessonsModelRealm: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var educationImageURL0: String = ""
    @objc dynamic var educationImageURL1: String = ""
    @objc dynamic var educationImageURL2: String = ""
    @objc dynamic var educationImageURL3: String = ""
    @objc dynamic var educationImageURL4: String = ""
    @objc dynamic var educationImageURL5: String = ""
    @objc dynamic var educationImageURL6: String = ""
    @objc dynamic var childId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var descText: String = ""
}
