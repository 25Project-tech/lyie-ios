//
//  Font.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit.UIFont

enum FontFamily {

    enum Roboto {
        case bold, light, medium, regular, thin

        func font(ofSize size: CGFloat) -> UIFont? {
            let prefix = "Roboto"
            let suffix: String
            switch self {
            case .thin: suffix = "Thin"
            case .light: suffix = "Light"
            case .regular: suffix = "Regular"
            case .medium: suffix = "Medium"
            case .bold: suffix = "Bold"
            }
            return UIFont(prefix: prefix, suffix: suffix, size: size)
        }
    }

    enum STIX {
        case general

        func font(ofSize size: CGFloat) -> UIFont? {
            let prefix = "STIX"
            let suffix: String
            switch self {
            case .general: suffix = "General"
            }
            return UIFont(prefix: prefix, suffix: suffix, separator: "", size: size)
        }
    }
}

private extension UIFont {

    convenience init?(prefix: String, suffix: String, separator: String = "-", size: CGFloat) {
        self.init(name: [prefix, suffix].joined(separator: separator), size: size)
    }
}
