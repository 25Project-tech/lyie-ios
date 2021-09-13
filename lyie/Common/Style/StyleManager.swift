//
//  StyleManager.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit

class StyleManager {
    
    struct colors {
        // Examples:
        static let background = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static let blue = #colorLiteral(red: 0.2705882353, green: 0.631372549, blue: 0.9882352941, alpha: 1)
        static let lightGray = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        static let darkGray = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        static let red = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        static let redText = #colorLiteral(red: 0.4385873675, green: 0.1013506278, blue: 0.03350879252, alpha: 1)
        static let genericGrey = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        static let green = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        static let clear = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        static let white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        static let hsLoginButtonStart = #colorLiteral(red: 0.04299018532, green: 0.289067924, blue: 0.464461565, alpha: 1)
        static let hsLoginButtonStop = #colorLiteral(red: 0.9601795077, green: 0.2423971891, blue: 0.3854450583, alpha: 1)
        static let mLoginStart = #colorLiteral(red: 0.1184263751, green: 0.6776941419, blue: 0.890357852, alpha: 1)
        static let mLoginStop = #colorLiteral(red: 0.1193263009, green: 0.1506450474, blue: 0.4286786914, alpha: 1)
        static let loginButtonStart = #colorLiteral(red: 0.1104717776, green: 0.2482416332, blue: 0.5859622955, alpha: 1)
        static let loginButtonStop = #colorLiteral(red: 0.1193263009, green: 0.1506450474, blue: 0.4286786914, alpha: 1)
        
        static let backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        static let lineColor = #colorLiteral(red: 0.6708114743, green: 0.6939958334, blue: 0.7542968392, alpha: 1)
        static let leftTitleColor = #colorLiteral(red: 0.1128033325, green: 0.4713571072, blue: 0.7175278068, alpha: 1)
        static let borderColorBlue = #colorLiteral(red: 0.1096807942, green: 0.5468695164, blue: 0.8439930677, alpha: 0.91)
        static let titleColor = #colorLiteral(red: 0.4990869164, green: 0.5032036304, blue: 0.5031830072, alpha: 1)
        
        static let scoreViewColor = #colorLiteral(red: 0.9599083066, green: 0.9649264216, blue: 0.9646570086, alpha: 1)
        static let scoreDescView = #colorLiteral(red: 0.9951989055, green: 1, blue: 0.9999468923, alpha: 1)
        
        static let deviceModeActiveBlue = #colorLiteral(red: 0, green: 0.4549019608, blue: 0.6980392157, alpha: 1)
        static let deviceModeinactiveGray = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        static let pickerLightGray = #colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)
        static let currentModeActiveBlue =  #colorLiteral(red: 0.3215686275, green: 0.568627451, blue: 0.8549019608, alpha: 1)
        static let navigationBarGradientColor2 =  #colorLiteral(red: 0, green: 0.8235294118, blue: 0.831372549, alpha: 1)
        static let navigationBarGradientColorFirst = #colorLiteral(red: 0.6039215686, green: 0.568627451, blue: 0.8941176471, alpha: 1)
        static let navigationBarGradientColorSecond = #colorLiteral(red: 0, green: 0.8549019608, blue: 0.831372549, alpha: 1)
        static let globalTabBarBackColor = #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)
        
        static let karartı = #colorLiteral(red: 0.3685853481, green: 0.3686524034, blue: 0.368575871, alpha: 1)
        static let questionArea = #colorLiteral(red: 0.9607964158, green: 0.9606838822, blue: 0.9692818522, alpha: 1)
    }
    
    struct fonts {
        static let muliBlackLarge = UIFont(name: "Muli-Black", size: 28.0)
        static let muliBlackMedium = UIFont(name: "Muli-Black", size: 19.0)
        static let muliBlackSmall = UIFont(name: "Muli-Black", size: 14.0)
    }
    
    static func configure() {
        // Apply global style here
    }
}
