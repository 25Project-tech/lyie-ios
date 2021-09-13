//
//  ChildEducationServices.swift
//  lyie
//
//  Created by Sevcan Eşim on 6.03.2021.
//

import Foundation
import UIKit

struct ChildEducationServices {
    var id: Int // slyt id si
    var title: String
    var descText: String
    var imageString: Array<String> //içindeki kaç sayfaysa o
    
    static func allChildEducationsList() -> [ChildEducationServices] {
        return [ChildEducationServices(id: 0, title: "", descText: "", imageString: ["Education/image2", "Education/image3", "Education/image4", "Education/image5", "Education/image6", "Education/image7"]), ChildEducationServices(id: 1, title: "", descText: "", imageString: ["Education/image9", "Education/image10", "Education/image11", "Education/image12", "Education/image13", "Education/image14", "Education/image15"]), ChildEducationServices(id: 2, title: "", descText: "", imageString: ["Education/image19", "Education/image20"]), ChildEducationServices(id: 3, title: "", descText: "", imageString: ["Education/image22", "Education/image23", "Education/image24", "Education/image25"]), ChildEducationServices(id: 4, title: "", descText: "", imageString: ["Education/image28", "Education/image29", "Education/image30", "Education/image31", "Education/image32", "Education/image33"]), ChildEducationServices(id: 5, title: "", descText: "", imageString: ["Education/image34", "Education/image35", "Education/image36", "Education/image37", "Education/image38"]),  ChildEducationServices(id: 6, title: "", descText: "", imageString: ["Education/image39", "Education/image40", "Education/image41", "Education/image42"]), ChildEducationServices(id: 7, title: "", descText: "", imageString: ["Education/image26", "Education/image27"]), ChildEducationServices(id: 8, title: "", descText: "", imageString: ["Education/image43", "Education/image44", "Education/image45", "Education/image46"])]
    }
    
    static func getList(by id: Int) -> ChildEducationServices {
        switch id {
        default:
            return ChildEducationServices.allChildEducationsList()[id]
        }
    }
    
    static func getPageCount(by id: Int) -> Int {
        switch id {
        default:
            return ChildEducationServices.allChildEducationsList()[id].imageString.count
        }
    }
}
