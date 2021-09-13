//
//  String.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import UIKit

extension String {
    struct Constants {
        static let splitLength = 5
    }
    
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    nonmutating func parseToUIntFormat() -> UInt {
        var result : UInt = 0
        
        for i in stride(from: 0, to: self.count, by: Constants.splitLength) {
            let endIndex = self.index(self.endIndex, offsetBy: -i)
            let startIndex = self.index(endIndex, offsetBy: -Constants.splitLength, limitedBy: self.startIndex) ?? self.startIndex
            let data = String(self[startIndex..<endIndex])
            result = result | UInt(data)! << (16 * i/Constants.splitLength)
        }
        return result
    }
    
    func isValidPass() -> Bool {
        if self.count > 5 {
            return true
        }
        return false
    }
    
    func setAttributedString(changeText: String, font: UIFont, color: UIColor, enableColor: UIColor)-> NSAttributedString {
        let longestWordRange = (self as NSString).range(of: changeText)
        let attributedString = NSMutableAttributedString(string: self, attributes:
                                                            [NSAttributedString.Key.foregroundColor : enableColor])
        attributedString.setAttributes([NSAttributedString.Key.font : font,NSAttributedString.Key.foregroundColor : color], range: longestWordRange)
        return attributedString
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func removingLeadingSpaces() -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
            return self
        }
        return String(self[index...])
    }
}

extension NSMutableAttributedString {
    func setColorForText(_ textToFind: String?, with color: UIColor) {
        let range: NSRange?
        if let text = textToFind {
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        } else {
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range!)
        }
    }
    
}
