//
//  LyieRegisterResponseResult.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

struct LyieRegisterResponseResult: Codable {
    let createUserNewResult: CreateUserNewResult

    enum CodingKeys: String, CodingKey {
        case createUserNewResult = "CreateUserNewResult"
    }
}

