//
//  IdentifierStepCell.swift
//  lyie
//
//  Created by Sevcan Eşim on 29.11.2020.
//

import UIKit

class IdentifierStepCell: UITableViewCell {
    
    static let reuseIdentifier = "IdentifierStepCell"
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var userText: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var secondText: UILabel!
    @IBOutlet weak var stepText: UILabel!
    
    func config() {
        if let currentUserInfo = UserDefaults.standard.string(forKey: currentUserKey) {
            if let userItem = UserProvider.users(for: currentUserInfo) {
                let nameTextArray = userItem.name.split(separator: " ")
                if userItem.name != "" {
                    userText.text = "Merhaba " + nameTextArray[0]
                }
                
                if userItem.gender == "Kadın" {
                    foto.image = UIImage(named: "Home/karakterKadın")
                } else {
                    foto.image = UIImage(named: "Home/karakterAdam")
                }
            }
        }
    }
    
    func firstStepConfig() {
        config()
        descLabel.text = "“Eğitim detaylarına girmeden önce doldurman gereken bazı bilgiler mevcut. Profil bilgilerini doldurarak İnovaTİM Lise Ekosistemine ilk adımını atabilirsin.”"
        secondText.text = "Aramıza katıldığını görmek harika! "
        stepText.text  = "1.Aşama"
    }
    
    func firstStepConfigProfile() {
        config()
        descLabel.isHidden = true
        secondText.isHidden = true
        stepText.isHidden = true
    }
    
    func secondStepConfig() {
        config()
        descLabel.text = "Şimdi eğitim tercihi yapma zamanı! Aşağıda içeriklerini görebileceğin eğitimleri almak istediğin sıraya göre seç!"
        secondText.text = "Aramıza katıldığını görmek harika! "
        stepText.text  = "2.Aşama"
    }
    
    func thirdStepConfig() {
        config()
        descLabel.text = "Şimdi kendini keşfetme zamanı! Aşağıdaki linki tıklayarak Karga Karga uygulamasını indir ve özgelecek raporunu oluştur. Bu raporu oluşturman 12 dakikalık bir zamanını alacak."
        secondText.text = "Aramıza katıldığını görmek harika! "
        stepText.text  = "Son Aşama"
    }
}
