//
//  ValidatableTextField.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import UIKit

extension ValidatableTextField {
    
    enum FieldType {
        case notEmpty, email, password, passwordAgain(originalPassword: String?)
        
        var errorMessage: String {
            switch self {
            case .notEmpty: return "Bu alan boş olmamalıdır"
            case .email: return "Geçersiz e posta"
            case .password: return "En az 8 karakter olmalı"
            case .passwordAgain: return "Alan \"Parola\" ile eşleşmiyor ";
            }
        }
    }
}

class ValidatableTextField: UnderlinedTextField {
    
    private let emailImage = UIImageView()
    
    private lazy var buttonDimension: CGFloat = self.intrinsicHeight
    
    //    private let errorLabel: UILabel = {
    //        let errorLabel = UILabel()
    //        errorLabel.isHidden = true
    //        errorLabel.numberOfLines = 0
    //        errorLabel.textColor = StyleManager.colors.red
    //        errorLabel.textAlignment = .left
    //        errorLabel.font = FontFamily.Roboto.regular.font(ofSize: 12)
    //        return errorLabel
    //    }()
    
    private let labelTopPadding: CGFloat = 4
    
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
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        //      addSubview(errorLabel)
        leftView = emailImage
        leftViewMode = .always
        updateEmailImage()
    }
    
    var fieldType: FieldType = .notEmpty {
        didSet {
            validate()
        }
    }
    
    private var padding: CGFloat {
        //        return errorLabel.isHidden ? CGFloat(0) : errorLabel.frame.height + labelTopPadding
        return CGFloat(0)
    }
    
    var isValidOrEmpty: Bool {
        return isValid || text.isNilOrEmpty
    }
    
    private (set) var isValid: Bool = false {
        didSet {
            if text.isNilOrEmpty  {
                fillColor = lineColor
            }
            else{
                let isValid = self.isValidOrEmpty
                fillColor = isValid ? .green : .red
            }
            //            errorLabel.text = isValid ? nil : fieldType.errorMessage
            //            errorLabel.isHidden = isValid
            //            errorLabel.frame.origin.y = intrinsicHeight + labelTopPadding
            setNeedsDisplay()
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        //        errorLabel.sizeToFit()
        size.height += padding
        return size
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: textTopEdge * 3), size: CGSize(width: buttonDimension / 2, height: buttonDimension / 2))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        rect.size.height -= padding
        return rect
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.placeholderRect(forBounds: bounds)
        rect.size.height -= padding
        rect.origin.x += buttonDimension * 0.7
        return rect
    }
    
    @objc private func textDidChange() {
        validate()
    }
    
    final func validate() {
        guard let text = self.text else { return }
        let trimmed = text.trimmed
        switch fieldType {
        case .email:
            isValid = NSPredicate(format: "SELF MATCHES %@", Regex.email).evaluate(with: trimmed)
        case .password:
            isValid = text.count > 5
        case .passwordAgain(let originalPassword):
            isValid = text == originalPassword
        case .notEmpty:
            isValid = !trimmed.isEmpty
        }
    }
    
    private func updateEmailImage(withColor color: UIColor? = nil) {
        let imageName = "login/mail"
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        emailImage.image = image
        emailImage.tintColor = StyleManager.colors.background
        emailImage.sizeToFit()
    }
}
