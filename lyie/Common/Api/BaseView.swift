//
//  BaseView.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

protocol BaseView {
    func onError(errorMessage: String)
    func onInternetError()
}
