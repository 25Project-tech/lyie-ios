//
//  PasswordTextField.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit

class PasswordTextField: ValidatableTextField {
    
    private let showPasswordButton = UIButton()
    private let passwordImage = UIImageView()
    
    private lazy var buttonDimension: CGFloat = self.intrinsicHeight
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        showPasswordButton.addTarget(self, action: #selector(showOrHidePassword(_:)), for: .touchUpInside)
        showPasswordButton.tintColor = StyleManager.colors.background
        rightView = showPasswordButton
        isSecureTextEntry = true
        rightViewMode = .always
        leftView = passwordImage
        leftViewMode = .always
        updateButtonImage()
        updatePasswordImage()
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: textTopEdge * 3), size: CGSize(width: buttonDimension / 2, height: buttonDimension / 2))
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: bounds.width - buttonDimension, y: textTopEdge), size: CGSize(width: buttonDimension, height: buttonDimension))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        return CGRect(origin: superRect.origin, size: CGSize(width: superRect.width - buttonDimension, height: superRect.height))
    }
    
    @objc private func showOrHidePassword(_ sender: UIButton) {
        isSecureTextEntry = !isSecureTextEntry
        updateButtonImage()
    }
    
    private func updateButtonImage() {
        let imageName = isSecureTextEntry ? "login/hide_password" : "login/show_password"
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        showPasswordButton.setImage(image, for: .normal)
    }
    
    private func updatePasswordImage(withColor color: UIColor? = nil) {
        let imageName = "login/lock"
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        passwordImage.image = image
        passwordImage.tintColor = StyleManager.colors.background
        passwordImage.sizeToFit()
    }
}
