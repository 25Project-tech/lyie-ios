//
//  Request.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

class BaseRequest: Codable {
    let action: String?
    let header: Header?
    let body: Body?
    
    enum CodingKeys: String, CodingKey {
        case action = "Action"
        case header = "Header"
        case body = "Body"
    }
    
    init(action: String, header: Header, body: Body) {
        self.action = action
        self.header = header
        self.body = body
    }
}
