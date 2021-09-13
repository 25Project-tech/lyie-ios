//
//  UITextField
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import UIKit
import Material
import SkyFloatingLabelTextField

extension UITextField {
    
    enum Direction {
        case Left
        case Right
    }
    
    func withImage(direction: Direction, image: UIImage, imageColor: UIColor) {
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0.0, y: 5.0, width: CGFloat(UIDevice.getPlaceholderInset(identifier: UIDevice.modelName)), height: CGFloat(UIDevice.getPlaceholderInset(identifier: UIDevice.modelName))) 
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.image = imageView.image?.imageWithColor(color: imageColor)
        
        if (Direction.Left == direction) { // image left
            self.leftViewMode = .always
            self.leftView = imageView
        } else { // image right
            self.rightViewMode = .always
            self.rightView = imageView
        }  
    }  
}

///MARK: - set icon and color to text fileds
extension TextField {
    func setTextColorAndIconToTextField(color: UIColor, leftViewIcon: String) {
        
        self.placeholderNormalColor = color
        self.placeholderActiveColor = color
        self.dividerNormalColor = color
        self.dividerActiveColor = color
        self.detailColor = color
        self.textColor = color
        setIconToLeftOfTextField(color:color,textFiled:self,leftViewIcon:leftViewIcon) 
    }
    
    func setIconToLeftOfTextField(color: UIColor, textFiled: TextField, leftViewIcon: String) {
        if let myImage = UIImage(named: leftViewIcon) {
            self.withImage(direction: .Left, image: myImage, imageColor: color)
        } 
    } 
    
    func prepareTextField(placeholder: String, errorText: String, leftViewIcon: String) {
        
        self.placeholder = placeholder
        self.detail = errorText
        self.isClearIconButtonEnabled = false
        self.placeholderAnimation = .default
        //self.placeholderVerticalOffset = CGFloat(UIDevice.getPlaceholderInset(identifier: UIDevice.modelName))
        self.textColor = StyleManager.colors.background
        self.detailColor = StyleManager.colors.red
        // self.detailVerticalOffset = 2
        self.setTextColorAndIconToTextField(color:StyleManager.colors.background,leftViewIcon:leftViewIcon)
        //self.textInset = CGFloat(UIDevice.getTextInset(identifier: UIDevice.modelName))
    }
    
}

extension SkyFloatingLabelTextFieldWithIcon {
    func prepareSkyTextField(placeholder: String, iconImage: UIImage) {
        self.iconColor = StyleManager.colors.black
        self.selectedIconColor = StyleManager.colors.black
        self.lineColor = StyleManager.colors.black
        self.textColor = StyleManager.colors.black
        self.placeholderColor = StyleManager.colors.black
        self.selectedLineColor = StyleManager.colors.black
        self.selectedTitleColor = StyleManager.colors.black
        self.placeholder = placeholder
        self.iconType = .image
        self.iconImage = iconImage.withRenderingMode(.alwaysTemplate)
        self.iconImageView.tintColor = StyleManager.colors.black
    }
}

