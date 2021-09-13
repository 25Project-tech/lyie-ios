//
//  UIImageView.swift
//  lyie
//
//  Created by Sevcan Eşim on 30.04.2021.
//
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ urlString: String, placeholder: UIImage? = UIImage(named:"placeholder")) {
        
        let p = Bundle.main.path(forResource: "loader", ofType: "gif")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: p))
        self.kf.indicatorType = .image(imageData: data)
        var imageUrl = urlString
        if !urlString.contains("http") && !urlString.contains("file:///") {
            imageUrl = "Config.baseURL" + urlString
        }
        let url = URL(string: imageUrl)
        
        self.kf.setImage(with: url, placeholder: placeholder)
    }
    
    func base64() -> String? {
        guard let image: UIImage = self.image else { return nil }
        
        let imageData: NSData = image.pngData()! as NSData
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    func blurImage() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
}

